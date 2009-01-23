//
//  Postcoder.h
//  Hello London
//
//  Created by Matt Biddulph on 22/01/2009.
//  Copyright 2009 Hackdiary Ltd. All rights reserved.
//
//  A screenscraper for www.streetmap.co.uk
//  (which appears to only return results 90% of the time and doesn't like being scraped
//  so a better source would be great)

#import <Foundation/Foundation.h>
#import "GTMHTTPFetcher.h"

@interface Postcoder : NSObject {
	id delegate;
	SEL success;
}

- (void)findPostcodeForLat:(NSString *)lat andLong:(NSString *)lng withDelegate:(id)successDelegate didSucceedSelector:(SEL)sel;

@end
