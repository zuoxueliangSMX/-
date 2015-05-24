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
#import "AccountHanler.h"
#import "WEHotRecommendModel.h"
#import "WECategorysModel.h"
#import "WEHomeInfoModel.h"
#import "WEProductDetailModel.h"
#import "WEProductsModel.h"
#import "MyOrderModel.h"
#import "NSString+Extension.h"
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
                               withSuccess:(SuccessBlock)success
                                withFailed:(FailedBlock)failed
{
    [AlertUtil showAlertWithText:@"获取首页数据"];
    NSString *url =[BaseHandler requestUrlWithUrl:API_HOME_DATA WithPath:@""];
    NSString *params =[NSString stringWithFormat:@"city_name=%@",cityName];
    [HttpTool post:url withParams:params withSuccess:^(id json) {
        DLog(@"%@",json);
        
        WEHomeInfoModel *homeInfoModel =[[WEHomeInfoModel alloc]initWithDict:json];
        if (homeInfoModel.message == 0) {
        
            if (success) {
                success(homeInfoModel);
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
                               withSuccess:(SuccessBlock)success
                                withFailed:(FailedBlock)failed
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
                               withSuccess:(SuccessBlock)success
                                withFailed:(FailedBlock)failed
{
    [AlertUtil showAlertWithText:@"获取推荐数据"];
    NSString *url =[BaseHandler requestUrlWithUrl:API_SEARCH_HOTRECOMMEND WithPath:@""];
    NSString *params = [NSString stringWithFormat:@"city_name=%@",cityName];
    [HttpTool post:url withParams:params withSuccess:^(id json) {
        DLog(@"%@",json);
        
        WEHotRecommendModel *model =[[WEHotRecommendModel alloc]initWithDict:json];
        if (model.message == 0) {
            
            if (success) {
                success(model);
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
                                  withSuccess:(SuccessBlock)success
                                   withFailed:(FailedBlock)failed
{
    [AlertUtil showAlertWithText:@"获取分类商品数据"];
    NSString *url =[BaseHandler requestUrlWithUrl:API_SEARCH_SEARCH WithPath:@""];
    NSString *params = [NSString stringWithFormat:@"t_id=%@",content];
    [HttpTool post:url withParams:params withSuccess:^(id json) {
        DLog(@"%@",json);
        WEProductsModel *productsModel =[[WEProductsModel alloc]initWithDict:json];
        if ([productsModel.message integerValue]== 0) {
            
            if (productsModel.products.count>0) {
                if (success) {
                    success(productsModel);
                }
            }else{
                [AlertUtil showAlertWithText:@"该分类下没有商品"];
            }
            
        }else{
            [AlertUtil showAlertWithText:@"获取分类商品数据出错"];
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
 *  搜索商品名字
 */

- (void)executeGetSearchDataWithSearchProductName:(NSString *)productName
                                  withSuccess:(SuccessBlock)success
                                   withFailed:(FailedBlock)failed
{
    [AlertUtil showAlertWithText:@"获取搜索数据"];
    NSString *url =[BaseHandler requestUrlWithUrl:API_SEARCH_SEARCH WithPath:@""];
    NSString *params = [NSString stringWithFormat:@"name=%@",productName];
    [HttpTool post:url withParams:params withSuccess:^(id json) {
        DLog(@"%@",json);
        
        WEProductsModel *productsModel =[[WEProductsModel alloc]initWithDict:json];
        if ([productsModel.message integerValue]== 0) {
            
            if (productsModel.products.count>0) {
                if (success) {
                    success(productsModel);
                }
            }else{
                [AlertUtil showAlertWithText:@"未搜索到你所需要的商品"];
            }
            
        }else{
            [AlertUtil showAlertWithText:@"搜索出错"];
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
                                     withSuccess:(SuccessBlock)success
                                      withFailed:(FailedBlock)failed
{
    [AlertUtil showAlertWithText:@"获取产品详情数据"];
    NSString *url =[BaseHandler requestUrlWithUrl:API_PRODUCT_DETAIL WithPath:@""];
    NSString *params = [NSString stringWithFormat:@"pid=%@",productId];
    [HttpTool post:url withParams:params withSuccess:^(id json) {
        DLog(@"%@",json);
        WEProductDetailModel *model =[[WEProductDetailModel alloc]initWithDict:json];
        if (model.message == 0) {
            
            if (success) {
                success(model);
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
                                      withSuccess:(SuccessBlock)success
                                       withFailed:(FailedBlock)failed
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
                                   withSuccess:(SuccessBlock)success
                                    withFailed:(FailedBlock)failed
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
 *  8.获取产品评论列表
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
        WEProductComments *comments =[[WEProductComments alloc]initWithDict:json];
        if ([comments.message integerValue]== 0) {
            
            if (success) {
                success(comments);
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
- (void)executeGetFirstCategoryTaskWithSuccess:(SuccessBlock)success
                                    WithFailed:(FailedBlock)failed
{
    [AlertUtil showAlertWithText:@"获取分类列表"];
    NSString *url =[BaseHandler requestUrlWithUrl:API_PRODUCT_SECONDCATEGORYLIST WithPath:@""];
    [HttpTool post:url withParams:nil withSuccess:^(id json) {
        DLog(@"%@",json);
        
        WECategorysModel *categorysModel =[[WECategorysModel alloc]initWithDict:json];
        if (categorysModel.message == 0) {
            
            if (success) {
                success(categorysModel);
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
- (void)executeGetSecondCategoryTaskWithCategory:(NSString *)categoryId
                                         Success:(SuccessBlock)success
                                      WithFailed:(FailedBlock)failed
{
    [AlertUtil showAlertWithText:@"获取分类列表"];
    NSString *url =[BaseHandler requestUrlWithUrl:API_PRODUCT_SECONDCATEGORYLIST WithPath:@""];
    NSString *params = [NSString stringWithFormat:@"t_id=%@",categoryId];
    [HttpTool post:url withParams:params withSuccess:^(id json) {
        DLog(@"%@",json);
        WECategorysModel *categorysModel =[[WECategorysModel alloc]initWithDict:json];
        if (categorysModel.message == 0) {
            
            if (success) {
                success(categorysModel);
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
- (void)executeRegistUserTaskWithName:(NSString *)nickName
                              withPaw:(NSString *)passWord
                            withEmail:(NSString *)email
                            withPhone:(NSString *)phone
                              success:(SuccessBlock)success
                               failed:(FailedBlock)failed
{
    [AlertUtil showAlertWithText:@"注册用户"];
    NSString *url =[BaseHandler requestUrlWithUrl:API_REGIST WithPath:@""];
    NSString *params = [NSString stringWithFormat:@"u_name=%@&phone=%@&email=%@&password=%@",nickName,phone,email,passWord];
    [HttpTool post:url withParams:params withSuccess:^(id json) {
        DLog(@"%@",json);
        if ([[json  objectForKey:@"message"] integerValue]== 0) {
            [AccountHanler saveAccountInfo:json];
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
- (void)executeLoginUserTaskWithAccount:(NSString *)account
                                withPaw:(NSString *)passWord
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
- (void)executeFindPwdTaskWithEmail:(NSString *)email
                            withPaw:(NSString *)passWord
                            success:(SuccessBlock)success
                            failed:(FailedBlock)failed
{
    [AlertUtil showAlertWithText:@"找回密码"];
    NSString *url =[BaseHandler requestUrlWithUrl:API_FINDPWD WithPath:@""];
    NSString *params = [NSString stringWithFormat:@"email=%@",email];
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
 *  用户注册协议
 */
- (void)executeGetUserRegistProtacolWithSuccess:(SuccessBlock)success
                                         failed:(FailedBlock)failed
{
    [AlertUtil showAlertWithText:@"获取登陆注册协议"];
    NSString *url =[BaseHandler requestUrlWithUrl:API_REGISTPROTOCOL WithPath:@""];
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
 *  个人中心信息
 */
- (void)executeGetPersonCenterInfoWithUserId:(NSString *)userId
                                     Success:(SuccessBlock)success
                                      failed:(FailedBlock)failed
{
    [AlertUtil showAlertWithText:@"获取个人中心信息"];
    NSString *url =[BaseHandler requestUrlWithUrl:API_PERSONCENTERINFO WithPath:@""];
    NSString *params = [NSString stringWithFormat:@"uid=%@",userId];
    [HttpTool post:url withParams:params withSuccess:^(id json) {
        DLog(@"%@",json);
        if ([[json  objectForKey:@"message"] integerValue]== 0) {
            [AccountHanler saveAccountOtherInfo:json];
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
 *  个人信息
 */
- (void)executeGetUserInfoWithUserId:(NSString *)userId
                             Success:(SuccessBlock)success
                              failed:(FailedBlock)failed

{
    [AlertUtil showAlertWithText:@"获取个人信息"];
    NSString *url =[BaseHandler requestUrlWithUrl:API_PERSONINFO WithPath:@""];
    NSString *params = [NSString stringWithFormat:@"uid=%@",userId];
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
 *  修改个人信息
 */
- (void)executeGetUserInfoWithUserId:(NSString *)userId
                           withPhone:(NSString *)phone
                           withEmail:(NSString *)email
                             Success:(SuccessBlock)success
                              failed:(FailedBlock)failed

{
    [AlertUtil showAlertWithText:@"修改个人信息"];
    NSString *url =[BaseHandler requestUrlWithUrl:API_UPDATEPERSONINFO WithPath:@""];
    NSString *params = [NSString stringWithFormat:@"uid=%@",userId];
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
 *  修改用户密码
 */
- (void)executeUpdateUserPwdWithUserId:(NSString *)userId
                          withOrderPwd:(NSString *)oldPwd
                            withNewPwd:(NSString *)newPwd
                               Success:(SuccessBlock)success
                                failed:(FailedBlock)failed
{
    [AlertUtil showAlertWithText:@"修改用户密码"];
    NSString *url =[BaseHandler requestUrlWithUrl:API_UPDATEPWD WithPath:@""];
    NSString *params = [NSString stringWithFormat:@"uid=%@&order_password=%@&new_password=%@",userId,oldPwd,newPwd];
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
 *  18.我的收藏
 */
- (void)executeGetMyCollectionTaskWithUserId:(NSString *)userId
                                    withPage:(NSString *)page
                                     Success:(SuccessBlock)success
                                      failed:(FailedBlock)failed
{
    
    [AlertUtil showAlertWithText:@"获取我的收藏"];
    NSString *url =[BaseHandler requestUrlWithUrl:API_MYCOLLECTION WithPath:@""];
    NSString *params = [NSString stringWithFormat:@"uid=%@&page=%@",userId,page];
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
 *  19.删除我的收藏
 */
- (void)executeDeleteMyCollectionTaskWithUserId:(NSString *)userId
                                 withProductIds:(NSString *)ids
                                        Success:(SuccessBlock)success
                                         failed:(FailedBlock)failed
{
    
    [AlertUtil showAlertWithText:@"获取我的收藏"];
    NSString *url =[BaseHandler requestUrlWithUrl:API_DELETEMYCOLLECTION WithPath:@""];
    NSString *params = [NSString stringWithFormat:@"uid=%@&ids=%@",userId,ids];
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
 *  20.添加收货地址
 */
- (void)executeAddAdressTaskWithUserId:(NSString *)userId
                          withUserName:(NSString *)userName
                            withMobile:(NSString *)mobile
                           withAddress:(NSString *)address
                         withDoorPlate:(NSString *)doorPlate
                        withPostalcode:(NSString *)postalcode
                             withPhone:(NSString *)phone
                               Success:(SuccessBlock)success
                                failed:(FailedBlock)failed
{
    
    [AlertUtil showAlertWithText:@"添加收货地址"];
    NSString *url =[BaseHandler requestUrlWithUrl:API_ADDADRESS WithPath:@""];
    NSString *params = [NSString stringWithFormat:@"uid=%@&u_name=%@&mobile=%@&address=%@&doorplate=%@&postalcode=%@&phone=%@",userId,userName,mobile,address,doorPlate,postalcode,phone];
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
 *  21.修改收货地址
 */
- (void)executeUpdateAdressTaskWithUserId:(NSString *)userId
                             withUserName:(NSString *)userName
                               withMobile:(NSString *)mobile
                              withAddress:(NSString *)address
                            withDoorPlate:(NSString *)doorPlate
                           withPostalcode:(NSString *)postalcode
                                withPhone:(NSString *)phone
                             withAdressHandleId:(NSString *)aid
                                  Success:(SuccessBlock)success
                                   failed:(FailedBlock)failed
{
    
    [AlertUtil showAlertWithText:@"修改收货地址"];
    NSString *url =[BaseHandler requestUrlWithUrl:API_UPDATEADDRESS WithPath:@""];
    NSString *params = [NSString stringWithFormat:@"uid=%@&u_name=%@&mobile=%@&address=%@&doorplate=%@&postalcode=%@&phone=%@&aid=%@",userId,userName,mobile,address,doorPlate,postalcode,mobile,aid];
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
 *  22.删除收货地址
 */
- (void)executeDeleteAdressTaskWithUserId:(NSString *)userId
                       withAdressHandleId:(NSString *)aid
                                  Success:(SuccessBlock)success
                                   failed:(FailedBlock)failed
{
    
    [AlertUtil showAlertWithText:@"删除收货地址"];
    NSString *url =[BaseHandler requestUrlWithUrl:API_DELETEMYADRESS WithPath:@""];
    NSString *params = [NSString stringWithFormat:@"uid=%@&aid=%@",userId,aid];
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
 *  23.设置某条收货地址为默认地址
 */
- (void)executeSetUpDefaultAdressTaskWithUserId:(NSString *)userId
                             withAdressHandleId:(NSString *)aid
                                        Success:(SuccessBlock)success
                                         failed:(FailedBlock)failed
{
    
    [AlertUtil showAlertWithText:@"设置收货地址为默认地址"];
    NSString *url =[BaseHandler requestUrlWithUrl:API_SETDEFAULTADRESS WithPath:@""];
    NSString *params = [NSString stringWithFormat:@"uid=%@&aid=%@",userId,aid];
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
 *  24.收货地址管理列表
 */
- (void)executeGetAdressListTaskWithUserId:(NSString *)userId
                                   Success:(SuccessBlock)success
                                    failed:(FailedBlock)failed
{
    
    [AlertUtil showAlertWithText:@"获取收货地址列表"];
    NSString *url =[BaseHandler requestUrlWithUrl:API_ADRESSLIST WithPath:@""];
    NSString *params = [NSString stringWithFormat:@"uid=%@",userId];
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
#pragma mark - 购物车
/**
 *  25.购物车列表数据
 */
- (void)executeGetCartListTaskWithUserId:(NSString *)userId
                                withPage:(NSString *)page
                                 Success:(SuccessBlock)success
                                  failed:(FailedBlock)failed
{
    
    [AlertUtil showAlertWithText:@"获取购物车列表"];
    NSString *url =[BaseHandler requestUrlWithUrl:API_CARTLIST WithPath:@""];
    NSString *params = [NSString stringWithFormat:@"uid=%@&page=%@",userId,page];
    [HttpTool post:url withParams:params withSuccess:^(id json) {
        DLog(@"%@",json);
        
        WECartsModel *cartsModel=[[WECartsModel alloc]initWithDict:json];
        if ([cartsModel.message integerValue]== 0) {
            
            if (success) {
                success(cartsModel);
            }
        }else{
            if (failed) {
                failed(cartsModel);
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
 *  26.修改购物车里单个产品购买数量
 */
- (void)executeUpdateCartProductCountTaskWithUserId:(NSString *)userId
                                      withProductId:(NSString *)productId
                                            withNum:(NSString *)count
                                            Success:(SuccessBlock)success
                                             failed:(FailedBlock)failed
{
    
    [AlertUtil showAlertWithText:@"修改购物车里单个产品购买数量"];
    NSString *url =[BaseHandler requestUrlWithUrl:API_UPDATECARTPRODUCTCOUNT WithPath:@""];
    NSString *params = [NSString stringWithFormat:@"uid=%@&pid=%@&num=%@",userId,productId,count];
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
 *  27.删除购物车里的产品
 */
- (void)executeDeleteCartProductTaskWithUserId:(NSString *)userId
                                 withProductId:(NSString *)productId
                                       Success:(SuccessBlock)success
                                        failed:(FailedBlock)failed
{
    [AlertUtil showAlertWithText:@"删除购物车里的产品"];

    NSString *url =[BaseHandler requestUrlWithUrl:API_DELETECARTPRODUCT WithPath:@""];
    NSString *params = [NSString stringWithFormat:@"uid=%@&pid=%@",userId,productId];
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
 *  28.下单接口
 */
- (void)executePlaceOrderWithUserId:(NSString *)userId
                       withOrderNum:(NSString *)orderNum
                withProductsJsonStr:(NSString *)productsJsonStr
                   withReceivedName:(NSString *)name
                withReceivedAddress:(NSString *)address
                 withReceivedMobile:(NSString *)mobile
                  withReceivedPhone:(NSString *)phone
                         withFapiao:(NSString *)fapiao
                         withYunfei:(NSString *)yunfei
                   withReduceYunfei:(NSString *)reduceYunfei
                      withAll_price:(NSString *)allPrice
                         withPayWay:(NSString *)payWay
                    withFapiaoHeade:(NSString *)FapiaoHeade
                            Success:(SuccessBlock)success
                             failed:(FailedBlock)failed


{
    
    
    [AlertUtil showAlertWithText:@"下单接口"];
    
    NSString *url =[BaseHandler requestUrlWithUrl:API_CARTPLACEORDER WithPath:@""];
    NSString *params = [NSString stringWithFormat:@"uid=%@&order_num=%@&products=%@&received_person_name=%@&received_address=%@&mobile=%@&phone=%@&is_get_fapiao=%@&fapiao_taitou=%@&address=%@&all_price=%@&yun_fei=%@&reduce_yun_fei=%@&pay_way=%@",userId,orderNum,productsJsonStr,name,address,mobile,phone,fapiao,FapiaoHeade,[[address componentsSeparatedByString:@","] objectAtIndex:0],allPrice,yunfei,reduceYunfei,payWay];
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
 *  29.订单查询接口地址
 */
- (void)executeQueryOrderTaskWithUserId:(NSString *)userId
                              withState:(NSString *)state withPage:(NSString*)page
                                Success:(SuccessBlock)success
                                 failed:(FailedBlock)failed
{
    [AlertUtil showAlertWithText:@"订单查询"];
    
    NSString *url =[BaseHandler requestUrlWithUrl:API_QUERYORDER WithPath:@""];
    NSString *params = [NSString stringWithFormat:@"uid=%@&state=%@&page=%@",userId,state,page];
    [HttpTool post:url withParams:params withSuccess:^(id json) {
        DLog(@"%@",json);
        
        MyOrderModel *mm = [[MyOrderModel alloc]initWithDict:json];
        if ([[json  objectForKey:@"message"] integerValue]== 0) {
            
            if (success) {
                success(mm);
            }
        }else{
            if (failed) {
                failed(mm);
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
 *  30.确认收货
 */

- (void)executeAffirmAcceptGoodsWithUserId:(NSString *)userId
                              withOrderNum:(NSString *)OrderNum
                                   Success:(SuccessBlock)success
                                    failed:(FailedBlock)failed

{


    [AlertUtil showAlertWithText:@"确认收货"];
    
    NSString *url =[BaseHandler requestUrlWithUrl:API_AFFIRMACCEPTGOODS WithPath:@""];
    NSString *params = [NSString stringWithFormat:@"uid=%@&order_num=%@",userId,OrderNum];
    [HttpTool post:url withParams:params withSuccess:^(id json) {
        DLog(@"%@",json);
         if ([[json  objectForKey:@"message"] integerValue]== 0) {
            
            if (success) {
                success(json);
            }
        }else{
            if (failed) {
                failed(json);
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
 *  31.订单详情
 */
- (void)executeOrderDetailWithUserId:(NSString *)userId
                        withOrderNum:(NSString *)orderNum
                             Success:(SuccessBlock)success
                              failed:(FailedBlock)failed
{


    [AlertUtil showAlertWithText:@"订单详情"];
    
    NSString *url =[BaseHandler requestUrlWithUrl:API_ORDERDETAIL WithPath:@""];
    NSString *params = [NSString stringWithFormat:@"uid=%@&order_num=%@",userId,orderNum];
    [HttpTool post:url withParams:params withSuccess:^(id json) {
        DLog(@"%@",json);
        
       
        if ([[json  objectForKey:@"message"] integerValue]== 0) {
            
            if (success) {
                success(json);
            }
        }else{
            if (failed) {
                failed(json);
            }
        }
    } withFailure:^(NSError *error) {
        DLog(@"%@",error.localizedDescription);
        if (failed) {
            failed(error);
        }
    }];


}
///**
// *  33.订单评价
// */
//- (void)executeAffirmAcceptGoodsWithUserId:(NSString *)userId
//                                   withArr:(NSArray *)arr
//                                   Success:(SuccessBlock)success
//                                    failed:(FailedBlock)failed;
//
//{
//
//
//    [AlertUtil showAlertWithText:@"订单评价"];
//    NSString *url =[BaseHandler requestUrlWithUrl:API_DELETECARTPRODUCT WithPath:@""];
//
//
//
////    NSString *params = [NSString stringWithFormat:@"uid=%@&Pinglun_list=%@",userId,count];
//    for (NSDictionary *dic in arr) {
//
//
//
//
//    }
//
//
//    [HttpTool post:url withParams:params withSuccess:^(id json) {
//        DLog(@"%@",json);
//        if ([[json  objectForKey:@"message"] integerValue]== 0) {
//
//            if (success) {
//                success(json);
//            }
//        }else{
//            if (failed) {
//                failed(nil);
//            }
//        }
//    } withFailure:^(NSError *error) {
//        DLog(@"%@",error.localizedDescription);
//        if (failed) {
//            failed(error);
//        }
//    }];
//
//
//}
//


/**
 *  31.订单支付
 */
- (void)executePayOrderWithUserId:(NSString *)userId
                     withOrderNum:(NSString *)orderNum
                   withTotalMoney:(NSString*)money
                          Success:(SuccessBlock)success
                           failed:(FailedBlock)failed{

    
    [AlertUtil showAlertWithText:@"订单支付"];
    
    NSString *url =[BaseHandler requestUrlWithUrl:API_PAYORDER WithPath:@""];
    NSString *params = [NSString stringWithFormat:@"uid=%@&order_num=%@&money=%@",userId,orderNum,money];
    [HttpTool post:url withParams:params withSuccess:^(id json) {
        DLog(@"%@",json);
        
        
        if ([[json  objectForKey:@"message"] integerValue]== 0) {
            
            if (success) {
                success(json);
            }
        }else{
            if (failed) {
                failed(json);
            }
        }
    } withFailure:^(NSError *error) {
        DLog(@"%@",error.localizedDescription);
        if (failed) {
            failed(error);
        }
    }];
}


@end
