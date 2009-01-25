//
//  TfL.h
//  Hello London
//
//  Created by Matt Biddulph on 22/01/2009.
//  Copyright 2009 Hackdiary Ltd. All rights reserved.
//
//  A screenscraper for the TfL WAP site.

#import <Foundation/Foundation.h>
#import "GTMHTTPFetcher.h"

@interface TfL : NSObject {
	GTMHTTPFetcher* myFetcher;
	NSString *from;
	NSString *to;
	id delegate;
	SEL success;
	NSMutableArray *routes;
}

- (void)planRouteFrom:(NSString *)fromPostcode to:(NSString *)toPostcode withDelegate:(id)successDelegate didSucceedSelector:(SEL)sel;

@property (nonatomic, readonly) NSArray *routes;
@property (nonatomic, retain) NSString *to;
@property (nonatomic, retain) NSString *from;

@end
