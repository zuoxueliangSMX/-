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


@interface WEMineAddComentVC ()<UITableViewDataSource,UITableViewDelegate,UIAlertViewDelegate>
{
    WEHTTPHandler *we;


}
@end

@implementation WEMineAddComentVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title =@"订单评价";
    
    we= [[WEHTTPHandler alloc]init];
    
    UITableView *table = [[UITableView alloc] initWithFrame:CGRectMake(0, 0,SCREEN_WIDTH,SCREEN_HEIGHT-64) style:UITableViewStylePlain];
    
    
        table.backgroundColor =SET_COLOR(234.0, 234.0, 234.0);
    
    self.view.backgroundColor =SET_COLOR(234.0, 234.0, 234.0);
    
    table.delegate =self;
    table.dataSource =self;
    [self.view addSubview:table];
    
    UIView * footView= [[UIView  alloc]init];
    footView.bounds =CGRectMake(0, 0, SCREEN_WIDTH, 50);
    table.tableFooterView =footView;
    
    
    
    // 提交
    UIButton *commtiBut = [UIButton buttonWithType:UIButtonTypeCustom];
    [commtiBut setFrame:CGRectMake(100, 2, SCREEN_WIDTH-40, 40)];
    [commtiBut setTitle:@"提交" forState:UIControlStateNormal];
    [commtiBut setBackgroundColor:[UIColor pumpkinColor]];
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
    
    
    return 4;
}
- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
    
    NSString * cellidentifer = @"cell";
    WEMineAddComentCell * cell = [tableView dequeueReusableCellWithIdentifier:cellidentifer];
    if (cell ==nil) {
        cell = [[WEMineAddComentCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellidentifer];
        
        
        
    }
    
    
    
    return cell;
    
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    
}
-(void)commitBtnClick
{



}
@end
