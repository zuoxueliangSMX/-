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
    UIBarButtonItem *right = [UIBarButtonItem addTarget:self WithTitle:[[NSUserDefaults standardUserDefaults] objectForKey:kHomeCityKey] withColor:[UIColor redColor] action:@selector(cityLocationClick:)];
    /**
     *  width为负数时，相当于btn向右移动width数值个像素，由于按钮本身和边界间距为5pix，所以width设为-15时，间距正好调整
     *  为10；width为正数时，正好相反，相当于往左移动width数值个像素
     */
    UIBarButtonItem *negativeSpacer = [[UIBarButtonItem alloc]
                                       initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace
                                       target:nil action:nil];
    negativeSpacer.width = -15;
    self.navigationItem.leftBarButtonItems = @[negativeSpacer, right];

}
- (void)cityLocationClick:(UIButton *)btn
{
    DLog(@"城市定位");
    WEHomeCityVC *homeCityVC =[[WEHomeCityVC alloc]init];
//    WENavitationController *homeCity =[[WENavitationController alloc]initWithRootViewController:homeCity];
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
    scrollView.backgroundColor =[UIColor clearColor];
    scrollView.contentSize = CGSizeMake(SCREEN_WIDTH, SCREEN_HEIGHT-64-49);
    scrollView.bounces = NO;
    scrollView.showsHorizontalScrollIndicator = NO;
    scrollView.showsVerticalScrollIndicator = NO;
    [self.view addSubview:scrollView];
    [scrollView.bottomView setHomeBottomScrollViewBlock:^(NSInteger bgTag, NSInteger imgTag) {
        DLog(@"%ld    -----    %ld",bgTag,imgTag);
    }];
    [scrollView.middleView setHomeMiddleVieBlock:^(NSInteger index) {
        if (index == 0) {
            AppDelegate *delegate =(AppDelegate *)[UIApplication sharedApplication].delegate;
            delegate.tabBarController.selectedIndex =2;
//            [delegate.tabBarController viewControllerAtIndex:3];
        }else{
            WEProductListVC *productListVC =[[WEProductListVC alloc]init];
            [bSelf.navigationController pushViewController:productListVC animated:YES];
        }
    }];
    _homeScroll = scrollView;
    
    WELocationManager *mgr =[WELocationManager sharedWELocationManager];
    [mgr getLocationCity:^(NSString *cityString) {
        [bSelf setLeftItems];
    }];
    
    
    [self initNetData:@"北京"];
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
        [bSelf showRecommendsInfo];
    } withFailed:^(id obj) {
        DLog(@"homeVC--error-->%@",obj);
    }];
}
- (void)showRecommendsInfo
{
    [_homeScroll.bottomView setUpRecommendsData:_homeInfoModel.recommends];
}
- (void)showADInfo
{
    NSMutableArray *temArray =[NSMutableArray array];
    UIImage * PlaceholderImage = [UIImage imageNamed:@"Home_Middle_04"];
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
        [temArray addObject:[NSDictionary dictionaryWithObjects:@[adModel.pic,picTag,@NO,PlaceholderImage] forKeys:@[@"pic",@"title",@"isLoc",@"placeholderImage"]]];
    }
    _homeScroll.headerView.imageURLs = temArray;
     [_homeScroll.headerView.imgPlayerView upDate];
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
