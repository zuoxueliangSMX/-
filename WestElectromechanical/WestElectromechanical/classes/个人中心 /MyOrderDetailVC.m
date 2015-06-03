//
//  MyOrderDetailVC.m
//  WestElectromechanical
//
//  Created by 夏亚峰 on 15/5/11.
//  Copyright (c) 2015年 zuo. All rights reserved.
//

#import "MyOrderDetailVC.h"
#import "GlanceCell.h"
#import "AccountHanler.h"
#import "NSString+Base64.h"
#import "ProductsM.h"
#import "RDVTabBarController.h"
#import "WEHTTPHandler.h"

#import "UIImageView+WebCacheImg.h"

@interface MyOrderDetailVC ()<UITableViewDelegate,UITableViewDataSource>
{
    
    
    UITableView *_table;
    NSArray *Arr;
    int pCount;
    WEHTTPHandler *we ;
    
   }



@end

@implementation MyOrderDetailVC



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
    
    
    self.view.backgroundColor =[UIColor whiteColor];
    
      we = [[WEHTTPHandler alloc]init];

    self.title =@"订单详情";
 

    
    _table = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, SCREEN_HEIGHT) style:UITableViewStylePlain];
    
    _table.backgroundColor =SET_COLOR(234.0, 234.0, 234.0);

    //添加headView,footView
    
    _table.delegate =self;
    _table.dataSource =self;
      [self addHeadFoot];
    
    [self.view addSubview:_table];
    
  
    
    
    
}


-(void)addHeadFoot
{
    
    
    UIView *headView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, VIEW_WIDETH, 160)];
    
    [headView.layer setCornerRadius:5];
    
    GlanceCell *headCell = [[[NSBundle mainBundle] loadNibNamed:@"GlanceCell" owner:self options:nil]objectAtIndex:2];
    headCell.frame = CGRectMake(10, 10, SCREEN_WIDTH-20, 140);
    [headCell.layer setCornerRadius:4];
    headCell.backgroundColor = [UIColor whiteColor];
    
    headCell.orderNum.text =[NSString stringWithFormat:@"订单号 :%@",_wm.order_num];
    
    headCell.orderTimeLa.text =_wm.order_time;
    headCell.CompletedLa.text =[_wm.order_state  base64DecodedString];
    
    
    
    headCell.NameAndPhoneLa.text =[NSString stringWithFormat:@"%@  %@",_wm.order_person_name,_wm.mobile];
    headCell.WaitComentLa.text =@"";
   
    UIImageView *lineimgv = [[UIImageView alloc]initWithFrame:CGRectMake(20, CGRectGetMaxY(headCell.orderTimeLa.frame)+10,  headCell.frame.size.width-40, 1)];
    lineimgv.backgroundColor =[UIColor appLineColor];
    [headCell addSubview:lineimgv];
    
    headCell.addressLa.text =_wm.address;
    
    
    [headView addSubview:headCell];
    UIView *footView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, VIEW_WIDETH, 150)];
    GlanceCell *footCell = [[[NSBundle mainBundle] loadNibNamed:@"GlanceCell" owner:self options:nil]objectAtIndex:3];
    footCell.frame = CGRectMake(10, 10, SCREEN_WIDTH-20, 120);
    [footCell.layer setCornerRadius:4];
    footCell.backgroundColor = [UIColor whiteColor];
    footCell.backgroundColor = [UIColor whiteColor];
  
    footCell.goodsPriceLa.text = [NSString stringWithFormat:@"商品总额 :¥ %@",_wm.product_all_money];
    footCell.totalCountLa.text =[NSString stringWithFormat:@"总计 :%@件商品",_wm.gongji];
    footCell.freightageLa.text =[NSString stringWithFormat:@"共计运费: ¥ %@",_wm.yunfei];
    footCell.subtractFeeLa.text =[NSString stringWithFormat:@"减免运费: ¥ %@",_wm.reduce_yunfei];
    footCell.goodsTotalPriceLa.text = @"";
    
    
    UIImageView *lineimgv2 = [[UIImageView alloc]initWithFrame:CGRectMake(20, CGRectGetMaxY(footCell.subtractFeeLa.frame)+6,  footCell.frame.size.width-40, 1)];
    lineimgv2.backgroundColor =[UIColor appLineColor];
    [footCell addSubview:lineimgv2];
    
    [footView addSubview:footCell];
    
      _table.tableHeaderView =headView;
    _table.tableFooterView =footView;
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return 120;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return _wm.products.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
    static NSString * cellidentifer = @"cell";
    GlanceCell * cell = [tableView dequeueReusableCellWithIdentifier:cellidentifer];
    if (cell ==nil) {
        
        
        cell = [[[NSBundle mainBundle] loadNibNamed:@"GlanceCell" owner:self options:nil]objectAtIndex:0];
        cell.selectionStyle = UITableViewCellSelectionStyleGray;
        cell.backgroundColor = SET_COLOR(234.0, 234.0, 234.0);
        cell.frame =CGRectMake(0, 0, SCREEN_WIDTH, 120);
        
        UIImageView *imgV = [[UIImageView alloc]initWithFrame:CGRectMake(10, 0, 100, 120)];
        
        [cell.contentView addSubview:imgV];
        
        imgV.tag = 98;

        
    }
    
        ProductsM *pm = [_wm.products objectAtIndex:indexPath.row];
    UIImageView*imgv2 =(UIImageView*)[cell.contentView viewWithTag:98];
    imgv2.contentMode =UIViewContentModeScaleAspectFit;
    
    [imgv2  setWebImgUrl:pm.p_imgurl placeHolder:[UIImage imageNamed:@"Product_Placeholder"]];
    

    
       cell.titleLa.text=pm.p_name;
    cell.titleLa.numberOfLines = 0;
    
    cell.orderNum.text = [NSString stringWithFormat:@"西域订单编号:%@",pm.p_order_num];
   
   cell.styleBrand.text =[NSString stringWithFormat:@"型号%@  品牌%@",pm.p_version,pm.p_brand];
   
    cell.priceLa.text =[NSString stringWithFormat:@"¥%@ x %@",pm.p_price,pm.p_num];
    
    cell.priceLa.textColor =[UIColor orangeColor];
    cell.memberPrice.text =@"";
    cell.cartBtn.hidden =YES;
    
       return cell;
    
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
      [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    
}

@end
