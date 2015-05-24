//
//  WEMineOrderVC.m
//  WestElectromechanical
//
//  Created by zuo on 15/5/18.
//  Copyright (c) 2015年 zuo. All rights reserved.
//

#import "WEMineOrderVC.h"
#import "HTHorizontalSelectionList.h"
#import "GlanceCell.h"
#import "RDVTabBarController.h"
#import "MyOrderDetailVC.h"
#import "WEHTTPHandler.h"
#import "AccountHanler.h"
#import "MyOrderModel.h"
#import "OrderM.h"
#import "WEMineOrderCell.h"
#import "WEMyOrderFrame.h"
#import "TLAlertView.h"
#import "WEMineAddComentVC.h"
#import "Order.h"
#import "ProductsM.h"
#import "NSDictionary+JsonString.h"

#import "DataSigner.h"
#import <AlipaySDK/AlipaySDK.h>

#import "APAuthV2Info.h"
@interface WEMineOrderVC()<HTHorizontalSelectionListDelegate,HTHorizontalSelectionListDataSource,UITableViewDelegate,UITableViewDataSource>
{
    UITableView *_table;
    NSArray *Arr;
    WEHTTPHandler *we;
    TLAlertView *alertView;

}

@property (nonatomic, strong) HTHorizontalSelectionList *selectionList;
@property (nonatomic, strong) NSArray *carMakes;

@property (nonatomic, strong) UILabel *selectedItemLabel;
@property (nonatomic ,strong)MyOrderModel *orderModel;
@end
@implementation WEMineOrderVC

#pragma mark -
#pragma mark - pop和push控制器时的操作
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
        [[self rdv_tabBarController] setTabBarHidden:YES animated:YES];
    
    
    [self sendRequest];

   }

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    [[self rdv_tabBarController] setTabBarHidden:NO animated:YES];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self addTopNavBar];
    self.title = @"我的订单";
    
    we = [[WEHTTPHandler alloc]init];
    VIEW_BACKGROUND
    
    _table = [[UITableView alloc]initWithFrame:CGRectMake(0, 40, self.view.frame.size.width, SCREEN_HEIGHT-64-40) style:UITableViewStylePlain];
    _table.delegate =self;
    _table.dataSource =self;
    [self.view addSubview:_table];
  
}

-(void)sendRequest
{
    [we  executeQueryOrderTaskWithUserId:[AccountHanler userId] withState: [NSString stringWithFormat:@"%ld",(long)self.selectedItem] withPage:@"1" Success:^(id obj) {
        
        _orderModel =(MyOrderModel*)obj;
               [_table reloadData];
        
        
    } failed:^(id obj) {
        
    }];



}
-(void)addTopNavBar
{
    self.edgesForExtendedLayout = UIRectEdgeNone;
    
    self.selectionList = [[HTHorizontalSelectionList alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 40)];
    [self.selectionList setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
    
    [self.selectionList setTitleColor:[UIColor darkGrayColor] forState:UIControlStateSelected];
    
    self.selectionList.selectedButtonIndex =self.selectedItem;
    
    
    //添加竖线
    for (int i =1; i<4; i++) {
        UILabel *veticalLineLa= [[UILabel alloc]initWithFrame:CGRectMake(VIEW_WIDETH/4*i, 5, 1, 30)];
        veticalLineLa.tag = 100+i;
        veticalLineLa.backgroundColor = [UIColor lightGrayColor];
        [ self.selectionList addSubview:veticalLineLa];
    }
    self.selectionList.backgroundColor =[UIColor whiteColor];
    self.selectionList.delegate = self;
    self.selectionList.dataSource = self;
    
    self.carMakes = @[@"全  部",
                      @"待付款",
                      @"待收货",
                      @"已完成"
                      ];
    
    [self.view addSubview:self.selectionList];
    
    
}
#pragma mark - HTHorizontalSelectionListDataSource Protocol Methods

- (NSInteger)numberOfItemsInSelectionList:(HTHorizontalSelectionList *)selectionList {
    return self.carMakes.count;
}

- (NSString *)selectionList:(HTHorizontalSelectionList *)selectionList titleForItemWithIndex:(NSInteger)index {
    return self.carMakes[index];
}

#pragma mark - HTHorizontalSelectionListDelegate Protocol Methods

- (void)selectionList:(HTHorizontalSelectionList *)selectionList didSelectButtonWithIndex:(NSInteger)index {
  
    DLog(@"输出我点击的是几%@",self.carMakes[index]);
    switch (index) {
        case 0:
        {
            self.selectedItem =0;
        }
            break;
        case 1:
        {
            self.selectedItem =1;
        }
            break;
        case 2:
        {
            self.selectedItem =2;
        }
            break;
        case 3:
        {
             self.selectedItem =3;
        }
            break;


            
        default:
            break;
    }
    
    
    [self  sendRequest];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
       //这写的  有点奇怪 啊
    
    WEMyOrderFrame *orderFrame=[self.orderModel.orders  objectAtIndex:indexPath.row];
    return orderFrame.height+5;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.orderModel.orders.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
    static NSString *CellIdentifier = @"Cell";
    WEMineOrderCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if(cell == nil) {
        cell = [[WEMineOrderCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
        cell.backgroundColor =[UIColor colorFromHexCode:@"f2f2f2"];
        cell.selectionStyle =UITableViewCellSelectionStyleNone;
    }
    WEMyOrderFrame *orderFrame=[self.orderModel.orders  objectAtIndex:indexPath.row];
    cell.orderFrame = orderFrame;
    
    __weak WEMineOrderVC *bSelf = self;
    [cell.bottomView setOrderBottomViewBlock:^(UIButton *btn) {
        
        if ([btn.titleLabel.text isEqualToString:kOrderBtnTypeConfirm] ) {

            [we executeAffirmAcceptGoodsWithUserId:[AccountHanler userId] withOrderNum:orderFrame.orderModel.order_num Success:^(id obj) {
                if ([[obj objectForKey:@"message"] isEqualToString:@"0"]) {
                    [bSelf sendRequest];
                    alertView = [TLAlertView showInView:self.view withTitle:@"" message:@"我已经收到货，同意支付宝付款" confirmButtonTitle:@"确定" cancelButtonTitle:@"取消"];

                    [alertView handleCancel:^{
                        
                    } handleConfirm:^{
                        
                        
                        WEMineAddComentVC *coment = [[WEMineAddComentVC alloc]init];
                        [self.navigationController pushViewController:coment animated:YES];
                        
                    }];
                    
                    alertView.TLAnimationType = (arc4random_uniform(10) % 2 == 0) ? TLAnimationType3D : tLAnimationTypeHinge;
                    
                    
                    
                    [alertView show];

                }

            } failed:^(id obj) {
                
            }];
        }else if ([btn.titleLabel.text isEqualToString:kOrderBtnTypePay]){
            
            
            [we executePayOrderWithUserId:[AccountHanler userId] withOrderNum:orderFrame.orderModel.order_num  withTotalMoney:orderFrame.orderModel.all_money Success:^(id obj) {
                
                
                if ([[obj objectForKey:@"message"] isEqualToString:@"0"]) {
                    
                    
                    WARN_ALERT(@"支付成功");
                }
                
            } failed:^(id obj) {
                
                
            }];
            
            
            
            
        }
        
    }];
    return cell;
    
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    WEMyOrderFrame *orderFrame=[self.orderModel.orders  objectAtIndex:indexPath.row];

    MyOrderDetailVC *orderDetail = [[MyOrderDetailVC alloc]init];
   
       orderDetail.om  =  orderFrame.orderModel;
    [self.navigationController pushViewController:orderDetail animated:YES];
    
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
