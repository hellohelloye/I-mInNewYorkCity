//
//  NewYorkCityAppDelegate.h
//  I'mInNewYorkCity
//
//  Created by Yukui ye on 1/24/14.
//  Copyright (c) 2014 Yukui Ye. All rights reserved.
//

#import <UIKit/UIKit.h>
@import CoreMotion;
#import "NewYorkCityViewController.h"

@interface NewYorkCityAppDelegate : UIResponder <UIApplicationDelegate> { CMMotionManager *motionManager; }

@property (strong, nonatomic) UIWindow *window;
@property (strong, nonatomic) NewYorkCityViewController *nycv;
@property (readonly) CMMotionManager *motionManager;

@end
