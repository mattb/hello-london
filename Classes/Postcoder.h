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
#import "FMDatabase.h"
#import "FMDatabaseAdditions.h"

// Bounding box for London as defined by Yahoo WOE ID 44418
// http://where.yahooapis.com/v1/place/44418?appid=your_yahoo_appid_here
#define LONDON_SOUTHWEST_LAT 51.261318
#define LONDON_SOUTHWEST_LNG -0.50901
#define LONDON_NORTHEAST_LAT 51.686031
#define LONDON_NORTHEAST_LNG 0.28036

@interface Postcoder : NSObject {
	id delegate;
	SEL success;
	FMDatabase *db;
}

- (NSString *)findPostcodeForLat:(NSNumber *)lat andLong:(NSNumber *)lng;

@end
