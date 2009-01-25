//
//  RootViewController.h
//  Hello London
//
//  Created by Matt Biddulph on 22/01/2009.
//  Copyright Hackdiary Ltd 2009. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreLocation/CoreLocation.h>
#import "TfL.h"

@interface RootViewController : UIViewController <CLLocationManagerDelegate> {
	IBOutlet UILabel *latitudeLabel;
	IBOutlet UILabel *longitudeLabel;
	IBOutlet UILabel *accuracyLabel;
	IBOutlet UILabel *postcodeLabel;
	IBOutlet UILabel *addressLabel;
	CLLocationManager *locationManager;
	TfL *tfl;
}

@property (nonatomic,retain) CLLocationManager *locationManager;
- (IBAction)planRoute: (id)sender;

@end
