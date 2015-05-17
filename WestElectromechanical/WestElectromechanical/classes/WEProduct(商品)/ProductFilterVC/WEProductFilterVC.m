//
//  WEProductFilterVC.m
//  WestElectromechanical
//
//  Created by zuo on 15/5/17.
//  Copyright (c) 2015年 zuo. All rights reserved.
//

#import "WEProductFilterVC.h"
#import "RDVTabBarController.h"
#import "UIButton+Extension.h"
@interface WEProductFilterVC ()<UITableViewDataSource,UITableViewDelegate>

@end

@implementation WEProductFilterVC
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
    
    UITableView *filterList =[[UITableView alloc]initWithFrame:CGRectMake(10, 0, SCREEN_WIDTH-20, SCREEN_HEIGHT-50) style:UITableViewStyleGrouped];
    filterList.delegate =self;
    filterList.dataSource =self;
    filterList.showsHorizontalScrollIndicator = NO;
    filterList.showsVerticalScrollIndicator = NO;
    filterList.backgroundColor =[UIColor clearColor];
    [self.view addSubview:filterList];
    
    
    UIView *bottomView = [[UIView alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(filterList.frame), SCREEN_WIDTH, 50)];
    bottomView.backgroundColor =[UIColor colorFromHexCode:@"f2f2f2"];
    [self.view addSubview:bottomView];
    

     
    UIButton *button =[UIButton addTarget:self WithNorTitle:@"筛选" withNorColor:[UIColor whiteColor] withSelectedTitle:@"帅选" withSelectedColor:[UIColor whiteColor] withBackgroundColor:[UIColor orangeColor] withTileSize:font(16) action:@selector(filterProduct:)];
    button.frame = CGRectMake(10, 3, SCREEN_WIDTH-20, 44);
    [bottomView addSubview:button];
    
}

- (void)filterProduct:(UIButton *)btn
{
    
}

#pragma mark -
#pragma mark - UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 2;
}
- (NSInteger)tableView:(UITableView*)tableView numberOfRowsInSection:(NSInteger)section {
    
    if (section == 0) {
        return 0;
    }else return 10;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    if (section == 0) {
        UIView *view =[[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 44)];
//        UITextField 
        
        
        view.backgroundColor =[UIColor redColor];
        
        
        return view;
    }else{
        UIView *view =[[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 44)];
        view.backgroundColor =[UIColor blueColor];
        return view;
    }
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 44;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 44;
}
- (UITableViewCell*)tableView:(UITableView*)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if(cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
        cell.backgroundColor =[UIColor grayColor];
    }
    
    return cell;
}
#pragma mark -
#pragma mark - UITableViewDelegate

- (void)tableView:(UITableView*)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
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
