//
//  RootViewController.h
//  Hello London
//
//  Created by Matt Biddulph on 22/01/2009.
//  Copyright Hackdiary Ltd 2009. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreLocation/CoreLocation.h>
#import <AddressBook/AddressBook.h>
#import <AddressBookUI/AddressBookUI.h>
#import "TfL.h"
#import "Postcoder.h"

@interface RootViewController : UIViewController <CLLocationManagerDelegate,ABPeoplePickerNavigationControllerDelegate> {
	IBOutlet UILabel *latitudeLabel;
	IBOutlet UILabel *longitudeLabel;
	IBOutlet UILabel *accuracyLabel;
	IBOutlet UILabel *postcodeLabel;
	IBOutlet UILabel *addressLabel;
	IBOutlet UITextField *homePostcodeText;
	CLLocationManager *locationManager;
	TfL *tfl;
	Postcoder *postcoder;
}

@property (nonatomic,retain) CLLocationManager *locationManager;
- (IBAction)planRoute: (id)sender;
- (IBAction)homePostcodeChanged: (id)sender;
- (IBAction)pickPostcodeFromAddressbook: (id)sender;

@end
