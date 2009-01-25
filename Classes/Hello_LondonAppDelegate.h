//
//  Hello_LondonAppDelegate.h
//  Hello London
//
//  Created by Matt Biddulph on 22/01/2009.
//  Copyright Hackdiary Ltd 2009. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface Hello_LondonAppDelegate : NSObject <UIApplicationDelegate> {
    
    UIWindow *window;
    UINavigationController *navigationController;
}

@property (nonatomic, retain) IBOutlet UIWindow *window;
@property (nonatomic, retain) IBOutlet UINavigationController *navigationController;

@end

