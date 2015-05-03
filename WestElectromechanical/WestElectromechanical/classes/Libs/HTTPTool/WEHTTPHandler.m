//
//  WEHTTPHandler.m
//  WestElectromechanical
//
//  Created by zuo on 15/5/2.
//  Copyright (c) 2015年 zuo. All rights reserved.
//

#import "WEHTTPHandler.h"
#import "HTTPBaseRequest.h"
#import "HttpTool.h"
@implementation WEHTTPHandler
#pragma mark -
#pragma mark - 首页模块
/**
 *  首页数据源
 *
 *  @param cityName 默认城市
 *  @param success  成功返回操作
 *  @param failed   失败返回操作
 */
- (void)executeGetHomeDataTaskWithCityName:(NSString *)cityName
                               withSuccess:(SuccessBlock)success withFailed:(FailedBlock)failed
{
    [AlertUtil showAlertWithText:@"获取首页数据"];
    NSString *url =[BaseHandler requestUrlWithUrl:API_HOME_DATA WithPath:@""];
    NSString *params =[NSString stringWithFormat:@"city_name=%@",cityName];
    [HttpTool post:url withParams:params withSuccess:^(id json) {
        DLog(@"%@",json);
        if ([[json  objectForKey:@"message"] integerValue]== 0) {
        
            if (success) {
                success(json);
            }
        }else{
            if (failed) {
                failed(nil);
            }
        }
    } withFailure:^(NSError *error) {
        DLog(@"%@",error);
        if (failed) {
            failed(error);
        }
    }];
    
}

/**
 *  公告详情
 */
- (void)executeGetHomeAdDetailTaskWithAdId:(NSString *)AdId
                               withSuccess:(SuccessBlock)success withFailed:(FailedBlock)failed
{
    [AlertUtil showAlertWithText:@"获取公告详情数据"];
    NSString *url =[BaseHandler requestUrlWithUrl:API_HOME_AD_DETAIL WithPath:@""];
    NSString *params =[NSString stringWithFormat:@"n_id=%@",AdId];
    [HttpTool post:url withParams:params withSuccess:^(id json) {
        DLog(@"%@",json);
        if ([[json  objectForKey:@"message"] integerValue]== 0) {
            
            if (success) {
                success(json);
            }
        }else{
            if (failed) {
                failed(nil);
            }
        }

    } withFailure:^(NSError *error) {
        DLog(@"%@",error.localizedDescription);
        DLog(@"%@",error);
        if (failed) {
            failed(error);
        }
    }];
    
}
#pragma mark -
#pragma mark - 搜索模块
/**
 *  获取搜索热门推荐
 */
- (void)executeGetHotRecommendWithCityName:(NSString *)cityName
                               withSuccess:(SuccessBlock)success withFailed:(FailedBlock)failed
{
    [AlertUtil showAlertWithText:@"获取推荐数据"];
    NSString *url =[BaseHandler requestUrlWithUrl:API_SEARCH_HOTRECOMMEND WithPath:@""];
    NSString *params = [NSString stringWithFormat:@"city_name=%@",cityName];
    [HttpTool post:url withParams:params withSuccess:^(id json) {
        DLog(@"%@",json);
        if ([[json  objectForKey:@"message"] integerValue]== 0) {
            
            if (success) {
                success(json);
            }
        }else{
            if (failed) {
                failed(nil);
            }
        }
    } withFailure:^(NSError *error) {
        DLog(@"%@",error.localizedDescription);
        if (failed) {
            failed(error);
        }
    }];
}
/**
 *  根据内容搜索
 */
- (void)executeGetSearchDataWithSearchContent:(NSString *)content
                                       withSuccess:(SuccessBlock)success withFailed:(FailedBlock)failed
{
    [AlertUtil showAlertWithText:@"获取搜索数据"];
    NSString *url =[BaseHandler requestUrlWithUrl:API_SEARCH_SEARCH WithPath:@""];
    NSString *params = [NSString stringWithFormat:@"t_id=%@",content];
    [HttpTool post:url withParams:params withSuccess:^(id json) {
        DLog(@"%@",json);
        if ([[json  objectForKey:@"message"] integerValue]== 0) {
            
            if (success) {
                success(json);
            }
        }else{
            if (failed) {
                failed(nil);
            }
        }
    } withFailure:^(NSError *error) {
        DLog(@"%@",error.localizedDescription);
        if (failed) {
            failed(error);
        }
    }];

}

#pragma mark -
#pragma mark - 产品详情
/**
 *  产品详情
 */
- (void)executeGetProductDetailDataWithProductId:(NSString *)productId
                                  withSuccess:(SuccessBlock)success withFailed:(FailedBlock)failed
{
    [AlertUtil showAlertWithText:@"获取产品详情数据"];
    NSString *url =[BaseHandler requestUrlWithUrl:API_PRODUCT_DETAIL WithPath:@""];
    NSString *params = [NSString stringWithFormat:@"pid=%@",productId];
    [HttpTool post:url withParams:params withSuccess:^(id json) {
        DLog(@"%@",json);
        if ([[json  objectForKey:@"message"] integerValue]== 0) {
            
            if (success) {
                success(json);
            }
        }else{
            if (failed) {
                failed(nil);
            }
        }
    } withFailure:^(NSError *error) {
        DLog(@"%@",error.localizedDescription);
        if (failed) {
            failed(error);
        }
    }];
    
}

/**
 *  产品收藏
 */
- (void)executeProductCollectionTaskWithProductId:(NSString *)productId
                                       withUserId:(NSString *)userId
                                     withSuccess:(SuccessBlock)success withFailed:(FailedBlock)failed
{
    [AlertUtil showAlertWithText:@"获取产品详情数据"];
    NSString *url =[BaseHandler requestUrlWithUrl:API_PRODUCT_COLLECTION WithPath:@""];
    NSString *params = [NSString stringWithFormat:@"pid=%@&uid=%@",productId,userId];
    [HttpTool post:url withParams:params withSuccess:^(id json) {
        DLog(@"%@",json);
        if ([[json  objectForKey:@"message"] integerValue]== 0) {
            
            if (success) {
                success(json);
            }
        }else{
            if (failed) {
                failed(nil);
            }
        }
    } withFailure:^(NSError *error) {
        DLog(@"%@",error.localizedDescription);
        if (failed) {
            failed(error);
        }
    }];
    
}

/**
 *  产品加入购物车
 */
- (void)executeProductAddCartTaskWithProductId:(NSString *)productId
                                       withUserId:(NSString *)userId
                                      withSuccess:(SuccessBlock)success withFailed:(FailedBlock)failed
{
    [AlertUtil showAlertWithText:@"产品加入购入车"];
    NSString *url =[BaseHandler requestUrlWithUrl:API_PRODUCT_ADDCART WithPath:@""];
    NSString *params = [NSString stringWithFormat:@"pid=%@&uid=%@",productId,userId];
    [HttpTool post:url withParams:params withSuccess:^(id json) {
        DLog(@"%@",json);
        if ([[json  objectForKey:@"message"] integerValue]== 0) {
            
            if (success) {
                success(json);
            }
        }else{
            if (failed) {
                failed(nil);
            }
        }
    } withFailure:^(NSError *error) {
        DLog(@"%@",error.localizedDescription);
        if (failed) {
            failed(error);
        }
    }];
    
}

/**
 *  产品加入购物车
 */
- (void)executeGetProductCommentListTaskWithProductId:(NSString *)productId
                                          withSuccess:(SuccessBlock)success
                                           withFailed:(FailedBlock)failed
{
    [AlertUtil showAlertWithText:@"获取产品评论列表"];
    NSString *url =[BaseHandler requestUrlWithUrl:API_PRODUCT_COMMENTLIST WithPath:@""];
    NSString *params = [NSString stringWithFormat:@"pid=%@",productId];
    [HttpTool post:url withParams:params withSuccess:^(id json) {
        DLog(@"%@",json);
        if ([[json  objectForKey:@"message"] integerValue]== 0) {
            
            if (success) {
                success(json);
            }
        }else{
            if (failed) {
                failed(nil);
            }
        }
    } withFailure:^(NSError *error) {
        DLog(@"%@",error.localizedDescription);
        if (failed) {
            failed(error);
        }
    }];
    
}


/**
 *  获取一级分类列表
 */
- (void)executeGetFirstCategoryTaskWithSuccess:(SuccessBlock)success WithFailed:(FailedBlock)failed
{
    [AlertUtil showAlertWithText:@"获取分类列表"];
    NSString *url =[BaseHandler requestUrlWithUrl:API_PRODUCT_SECONDCATEGORYLIST WithPath:@""];
    [HttpTool post:url withParams:nil withSuccess:^(id json) {
        DLog(@"%@",json);
        if ([[json  objectForKey:@"message"] integerValue]== 0) {
            
            if (success) {
                success(json);
            }
        }else{
            if (failed) {
                failed(nil);
            }
        }
    } withFailure:^(NSError *error) {
        DLog(@"%@",error.localizedDescription);
        if (failed) {
            failed(error);
        }
    }];
}


/**
 *  获取二级分类列表
 */
- (void)executeGetSecondCategoryTaskWithCategory:(NSString *)categoryId Success:(SuccessBlock)success WithFailed:(FailedBlock)failed
{
    [AlertUtil showAlertWithText:@"获取分类列表"];
    NSString *url =[BaseHandler requestUrlWithUrl:API_PRODUCT_SECONDCATEGORYLIST WithPath:@""];
    NSString *params = [NSString stringWithFormat:@"t_id=%@",categoryId];
    [HttpTool post:url withParams:params withSuccess:^(id json) {
        DLog(@"%@",json);
        if ([[json  objectForKey:@"message"] integerValue]== 0) {
            
            if (success) {
                success(json);
            }
        }else{
            if (failed) {
                failed(nil);
            }
        }
    } withFailure:^(NSError *error) {
        DLog(@"%@",error.localizedDescription);
        if (failed) {
            failed(error);
        }
    }];
}

#pragma mark -
#pragma mark -个人中心

/**
 *  注册
 */
- (void)executeRegistUserTaskWithName:(NSString *)nickName withPaw:(NSString *)passWord withEmail:(NSString *)email withPhone:(NSString *)phone success:(SuccessBlock)success failed:(FailedBlock)failed
{
    [AlertUtil showAlertWithText:@"注册用户"];
    NSString *url =[BaseHandler requestUrlWithUrl:API_REGIST WithPath:@""];
    NSString *params = [NSString stringWithFormat:@"u_name=%@&phone=%@&email=%@&password=%@",nickName,phone,email,passWord];
    [HttpTool post:url withParams:params withSuccess:^(id json) {
        DLog(@"%@",json);
        if ([[json  objectForKey:@"message"] integerValue]== 0) {
            
            if (success) {
                success(json);
            }
        }else{
            if (failed) {
                failed(nil);
            }
        }
    } withFailure:^(NSError *error) {
        DLog(@"%@",error.localizedDescription);
        if (failed) {
            failed(error);
        }
    }];

}
/**
 *  登陆
 */
#define API_Login @"/json_login.php"
- (void)executeLoginUserTaskWithAccount:(NSString *)account withPaw:(NSString *)passWord
                                success:(SuccessBlock)success
                                 failed:(FailedBlock)failed
{
    [AlertUtil showAlertWithText:@"登陆用户"];
    NSString *url =[BaseHandler requestUrlWithUrl:API_Login WithPath:@""];
    NSString *params = [NSString stringWithFormat:@"account=%@&password=%@",account,passWord];
    [HttpTool post:url withParams:params withSuccess:^(id json) {
        DLog(@"%@",json);
        if ([[json  objectForKey:@"message"] integerValue]== 0) {
            
            if (success) {
                success(json);
            }
        }else{
            if (failed) {
                failed(nil);
            }
        }
    } withFailure:^(NSError *error) {
        DLog(@"%@",error.localizedDescription);
        if (failed) {
            failed(error);
        }
    }];
    
}

/**
 *  找回密码
 */
#define API_FINDPWD @"/json_password.php"

/**
 *  用户注册协议
 */
#define API_REGISTPROTOCOL @"/json_registinfo.php"

/**
 *  个人中心信息
 */
#define API_PERSONCENTERINFO @"/json_member.php"


/**
 *  个人中心
 */
#define API_PERSONCENTERINFO @"/json_member.php"


/**
 *  个人信息
 */
#define API_PERSONINFO @"/json_info.php"
/**
 *  修改个人信息
 */

#define API_UPDATEPERSONINFO @"/json_infoedite.php"


/**
 *  修改用户密码
 */
#define API_UPDATEPWD @"/json_passwordedite.php"



@end
