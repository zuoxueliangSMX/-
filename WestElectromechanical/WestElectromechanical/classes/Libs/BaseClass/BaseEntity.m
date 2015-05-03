//
//  BaseEntity.m
//  ZLYDoc
//
//  Created by Ryan on 14-4-3.
//  Copyright (c) 2014年 ZLY. All rights reserved.
//

#import "BaseEntity.h"

static NSString * const MSG = @"failure_cause";
static NSString * const STATUS = @"result";
static NSString * const RES = @"res";

@implementation BaseEntity

- (NSString*)description{
    return [NSString stringWithFormat:@"result:%d\n,failure_cause:%@",self.status,self.msg];
}



+(BaseEntity* )parseResponseErrorJSON:(id)json
{
//    NSString *responseJSON = [NSString stringWithFormat:@"%@",json];
//    DLog(@"%@",responseJSON);
//    NSData *jsonData = [responseJSON dataUsingEncoding:NSUTF8StringEncoding];
//    DLog(@"jsonData :\n%@",jsonData);
//    
//    NSError *error = nil;
    NSError *error = nil;
    NSDictionary *dic_json = [NSJSONSerialization JSONObjectWithData:json options:kNilOptions error:&error];
    
    if (error != nil) {
        DLog(@"error %@",[error description]);
    }
    

    
    DLog(@"dic_json :\n%@",dic_json);
    
    if ([NSJSONSerialization isValidJSONObject:dic_json]) {
        BaseEntity *baseEntity = [[BaseEntity alloc] init];
        baseEntity.status = [((NSNumber *)[dic_json objectForKey:STATUS]) intValue];
        baseEntity.msg = [dic_json objectForKey:MSG];
        return baseEntity;
    }
    return nil;
}

+ (BaseEntity *)parseResponseStatusJSON:(id)json
{
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:json options:NSJSONWritingPrettyPrinted error:nil];
    //格式化打印输出至控制台
    NSString *responseJSON = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
    DLog(@"%@",responseJSON);
    NSDictionary *dic_json = [NSJSONSerialization JSONObjectWithData:jsonData options:kNilOptions error:nil];
    if ([NSJSONSerialization isValidJSONObject:dic_json]) {
        NSNumber *status = (NSNumber *)[dic_json objectForKey:STATUS];
        BaseEntity *baseEntity = [[BaseEntity alloc] init];
        baseEntity.status = [status intValue];
        baseEntity.msg = [dic_json objectForKey:MSG];
        return baseEntity;
    }
    return nil;
}

+(BaseEntity *)parseResponseUpdateJSON:(id)json
{
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:json options:NSJSONWritingPrettyPrinted error:nil];
    //格式化打印输出至控制台
    NSString *responseJSON = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
    DLog(@"%@",responseJSON);
    NSDictionary *dic_json = [NSJSONSerialization JSONObjectWithData:jsonData options:kNilOptions error:nil];
    if ([NSJSONSerialization isValidJSONObject:dic_json]) {
        NSNumber *status = (NSNumber *)[dic_json objectForKey:STATUS];
        BaseEntity *baseEntity = [[BaseEntity alloc] init];
        baseEntity.status = [status intValue];
        id res = [dic_json objectForKey:RES];
        baseEntity.version = [res objectForKey:@"v"];
        baseEntity.updateURL = [res objectForKey:@"url"];
        return baseEntity;
    }
    return nil;
}

@end
