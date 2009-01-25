//
//  RootViewController.h
//  Hello London
//
//  Created by Matt Biddulph on 22/01/2009.
//  Copyright Hackdiary Ltd 2009. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreLocation/CoreLocation.h>

@interface RootViewController : UIViewController <CLLocationManagerDelegate> {
	IBOutlet UILabel *latitudeLabel;
	IBOutlet UILabel *longitudeLabel;
	IBOutlet UILabel *accuracyLabel;
	IBOutlet UILabel *postcodeLabel;
	CLLocationManager *locationManager;
}

@property (nonatomic,retain) CLLocationManager *locationManager;

@end
