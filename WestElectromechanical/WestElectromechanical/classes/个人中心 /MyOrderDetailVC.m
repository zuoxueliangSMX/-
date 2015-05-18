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

@interface MyOrderDetailVC ()<UITableViewDelegate,UITableViewDataSource>
{
    
    
    UITableView *_table;
    NSArray *Arr;
    int pCount;
    
}


@end

@implementation MyOrderDetailVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title =@"订单详情";
    for (int i =0; i< self.om.order_products.count; i++) {
        
        ProductsM *pm =[self.om.order_products objectAtIndex:i];
        pCount +=[pm.p_num  intValue];
    }

    
    _table = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height-44) style:UITableViewStylePlain];
    
    _table.backgroundColor =SET_COLOR(234.0, 234.0, 234.0);

    //添加headView,footView
    
    _table.delegate =self;
    _table.dataSource =self;
     [self addHeadFoot];
    
        DLog(@"输出这产品的数量%d",pCount);
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
    
    headCell.orderNum.text =[NSString stringWithFormat:@"订单号 :%@",self.om.order_num];
    
    headCell.orderTimeLa.text =self.om.order_time;
    headCell.CompletedLa.text =self.om.order_state;
    
    
    
    headCell.NameAndPhoneLa.text =[NSString stringWithFormat:@"%@  %@",[AccountHanler reciveName],[AccountHanler recivePhone]];
    headCell.WaitComentLa.text =@"";
   
    UIImageView *lineimgv = [[UIImageView alloc]initWithFrame:CGRectMake(20, CGRectGetMaxY(headCell.orderTimeLa.frame)+10,  headCell.frame.size.width-40, 1)];
    lineimgv.backgroundColor =[UIColor appLineColor];
    [headCell addSubview:lineimgv];
    
    headCell.addressLa.text =[AccountHanler addres];
    
    
    [headView addSubview:headCell];
    UIView *footView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, VIEW_WIDETH, 150)];
    GlanceCell *footCell = [[[NSBundle mainBundle] loadNibNamed:@"GlanceCell" owner:self options:nil]objectAtIndex:3];
    footCell.frame = CGRectMake(0, 10, SCREEN_WIDTH, 140);
    [footCell.layer setCornerRadius:4];
    footCell.backgroundColor = [UIColor whiteColor];
    footCell.backgroundColor = [UIColor whiteColor];
  
    footCell.goodsPriceLa.text = [NSString stringWithFormat:@"商品总额“¥ :%@",self.om.all_money];
    footCell.totalCountLa.text =[NSString stringWithFormat:@"总计 :%d件商品",pCount];
    footCell.freightageLa.text = @"共计运费: ¥ 000";
    footCell.subtractFeeLa.text =@"减免运费: 000";
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
    
    return self.om.order_products.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
    static NSString * cellidentifer = @"cell";
    GlanceCell * cell = [tableView dequeueReusableCellWithIdentifier:cellidentifer];
    if (cell ==nil) {
        
        
        cell = [[[NSBundle mainBundle] loadNibNamed:@"GlanceCell" owner:self options:nil]objectAtIndex:0];
        cell.selectionStyle = UITableViewCellSelectionStyleGray;
        cell.backgroundColor = SET_COLOR(234.0, 234.0, 234.0);
        cell.frame =CGRectMake(0, 0, SCREEN_WIDTH, 120);
        
    }
    
    //    ZyxM *zm = [zyxArr objectAtIndex:indexPath.row];
    //
    //
    //    NSString *path1 = [NSString stringWithFormat:@"%@%@",SendIFServer,zm.picture];
    //    [cell.bigImgView sd_setImageWithURL:[NSURL URLWithString:path1] placeholderImage:[UIImage imageNamed:@"about_1"] completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
    //        [[SDImageCache sharedImageCache] storeImage:image forKey:zm.picture];
    //    }];
    //
     ProductsM *pm = [self.om.order_products objectAtIndex:indexPath.row];

    
    cell.imgV.image = [UIImage imageNamed:@"Product_Placeholder"];
    cell.titleLa.text=pm.p_name;
    cell.titleLa.numberOfLines = 0;
    
    cell.orderNum.text = [NSString stringWithFormat:@"西域订单编号:%@",pm.p_order_num];
   
   cell.styleBrand.text =[NSString stringWithFormat:@"型号%@  品牌%@",pm.p_version,pm.p_brand];
   
    cell.priceLa.text =[NSString stringWithFormat:@"¥%@ x %@",pm.p_price,pm.p_num];
    
    cell.priceLa.textColor =[UIColor orangeColor];
    cell.memberPrice.text =@"";
    //    cell.cartBtn.image= [UIImage imageNamed:@"Product_AddCart"];
    
    [cell.cartBtn setBackgroundImage:[UIImage imageNamed:@"Product_AddCart"] forState:UIControlStateNormal];
    
    //    cell.titleLa.text = zm.zyxName;
    //    cell.introduceLa.text =[NSString stringFromHtml:zm.introduce];
    //    cell.priceLa.text =zm.price ;
    //    cell.accesoryImgv.image =[UIImage imageNamed:@"Person_arrow_right"];
    return cell;
    
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
    //    FreeLineDetailVC *free =[[FreeLineDetailVC alloc]init];
    //
    //
    //    ZyxM*zm = [zyxArr objectAtIndex:indexPath.row];
    //    free.zm =zm;
    //
    //
    //    [self.navigationController pushViewController:free animated:YES];
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    
}

@end
