//
//  WEMineVC.m
//  WestElectromechanical
//
//  Created by zuo on 15/4/26.
//  Copyright (c) 2015年 zuo. All rights reserved.
//

#import "WEMineHomeVC.h"
#import "RDVTabBarController.h"
@interface WEMineHomeVC ()

@end

@implementation WEMineHomeVC
#pragma mark -
#pragma mark - pop和push控制器时的操作
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [[self rdv_tabBarController] setTabBarHidden:NO animated:YES];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    [[self rdv_tabBarController] setTabBarHidden:NO animated:YES];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    /**
     *  我很帅气左学良

     *  我很帅气 夏亚峰   无敌  matchless
     *
     *  @return <#return value description#>
     */
}

/**
 *  注册接口
 */

- (void)registUserWithName:(NSString *)nickname withPhone:(NSString *)phone withEmail:(NSString *)email withPassword:(NSString *)pwd
{
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
