//
//  WECartVC.m
//  WestElectromechanical
//
//  Created by zuo on 15/4/26.
//  Copyright (c) 2015年 zuo. All rights reserved.
//

#import "WECartHomeVC.h"
#import "WECartHomeCell.h"
#import "WEHTTPHandler.h"
#import "JsonToModel.h"
#import "MyCartM.h"
@interface WECartHomeVC ()<UITableViewDelegate,UITableViewDataSource>
{

   int _num;
    UILabel *totalPriceLa;
    UITextField *qnumTF;
    UITableView *cartTable;
    NSString *str;
    WEHTTPHandler *we;
    NSMutableArray *arr;
    
    
}
/**
 *  购物车TableView
 */
@property (nonatomic ,weak)UITableView *cartTable;
@property (nonatomic ,strong)WECartsModel *cartsModel;

@end

@implementation WECartHomeVC


- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    [we executeGetCartListTaskWithUserId:@"15472" withPage:@"1" Success:^(id obj) {
    
        DLog(@"输出我的购物车里面的数据%@",obj);
        _cartsModel = (WECartsModel *)obj;
        [self.cartTable reloadData];

        
    } failed:^(id obj) {
        
    }];
    
}
- (void)viewDidLoad {
    [super viewDidLoad];
    we = [[WEHTTPHandler alloc]init];
    
    arr = [[NSMutableArray alloc] initWithCapacity:0];
    
   
    [self initCartTable];
}

-(void)initCartTable
{   //新加的注释
    cartTable =[[UITableView alloc]init];
    cartTable.frame =CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT-49-44);
    cartTable.delegate =self;
    cartTable.dataSource =self;
    cartTable.backgroundColor =[UIColor clearColor];
    [self.view addSubview:cartTable];
    cartTable.tableFooterView =[[UIView alloc]init];
    _cartTable = cartTable;

}

#pragma mark -
#pragma mark - UITableViewDataSource

- (NSInteger)tableView:(UITableView*)tableView numberOfRowsInSection:(NSInteger)section {
    return _cartsModel.products.count;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 180;
}
- (UITableViewCell*)tableView:(UITableView*)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *CellIdentifier = @"Cell";
    WECartHomeCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if(cell == nil) {
        cell = [[WECartHomeCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    
       MyCartM *mcm = [_cartsModel.products objectAtIndex:indexPath.row];
    DLog(@"mycarrt-------->%ld",indexPath.row);
    DLog(@"mycarrt-------->%@",mcm);
    DLog(@"mycarrt-------->%@",[NSString stringWithFormat:@"型号:%@ 品牌:%@",mcm.p_version,mcm.p_brand]);
    cell.wbgv.middleview.priceLabel.text =mcm.p_price;
//
    cell.wbgv.middleview.versionBrandLa.text =[NSString stringWithFormat:@"型号:%@ 品牌:%@",mcm.p_version,mcm.p_brand];
//
    cell.wbgv.middleview.productLabel.text =mcm.p_name;
//
    cell.wbgv.middleview.productCartIdLabel.text =mcm.p_order_num;
//
  
    __weak WECartHomeCell *bCell =(WECartHomeCell *)[tableView cellForRowAtIndexPath:indexPath];
    [cell.wbgv.bottomView setCartHomeCellBottomCutBlock:^(NSInteger tfNum,UITextField *numTf,UILabel*jineLa) {
        DLog(@"%ld",(long)tfNum);
        
        tfNum--;
        
        if (tfNum<0) {
            tfNum=0;
        }
        str = [NSString stringWithFormat:@"%ld",(long)tfNum];\
        DLog(@"%@",str);
        
        numTf.text =str;
        jineLa.text=[NSString stringWithFormat:@"金额:%d",[str  intValue]*800];
        dispatch_async(dispatch_get_main_queue(), ^{
            [cartTable reloadData];
        });
        
        }];
    
    
    [cell.wbgv.bottomView setCartHomeCellBottomPlusBlock:^(NSInteger tfNum,UITextField *numTf,UILabel*jineLa) {
        DLog(@"%ld",(long)tfNum);
       
        tfNum++;
     

        str = [NSString stringWithFormat:@"%ld",(long)tfNum];
        DLog(@"%@",str);
 
        numTf.text =str;
        jineLa.text=[NSString stringWithFormat:@"金额:%d",[str  intValue]*800];

        dispatch_async(dispatch_get_main_queue(), ^{
            [cartTable reloadData];
            
            
        });
        

    }];

    return cell;
}
#pragma mark -
#pragma mark - UITableViewDelegate

- (void)tableView:(UITableView*)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
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
