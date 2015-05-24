//
//  PALocation.h
//  time
//
//  Created by zuo on 15/4/2.
//  Copyright (c) 2015年 chenyirong007. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface PALocation : NSObject
//国家
@property (copy, nonatomic) NSString *country;
// 州 省
@property (copy, nonatomic) NSString *state;
// 市
@property (copy, nonatomic) NSString *city;
// 区
@property (copy, nonatomic) NSString *district;
// 街道  村落
@property (copy, nonatomic) NSString *street;
//纬度
@property (nonatomic ,assign) double latitude;
//经度
@property (nonatomic ,assign) double longitude;
//邮政编码
@property (nonatomic ,copy)NSString * zipCode;
@end
