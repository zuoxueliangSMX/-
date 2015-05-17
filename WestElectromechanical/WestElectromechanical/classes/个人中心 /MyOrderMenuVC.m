//
//  MyOrderMenuVC.m
//  flame
//
//  Created by xia on 15-5-8.
//  Copyright (c) 2015年 dsfa. All rights reserved.
//

#import "MyOrderMenuVC.h"
#import "HTHorizontalSelectionList.h"
#import "GlanceCell.h"
#import "RDVTabBarController.h"
#import "MyOrderDetailVC.h"
#import "WEHTTPHandler.h"
#import "AccountHanler.h"
#import "MyOrderModel.h"
#import "OrderM.h"
@interface MyOrderMenuVC ()<HTHorizontalSelectionListDelegate,HTHorizontalSelectionListDataSource,UITableViewDelegate,UITableViewDataSource>{

    
    UITableView *_table;
    NSArray *Arr;
    
    WEHTTPHandler *we;

}

@property (nonatomic, strong) HTHorizontalSelectionList *selectionList;
@property (nonatomic, strong) NSArray *carMakes;

@property (nonatomic, strong) UILabel *selectedItemLabel;
@property (nonatomic ,strong)MyOrderModel *orderModel;


@end

@implementation MyOrderMenuVC

#pragma mark -
#pragma mark - pop和push控制器时的操作
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [[self rdv_tabBarController] setTabBarHidden:YES animated:YES];
    
    
    
    [we  executeQueryOrderTaskWithUserId:[AccountHanler userId] withState:@"0" withPage:@"1" Success:^(id obj) {
        DLog(@"输出我的订单有多少%@",obj);
        
        _orderModel =(MyOrderModel*)obj;
        
         
        
    } failed:^(id obj) {
      
    }];
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
    
    _table = [[UITableView alloc]initWithFrame:CGRectMake(0, 40, self.view.frame.size.width, self.view.frame.size.height-64) style:UITableViewStylePlain];
    _table.delegate =self;
    _table.dataSource =self;
    [self.view addSubview:_table];

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
    // update the view for the corresponding index
    self.selectedItemLabel.text = self.carMakes[index];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return 230;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return self.orderModel.orders.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
    static NSString * cellidentifer = @"cell";
    GlanceCell * cell = [tableView dequeueReusableCellWithIdentifier:cellidentifer];
    if (cell ==nil) {
        
        
        cell = [[[NSBundle mainBundle] loadNibNamed:@"GlanceCell" owner:self options:nil]objectAtIndex:1];
        cell.selectionStyle = UITableViewCellSelectionStyleGray;
        cell.backgroundColor =SET_COLOR(234.0, 234.0, 234.0);
               UIView *cellBgview = [[UIView alloc]initWithFrame:CGRectMake(0, 10, SCREEN_WIDTH, 219)];
        
        cellBgview.backgroundColor = SET_COLOR(246.0, 246.0, 246.0);
        [cell insertSubview:cellBgview atIndex:0];
       
        
        UIImageView *lineimgv2 = [[UIImageView alloc]initWithFrame:CGRectMake(10, CGRectGetMaxY(cell.orderTimeLa.frame)+10,  SCREEN_WIDTH-20, 1)];
        lineimgv2.backgroundColor =[UIColor appLineColor];
        [cellBgview addSubview:lineimgv2];
        
        UIImageView *lineimgv1 = [[UIImageView alloc]initWithFrame:CGRectMake(10, CGRectGetMaxY(cell.priceLa.frame)+21,  SCREEN_WIDTH-20, 1)];
        lineimgv1.backgroundColor =[UIColor appLineColor];
        [cellBgview addSubview:lineimgv1];

    }
    
    //    ZyxM *zm = [zyxArr objectAtIndex:indexPath.row];
    //
    //
    //    NSString *path1 = [NSString stringWithFormat:@"%@%@",SendIFServer,zm.picture];
    //    [cell.bigImgView sd_setImageWithURL:[NSURL URLWithString:path1] placeholderImage:[UIImage imageNamed:@"about_1"] completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
    //        [[SDImageCache sharedImageCache] storeImage:image forKey:zm.picture];
    //    }];
    //
    
    cell.orderCodeLa.text =@"订单号: 0dadfasf907654";
    cell.orderTimeLa.text =@"下单时间: 2015-02-08";
    cell.changgeLa.text =@"待付款";
    cell.totalPriceLa.text =@"总计: ¥100000";
    [cell.changeBtn setTitle:@"立即支付" forState:UIControlStateNormal];
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
    
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    MyOrderDetailVC *orderDetail = [[MyOrderDetailVC alloc]init];
    
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
