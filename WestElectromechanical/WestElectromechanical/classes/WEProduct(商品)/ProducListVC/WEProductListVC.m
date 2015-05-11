//
//  WEProductListVC.m
//  WestElectromechanical
//
//  Created by zuo on 15/5/6.
//  Copyright (c) 2015年 zuo. All rights reserved.
//

#import "WEProductListVC.h"
#import "RDVTabBarController.h"
#import "UIBarButtonItem+Extension.h"
#import "UIButton+Extension.h"
#import "WEProductCollectionCell.h"
#import "WEProductTableCell.h"
#import "WEProductDetailVC.h"
#import "WEHTTPHandler.h"
#import "WEProductDetailModel.h"
#import "WEProductSingleModel.h"
#import "WEProductHandler.h"
@interface WEProductListVC ()<UITableViewDataSource,UITableViewDelegate,UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout>
@property (nonatomic ,weak)UITableView *productList;
@property (nonatomic ,weak)UICollectionView *productCollection;

@end

@implementation WEProductListVC
- (instancetype)init
{
    if (self =[super init]) {
        _products =[[WEProductsModel alloc]initWithDict:@{}];
    }
    return self;
}
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
    UIBarButtonItem *right1 =[UIBarButtonItem itemWithImageName:@"Product_Condition" highImageName:@"Product_Condition" target:self action:@selector(condition:)];
    UIBarButtonItem *right2 =[UIBarButtonItem itemWithImageName:@"Product_Screen" highImageName:@"Product_Screen" target:self action:@selector(screen:)];
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
- (void)screen:(UIButton*)btn{
    NSLog(@"添加好友");
}
- (void)condition:(UIButton*)btn{
    NSLog(@"添加好友");
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
//    self.view.backgroundColor =[UIColor appBlueColor];
    VIEW_BACKGROUND;
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.title = @"商品分类";
    [self initTableView];
    [self initCollectionView];
    [self initBottomView];
}

- (void)initTableView
{
    UITableView *productList =[[UITableView alloc]init];
    productList.frame =CGRectMake(0, 64, SCREEN_WIDTH, SCREEN_HEIGHT-44-64);
    productList.delegate =self;
    productList.dataSource =self;
    productList.hidden = YES;
    productList.backgroundColor =[UIColor colorFromHexCode:@"f2f2f2"];
    productList.separatorStyle = UITableViewCellSelectionStyleNone;
    [self.view addSubview:productList];
    _productList = productList;
}

- (void)initBottomView
{
    UIView *view =[[UIView alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(_productCollection.frame), SCREEN_WIDTH, 44)];
    view.backgroundColor =kHightLightedColor;
    UIButton *btn =[UIButton buttonWithImageName:@"Product_Condition" highImageName:@"Product_Condition" target:self action:@selector(exchangeView:)];
    btn.frame = CGRectMake(SCREEN_WIDTH-btn.size.width-20, (44-btn.size.height)/2.0, btn.size.width, btn.size.height);
    [view addSubview:btn];
    [self.view addSubview:view];
    
}

- (void)exchangeView:(UIButton *)btn
{
    if (_productCollection.hidden) {
        _productCollection.hidden = NO;
        _productList.hidden = YES;
    }else{
        _productCollection.hidden = YES;
        _productList.hidden = NO;
    }
}


- (void)initCollectionView
{
    UICollectionViewFlowLayout *flowLayout=[[UICollectionViewFlowLayout alloc] init];
    [flowLayout setScrollDirection:UICollectionViewScrollDirectionVertical];
    UICollectionView *  productCollection=[[UICollectionView alloc] initWithFrame:CGRectMake(0, 64, SCREEN_WIDTH, SCREEN_HEIGHT-44-64) collectionViewLayout:flowLayout];
    productCollection.dataSource=self;
    productCollection.delegate=self;
    [productCollection setBackgroundColor:[UIColor colorFromHexCode:@"f2f2f2"]];
    
    [productCollection registerClass:[WEProductCollectionCell class] forCellWithReuseIdentifier:@"UICollectionViewCell"];
    [productCollection registerClass:[UICollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"header"];
    [productCollection registerClass:[UICollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:@"footer"];
    _productCollection =productCollection;
    [self.view addSubview:productCollection];

}

#pragma mark -
#pragma mark - UITableViewDataSource

- (NSInteger)tableView:(UITableView*)tableView numberOfRowsInSection:(NSInteger)section {
    return _products.products.count;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 110;
}
- (UITableViewCell*)tableView:(UITableView*)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *CellIdentifier = @"Cell";
    WEProductTableCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if(cell == nil) {
        cell = [[WEProductTableCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    cell.backgroundColor =[UIColor colorFromHexCode:@"f2f2f2"];
    WEProductSingleModel *singleModel =_products.products[indexPath.row];
    cell.singleModel = singleModel;
//    cell.backgroundColor =[UIColor redColor];
    
    return cell;
}
#pragma mark -
#pragma mark - UITableViewDelegate

- (void)tableView:(UITableView*)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
}



#pragma mark -- UICollectionViewDataSource

//定义展示的UICollectionViewCell的个数
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return _products.products.count;
}

//定义展示的Section的个数
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}

//每个UICollectionView展示的内容
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString * CellIdentifier = @"UICollectionViewCell";
    WEProductCollectionCell * cell = [collectionView dequeueReusableCellWithReuseIdentifier:CellIdentifier forIndexPath:indexPath];
    cell.backgroundColor =[UIColor whiteColor];
    cell.singleModel =_products.products[indexPath.row];
    return cell;
}



#pragma mark --UICollectionViewDelegateFlowLayout
//定义每个Item 的大小
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    return CGSizeMake((SCREEN_WIDTH-30)/2,(SCREEN_WIDTH-30)/2+60);
}

//定义每个UICollectionView 的 margin
-(UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
{
    
    return UIEdgeInsetsMake(10,10,10,10);
}


- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section{
    
    return 10;
    
}
//设置每行的间距
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section
{
    
    return 10;
}


#pragma mark --UICollectionViewDelegate

//UICollectionView被选中时调用的方法
-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
//    DLog(@"点击的是----%ld",indexPath.row);
    
    WEHTTPHandler *handler = [[WEHTTPHandler alloc]init];
    WEProductSingleModel *singleModel =_products.products[indexPath.row];
    [handler executeGetProductDetailDataWithProductId:[_products.products[indexPath.row] pid] withSuccess:^(id obj) {
        DLog(@"%@",obj);
        WEProductDetailModel *detailModel = (WEProductDetailModel *)obj;
        WEProductHandler *productHandler =[[WEProductHandler alloc]init];
        [productHandler addProductSingleModels:@[singleModel] success:^(id obj) {
            DLog(@"插入成功");
            WEProductDetailVC *detailVC =[[WEProductDetailVC alloc]init];
            detailVC.productId =singleModel.pid;
            detailVC.detailModel = detailModel;
            [self.navigationController pushViewController:detailVC animated:YES];
        } faileBlock:^(id obj) {
            
        }];
        
    } withFailed:^(id obj) {
        DLog(@"%@",obj);
    }];
    

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
