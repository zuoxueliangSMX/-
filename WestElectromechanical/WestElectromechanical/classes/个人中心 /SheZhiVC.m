//
//  SheZhiVC.m
//  WestElectromechanical
//
//  Created by 夏亚峰 on 15/5/7.
//  Copyright (c) 2015年 zuo. All rights reserved.
//

#import "SheZhiVC.h"
#import "RDVTabBarController.h"
#import "WEHTTPHandler.h"
#import "AccountHanler.h"


@interface SheZhiVC ()<UITableViewDataSource,UITableViewDelegate>
{
    
    WEHTTPHandler *we;
    
}


@end

@implementation SheZhiVC

-(void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [[self rdv_tabBarController] setTabBarHidden:YES animated:YES];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    [[self rdv_tabBarController] setTabBarHidden:NO animated:YES];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title =@"设置";
    we= [[WEHTTPHandler alloc]init];
    
           UITableView *table = [[UITableView alloc] initWithFrame:CGRectMake(0, 10,SCREEN_WIDTH,SCREEN_HEIGHT-64) style:UITableViewStylePlain];
    
    
    table.backgroundColor =SET_COLOR(234.0, 234.0, 234.0);
    
    self.view.backgroundColor =SET_COLOR(234.0, 234.0, 234.0);
    
    table.delegate =self;
    table.dataSource =self;
    [self.view addSubview:table];
    UIView *view =[[UIView alloc]init];
    table.tableFooterView = view;

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
