//
//  BaseHandler.m
//  zlydoc-iphone
//
//  Created by Ryan on 14-6-25.
//  Copyright (c) 2014年 zlycare. All rights reserved.
//

#import "BaseHandler.h"


@implementation BaseHandler

+ (NSString *)requestUrlWithUrl:(NSString *)url WithPath:(NSString *)path
{
    return [[SERVER_PROTOCOL stringByAppendingString:[[SERVER_HOST stringByAppendingString:SERVER_PORT]stringByAppendingString:url]] stringByAppendingString:path];
}

@end
