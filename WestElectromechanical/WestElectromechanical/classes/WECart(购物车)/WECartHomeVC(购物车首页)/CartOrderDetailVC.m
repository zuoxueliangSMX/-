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

@interface CartOrderDetailVC ()<UITableViewDelegate,UITableViewDataSource>
{
    
    
    UITableView *_table;
    NSArray *Arr;
    
}
@property (nonatomic ,strong)NSMutableArray *totalHistoryProducts;


@end

@implementation CartOrderDetailVC

- (void)viewDidLoad {
    [super viewDidLoad];
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
    
    return 5;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
    static NSString * cellidentifer = @"cell";
    GlanceCell * cell = [tableView dequeueReusableCellWithIdentifier:cellidentifer];
    if (cell ==nil) {
        
        
        cell = [[[NSBundle mainBundle] loadNibNamed:@"GlanceCell" owner:self options:nil]objectAtIndex:0];
        cell.selectionStyle = UITableViewCellSelectionStyleGray;
        
    }
//    WEProductSingleModel *singleModel =_totalHistoryProducts[indexPath.row];
//    [cell.imgV setWebImgUrl:singleModel.p_imgurl placeHolder:[UIImage imageNamed:@"Product_Placeholder"]];
    
    cell.imgV.image = [UIImage imageNamed:@"Product_Placeholder"];
    cell.titleLa.text=@"组合工具";
    cell.orderNum.text =@"订单号： 0919898767yhu";
    cell.styleBrand.text =@"苹果品牌";
    cell.priceLa.text =@"¥100000";
    cell.memberPrice.text =@"8000";
    //    cell.cartBtn.image= [UIImage imageNamed:@"Product_AddCart"];
    
    [cell.cartBtn setBackgroundImage:[UIImage imageNamed:@"Product_AddCart"] forState:UIControlStateNormal];
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
