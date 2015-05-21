//
//  WEHomeVC.m
//  WestElectromechanical
//
//  Created by zuo on 15/4/26.
//  Copyright (c) 2015年 zuo. All rights reserved.
//

#import "WEHomeVC.h"
#import "RDVTabBarController.h"
#import <CoreLocation/CoreLocation.h>
#import "WELocationManager.h"
#import "UIBarButtonItem+Extension.h"
#import "WEHomeScrollView.h"
#import "UIImageView+WebCacheImg.h"
#import "WEHomeCityVC.h"
#import "WEHTTPHandler.h"
#import "WEHomeInfoModel.h"
#import "AppDelegate.h"
#import "WEProductListVC.h"
#import "WEProductDetailVC.h"
#import "WEHomeAdDetailVC.h"
#import "UIBarButtonItem+Extension.h"
@interface WEHomeVC ()
@property (nonatomic ,strong)NSMutableArray *imgurls;
@property (nonatomic ,weak)WEHomeScrollView *homeScroll;
@property (nonatomic ,strong)WEHomeInfoModel *homeInfoModel;
@end

@implementation WEHomeVC
#pragma mark -
#pragma mark - pop和push控制器时的操作
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [[self rdv_tabBarController] setTabBarHidden:NO animated:YES];
    [self addRightItem];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    [[self rdv_tabBarController] setTabBarHidden:NO animated:YES];
}


- (void)addRightItem{
    [self addRightItemWithImage:@"Navigation_Search" action:@selector(searchData:)];
}

- (UIButton *)addRightItemWithImage:(NSString *)imageName action:(SEL)action {
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    UIImage *image = [UIImage imageNamed:imageName];
    button.frame = CGRectMake(0, 0, image.size.width, image.size.height);
    
    // 这里需要注意：由于是想让图片右移，所以left需要设置为正，right需要设置为负。正在是相反的。
    // 让按钮图片右移15
    //[button setImageEdgeInsets:UIEdgeInsetsMake(0, 15, 0, -15)];
    
    [button setImage:image forState:UIControlStateNormal];
    [button addTarget:self action:action forControlEvents:UIControlEventTouchUpInside];
    button.titleLabel.font = [UIFont systemFontOfSize:16];
    UIBarButtonItem *rightItem = [[UIBarButtonItem alloc] initWithCustomView:button];
    self.navigationItem.rightBarButtonItem = rightItem;
    return button;
}

- (void)searchData:(UIButton *)click
{
    AppDelegate *delegate =(AppDelegate *)[UIApplication sharedApplication].delegate;
    delegate.tabBarController.selectedIndex =1;

}
- (void)setBarButtonItems
{
    self.navigationItem.titleView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"Navigation_logo"]];
}

- (void)setLeftItems
{
    UIBarButtonItem *right =[UIBarButtonItem
                              itemWithImageName:@"Navigation_arrow_down"
                              withTitle:[[[NSUserDefaults standardUserDefaults] objectForKey:kHomeCityKey] substringToIndex:2]
                          highImageName:@"Navigation_arrow_down" withHighTitle:[[[NSUserDefaults standardUserDefaults] objectForKey:kHomeCityKey] substringToIndex:2] target:self action:@selector(cityLocationClick:)];
    /**
     *  width为负数时，相当于btn向右移动width数值个像素，由于按钮本身和边界间距为5pix，所以width设为-15时，间距正好调整
     *  为10；width为正数时，正好相反，相当于往左移动width数值个像素
     */
    UIBarButtonItem *negativeSpacer = [[UIBarButtonItem alloc]
                                       initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace
                                       target:nil action:nil];
    negativeSpacer.width = -5;
    self.navigationItem.leftBarButtonItems = @[negativeSpacer, right];

}
- (void)cityLocationClick:(UIButton *)btn
{
    DLog(@"城市定位");
    WEHomeCityVC *homeCityVC =[[WEHomeCityVC alloc]init];
//    WENavitationController *homeCity =[[WENavitationController alloc]initWithRootViewController:homeCity];
    __weak WEHomeVC *bSelf = self;
    [homeCityVC setHomeCityBlock:^(NSString *city) {
//        NSString *cityStr =[city substringToIndex:2];
        bSelf.navigationItem.leftBarButtonItems =nil;
        [bSelf setLeftItems];
    }];
    [self.navigationController pushViewController:homeCityVC animated:YES];
    
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor =[UIColor colorFromHexCode:@"#f2f2f2"];
    [self setBarButtonItems];

    self.automaticallyAdjustsScrollViewInsets = NO;
    __weak WEHomeVC *bSelf =self;
    WEHomeScrollView *scrollView =[[WEHomeScrollView alloc]initWithFrame:CGRectMake(0, 64, SCREEN_WIDTH, SCREEN_HEIGHT-64-49)];
    scrollView.userInteractionEnabled = YES;
    scrollView.backgroundColor =[UIColor clearColor];
    scrollView.contentSize = CGSizeMake(SCREEN_WIDTH, SCREEN_HEIGHT-64-49);
    scrollView.bounces = NO;
    scrollView.showsHorizontalScrollIndicator = NO;
    scrollView.showsVerticalScrollIndicator = NO;
    [self.view addSubview:scrollView];
    [scrollView.bottomView setHomeBottomScrollViewBlock:^(NSInteger bgTag, NSInteger imgTag) {
        DLog(@"%ld    -----    %ld",bgTag,imgTag);
        DLog(@"%@------%@-----%@",[_homeInfoModel.recommends[bgTag*4+imgTag] p_id],[_homeInfoModel.recommends[bgTag*4+imgTag] contentid],[_homeInfoModel.recommends[bgTag*4+imgTag] Imgurl]);
        [bSelf getProductDetailInfo:[_homeInfoModel.recommends[bgTag*4+imgTag] p_id]];
    }];

    [scrollView.middleView setHomeMiddleViewAdLabelBlock:^(NSInteger index) {
        DLog(@"%@",[_homeInfoModel.nocices[index-1000] n_name]);
        WEHomeAdDetailVC *adDetailVC =[[WEHomeAdDetailVC alloc]init];
        adDetailVC.noticeContent =[_homeInfoModel.nocices[index-1000] n_name];
        [bSelf.navigationController pushViewController:adDetailVC animated:YES];
    }];
    [scrollView.middleView setHomeMiddleVieBlock:^(NSInteger index) {
        if (index == 0) {
            AppDelegate *delegate =(AppDelegate *)[UIApplication sharedApplication].delegate;
            delegate.tabBarController.selectedIndex =2;
//            [delegate.tabBarController viewControllerAtIndex:3];
        }else if(index ==1){

            [bSelf getNextVCData:@"1000949"];

        }else if(index == 2){
            [bSelf getNextVCData:@"1009581"];

        }else{
            [bSelf getNextVCData:@"1006595"];
        }
    }];
    [scrollView.headerView setHomeHeaderScrollViewBlock:^(NSString *pid) {
        [bSelf getProductDetailInfo:pid];

    }];
    _homeScroll = scrollView;
    
    [self setLeftItems];
    
    WELocationManager *mgr =[WELocationManager sharedWELocationManager];
    
    [mgr getLocationCity:^(NSString *cityString) {
        
        DLog(@"%@=------%@",cityString,[[NSUserDefaults standardUserDefaults] objectForKey:kHomeCityKey]);
        if ([cityString rangeOfString:[[NSUserDefaults standardUserDefaults] objectForKey:kHomeCityKey]].location !=NSNotFound||[[[NSUserDefaults standardUserDefaults] objectForKey:kHomeCityKey] rangeOfString:cityString].location!=NSNotFound) {
            DLog(@"定位的城市相同");
        }else{
            DLog(@"您现在定位的城市是%@,是否本地地址选择为定位地址",cityString);
            
            [[NSUserDefaults standardUserDefaults] setObject:cityString forKey:kHomeCityKey];
            [bSelf setLeftItems];
        }
    }];
    

    [self initNetData:@"北京"];
}

/**
 *  获取下一个控制器的数据
 */
- (void)getNextVCData:(NSString *)categroyId
{
    WEHTTPHandler *handler =[[WEHTTPHandler alloc]init];
    __weak WEHomeVC *bSelf =self;
    [handler executeGetSearchDataWithSearchContent:categroyId withSuccess:^(id obj) {
        WEProductListVC *productListVC =[[WEProductListVC alloc]init];
        productListVC.products = (WEProductsModel *)obj;
        [bSelf.navigationController pushViewController:productListVC animated:YES];
        
    } withFailed:^(id obj) {
        
    }];
    
}


/**
 *  获取首页数据
 */
- (void)initNetData:(NSString *)cityName
{
    WEHTTPHandler *handler =[[WEHTTPHandler alloc]init];
    __weak WEHomeVC *bSelf = self;
    [handler executeGetHomeDataTaskWithCityName:cityName withSuccess:^(id obj) {
        DLog(@"homeVC----->%@",obj);
        _homeInfoModel = (WEHomeInfoModel *)obj;
//        [self initAdData:@"1"];
        [bSelf showADInfo];
        [bSelf showMiddleAdLabelInfo];
        [bSelf showRecommendsInfo];
    } withFailed:^(id obj) {
        DLog(@"homeVC--error-->%@",obj);
    }];
}
- (void)showMiddleAdLabelInfo
{
    NSMutableArray *tem =[NSMutableArray array];
    for (int i = 0; i < _homeInfoModel.nocices.count; i++) {
        WENoticeModel *noticeModel =_homeInfoModel.nocices[i];
        [tem addObject:noticeModel.n_name];
    }
    [_homeScroll.middleView.adLabel animateWithWords:tem forDuration:3.0];

}
- (void)showRecommendsInfo
{
    [_homeScroll.bottomView setUpRecommendsData:_homeInfoModel.recommends];
}
- (void)showADInfo
{
    NSMutableArray *temArray =[NSMutableArray array];
    UIImage * PlaceholderImage = [UIImage imageNamed:@"product_load_default"];
    NSInteger index = 1;
    for (WEAdModel *adModel in _homeInfoModel.ads) {
        //网络图片
        //***********************//
        //key pic = 地址 NSString
        //key title = 显示的标题 NSString
        //key isLoc = 是否本地图片 Bool
        //key placeholderImage = 网络图片加载失败时显示的图片 UIImage
        //***********************//
        NSString *picTag =[NSString stringWithFormat:@"PIC%ld",(long)index];
        DLog(@"%@",[NSDictionary dictionaryWithObjects:@[adModel.pic,picTag,@NO,PlaceholderImage] forKeys:@[@"pic",@"title",@"isLoc",@"placeholderImage"]]);
        DLog(@"%@",adModel.pic);
        [temArray addObject:[NSDictionary dictionaryWithObjects:@[adModel.pic,picTag,@NO,PlaceholderImage,adModel.pid] forKeys:@[@"pic",@"title",@"isLoc",@"placeholderImage",@"pId"]]];
    }
    _homeScroll.headerView.imageURLs = temArray;
     [_homeScroll.headerView.imgPlayerView upDate];
}


- (void)getProductDetailInfo:(NSString *)productId
{
    WEHTTPHandler *handler =[[WEHTTPHandler alloc]init];
    [handler executeGetProductDetailDataWithProductId:productId withSuccess:^(id obj) {
        DLog(@"%@",obj);
        WEProductDetailVC *detailVC =[[WEProductDetailVC alloc]init];
        detailVC.productId =productId;
        detailVC.detailModel = (WEProductDetailModel *)obj;
        [self.navigationController pushViewController:detailVC animated:YES];
    } withFailed:^(id obj) {
        
    }];
}



- (void)initAdData:(NSString *)AdId
{
    WEHTTPHandler *handler =[[WEHTTPHandler alloc]init];
    [handler executeGetHomeAdDetailTaskWithAdId:AdId withSuccess:^(id obj) {
        DLog(@"homeVC----->%@",obj);
        
    } withFailed:^(id obj) {
        DLog(@"homeVC--error-->%@",obj);
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
