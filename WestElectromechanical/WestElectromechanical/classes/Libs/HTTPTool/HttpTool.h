//
//  HttpTool.h
//  YINB
//
//  Created by MacOS on 14-11-7.
//  Copyright (c) 2014年 Bullet. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AFNetworking.h"
@interface HttpTool : NSObject

/**
 *  无参数
 *
 *  @param url     <#url description#>
 *  @param success <#success description#>
 *  @param failure <#failure description#>
 */
+ (void)post:(NSString *)url withSuccess:(void(^)(id json))success withFailure:(void(^)(NSError *error))failure;
/**
 *  有参数
 *
 *  @param url     <#url description#>
 *  @param success <#success description#>
 *  @param failure <#failure description#>
 */
+ (void)post:(NSString *)url withParams:(NSString *)paramsStr withSuccess:(void(^)(id json))success withFailure:(void(^)(NSError *error))failure;


@end
