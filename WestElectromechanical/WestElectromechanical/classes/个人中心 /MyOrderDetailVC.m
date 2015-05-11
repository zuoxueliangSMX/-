//
//  MyOrderDetailVC.m
//  WestElectromechanical
//
//  Created by 夏亚峰 on 15/5/11.
//  Copyright (c) 2015年 zuo. All rights reserved.
//

#import "MyOrderDetailVC.h"
#import "GlanceCell.h"

@interface MyOrderDetailVC ()<UITableViewDelegate,UITableViewDataSource>
{
    
    
    UITableView *_table;
    NSArray *Arr;
    
}


@end

@implementation MyOrderDetailVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title =@"订单详情";
    
    _table = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height-44) style:UITableViewStylePlain];
    
    _table.backgroundColor =SET_COLOR(234.0, 234.0, 234.0);

    //添加headView,footView
    [self addHeadFoot];
    _table.delegate =self;
    _table.dataSource =self;
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
    headCell.orderNum.text =@"订单号 :11111111";
    headCell.orderTimeLa.text =@"2015.05.11";
    headCell.CompletedLa.text =@"已完成";
    headCell.NameAndPhoneLa.text =@"徐琳  15515717255";
    headCell.WaitComentLa.text =@"带评价";
    
    UIImageView *lineimgv = [[UIImageView alloc]initWithFrame:CGRectMake(20, CGRectGetMaxY(headCell.orderTimeLa.frame)+10,  headCell.frame.size.width-40, 1)];
    lineimgv.backgroundColor =[UIColor appLineColor];
    [headCell addSubview:lineimgv];
    
    headCell.addressLa.text =@"上海市机械制造厂,专业修理核潜艇，航母保修，核弹头保存，等业务";
    
    
    [headView addSubview:headCell];
    UIView *footView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, VIEW_WIDETH, 150)];
    GlanceCell *footCell = [[[NSBundle mainBundle] loadNibNamed:@"GlanceCell" owner:self options:nil]objectAtIndex:3];
    footCell.frame = CGRectMake(0, 10, SCREEN_WIDTH, 140);
    [footCell.layer setCornerRadius:4];
    footCell.backgroundColor = [UIColor whiteColor];
    footCell.backgroundColor = [UIColor whiteColor];
    footCell.goodsPriceLa.text = @"商品总额“¥ :800.00";
    footCell.totalCountLa.text =@"共计 5 件商品";
    footCell.freightageLa.text = @"共计运费: ¥ 8";
    footCell.subtractFeeLa.text =@"减免运费: 30";
    footCell.goodsTotalPriceLa.text =@"总计:  ¥888";
    
    
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
    
    return 3;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
    static NSString * cellidentifer = @"cell";
    GlanceCell * cell = [tableView dequeueReusableCellWithIdentifier:cellidentifer];
    if (cell ==nil) {
        
        
        cell = [[[NSBundle mainBundle] loadNibNamed:@"GlanceCell" owner:self options:nil]objectAtIndex:0];
        cell.selectionStyle = UITableViewCellSelectionStyleGray;
        cell.backgroundColor = SET_COLOR(234.0, 234.0, 234.0);
        
    }
    
    //    ZyxM *zm = [zyxArr objectAtIndex:indexPath.row];
    //
    //
    //    NSString *path1 = [NSString stringWithFormat:@"%@%@",SendIFServer,zm.picture];
    //    [cell.bigImgView sd_setImageWithURL:[NSURL URLWithString:path1] placeholderImage:[UIImage imageNamed:@"about_1"] completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
    //        [[SDImageCache sharedImageCache] storeImage:image forKey:zm.picture];
    //    }];
    //
    
    cell.imgV.image = [UIImage imageNamed:@"Product_Placeholder"];
    cell.titleLa.text=@"CPU芯片";
    cell.orderNum.text =@"090807";
    cell.styleBrand.text =@"89-2型 联发科品牌";
    cell.priceLa.text =@"999元";
    cell.memberPrice.text =@"9.9元";
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
