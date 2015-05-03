//
//  WELocationManager.h
//  WestElectromechanical
//
//  Created by zuo on 15/4/26.
//  Copyright (c) 2015年 zuo. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreLocation/CoreLocation.h>
typedef void (^LocationBlock)(CLLocationCoordinate2D locationCorrrdinate);
typedef void (^LocationErrorBlock) (NSError *error);
typedef void(^LocationCityBlock)(NSString *cityString);
@interface WELocationManager : NSObject

DEFINE_SINGLETON_FOR_INTERFACE(WELocationManager)
/**
 *  获取城市
 *
 *  @param cityBlock cityBlock description
 */
- (void)getLocationCity:(LocationCityBlock)cityBlock;


@end
