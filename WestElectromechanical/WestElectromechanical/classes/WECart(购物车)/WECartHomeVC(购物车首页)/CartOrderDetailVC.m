//
//  CartOrderDetailVC.m
//  WestElectromechanical
//
//  Created by 夏亚峰 on 15/5/15.
//  Copyright (c) 2015年 zuo. All rights reserved.
//

#import "CartOrderDetailVC.h"
#import "GlanceCell.h"
#import "WEProductHandler.h"
#import "UIImageView+WebCacheImg.h"
#import "MyCartM.h"
#import "NSString+Base64.h"
#import "RDVTabBarController.h"
@interface CartOrderDetailVC ()<UITableViewDelegate,UITableViewDataSource>
{
    
    
    UITableView *_table;
    NSArray *Arr;
    
}
@property (nonatomic ,strong)NSMutableArray *totalHistoryProducts;


@end

@implementation CartOrderDetailVC
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
    self.view.backgroundColor =[UIColor colorFromHexCode:@"f2f2f2"];
    _table = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height-64) style:UITableViewStylePlain];
    
    
    
    
    //    NSMutableArray *images = [[NSMutableArray alloc] initWithCapacity:0];
    _table.delegate =self;
    _table.dataSource =self;
    [self.view addSubview:_table];
    _table.tableFooterView =[[UIView alloc]init];
    

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return 110;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return self.Mu.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
    static NSString * cellidentifer = @"cell";
    GlanceCell * cell = [tableView dequeueReusableCellWithIdentifier:cellidentifer];
    if (cell ==nil) {
        
        
        cell = [[[NSBundle mainBundle] loadNibNamed:@"GlanceCell" owner:self options:nil]objectAtIndex:0];
        cell.selectionStyle = UITableViewCellSelectionStyleGray;
        
    }
    MyCartM *mc =self.Mu[indexPath.row];
    [cell.imgV setWebImgUrl:mc.p_imgurl placeHolder:[UIImage imageNamed:@"Product_Placeholder"]];
    DLog(@"输出这张卑微的图片%@",mc.p_imgurl);
    cell.titleLa.text=[mc.p_name base64DecodedString];
  
    
     cell.orderNum.text = [NSString stringWithFormat:@"西域订单编号:%@",mc.p_order_num];
    cell.styleBrand.text =mc.p_brand;
    cell.priceLa.text= [NSString stringWithFormat:@"¥:%@ x %@",mc.p_price,mc.p_num];
    cell.priceLa.textColor = [UIColor orangeColor];
    cell.memberPrice.hidden =YES;
       [cell.cartBtn setBackgroundImage:[UIImage imageNamed:@"Product_AddCart"] forState:UIControlStateNormal];
    cell.cartBtn.hidden =YES;
    return cell;
    
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
   
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    
}
@end
