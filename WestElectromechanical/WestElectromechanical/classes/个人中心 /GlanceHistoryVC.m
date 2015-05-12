//
//  GlanceHistoryVC.m
//  WestElectromechanical
//
//  Created by 夏亚峰 on 15/5/7.
//  Copyright (c) 2015年 zuo. All rights reserved.
//

#import "GlanceHistoryVC.h"
#import "GlanceCell.h"
#import "WEProductHandler.h"
#import "UIImageView+WebCacheImg.h"
#import "RDVTabBarController.h"
@interface GlanceHistoryVC ()<UITableViewDelegate,UITableViewDataSource>
{
    
    
    UITableView *_table;
    NSArray *Arr;
    
}
@property (nonatomic ,strong)NSMutableArray *totalHistoryProducts;
@end

@implementation GlanceHistoryVC
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
    
    self.totalHistoryProducts =[NSMutableArray array];
    self.navigationItem.rightBarButtonItem =   [[UIBarButtonItem alloc]initWithTitle:@"清空" style:UIBarButtonItemStylePlain target:self action:@selector(clearAllClick)];
   
     self.navigationItem.rightBarButtonItem.tintColor =[UIColor whiteColor];

    
    _table = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height) style:UITableViewStylePlain];
    
    
    
  
//    NSMutableArray *images = [[NSMutableArray alloc] initWithCapacity:0];
    _table.delegate =self;
    _table.dataSource =self;
    [self.view addSubview:_table];
    _table.tableFooterView =[[UIView alloc]init];
    
    
    WEProductHandler *handler =[[WEProductHandler alloc]init];
    [handler fetchAllSuccessBlock:^(id obj) {
        DLog(@"%@",obj);
        _totalHistoryProducts = obj;
        [_table reloadData];
    } failedBlock:^(id obj) {
        DLog(@"%@",obj);
    }];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return 110;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return _totalHistoryProducts.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
    static NSString * cellidentifer = @"cell";
    GlanceCell * cell = [tableView dequeueReusableCellWithIdentifier:cellidentifer];
    if (cell ==nil) {
        
        
        cell = [[[NSBundle mainBundle] loadNibNamed:@"GlanceCell" owner:self options:nil]objectAtIndex:0];
        cell.selectionStyle = UITableViewCellSelectionStyleGray;
        
    }
    WEProductSingleModel *singleModel =_totalHistoryProducts[indexPath.row];
    [cell.imgV setWebImgUrl:singleModel.p_imgurl placeHolder:[UIImage imageNamed:@"Product_Placeholder"]];
    cell.titleLa.text=singleModel.p_name;
    cell.orderNum.text =singleModel.p_order_num;
    cell.styleBrand.text =singleModel.p_brand;
    cell.priceLa.text =singleModel.p_price;
    cell.memberPrice.text =singleModel.p_v_price;
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

-(void)clearAllClick
{



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
