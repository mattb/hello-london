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


@implementation RootViewController

@synthesize locationManager;

- (void)viewDidLoad {
    [super viewDidLoad];
	
	self.locationManager = [[[CLLocationManager alloc] init] autorelease]; 
	self.locationManager.delegate = self; 
	[self.locationManager startUpdatingLocation];
	postcodeLabel.text = @"E8 1PE";
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
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
	postcodeLabel.text = [NSString stringWithFormat:@"Postcode: %@", postcode];
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
    [super dealloc];
}


@end

