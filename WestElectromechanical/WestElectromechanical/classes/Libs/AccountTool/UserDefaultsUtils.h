//
//  UserDefaultsUtils.h
//  ZLYDoc
//  键值对操作
//  Created by Ryan on 14-4-1.
//  Copyright (c) 2014年 ZLY. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface UserDefaultsUtils : NSObject

+(void)saveValue:(id) value forKey:(NSString *)key;

+(id)valueWithKey:(NSString *)key;

+(BOOL)boolValueWithKey:(NSString *)key;

+(void)saveBoolValue:(BOOL)value withKey:(NSString *)key;

+(NSInteger)integerValueWithKey:(NSString *)key;
+(void)setIntegerValue:(NSInteger)value withKey:(NSString *)key;

+(void)print;

@end
