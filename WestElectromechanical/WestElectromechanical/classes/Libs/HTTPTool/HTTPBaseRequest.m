//
//  HTTPBaseRequest.m
//  time
//
//  Created by zuo on 15/3/30.
//  Copyright (c) 2015年 chenyirong007. All rights reserved.
//

#import "HTTPBaseRequest.h"
#import "AFNetworking.h"
#import "Reachability.h"
#import "APIConfig.h"
#import "AccountHanler.h"
#import <QuartzCore/QuartzCore.h>
#import <SystemConfiguration/SystemConfiguration.h>
//#import "AlertUtil.h"
@interface HTTPBaseRequest()
@property(nonatomic,strong) AFHTTPSessionManager *manager;
@end
@implementation HTTPBaseRequest

- (id)init{
    if (self = [super init]){
        self.manager = [AFHTTPSessionManager manager];
        
//        self.manager.responseSerializer = [AFJSONResponseSerializer serializer];
        //申明请求的数据是json类型
//        self.manager.requestSerializer=[AFJSONRequestSerializer serializer];
        
        //如果报接受类型不一致请替换一致text/html或别的
        
        // 对于网站成功返回 JSON 格式的数据但是却在 failure 回调中显示的，
        // 是因为服务器返回数据的网页中 content type 没有设置为 text/json
        // 对于我们公司的服务器返回的 content type 为 text/html 所以我设置为如下这样，
        // 对于不同的情况可以根据自己的情况设置合适的接受的 content type 的类型
        self.manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json",@"text/html",@"text/plain",nil];
        
    }
    return self;
}

+ (HTTPBaseRequest *)defaultRequest
{
    static HTTPBaseRequest *instance = nil;
    static dispatch_once_t predicate;
    dispatch_once(&predicate, ^{
        instance = [[self alloc] init];
    });
    return instance;
}
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
                failure:(void (^)(NSURLSessionDataTask *task, NSError *error))failure{
    //请求的URL
    DLog(@"Request path:%@",url);
//    DLog(@"%@",params);
    //判断网络状况（有链接：执行请求；无链接：弹出提示）
    if ([self isConnectionAvailable]) {
        //预处理（显示加载信息啥的）
        if (prepare) {
            prepare();
        }
        switch (method) {
            case PAHTTPREQUEST_GET:
            {
                
                [self.manager GET:url parameters:parameters success:success failure:failure];
            }
                break;
            case PAHTTPREQUEST_POST:
            {
                [self.manager POST:url parameters:parameters success:success failure:failure];
            }
                break;
            case PAHTTPREQUEST_DELETE:
            {
                [self.manager DELETE:url parameters:parameters success:success failure:failure];
            }
                break;
            case PAHTTPREQUEST_PUT:
            {
                [self.manager PUT:url parameters:parameters success:success failure:false];
            }
                break;
            default:
                break;
        }
    }else{
        [AlertUtil performWaitingAlertDismiss];
        //网络错误咯
        [self showExceptionDialog];
        //发出网络异常通知广播
//        [[NSNotificationCenter defaultCenter] postNotificationName:k_NOTI_NETWORK_ERROR object:nil];
    }
    

    
    
}


//看看网络是不是给力
- (BOOL)isConnectionAvailable{
    // Create zero addy
//    NetworkStatus status = [[[Reachability alloc]init] currentReachabilityStatus];
//    
//    if (status == ReachableViaWiFi||status == ReachableViaWWAN) {
//        return YES;
//    }else{
//        return NO;
//    }
    
    return YES;
}

//弹出网络错误提示框
- (void)showExceptionDialog
{
//    [[[UIAlertView alloc] initWithTitle:@"提示"
//                                message:@"网络异常，请检查网络连接"
//                               delegate:self
//                      cancelButtonTitle:@"好的"
//                      otherButtonTitles:nil, nil] show];
    [AlertUtil showAlertWithText:@"网络连接异常，请检查网络连接"];
}

@end
