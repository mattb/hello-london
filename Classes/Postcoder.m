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
- (NSString *)findPostcodeForLat:(NSNumber *)lat andLong:(NSNumber *)lng {
	NSString *dbpath = [[NSBundle mainBundle] 
							  pathForResource:@"postcodes" 
							  ofType:@"sqlite"]; 
	FMDatabase *db = [[FMDatabase databaseWithPath:dbpath] retain];
	if (![db open]) {
        NSLog(@"Could not open db.");
        return @"";
    }
	NSString *postcode = [db stringForQuery:@"select postcode from postcodes order by ((lat-?)*(lat-?))+((lng-?)*(lng-?)) limit 1;", lat,lat,lng,lng];
	NSLog(@"%@",postcode);
	[db close];

	return postcode;
}

@end
