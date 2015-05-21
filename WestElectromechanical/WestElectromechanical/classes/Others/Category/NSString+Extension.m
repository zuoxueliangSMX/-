//
//  NSString+Extension.m
//  time
//
//  Created by zuo on 15/5/6.
//  Copyright (c) 2015年 chenyirong007. All rights reserved.
//

#import "NSString+Extension.h"
#import <CommonCrypto/CommonDigest.h>
@implementation NSString (Extension)
+ (NSString *)deleteSpacing:(NSString *)spacingStr
{
    spacingStr = [spacingStr stringByReplacingOccurrencesOfString:@" " withString:@""];
    spacingStr = [spacingStr stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];//方法只是去掉左右两边的空格；
    return spacingStr;
}


+(NSString*)MD5:(NSString *)str{
    const char *cStr = [str UTF8String];
    unsigned char digest[CC_MD5_DIGEST_LENGTH];
    CC_MD5( cStr, (int)strlen(cStr), digest );
    NSMutableString *output = [NSMutableString stringWithCapacity:CC_MD5_DIGEST_LENGTH * 2];
    for(int i = 0; i < CC_MD5_DIGEST_LENGTH; i++)
        [output appendFormat:@"%02x", digest[i]];
    
    return output;
}


@end
