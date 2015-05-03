//
//  HTTPBaseRequest.h
//  time
//
//  Created by zuo on 15/3/30.
//  Copyright (c) 2015年 chenyirong007. All rights reserved.
//

#import <Foundation/Foundation.h>
typedef enum : NSUInteger {
    PAHTTPREQUEST_GET,   //get请求
    PAHTTPREQUEST_POST,  //post请求
    PAHTTPREQUEST_DELETE, //delete 请求
    PAHTTPREQUEST_PUT,//put 请求
} PAHTTPREQUEST_TYPE; //网络请求类别

/**
 *  请求开始前预处理Block
 */
typedef void(^PrepareExecuteBlock)(void);


@interface HTTPBaseRequest : NSObject

+ (HTTPBaseRequest *)defaultRequest;
//不包含上传二进制数据流
/**
 *  HTTP请求（GET、POST、DELETE、PUT）
 *
 *  @param path
 *  @param method     RESTFul请求类型
 *  @param parameters 请求参数
 *  @param prepare    请求前预处理块
 *  @param success    请求成功处理块
 *  @param failure    请求失败处理块
 */
- (void)requestWithPath:(NSString *)url
                 method:(NSInteger)method
             parameters:(id)parameters
         prepareExecute:(PrepareExecuteBlock) prepare
                success:(void (^)(NSURLSessionDataTask *task, id responseObject))success
                failure:(void (^)(NSURLSessionDataTask *task, NSError *error))failure;

//判断当前网络状态
- (BOOL)isConnectionAvailable;

@end
