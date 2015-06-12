//
//  WELocationManager.m
//  WestElectromechanical
//
//  Created by zuo on 15/4/26.
//  Copyright (c) 2015年 zuo. All rights reserved.
//

#import "WELocationManager.h"
#import <AddressBook/AddressBook.h>
@interface WELocationManager()<CLLocationManagerDelegate>
@property (nonatomic ,strong)CLLocationManager *locationMgr;
@property (nonatomic ,strong)CLGeocoder *locationGeocoder;

@property (nonatomic, strong) LocationBlock locationBlock;
@property (nonatomic, strong) LocationCityBlock cityBlock;
@property (nonatomic, strong) LocationErrorBlock errorBlock;
@end
@implementation WELocationManager

DEFINE_SINGLETON_FOR_IMPLEMENTATION(WELocationManager)
// 工具类初始化时,创建 定位管理器、地理位置解码编码器，并设置代理为当前工具类
- (id)init
{
    if (self = [super init]) {
        // 定位管理器
        _locationMgr = [[CLLocationManager alloc] init];
        // 当它定位完成,获得用户的经度和纬度时,会通知代理
        if ([CLLocationManager locationServicesEnabled]) {
            DLog(@"定位服务可用");
            if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 8.0) {
                self.locationMgr = [[CLLocationManager alloc] init];
                self.locationMgr.delegate = self;
                self.locationMgr.distanceFilter = 200;
                self.locationMgr.desiredAccuracy = kCLLocationAccuracyThreeKilometers;//设置定位精度
                //定位频率,每隔多少米定位一次
                CLLocationDistance distance=10000.0;//十米定位一次
                self.locationMgr.distanceFilter=distance;
                [self.locationMgr requestWhenInUseAuthorization];
                //启动跟踪定位
                // CLGeocoder可以根据刚才定位管理器定出的 经度和纬度,解码出用户所在位置的城市名
            }else{
                 [_locationMgr startUpdatingLocation];

            }
            _locationGeocoder = [[CLGeocoder alloc] init];

            
        }else{
            DLog(@"定位服务不可用");

        }
        
        
//        if([CLLocationManager locationServicesEnabled]){
//          kCLLocationAccuracyBest;
//            if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 8.0) {
//                //使用期间
//
//                //始终
//                //or [self.locationManage requestAlwaysAuthorization]
//            }
//        }
//        
//        
//        
//        //如果没有授权则请求用户授权
//        if ([CLLocationManager authorizationStatus]==kCLAuthorizationStatusNotDetermined){
//            [_locationMgr requestWhenInUseAuthorization];
//        }else if([CLLocationManager authorizationStatus]==kCLAuthorizationStatusAuthorizedWhenInUse){
//
//        }
        
    }
    return self;
}

- (void)getLocationCity:(LocationCityBlock)cityBlock 
{
    _cityBlock = cityBlock;
    [self.locationMgr startUpdatingLocation];
}

- (void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray *)locations
{
    // 1.既然已经定位到了用户当前的经纬度了,那么可以让定位管理器 停止定位了
    [_locationMgr stopUpdatingLocation];
    // 2.然后,取出第一个位置,根据其经纬度,通过CLGeocoder反向解析,获得该位置所在的城市名称,转成城市对象,用工具保存
    CLLocation *loc = locations[0];
    // 3.CLGeocoder反向通过经纬度,获得城市名
    [_locationGeocoder reverseGeocodeLocation:loc completionHandler:
     ^(NSArray *placemarks, NSError *error) {
         
         if (locations.count > 0)
         {
//             CLPlacemark *placemark = [placemarks objectAtIndex:0];//
             //获取城市
             
             NSDictionary *address = [placemarks[0] addressDictionary];
             NSString *city = address[(NSString *)kABPersonAddressCityKey];
             
             if (!city) {
                 //四大直辖市的城市信息无法通过locality获得，只能通过获取省份的方法来获得（如果city为空，则可知为直辖市）
                 city =address[(NSString *)kABPersonAddressStateKey];
             }
             DLog(@"city = %@", city);
//             NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
//             [defaults setValue:[city substringToIndex:2] forKey:kHomeCityKey];
             
             
             if (_cityBlock) {
                 _cityBlock(city);
                 _cityBlock = nil;
             }
             
             if (_locationBlock) {
                 _locationBlock(loc.coordinate);
                 _locationBlock = nil;
             }
             
         }
         else if (error == nil && [locations count] == 0)
         {
             DLog(@"No results were returned.");
         }
         else if (error != nil)
         {
             DLog(@"An error occurred = %@", error);
             if (_errorBlock) {
                 _errorBlock(error);
                 _errorBlock = nil;
             }
         }
        
         
         
//         // 从字典中取出 state---->某某市
//         CLPlacemark *place = placemarks[0];
//         NSString *cityName = place.addressDictionary[@"State"];
//         // 将最后一个字符【市】去掉,转成城市对应,用工具保存
//         cityName = [cityName substringToIndex:cityName.length - 1];
         // 从工具的城市字典中,根据城市名,取出对应的城市对象
        
         //         City *city = [MetaDataTool sharedMetaDataTool].allCitiesDict[cityName];
//         // 设置当前城市对象,内部会拦截setter操作,并发出通知
//         [MetaDataTool sharedMetaDataTool].currentCity = city;
//         // 定位,并且解析完毕之后,用成员变量记住
//         _locationCity = city;
//         // 为成员属性赋值,供发起GET请求时,提供经纬度参数用
//         _locationCity.position = loc.coordinate;
     }];
}

@end
