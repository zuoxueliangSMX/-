//
//  WEProcutCommentListVC.m
//  WestElectromechanical
//
//  Created by zuo on 15/5/12.
//  Copyright (c) 2015年 zuo. All rights reserved.
//

#import "WEProdcutCommentListVC.h"
#import "RDVTabBarController.h"
#import "WEHTTPHandler.h"
@interface WEProdcutCommentListVC ()<UITableViewDataSource,UITableViewDelegate>
@property (nonatomic ,weak)UITableView *commentList;
@end

@implementation WEProdcutCommentListVC
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
    [self initCommentList];
    
    [self initCommentData];
}

- (void)initCommentData
{
    WEHTTPHandler *handler =[[WEHTTPHandler alloc]init];
    [handler executeGetProductCommentListTaskWithProductId:self.productId withSuccess:^(id obj) {
        DLog(@"GetProductCommentList-------->%@",obj);
    } withFailed:^(id obj) {
        DLog(@"GetProductCommentList-----error--->%@",obj);

    }];
}

- (void)initCommentList
{
    UITableView *commentList =[[UITableView alloc]init];
    commentList.frame =CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT);
    commentList.delegate =self;
    commentList.dataSource =self;
    commentList.backgroundColor =[UIColor clearColor];
    [self.view addSubview:commentList];
    commentList.tableFooterView =[[UIView alloc]init];
    _commentList = commentList;
}
#pragma mark -
#pragma mark - UITableViewDataSource

- (NSInteger)tableView:(UITableView*)tableView numberOfRowsInSection:(NSInteger)section {
    return 10;
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
    }
    cell.textLabel.text =[NSString stringWithFormat:@"%ld",indexPath.row];
    
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
