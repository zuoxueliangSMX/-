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
#import "WEProductInfoView.h"
#import "WEProductDetailInfoCell.h"
#import "AccountHanler.h"
#import "LoginVC.h"
#import "WEAdModel.h"
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

}
- (void)initTableView
{
    UITableView *productForm =[[UITableView alloc]init];
    productForm.frame =CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT);
    productForm.delegate =self;
    productForm.dataSource =self;
    productForm.bounces = NO;
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
    
    UIButton * collectionBtn =[UIButton buttonWithBgImageName:@"Product_collectionBtnBg" bgHighImageName:@"Product_collectionBtnBg" title:@"收藏" selectedTitle:@"已收藏" target:self action:@selector(collectionClick:)];
    collectionBtn.selected = _detailModel.isCollect;
    collectionBtn.frame = CGRectMake(SCREEN_WIDTH-80, CGRectGetHeight(_headerView.frame)-40, 60, 25);
    [_headerView addSubview:collectionBtn];
    _productForm.tableHeaderView = _headerView;
    
    NSMutableArray *temArray =[NSMutableArray array];
    UIImage * PlaceholderImage = [UIImage imageNamed:@"Home_Middle_04"];
    NSInteger index = 1;
    for (WEProductImgModel *adModel in _detailModel.imgs) {
        //网络图片
        //***********************//
        //key pic = 地址 NSString
        //key title = 显示的标题 NSString
        //key isLoc = 是否本地图片 Bool
        //key placeholderImage = 网络图片加载失败时显示的图片 UIImage
        //***********************//
        NSString *picTag =[NSString stringWithFormat:@"PIC%ld",index];
        DLog(@"%@",adModel.imgurl);

        DLog(@"%@",[NSDictionary dictionaryWithObjects:@[adModel.imgurl,picTag,@NO,PlaceholderImage] forKeys:@[@"pic",@"title",@"isLoc",@"placeholderImage"]]);
        [temArray addObject:[NSDictionary dictionaryWithObjects:@[adModel.imgurl,picTag,@NO,PlaceholderImage] forKeys:@[@"pic",@"title",@"isLoc",@"placeholderImage"]]];
    }
    headerView.imageURLs = temArray;
    if (temArray.count >0) {
        [headerView.imgPlayerView upDate];

    }
}

- (void)collectionClick:(UIButton *)btn
{
    DLog(@"收藏");
    WEHTTPHandler *handler =[[WEHTTPHandler alloc]init];

    if ([AccountHanler userId]) {
        if (btn.selected) {
            
            [handler executeDeleteMyCollectionTaskWithUserId:[AccountHanler userId] withProductIds:self.productId Success:^(id obj) {
                btn.selected = NO;
            } failed:^(id obj) {
                
            }];
        }else{
            [handler executeProductCollectionTaskWithProductId:self.productId withUserId:[AccountHanler userId] withSuccess:^(id obj) {
                btn.selected = YES;
            } withFailed:^(id obj) {
                
            }];
            
            
        }

    }else{
        
        LoginVC *loginVC =[[LoginVC alloc]init];
        UINavigationController *nav =[[UINavigationController alloc]initWithRootViewController:loginVC];
        [self presentViewController:nav animated:YES completion:^{
            
        }];
    }
    
    
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
    if (indexPath.row<1) {
        return [WEProductInfoView sizeWithDetailModel:_detailModel].height;
    }
    return 44;
}
- (UITableViewCell*)tableView:(UITableView*)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *CellIdentifier = @"Cell";
    WEProductDetailInfoCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if(cell == nil) {
        cell = [[WEProductDetailInfoCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;

    }
    if (indexPath.row > 0) {
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
       cell.textLabel.text = @"更多产品";
    }else{
         cell.detailModel =_detailModel;
    }
    
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
