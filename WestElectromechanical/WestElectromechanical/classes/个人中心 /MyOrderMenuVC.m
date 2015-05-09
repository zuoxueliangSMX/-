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

@interface MyOrderMenuVC ()<HTHorizontalSelectionListDelegate,HTHorizontalSelectionListDataSource,UITableViewDelegate,UITableViewDataSource>{

    
    UITableView *_table;
    NSArray *Arr;

}

@property (nonatomic, strong) HTHorizontalSelectionList *selectionList;
@property (nonatomic, strong) NSArray *carMakes;

@property (nonatomic, strong) UILabel *selectedItemLabel;


@end

@implementation MyOrderMenuVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [self addTopNavBar];
    self.title = @"我的订单";
  

    
    _table = [[UITableView alloc]initWithFrame:CGRectMake(0, 40, self.view.frame.size.width, self.view.frame.size.height) style:UITableViewStylePlain];
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
    
//    self.selectedItemLabel = [[UILabel alloc] init];
//    self.selectedItemLabel.backgroundColor = [UIColor greenColor];
//    self.selectedItemLabel.text = self.carMakes[self.selectionList.selectedButtonIndex];
//    self.selectedItemLabel.translatesAutoresizingMaskIntoConstraints = NO;
//    [self.view addSubview:self.selectedItemLabel];
//    
//    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:self.selectedItemLabel
//                                                          attribute:NSLayoutAttributeCenterX
//                                                          relatedBy:NSLayoutRelationEqual
//                                                             toItem:self.view
//                                                          attribute:NSLayoutAttributeCenterX
//                                                         multiplier:1.0
//                                                           constant:0.0]];
//    
//    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:self.selectedItemLabel
//                                                          attribute:NSLayoutAttributeCenterY
//                                                          relatedBy:NSLayoutRelationEqual
//                                                             toItem:self.view
//                                                          attribute:NSLayoutAttributeCenterY
//                                                         multiplier:1.0
//                                                           constant:0.0]];
    
    
    

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
    
    return 200;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return 10;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
    static NSString * cellidentifer = @"cell";
    GlanceCell * cell = [tableView dequeueReusableCellWithIdentifier:cellidentifer];
    if (cell ==nil) {
        
        
        cell = [[[NSBundle mainBundle] loadNibNamed:@"GlanceCell" owner:self options:nil]objectAtIndex:1];
        cell.selectionStyle = UITableViewCellSelectionStyleGray;
        
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

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
