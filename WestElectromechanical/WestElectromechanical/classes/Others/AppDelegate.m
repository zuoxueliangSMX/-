//
//  AppDelegate.m
//  WestElectromechanical
//
//  Created by zuo on 15/4/25.
//  Copyright (c) 2015年 zuo. All rights reserved.
//

#import "AppDelegate.h"
#import "RDVTabBarController.h"
#import "RDVTabBarItem.h"
#import "WELeadPageVC.h"
#import "WECartHomeVC.h"
#import "WECategoryHomeVC.h"
#import "WEMineHomeVC.h"
#import "WESearchHomeVC.h"
#import "WEHomeVC.h"
@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    
    [self loadingVC];
    [self.window makeKeyAndVisible];
    return YES;
}
- (void)loadingVC
{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    if ([defaults objectForKey:@"first_install"]==nil||[defaults boolForKey:@"first_install"]== YES) {
        WELeadPageVC *loading =[[WELeadPageVC alloc]init];
        WENavitationController *loadingNav = [[WENavitationController alloc] initWithRootViewController:loading];
        
        self.window.rootViewController = loadingNav;
        
    }else{
        //        loading = [NavigationViewController new];
        [self initTabControlers];
        
    }

}

#pragma mark - 初始化Tab控制器Methods
- (void)initTabControlers
{
    WEHomeVC *homeVC = [[WEHomeVC alloc] init];
    homeVC.title =@"首页";
    WENavitationController *homeNav = [[WENavitationController alloc]
                                       initWithRootViewController:homeVC];
    
    WECategoryHomeVC *categoryVC = [[WECategoryHomeVC alloc] init];
    categoryVC.title =@"分类";
    WENavitationController *categoryNav = [[WENavitationController alloc]
                                       initWithRootViewController:categoryVC];
    WESearchHomeVC *searchVC = [[WESearchHomeVC alloc] init];
    searchVC.title =@"搜索";
    WENavitationController *searchNav = [[WENavitationController alloc]
                                       initWithRootViewController:searchVC];

    WECartHomeVC *cartVC = [[WECartHomeVC alloc] init];
    cartVC.title =@"购物车";
    WENavitationController *cartNav = [[WENavitationController alloc]
                                       initWithRootViewController:cartVC];

    WEMineHomeVC *mineVC = [[WEMineHomeVC alloc] init];
    mineVC.title = @"我的";
    WENavitationController *mineNav = [[WENavitationController alloc]
                                       initWithRootViewController:mineVC];
    
    RDVTabBarController *tabBarController = [[RDVTabBarController alloc] init];
    [tabBarController setViewControllers:@[homeNav,
                                           searchNav,
                                           categoryNav,
                                           cartNav,
                                           mineNav]];
    
    [self customizeTabBarForController:tabBarController];
//    [self customizeInterface];
    self.window.rootViewController = tabBarController;
    [self.window makeKeyAndVisible];
    
    
}
//自定义tabbar的样式
- (void)customizeTabBarForController:(RDVTabBarController *)tabBarController {
    UIImage *finishedImage = [UIImage imageNamed:@"Tabbar_Background_Highlighted"];
    UIImage *unfinishedImage = [UIImage imageNamed:@"Tabbar_Background_Normal"];
    NSArray *tabBarItemImages = @[@"Tabbar_First", @"Tabbar_Second", @"Tabbar_Third", @"Tabbar_Fourth",@"Tabbar_Five"];
    
    NSInteger index = 0;
    for (RDVTabBarItem *item in [[tabBarController tabBar] items]) {
        [item setBackgroundSelectedImage:finishedImage withUnselectedImage:unfinishedImage];
        UIImage *selectedimage = [UIImage imageNamed:[NSString stringWithFormat:@"%@_Highlighted",
                                                      [tabBarItemImages objectAtIndex:index]]];
        UIImage *unselectedimage = [UIImage imageNamed:[NSString stringWithFormat:@"%@_Normal",
                                                        [tabBarItemImages objectAtIndex:index]]];
        [item setFinishedSelectedImage:selectedimage withFinishedUnselectedImage:unselectedimage];
        
        
        NSDictionary *unselectedTextAttributes = @{
                                                   NSFontAttributeName: [UIFont systemFontOfSize:10],
                                                   NSForegroundColorAttributeName: [UIColor blackColor],
                                                   };
        [item setUnselectedTitleAttributes:unselectedTextAttributes];
        
        NSDictionary *selectedTextAttributes = @{
                                                 NSFontAttributeName: [UIFont systemFontOfSize:10],
                                                 NSForegroundColorAttributeName: kHightLightedColor // item被选中时标题的颜色,
                                                 };
        [item setSelectedTitleAttributes:selectedTextAttributes];
        
        index++;
    }
    
    
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end