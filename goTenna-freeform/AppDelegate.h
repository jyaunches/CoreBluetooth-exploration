//
//  AppDelegate.h
//  goTenna-freeform
//
//  Created by Julietta Yaunches on 11/24/13.
//  Copyright (c) 2013 Julietta Yaunches. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreBluetooth/CoreBluetooth.h>


static CBUUID *const SERVICE_ID = [CBUUID UUIDWithString:@"BEFFC411-C5C7-4569-8991-D3E4CD52231B"];

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;

@end
