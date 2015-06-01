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
#import "WEProductFilterVC.h"
#import "WECartHomeVC.h"
#import "AccountHanler.h"
#import "LoginVC.h"
#import "UIButton+Extension.h"
@interface WEProductListVC ()<UITableViewDataSource,UITableViewDelegate,UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout>
@property (nonatomic ,weak)UITableView *productList;
@property (nonatomic ,weak)UICollectionView *productCollection;
@property (nonatomic ,weak)UITableView *conditionTable;
@property (nonatomic ,weak)UIView *mask;
@property (nonatomic ,strong)NSArray *conditionArr;
@property (nonatomic ,weak)UIImageView *contitionBgView;
@property (nonatomic ,weak)UILabel *dotImage;
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

    
    if (![[NSUserDefaults standardUserDefaults] objectForKey:kProductCount]) {
        _dotImage.text = @"0";
    }else{
        
        if ([[[NSUserDefaults standardUserDefaults] objectForKey:kProductCount] integerValue]>99) {
            _dotImage.text =@"99";
        }else{
            _dotImage.text =[[NSUserDefaults standardUserDefaults] objectForKey:kProductCount];
        }
        
    }
    
    
   
    
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
    negativeSpacer1.width = 30;
    self.navigationItem.rightBarButtonItems = @[negativeSpacer, right2,negativeSpacer1,right1];
    
    
    
    
}
- (void)screen:(UIButton*)btn{
    NSLog(@"添加好友");
    WEProductFilterVC *filterVC =[[WEProductFilterVC alloc]init];
    if (_t_id.length>0&&_t_id) {
    
        filterVC.t_id = _t_id;
    }else{
        filterVC.productName = _searchName;
    }
    
    [filterVC setProductFilterBlock:^(WEProductsModel *model) {
        _products = model;
        [_productList reloadData];
        [_productCollection reloadData];
    }];
    [self.navigationController pushViewController:filterVC animated:YES];
}
- (void)condition:(UIButton*)btn{
    NSLog(@"添加好友");
//    [self exchangeView:btn];
    _mask.hidden = !_mask.hidden;
    _contitionBgView.hidden = !_contitionBgView.hidden;

}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
//    self.view.backgroundColor =[UIColor appBlueColor];
    [self addRightItem];
    VIEW_BACKGROUND;
    self.automaticallyAdjustsScrollViewInsets = NO;
    _conditionArr = @[@"最新",@"价格",@"销售量",@"评论量"];
    self.title = @"商品分类";
    [self initTableView];
    [self initCollectionView];
    [self initBottomView];
    
    [self initMaskView];
    [self initConditionTable];
}
- (void)initConditionTable
{
    UIImageView *view =[[UIImageView alloc]initWithFrame: CGRectMake(SCREEN_WIDTH-120, 64, 100, 190)];
    view.hidden = YES;
    [view setImage:[UIImage imageNamed:@"Product_order_bgView"]];
    view.userInteractionEnabled = YES;
    [self.view addSubview:view];
    _contitionBgView = view;
    
    UITableView *conditionTable =[[UITableView alloc]init];
    conditionTable.frame =CGRectMake(0, 14, 100, 176);
    conditionTable.delegate =self;
    conditionTable.dataSource =self;
    conditionTable.hidden = NO;
    conditionTable.backgroundColor =[UIColor clearColor];
    conditionTable.separatorStyle = UITableViewCellSelectionStyleNone;
    [view addSubview:conditionTable];
    
    
    _conditionTable = conditionTable;
    _conditionTable.tableFooterView = [[UIView alloc]init];

}
- (void)initMaskView
{
    UIView *maskView =[[UIView alloc]initWithFrame:CGRectMake(0, 64, SCREEN_WIDTH, SCREEN_HEIGHT-64)];
    maskView.backgroundColor =[UIColor clearColor];
    maskView.hidden = YES;
    maskView.userInteractionEnabled = YES;
    [self.view addSubview:maskView];
    _mask = maskView;
    
    
    UITapGestureRecognizer *tap =[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapMask:)];

    [_mask addGestureRecognizer:tap];
}

- (void)tapMask:(UITapGestureRecognizer *)tap
{
    _mask.hidden = !_mask.hidden;
    _contitionBgView.hidden = !_contitionBgView.hidden;

}

- (void)initTableView
{
  
    
    UITableView *productList =[[UITableView alloc]init];
    productList.frame =CGRectMake(0, 64, SCREEN_WIDTH, SCREEN_HEIGHT-44-64);
    productList.delegate =self;
    productList.dataSource =self;
    productList.hidden = YES;
    productList.backgroundColor =[UIColor colorFromHexCode:@"f2f2f2"];
//    productList.separatorStyle = UITableViewCellSelectionStyleNone;
    [self.view addSubview:productList];
    _productList = productList;
}

- (void)initBottomView
{
    UIView *view =[[UIView alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(_productCollection.frame), SCREEN_WIDTH, 44)];
    view.backgroundColor =kHightLightedColor;
    UIButton *btn =[UIButton buttonWithImageName:@"Product_exchangeType" highImageName:@"Product_exchangeType" target:self action:@selector(exchangeView:)];
    btn.frame = CGRectMake(SCREEN_WIDTH-btn.size.width-20-btn.size.width-15, (44-btn.size.height)/2.0, btn.size.width, btn.size.height);
    [view addSubview:btn];
    
    UIButton *btn1 =[UIButton buttonWithBgImageName:@"Navitation_Cart" bgHighImageName:@"Navitation_Cart" title:nil selectedTitle:nil target:self action:@selector(enterAcart:)];
    btn1.frame = CGRectMake(CGRectGetMaxX(btn.frame)+15, (44-btn1.size.height)/2.0, btn1.size.width, btn1.size.height);
    [view addSubview:btn1];
    
    UILabel *dotImage = [[UILabel alloc] init];
    dotImage.textAlignment = 1;
    
    dotImage.backgroundColor = [UIColor whiteColor];
//    dotImage.tag = RED_DOT_TAG;
    
    CGRect btnFrame = btn.frame;
    
    CGFloat x = ceilf(0.94 * btn.size.width);
    
    CGFloat y = -ceilf(0.2 * btn.size.height);
    dotImage.textColor =kNavBarColor;
    dotImage.frame = CGRectMake(x, y, 15, 15);
    
    //创建圆形遮罩，把用户头像变成圆形
    UIBezierPath* path = [UIBezierPath bezierPathWithArcCenter:CGPointMake(dotImage.frame.size.width/2,dotImage.frame.size.width/2) radius:dotImage.frame.size.width/2 startAngle:0 endAngle:2*M_PI clockwise:YES];
    CAShapeLayer* shape = [CAShapeLayer layer];
    shape.path = path.CGPath;
    dotImage.layer.mask = shape;
    [btn1 addSubview:dotImage];
    dotImage.font = font(7);
    _dotImage = dotImage;
    
    if (![[NSUserDefaults standardUserDefaults] objectForKey:kProductCount]) {
        dotImage.text = @"0";
    }else{
        
        if ([[[NSUserDefaults standardUserDefaults] objectForKey:kProductCount] integerValue]>99) {
             dotImage.text =@"99";
        }else{
             dotImage.text =[[NSUserDefaults standardUserDefaults] objectForKey:kProductCount];
        }
       
    }
    
    
    [self.view addSubview:view];
    
    
    
    
}
- (void)enterAcart:(UIButton *)btn{
    if (![AccountHanler userId]) {
        LoginVC *loginVC =[[LoginVC alloc]init];
        __weak WEProductListVC *bSelf = self;
        [loginVC setLoginBlock:^{
            if (bSelf.searchName.length>0) {
                
                [bSelf productRedreshSearchName:bSelf.searchName];
            }else{
                [bSelf productRedreshCategoryId:bSelf.t_id];
            }
        }];
        WENavitationController *nav =[[WENavitationController alloc]initWithRootViewController:loginVC];
        
        
        [self presentViewController:nav animated:YES completion:^{
            
        }];
        
        
    }else{
        
        WECartHomeVC *homeVC =[[WECartHomeVC alloc]init];
        homeVC.cartType = WECartHomeTypeAdd;
        [self.navigationController pushViewController:homeVC animated:YES];

    }
    
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
  
    if (tableView == _productList) {
        return _products.products.count;
    }else{
        return 4;
    }
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    if (tableView == _productList) {
        return 110;
    }else{
        return 44;
    }
}
- (UITableViewCell*)tableView:(UITableView*)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (tableView == _productList) {
        static NSString *CellIdentifier = @"Cell";
        WEProductTableCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
        if(cell == nil) {
            cell = [[WEProductTableCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
        }
        
        __weak WEProductListVC *bSelf =self;
        [cell setProductAddCartBlock:^(NSString *productId) {
            [bSelf productAddCart:productId];
        }];
        
        cell.backgroundColor =[UIColor colorFromHexCode:@"f2f2f2"];
        WEProductSingleModel *singleModel =_products.products[indexPath.row];
        cell.singleModel = singleModel;
        //    cell.backgroundColor =[UIColor redColor];
        
        return cell;

    }else{
        static NSString *CellIdentifier = @"conditionTable";
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
        if(cell == nil) {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            cell.accessoryType =UITableViewCellAccessoryDisclosureIndicator;
            cell.backgroundColor =[UIColor clearColor];
        }
        cell.textLabel.text =_conditionArr[indexPath.row];
        cell.textLabel.textColor =[UIColor whiteColor];
        cell.textLabel.font = font(16);
        return cell;

        
    }
}
#pragma mark -
#pragma mark - UITableViewDelegate

- (void)tableView:(UITableView*)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    
    
    if (tableView == _productList) {
        WEProductSingleModel *singleModel =_products.products[indexPath.row];
        [self getProductDeatilData:singleModel];
    }else{
        _mask.hidden = !_mask.hidden;
        _contitionBgView.hidden = !_contitionBgView.hidden;
        if (_t_id.length>0) {
            [self productOrder:_t_id withOrder:[NSString stringWithFormat:@"%ld",indexPath.row+1]];
            
        }else{
            [self productOrderSearchName:_searchName withOrder:[NSString stringWithFormat:@"%ld",indexPath.row+1]];
        }
    }
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
    
    __weak WEProductListVC *bSelf =self;
    [cell setProductAddCartBlock:^(NSString *productId) {
        [bSelf productAddCart:productId];
    }];
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
    
    
    WEProductSingleModel *singleModel =_products.products[indexPath.row];
    [self getProductDeatilData:singleModel];
    

}

- (void)getProductDeatilData:(WEProductSingleModel *)singleModel
{
    WEHTTPHandler *handler = [[WEHTTPHandler alloc]init];
    __weak WEProductListVC *bSelf = self;
    [handler executeGetProductDetailDataWithProductId:singleModel.pid withSuccess:^(id obj) {
        DLog(@"%@",obj);
        WEProductDetailModel *detailModel = (WEProductDetailModel *)obj;
        WEProductHandler *productHandler =[[WEProductHandler alloc]init];
        [productHandler addProductSingleModels:@[singleModel] success:^(id obj) {
            DLog(@"插入成功");
            WEProductDetailVC *detailVC =[[WEProductDetailVC alloc]init];
            detailVC.productId =singleModel.pid;
            detailVC.detailModel = detailModel;
            [detailVC setProductDetailBlock:^{
                if (bSelf.searchName.length>0) {
                    
                    [bSelf productRedreshSearchName:bSelf.searchName];
                }else{
                    [bSelf productRedreshCategoryId:bSelf.t_id];
                }

            }];
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

- (void)productOrder:(NSString *)t_id withOrder:(NSString *)order
{
    __weak WEProductListVC *bSelf = self;
    [[[WEHTTPHandler alloc]init] executeGetSearchDataWithSearchContent:t_id withOrder:order withSuccess:^(id obj) {
        DLog(@"222");
        bSelf.products = (WEProductsModel *)obj;
        [bSelf.productList reloadData];
        [bSelf.productCollection reloadData];
        
    } withFailed:^(id obj) {
        DLog(@"111");
    }];
}

- (void)productOrderSearchName:(NSString *)searchName withOrder:(NSString *)order
{
    __weak WEProductListVC *bSelf = self;
    
    
    [[[WEHTTPHandler alloc]init]executeGetSearchDataWithSearchProductNameOrder:searchName withOrder:order withSuccess:^(id obj) {
        bSelf.products = (WEProductsModel *)obj;
        [bSelf.productList reloadData];
        [bSelf.productCollection reloadData];
    } withFailed:^(id obj) {
        
    }];
}


// 刷新分类数据
- (void)productRedreshCategoryId:(NSString *)t_id
{
    __weak WEProductListVC *bSelf = self;
    [[[WEHTTPHandler alloc]init] executeGetSearchDataWithSearchContent:t_id withSuccess:^(id obj) {
        bSelf.products = (WEProductsModel *)obj;
        [bSelf.productList reloadData];
        [bSelf.productCollection reloadData];

    } withFailed:^(id obj) {
        
    }];
}


// 刷新产品名字搜索数据
- (void)productRedreshSearchName:(NSString *)searchName
{
    __weak WEProductListVC *bSelf = self;
    
    
    [[[WEHTTPHandler alloc]init]executeGetSearchDataWithSearchProductName:searchName withSuccess:^(id obj) {
        bSelf.products = (WEProductsModel *)obj;
        [bSelf.productList reloadData];
        [bSelf.productCollection reloadData];
    } withFailed:^(id obj) {
        
    }];
}

- (void)productAddCart:(NSString *)productId
{
    
    if (![AccountHanler userId]) {
        LoginVC *loginVC =[[LoginVC alloc]init];
        __weak WEProductListVC *bSelf = self;
        [loginVC setLoginBlock:^{
            if (bSelf.searchName.length>0) {

                [bSelf productRedreshSearchName:bSelf.searchName];
            }else{
                [bSelf productRedreshCategoryId:bSelf.t_id];
            }
        }];
        WENavitationController *nav =[[WENavitationController alloc]initWithRootViewController:loginVC];
        
        
        [self presentViewController:nav animated:YES completion:^{
            
        }];

        
    }else{
        WEHTTPHandler *handler =[[WEHTTPHandler alloc]init];
        __weak WEProductListVC *bSelf =self;
        [handler executeProductAddCartTaskWithProductId:productId withUserId:[AccountHanler userId] withSuccess:^(id obj) {
            DLog(@"%@",obj);
            WECartHomeVC *homeVC =[[WECartHomeVC alloc]init];
            homeVC.cartType = WECartHomeTypeAdd;
            [bSelf.navigationController pushViewController:homeVC animated:YES];
        } withFailed:^(id obj) {
            DLog(@"加入购物车失败");
        }];

    }
    
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
