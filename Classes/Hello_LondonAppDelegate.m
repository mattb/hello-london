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
	Postcoder *postcode = [[Postcoder alloc] init];
	[postcode findPostcodeForLat:@"51.5" andLong:@"-0.01" withDelegate:self didSucceedSelector:@selector(gotPostcode:)];
}

- (void)gotPostcode:(NSString *)postcode {
	NSLog(@"Success: %@", postcode);
	[tfl planRouteFrom:postcode to:@"EC1Y 2BP" withDelegate:self didSucceedSelector:@selector(gotRoute)];
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
