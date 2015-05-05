//
//  AppDelegate.h
//  WestElectromechanical
//
//  Created by zuo on 15/4/25.
//  Copyright (c) 2015年 zuo. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RDVTabBarController.h"
@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;
@property (nonatomic ,strong) RDVTabBarController *tabBarController;
- (void)loadingVC;
- (void)initTabControlers;

@end

