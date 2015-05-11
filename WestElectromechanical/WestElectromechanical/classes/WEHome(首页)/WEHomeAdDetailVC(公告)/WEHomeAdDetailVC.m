//
//  WEHomeAdDetailVC.m
//  WestElectromechanical
//
//  Created by zuo on 15/5/11.
//  Copyright (c) 2015年 zuo. All rights reserved.
//

#import "WEHomeAdDetailVC.h"
#import "RDVTabBarController.h"
@interface WEHomeAdDetailVC ()

@end

@implementation WEHomeAdDetailVC
#pragma mark -
#pragma mark - pop和push控制器时的操作
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [[self rdv_tabBarController] setTabBarHidden:YES animated:YES];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    [[self rdv_tabBarController] setTabBarHidden:NO animated:YES];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor =[UIColor colorFromHexCode:@"f2f2f2"];
    UILabel *adLabel =[[UILabel alloc]init];
    adLabel.frame =CGRectMake(  0,0,SCREEN_WIDTH,SCREEN_HEIGHT);
    adLabel.text = _noticeContent;
    adLabel.numberOfLines =1;
    adLabel.textAlignment = NSTextAlignmentCenter;
    adLabel.font =[UIFont systemFontOfSize:18.0];
    adLabel.backgroundColor =[UIColor clearColor];
    [self.view addSubview:adLabel];
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
