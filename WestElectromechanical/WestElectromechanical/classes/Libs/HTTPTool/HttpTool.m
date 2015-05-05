//
//  HttpTool.m
//  YINB
//
//  Created by MacOS on 14-11-7.
//  Copyright (c) 2014年 Bullet. All rights reserved.
//

#import "HttpTool.h"

@implementation HttpTool

/**
 *  无参数
 *
 *  @param url     <#url description#>
 *  @param success <#success description#>
 *  @param failure <#failure description#>
 */
+ (void)post:(NSString *)url withSuccess:(void (^)(id))success withFailure:(void (^)(NSError *))failure
{
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL:[NSURL URLWithString:url]];
    
    AFHTTPRequestOperation *op = [[AFHTTPRequestOperation alloc] initWithRequest:request];
    
    [op setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation, id responseObject) {
        

        if (success) {
            success(responseObject);
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        if (failure) {
            failure(error);
        }
        
    }];
    
    [op start];

}

/**
 *  有参数
 *
 *  @param url     <#url description#>
 *  @param success <#success description#>
 *  @param failure <#failure description#>
 */
+ (void)post:(NSString *)url withParams:(NSString *)paramsStr withSuccess:(void (^)(id))success withFailure:(void (^)(NSError *))failure{
    
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL:[NSURL URLWithString:url]];
    [request setHTTPMethod:@"POST"];
    
    [request setHTTPBody:[paramsStr dataUsingEncoding:NSUTF8StringEncoding]];
   
    AFHTTPRequestOperation *op = [[AFHTTPRequestOperation alloc] initWithRequest:request];
    op.responseSerializer = [AFJSONResponseSerializer serializer];
    op.responseSerializer.acceptableContentTypes =[NSSet setWithObjects:@"application/json",@"text/html",@"text/plain",nil];
    [op setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        if (success) {
            success(responseObject);
        }
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
        if (failure) {
            failure(error);
        }
    }];
    
    [op start];
    
}

@end
