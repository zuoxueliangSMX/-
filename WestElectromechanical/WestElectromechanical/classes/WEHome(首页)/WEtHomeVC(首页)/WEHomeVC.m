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
@interface WEHomeVC ()
@property (nonatomic ,strong)NSMutableArray *imgurls;
@property (nonatomic ,weak)WEHomeScrollView *homeScroll;
@end

@implementation WEHomeVC
#pragma mark -
#pragma mark - pop和push控制器时的操作
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [[self rdv_tabBarController] setTabBarHidden:NO animated:YES];
//    [self addRightItem];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    [[self rdv_tabBarController] setTabBarHidden:NO animated:YES];
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
    
    NSMutableArray *temArray =[NSMutableArray array];
    UIImage * PlaceholderImage = [UIImage imageNamed:@"Home_Middle_04"];
    
    //网络图片
    //***********************//
    //key pic = 地址 NSString
    //key title = 显示的标题 NSString
    //key isLoc = 是否本地图片 Bool
    //key placeholderImage = 网络图片加载失败时显示的图片 UIImage
    //***********************//

    
    [temArray addObject:[NSDictionary dictionaryWithObjects:@[@"http://www.ghzw.cn/wzsq/UploadFiles_9194/201109/20110915154150869.bmp",@"PIC1",@NO,PlaceholderImage] forKeys:@[@"pic",@"title",@"isLoc",@"placeholderImage"]]];
    
    [temArray addObject:[NSDictionary dictionaryWithObjects:@[@"http://sudasuta.com/wp-content/uploads/2013/10/10143181686_375e063f2c_z.jpg",@"PIC2",@NO,PlaceholderImage] forKeys:@[@"pic",@"title",@"isLoc",@"placeholderImage"]]];
    
    [temArray addObject:[NSDictionary dictionaryWithObjects:@[@"http://www.yancheng.gov.cn/ztzl/zgycddhsdgy/xwdt/201109/W020110902584601289616.jpg",@"PIC3",@NO,PlaceholderImage] forKeys:@[@"pic",@"title",@"isLoc",@"placeholderImage"]]];
    
    WEHomeScrollView *scrollView =[[WEHomeScrollView alloc]initWithFrame:CGRectMake(0, 64, SCREEN_WIDTH, SCREEN_HEIGHT-64-49)];
    scrollView.backgroundColor =[UIColor clearColor];
    scrollView.contentSize = CGSizeMake(SCREEN_WIDTH, SCREEN_HEIGHT-64-49);
    scrollView.headerView.imageURLs = temArray;
    [scrollView.headerView.imgPlayerView upDate];
    scrollView.bounces = NO;
    scrollView.showsHorizontalScrollIndicator = NO;
    scrollView.showsVerticalScrollIndicator = NO;
    [self.view addSubview:scrollView];
    _homeScroll = scrollView;
    
    WELocationManager *mgr =[WELocationManager sharedWELocationManager];
    __weak WEHomeVC *bSelf = self;
    [mgr getLocationCity:^(NSString *cityString) {
        [bSelf setLeftItems];
    }];
    
    
    [self initNetData:@"上海"];
}

/**
 *  获取首页数据
 */
- (void)initNetData:(NSString *)cityName
{
    WEHTTPHandler *handler =[[WEHTTPHandler alloc]init];
    [handler executeGetHomeDataTaskWithCityName:cityName withSuccess:^(id obj) {
        DLog(@"homeVC----->%@",obj);
        [self initAdData:@"1"];
    } withFailed:^(id obj) {
        DLog(@"homeVC--error-->%@",obj);
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
