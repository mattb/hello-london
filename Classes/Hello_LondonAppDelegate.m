//
//  Hello_LondonAppDelegate.m
//  Hello London
//
//  Created by Matt Biddulph on 22/01/2009.
//  Copyright Hackdiary Ltd 2009. All rights reserved.
//

#import "Hello_LondonAppDelegate.h"
#import "RootViewController.h"
#import "Postcoder.h"

@implementation Hello_LondonAppDelegate

@synthesize window;
@synthesize navigationController;


- (void)applicationDidFinishLaunching:(UIApplication *)application {
	
	// Configure and show the window
	[window addSubview:[navigationController view]];
	[window makeKeyAndVisible];
	tfl = [[TfL alloc] init];
	Postcoder *postcoder = [[Postcoder alloc] init];
	NSString *postcode = [postcoder findPostcodeForLat:[NSNumber numberWithFloat:51.5] andLong:[NSNumber numberWithFloat:-0.01]];
	NSLog(@"Postcode: %@", postcode);
	[tfl planRouteFrom:postcode to:@"E8 1PE" withDelegate:self didSucceedSelector:@selector(gotRoute)];
}

- (void)gotRoute {
	NSLog(@"Success!\n%@", tfl.routes);
}

- (void)applicationWillTerminate:(UIApplication *)application {
	// Save data if appropriate
}


- (void)dealloc {
	[navigationController release];
	[window release];
	[super dealloc];
}

@end
