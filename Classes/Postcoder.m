//
//  Postcoder.m
//  Hello London
//
//  Created by Matt Biddulph on 22/01/2009.
//  Copyright 2009 Hackdiary Ltd. All rights reserved.
//

#import "Postcoder.h"
#import "XPathQuery.h"

@implementation Postcoder
- (void)findPostcodeForLat:(NSString *)lat andLong:(NSString *)lng withDelegate:(id)successDelegate didSucceedSelector:(SEL)sel {
	delegate = successDelegate;
	success = sel;
	NSString *url = @"http://www.streetmap.co.uk/streetmap.dll?";
	NSData *post = [[NSString stringWithFormat:@"MfcISAPICommand=GridConvert&name=%@%%2C%@&type=LatLong", lat, lng] dataUsingEncoding:NSUTF8StringEncoding];
	
	NSLog(@"URL: %@", url);
	NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:url]];
	GTMHTTPFetcher *myFetcher = [GTMHTTPFetcher httpFetcherWithRequest:request];
	[myFetcher setPostData:post];
	[myFetcher beginFetchWithDelegate:self
					didFinishSelector:@selector(myFetcher:finishedStreetmapWithData:)
				      didFailSelector:@selector(myFetcher:failedWithError:)];	
}

- (void)myFetcher:(GTMHTTPFetcher *)fetcher finishedStreetmapWithData:(NSData *)retrievedData {
	NSString *xpath = @"//tr[td/strong/text()='Nearest Post Code']/td[position()=2]";
	NSArray *postcode = PerformHTMLXPathQuery(retrievedData, xpath);

	if([postcode count] == 1) {
		NSString *p;
		for(NSDictionary *d in postcode) {
			p = [d objectForKey:@"nodeContent"];
		}
		[delegate performSelector:success withObject:[p retain]];
	}	
}

- (void)myFetcher:(GTMHTTPFetcher *)fetcher failedWithError:(NSError *)error {
	NSLog(@"Error: %@",error);
}

@end
