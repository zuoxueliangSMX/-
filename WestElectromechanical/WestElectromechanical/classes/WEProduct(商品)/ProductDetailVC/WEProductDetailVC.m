//
//  WEProductDetailVC.m
//  WestElectromechanical
//
//  Created by zuo on 15/5/7.
//  Copyright (c) 2015年 zuo. All rights reserved.
//

#import "WEProductDetailVC.h"
#import "RDVTabBarController.h"
#import "UIBarButtonItem+Extension.h"
#import "HomeHeaderScrollView.h"
#import "UIButton+Extension.h"
#import "WEHTTPHandler.h"
@interface WEProductDetailVC ()<UITableViewDataSource,UITableViewDelegate>
@property (nonatomic ,weak)HomeHeaderScrollView *headerView;
@property (nonatomic ,weak)UITableView *productForm;

@end

@implementation WEProductDetailVC
#pragma mark -
#pragma mark - pop和push控制器时的操作
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [[self rdv_tabBarController] setTabBarHidden:YES animated:YES];
    [self addRightItem];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    [[self rdv_tabBarController] setTabBarHidden:NO animated:YES];
}
- (void)addRightItem{
    UIBarButtonItem *right1 =[UIBarButtonItem itemWithImageName:@"Navitation_Cart" highImageName:@"Navitation_Cart" target:self action:@selector(addCart:)];
    UIBarButtonItem *right2 =[UIBarButtonItem itemWithImageName:@"Navitation_Cart" highImageName:@"Navitation_Cart" target:self action:@selector(shareProduct:)];
    /**
     *  width为负数时，相当于btn向右移动width数值个像素，由于按钮本身和边界间距为5pix，所以width设为-15时，间距正好调整
     *  为10；width为正数时，正好相反，相当于往左移动width数值个像素
     */
    UIBarButtonItem *negativeSpacer = [[UIBarButtonItem alloc]
                                       initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace
                                       target:nil action:nil];
    negativeSpacer.width = -5;
    
    UIBarButtonItem *negativeSpacer1= [[UIBarButtonItem alloc]
                                       initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace
                                       target:nil action:nil];
    negativeSpacer1.width = 15;
    self.navigationItem.rightBarButtonItems = @[negativeSpacer, right2,negativeSpacer1,right1];
}
- (void)addCart:(UIButton*)btn{
    NSLog(@"添加到购物车");
}
- (void)shareProduct:(UIButton*)btn{
    NSLog(@"分享产品");
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor =[UIColor colorFromHexCode:@"f2f2f2"];
    self.title = @"商品详情";
    [self initTableView];
    [self initTableHeaderView];
    [self initTableFooterView];
    
    WEHTTPHandler *handler = [[WEHTTPHandler alloc]init];
    [handler executeGetProductDetailDataWithProductId:_productId withSuccess:^(id obj) {
        DLog(@"%@",obj);
    } withFailed:^(id obj) {
        DLog(@"%@",obj);
    }];

    
}
- (void)initTableView
{
    UITableView *productForm =[[UITableView alloc]init];
    productForm.frame =CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT-64);
    productForm.delegate =self;
    productForm.dataSource =self;
    productForm.backgroundColor =[UIColor clearColor];
    [self.view addSubview:productForm];
    _productForm = productForm;
    
}
- (void)initTableHeaderView
{
    HomeHeaderScrollView *headerView =[[HomeHeaderScrollView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH,(SCREEN_HEIGHT-64)*0.3)];
    headerView.backgroundColor =[UIColor clearColor];
    [self.view addSubview:headerView];
    _headerView = headerView;
    _productForm.tableHeaderView = _headerView;
}

- (void)initTableFooterView
{
    UIView *footer =[[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 50)];
    UIButton *button =[UIButton addTarget:self WithNorTitle:@"加入购物车" withNorColor:[UIColor whiteColor] withSelectedTitle:@"加入购物车" withSelectedColor:[UIColor whiteColor] withBackgroundColor:[UIColor redColor] withTileSize:font(16) action:@selector(addProductCart:)];
    button.frame = CGRectMake(5, 5, SCREEN_WIDTH-10, 40);
    button.layer.cornerRadius = 5;
    [footer addSubview:button];
    
    _productForm.tableFooterView = footer;
}
- (void)addProductCart:(UIButton *)btn
{
    
}
#pragma mark -
#pragma mark - UITableViewDataSource

- (NSInteger)tableView:(UITableView*)tableView numberOfRowsInSection:(NSInteger)section {
    return 3;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 44;
}
- (UITableViewCell*)tableView:(UITableView*)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if(cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;

    }
    if (indexPath.row > 0) {
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    }
    cell.textLabel.text = @"更多产品";
    return cell;
}
#pragma mark -
#pragma mark - UITableViewDelegate

- (void)tableView:(UITableView*)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
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
