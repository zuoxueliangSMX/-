//
//  BaseModel.h
//  RTLibrary-ios
//
//  Created by Elon on 15/3/20.
//  Copyright (c) 2015年 zlycare. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

/**
 *
 * 数据库实体Model需要实现的委托
 */
@protocol IEntity

@required
+ (NSArray*) getAllFields;
-(void) setFieldValue:(NSString*) fieldName value:(NSObject*) value;
- (id)getFromFieldValue:(NSString *)fieldName;

//@optional
@end




@interface BaseModel : NSObject
- (NSDate *)dateFromValue:(NSObject *)value;
- (BOOL) booleanFromValue:(NSObject *)value;
- (NSString *)stringFromValue:(NSObject *)value;
/**
 *  增加model返回默认值的处理方法
 *
 *  @param value <#value description#>
 *  @param def   如果为空，返回默认值
 *
 *  @return <#return value description#>
 */
- (NSString *)stringFromValue:(NSObject *)value defaultValue: (NSString *) def;
- (NSInteger)intFromValue:(NSObject *)value;
- (CGFloat)floatFromValue:(NSObject *)value;
- (NSDictionary *)dictionaryFromValue:(NSObject *)value;
+ (NSDictionary *)dictionaryFromValue:(NSObject *)value;
@end
