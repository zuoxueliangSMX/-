//
//  WEMineAddComentVC.m
//  WestElectromechanical
//
//  Created by 夏亚峰 on 15/5/18.
//  Copyright (c) 2015年 zuo. All rights reserved.
//

#import "WEMineAddComentVC.h"
#import "WEHTTPHandler.h"
#import "WEMineAddComentCell.h"
#import "AccountHanler.h"
#import "RDVTabBarController.h"
#import "JSONKit.h"
#import "ProductsM.h"
@interface WEMineAddComentVC ()<UITableViewDataSource,UITableViewDelegate,UIAlertViewDelegate>
{
    WEHTTPHandler *we;


}
@end

@implementation WEMineAddComentVC

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

-(void)sendRequset
{
    
    for (ProductsM* pm in self.orderFrame.orderModel.order_products) {
        
    }
  
//  @[];
    
//    NSDictionary *dict =@{@"P_id":self.orderFrame.orderModel.o_id,
//                          @"Comment":};
//    
//    
//    
//    NSString *dictJson =[dict JSONString];
//    DLog(@"%@",dictJson);
//
//    [we executeOrderCommentsWithUserId:[AccountHanler userId] withOrderNum:self.orderFrame.orderModel.order_num withJsonStr:(NSString *) Success:^(id obj) {
//   
//        
//    } failed:^(id obj) {
//  
//        
//    }];


}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.title =@"订单评价";
    
    
    
    we= [[WEHTTPHandler alloc]init];
    
    
    [self sendRequset];
    UITableView *table = [[UITableView alloc] initWithFrame:CGRectMake(0, 0,SCREEN_WIDTH,SCREEN_HEIGHT) style:UITableViewStylePlain];
    
    
        table.backgroundColor =SET_COLOR(234.0, 234.0, 234.0);
    
    self.view.backgroundColor =SET_COLOR(234.0, 234.0, 234.0);
    
    table.delegate =self;
    table.dataSource =self;
    [self.view addSubview:table];
    
    UIView * footView= [[UIView  alloc]init];
    footView.frame =CGRectMake(0, 0, SCREEN_WIDTH, 50);
    table.tableFooterView =footView;
    
    
    
    // 提交
    UIButton *commtiBut = [UIButton buttonWithType:UIButtonTypeCustom];
    [commtiBut setFrame:CGRectMake(10, 25, SCREEN_WIDTH-20, 40)];
    [commtiBut setTitle:@"提交" forState:UIControlStateNormal];
    [commtiBut setBackgroundColor:[UIColor redColor]];
    [commtiBut addTarget:self action:@selector(commitBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [commtiBut setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [footView addSubview:commtiBut];

   
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
    return 140;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    
    return self.orderFrame.orderModel.order_products.count;
}
- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
    
    NSString * cellidentifer = @"cell";
    WEMineAddComentCell * cell = [tableView dequeueReusableCellWithIdentifier:cellidentifer];
    if (cell ==nil) {
        cell = [[WEMineAddComentCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellidentifer];
    }
    ProductsM*pm = [self.orderFrame.orderModel.order_products objectAtIndex:indexPath.row];
    DLog(@"%@",pm);
    
    cell.header.titleLabel.text =pm.p_name;
    cell.header.orderNumLa.text =pm.p_order_num;
      return cell;
    
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    
}
-(void)commitBtnClick
{



}
@end
