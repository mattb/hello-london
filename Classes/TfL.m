//
//  TfL.m
//  Hello London
//
//  Created by Matt Biddulph on 22/01/2009.
//  Copyright 2009 Hackdiary Ltd. All rights reserved.
//
//
//  A screenscraper for the TfL WAP site at http://www.tflwap.gov.uk

#import "TfL.h"
#import "NSString+URLEncoding.h"
#import "RegexKitLite.h"
#import "XPathQuery.h"

@implementation TfL

@synthesize routes;
@synthesize to;
@synthesize from;

- (void)planRouteFrom:(NSString *)fromPostcode to:(NSString *)toPostcode withDelegate:(id)successDelegate didSucceedSelector:(SEL)sel {
	self.from = fromPostcode;
	self.to = toPostcode;
	delegate = successDelegate;
	success = sel;
	NSString *url = [NSString stringWithFormat:@"http://www.tflwap.gov.uk/planner/fromValidate?from=%@", [self.from URLEncodedString]];
	NSLog(@"URL: %@", url);
	NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:url]];
	myFetcher = [GTMHTTPFetcher httpFetcherWithRequest:request];
	[myFetcher beginFetchWithDelegate:self
					didFinishSelector:@selector(myFetcher:finishedStep1WithData:)
				      didFailSelector:@selector(myFetcher:failedWithError:)];
	[UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
}

- (void)myFetcher:(GTMHTTPFetcher *)fetcher finishedStep1WithData:(NSData *)retrievedData {
	NSLog(@"Success!");
	[UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
	NSString *xpath = @"//form[@id='locationForm']/@action";
	NSArray *action = PerformHTMLXPathQuery(retrievedData, xpath);
	if([action count] == 1) {
		NSString *path = [((NSDictionary *)[action objectAtIndex:0]) objectForKey:@"nodeContent"];
		NSLog(@"Path: %@", path);
		NSString *url = [NSString stringWithFormat:@"http://www.tflwap.gov.uk%@?to=%@", path, [self.to URLEncodedString]];
		NSLog(@"URL: %@", url);
		NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:url]];
		myFetcher = [GTMHTTPFetcher httpFetcherWithRequest:request];
		[myFetcher beginFetchWithDelegate:self
						didFinishSelector:@selector(myFetcher:finishedStep2WithData:)
						  didFailSelector:@selector(myFetcher:failedWithError:)];
		[UIApplication sharedApplication].networkActivityIndicatorVisible = YES; 
	} else {
		NSLog(@"Screenscrape failed");
	}
}

- (void)myFetcher:(GTMHTTPFetcher *)fetcher finishedStep2WithData:(NSData *)retrievedData {
	[UIApplication sharedApplication].networkActivityIndicatorVisible = NO; 
	NSString *xpath = @"//a[starts-with(@href,'/planner/details')]";
	NSArray *detailNodes = PerformHTMLXPathQuery(retrievedData, xpath);
	self.routes = [NSMutableArray array];
	for (NSDictionary *d in detailNodes) {
		NSDictionary *route = [NSMutableDictionary dictionary];
		NSString *content = [d objectForKey:@"nodeContent"];
		NSString *href=nil;
		for (NSDictionary *attr in [d objectForKey:@"nodeAttributeArray"]) {
			href = [attr objectForKey:@"nodeContent"];
		}
		NSArray *details = [[content stringByReplacingOccurrencesOfRegex:@"[^0-9]*([0-9]+)[^0-9]*" 
													   withString:@"$1-"] componentsSeparatedByRegex:@"-"];
		if(href != nil && [details count] >= 3) {
			[route setValue:[details objectAtIndex:0] forKey:@"leave"];
			[route setValue:[details objectAtIndex:1] forKey:@"arrive"];
			[route setValue:[details objectAtIndex:2] forKey:@"stops"];
			[route setValue:[NSString stringWithFormat:@"http://www.tflwap.gov.uk%@",href] forKey:@"url"];

			[routes addObject:route];
		}
	}
	[delegate performSelector:success];
}

- (void)myFetcher:(GTMHTTPFetcher *)fetcher failedWithError:(NSError *)error {
	NSLog(@"Error: %@",error);
	[UIApplication sharedApplication].networkActivityIndicatorVisible = NO; 
}

- (void)dealloc {
	[routes release];
	[to release];
	[from release];
	[super dealloc];
}

@end