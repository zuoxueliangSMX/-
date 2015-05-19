//
//  NSString+Extension.m
//  time
//
//  Created by zuo on 15/5/6.
//  Copyright (c) 2015年 chenyirong007. All rights reserved.
//

#import "NSString+Extension.h"

@implementation NSString (Extension)
+ (NSString *)deleteSpacing:(NSString *)spacingStr
{
    spacingStr = [spacingStr stringByReplacingOccurrencesOfString:@" " withString:@""];
    spacingStr = [spacingStr stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];//方法只是去掉左右两边的空格；
    return spacingStr;
}

@end
