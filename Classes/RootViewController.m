//
//  RootViewController.m
//  Hello London
//
//  Created by Matt Biddulph on 22/01/2009.
//  Copyright Hackdiary Ltd 2009. All rights reserved.
//

#import "RootViewController.h"
#import "Hello_LondonAppDelegate.h"
#import "Postcoder.h"
#import "TfL.h"
#import "GTMHTTPFetcher.h"
#import "RegexKitLite.h"

@implementation RootViewController

@synthesize locationManager;

- (void)viewDidLoad {
    [super viewDidLoad];
	
	self.locationManager = [[[CLLocationManager alloc] init] autorelease]; 
	self.locationManager.delegate = self; 
	[self.locationManager startUpdatingLocation];
	tfl = [[TfL alloc] init];
	NSString *homePostcode = [[NSUserDefaults standardUserDefaults] stringForKey:@"homePostcode"];
	if(!homePostcode) {
		homePostcode = @"E8 1PE";
	}
	homePostcodeText.text = homePostcode;
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (void)geocodeLat:(double)lat andLong:(double)lng {
	NSString *url = [NSString stringWithFormat:@"http://maps.google.com/maps/geo?q=%f,%f&output=csv&oe=utf8&sensor=true&key=ABQIAAAASw_mpQsqmT0mJpSX2YojThTJQa0g3IQ9GZqIMmInSLzwtGDKaBT7rtzYiNX0yqsGcc-Lvo0V4u1_7w",lat,lng];
	NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:url]];
	GTMHTTPFetcher *myFetcher = [GTMHTTPFetcher httpFetcherWithRequest:request];
	[myFetcher beginFetchWithDelegate:self
					didFinishSelector:@selector(myFetcher:geocoded:)
				      didFailSelector:@selector(myFetcher:geocodeFailed:)];
}

- (void)myFetcher:(GTMHTTPFetcher *)fetcher geocoded:(NSData *)retrievedData {
	NSString *address = [[NSString alloc] initWithData:retrievedData encoding:NSUTF8StringEncoding];
	addressLabel.text = [address stringByReplacingOccurrencesOfRegex:@"^.*\"(.+)\"$" 
														  withString:@"$1"];
	[address release];
}

- (void)myFetcher:(GTMHTTPFetcher *)fetcher geocodeFailed:(NSError *)error {
	NSLog(@"Error: %@",error);
	addressLabel.text = @"";
}

- (IBAction)homePostcodeChanged: (id)sender {
	NSLog(@"Saving new home.");
	[[NSUserDefaults standardUserDefaults] setObject:homePostcodeText.text forKey:@"homePostcode"];
}

- (void)locationManager:(CLLocationManager *)manager 
	didUpdateToLocation:(CLLocation *)newLocation 
		   fromLocation:(CLLocation *)oldLocation { 
	Postcoder *postcoder = [[Postcoder alloc] init];
	NSString *postcode = [postcoder findPostcodeForLat:[NSNumber numberWithDouble:newLocation.coordinate.latitude] andLong:[NSNumber numberWithDouble:newLocation.coordinate.longitude]];
	
	latitudeLabel.text = [NSString stringWithFormat:@"Latitude: %3.5f", 
							  newLocation.coordinate.latitude]; 
	longitudeLabel.text = [NSString stringWithFormat:@"Longitude: %3.5f", 
							   newLocation.coordinate.longitude]; 
	accuracyLabel.text = [NSString stringWithFormat:@"Accuracy: %0.1f", 
						   newLocation.horizontalAccuracy];
	postcodeLabel.text = [NSString stringWithFormat:@"%@", postcode];
	[self geocodeLat:newLocation.coordinate.latitude andLong: newLocation.coordinate.longitude];
}

- (IBAction)planRoute: (id)sender {
	[tfl planRouteFrom:postcodeLabel.text to:homePostcodeText.text withDelegate:self didSucceedSelector:@selector(gotRoute)];
}

- (void)gotRoute {
	NSLog(@"Success!\n%@", tfl.routes);
	
	NSDictionary *route = [tfl.routes objectAtIndex:0];
	NSURL *url = [ [ NSURL alloc ] initWithString: [route objectForKey:@"url"]];
	[[UIApplication sharedApplication] openURL:url];
}

/*
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
}
*/
/*
- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
}
*/
/*
- (void)viewWillDisappear:(BOOL)animated {
	[super viewWillDisappear:animated];
}
*/
/*
- (void)viewDidDisappear:(BOOL)animated {
	[super viewDidDisappear:animated];
}
*/

/*
// Override to allow orientations other than the default portrait orientation.
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}
*/

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning]; // Releases the view if it doesn't have a superview
    // Release anything that's not essential, such as cached data
}

- (void)dealloc {
	[tfl release];
    [super dealloc];
}


@end

