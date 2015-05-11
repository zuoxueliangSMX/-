//
//  BaseModel.m
//  RTLibrary-ios
//
//  Created by Elon on 15/3/20.
//  Copyright (c) 2015年 zlycare. All rights reserved.
//

#import "BaseModel.h"

@implementation BaseModel
- (NSInteger)intFromValue:(NSObject *)value
{
    if ([value isKindOfClass:[NSNumber class]])
    {
        return  [(NSNumber *)value integerValue];
    }
    else if ([value isKindOfClass:[NSString class]])
    {
        return [(NSString *)value integerValue];
    }
    else {
        
    }
    
    return 0;
}

- (NSDictionary *)dictionaryFromValue:(NSObject *)value
{
    if ([value isKindOfClass:[NSDictionary class]])
    {
        return (NSDictionary *)value;
    }
    else if ([value isKindOfClass:[NSNull class]])
    {
        return @{};
    }
    else {
        return @{};
    }
    return 0;
}

+ (NSDictionary *)dictionaryFromValue:(NSObject *)value
{
   return [[[BaseModel alloc]init] dictionaryFromValue:value];
}
- (CGFloat)floatFromValue:(NSObject *)value
{
    
    if ([value isKindOfClass:[NSNumber class]])
    {
        return  [(NSNumber *)value floatValue];
    }
    else if ([value isKindOfClass:[NSString class]])
    {
        return [(NSString *)value floatValue];
    }
    else {
        
    }
    
    return 0;
}

- (NSString *)stringFromValue:(NSObject *)value
{
//    DLog(@"%@",value);
    if ([value isKindOfClass:[NSString class]])
    {
        return (NSString *)value;
    }
    else if ([value isKindOfClass:[NSNumber class]])
    {
        return [(NSNumber *)value stringValue];
    }
    else if ([value  isKindOfClass:[NSNull class]])
    {
        return @"";
    }
    else
    {
        return @"";
    }
    return nil;
}

- (NSString *)stringFromValue:(NSObject *)value defaultValue: (NSString *) def{
    if ([value isKindOfClass:[NSString class]])
    {
        return (NSString *)value;
    }
    else if ([value isKindOfClass:[NSNumber class]])
    {
        return [(NSNumber *)value stringValue];
    }
    else if ([value  isKindOfClass:[NSNull class]] || value == nil)
    {
        return def;
    }
 
    return nil;
}

- (BOOL) booleanFromValue:(NSObject *)value
{
    if ([value isKindOfClass:[NSNumber class]])
    {
        return [(NSNumber *)value boolValue];
    }
    else if ([value isKindOfClass:[NSString class]])
    {
        
        if (CompareStringCaseInsenstive((NSString *)value,@"true")) {
            return YES;
            
        }
        else if (CompareStringCaseInsenstive((NSString *)value,@"false"))
        {
            return NO;
        }
        else if (CompareStringCaseInsenstive((NSString *)value,@"yes"))
        {
            return YES;
        }
        else if (CompareStringCaseInsenstive((NSString *)value,@"no"))
        {
            return NO;
        }
        else {
            return [(NSString *)value boolValue];
        }
    }
    else {
        
    }
    
    return NO;
}

- (NSDate *)dateFromValue:(NSObject *)value
{
    if ([value isKindOfClass:[NSDate class]]) {
        return (NSDate *)value;
    }
    else if ([value isKindOfClass:[NSNumber class]]) {
        return [NSDate dateWithTimeIntervalSince1970:[(NSNumber *)value doubleValue]];
    }
    else if ([value isKindOfClass:[NSString class]]) {
        NSDateFormatter *df = [[NSDateFormatter alloc] init];
        [df setFormatterBehavior:NSDateFormatterBehavior10_4];
        [df setLocale:[[NSLocale alloc] initWithLocaleIdentifier:@"en_US"]];
        [df setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
        
        NSDate *result = [df dateFromString:(NSString *)value];
        return  result;;
    }
    else {
        
    }
    
    return nil;
}

@end
