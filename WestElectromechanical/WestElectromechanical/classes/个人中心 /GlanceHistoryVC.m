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
#import "NSString+Base64.h"
#import "WEHTTPHandler.h"
#import "WEProductDetailVC.h"
#import "LoginVC.h"
#import "AccountHanler.h"
#import "WECartHomeVC.h"
#import "UIBarButtonItem+BarButtonItem.h"
@interface GlanceHistoryVC ()<UITableViewDelegate,UITableViewDataSource>
{
    
    
    UITableView *_table;
    NSArray *Arr;
    WEProductHandler *handler;
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

- (void)addRightItem{
    UIBarButtonItem *right = [UIBarButtonItem addTarget:self WithTitle:@"清空" withColor:[UIColor whiteColor] action:@selector(clearAllClick)];
    /**
     *  width为负数时，相当于btn向右移动width数值个像素，由于按钮本身和边界间距为5pix，所以width设为-15时，间距正好调整
     *  为10；width为正数时，正好相反，相当于往左移动width数值个像素
     */
    UIBarButtonItem *negativeSpacer = [[UIBarButtonItem alloc]
                                       initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace
                                       target:nil action:nil];
    negativeSpacer.width = -15;
    self.navigationItem.rightBarButtonItems = @[negativeSpacer, right];
}




- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"浏览历史";
    self.view.backgroundColor =[UIColor whiteColor];
    self.totalHistoryProducts =[NSMutableArray array];

    [self addRightItem];
    _table = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height) style:UITableViewStylePlain];
    
    
    
  
//    NSMutableArray *images = [[NSMutableArray alloc] initWithCapacity:0];
    _table.delegate =self;
    _table.dataSource =self;
    [self.view addSubview:_table];
    _table.tableFooterView =[[UIView alloc]init];
    
    
    handler =[[WEProductHandler alloc]init];
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
    
    return 120;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return _totalHistoryProducts.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
    static NSString * cellidentifer = @"cell";
    GlanceCell * cell = [tableView dequeueReusableCellWithIdentifier:cellidentifer];
    if (cell ==nil) {
        
        
        cell = [[[NSBundle mainBundle] loadNibNamed:@"GlanceCell" owner:self options:nil]objectAtIndex:0];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
        UIImageView *imgV = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 110, 120)];
        
        [cell.contentView addSubview:imgV];
        
        imgV.tag = 10086;
    }
    WEProductSingleModel *singleModel =_totalHistoryProducts[indexPath.row];
    cell.titleLa.text= singleModel.p_name;
    cell.orderNum.text =singleModel.p_order_num;
     cell.styleBrand.text=  [NSString stringWithFormat:@"型号:%@  品牌:%@",singleModel.p_version,singleModel.p_brand];
    
    cell.priceLa.text =[NSString stringWithFormat:@"¥%@",singleModel.p_price];
    cell.memberPrice.text =[NSString stringWithFormat:@"会员价:%@",singleModel.p_v_price];
    cell.memberPrice.textColor =[UIColor redColor];
    UIImageView*imgv2 =(UIImageView*)[cell.contentView viewWithTag:10086];
    imgv2.contentMode =UIViewContentModeScaleAspectFit;

    [imgv2  setWebImgUrl:singleModel.p_imgurl placeHolder:[UIImage imageNamed:@"Product_Placeholder"]];

    cell.cartBtn.tag = indexPath.row+100;
     [cell.cartBtn setBackgroundImage:[UIImage imageNamed:@"Product_AddCart"] forState:UIControlStateNormal];
      [cell.cartBtn  addTarget:self action:@selector(productAddCart:) forControlEvents:UIControlEventTouchUpInside];
    return cell;
    
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    WEProductSingleModel *singleModel =_totalHistoryProducts[indexPath.row];
    [self getProductDetailInfo:singleModel.pid];
    
}

- (void)getProductDetailInfo:(NSString *)productId
{
    WEHTTPHandler *HTTPhandler =[[WEHTTPHandler alloc]init];
    [HTTPhandler executeGetProductDetailDataWithProductId:productId withSuccess:^(id obj) {
        DLog(@"%@",obj);
        WEProductDetailVC *detailVC =[[WEProductDetailVC alloc]init];
        detailVC.productId =productId;
        detailVC.detailModel = (WEProductDetailModel *)obj;
        [self.navigationController pushViewController:detailVC animated:YES];
    } withFailed:^(id obj) {
        
    }];
}


- (void)productAddCart:(UIButton *)button
{
    
    NSInteger row2= button.tag-100;
    
    WEProductSingleModel  *singleModel =_totalHistoryProducts[row2];
    if (![AccountHanler userId]) {
        LoginVC *loginVC =[[LoginVC alloc]init];
        UINavigationController *nav =[[UINavigationController alloc]initWithRootViewController:loginVC];
        [self presentViewController:nav animated:YES completion:^{
            
        }];
        
        
    }else{
        WEHTTPHandler *HTTPhandler =[[WEHTTPHandler alloc]init];
        __weak GlanceHistoryVC *bSelf =self;
        [HTTPhandler executeProductAddCartTaskWithProductId:singleModel.pid withUserId:[AccountHanler userId] withSuccess:^(id obj) {
            DLog(@"%@",obj);
            WECartHomeVC *homeVC =[[WECartHomeVC alloc]init];
            homeVC.cartType = WECartHomeTypeAdd;
            [bSelf.navigationController pushViewController:homeVC animated:YES];
        } withFailed:^(id obj) {
            DLog(@"加入购物车失败");
        }];
        
    }
}



-(void)clearAllClick
{

    [handler deleteProductSuccessBlock:^(id obj) {
        _totalHistoryProducts = nil;

        [_table reloadData];
    } failedBlock:^(id obj) {
        
        
          }];

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
