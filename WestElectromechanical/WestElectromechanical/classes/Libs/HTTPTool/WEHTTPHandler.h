//
//  WEHTTPHandler.h
//  WestElectromechanical
//
//  Created by zuo on 15/5/2.
//  Copyright (c) 2015年 zuo. All rights reserved.
//

#import "BaseHandler.h"

@interface WEHTTPHandler : BaseHandler

#pragma mark -
#pragma mark -首页
/**
 *  首页数据
 */
- (void)executeGetHomeDataTaskWithCityName:(NSString *)cityName
                               withSuccess:(SuccessBlock)success withFailed:(FailedBlock)failed;
/**
 *  公告详情
 */
- (void)executeGetHomeAdDetailTaskWithAdId:(NSString *)AdId
                               withSuccess:(SuccessBlock)success withFailed:(FailedBlock)failed;



#pragma mark -
#pragma mark -搜索
/**
 *  获取搜索热门推荐
 */
- (void)executeGetHotRecommendWithCityName:(NSString *)cityName
                               withSuccess:(SuccessBlock)success withFailed:(FailedBlock)failed;

/**
 *  根据内容搜索
 */
- (void)executeGetSearchDataWithSearchContent:(NSString *)content
                                  withSuccess:(SuccessBlock)success withFailed:(FailedBlock)failed;


#pragma mark -
#pragma mark - 产品详情
/**
 *  产品详情
 */
- (void)executeGetProductDetailDataWithProductId:(NSString *)productId
                                     withSuccess:(SuccessBlock)success withFailed:(FailedBlock)failed;

/**
 *  产品收藏
 */
- (void)executeProductCollectionTaskWithProductId:(NSString *)productId
                                       withUserId:(NSString *)userId
                                      withSuccess:(SuccessBlock)success withFailed:(FailedBlock)failed;

/**
 *  产品加入购物车
 */
- (void)executeProductAddCartTaskWithProductId:(NSString *)productId
                                    withUserId:(NSString *)userId
                                   withSuccess:(SuccessBlock)success withFailed:(FailedBlock)failed;


/**
 *  产品加入购物车
 */
- (void)executeGetProductCommentListTaskWithProductId:(NSString *)productId
                                          withSuccess:(SuccessBlock)success
                                           withFailed:(FailedBlock)failed;

#pragma mark -
#pragma mark -分类
/**
 *  获取一级分类列表
 */
- (void)executeGetFirstCategoryTaskWithSuccess:(SuccessBlock)success WithFailed:(FailedBlock)failed;
/**
 *  获取二级分类列表
 */
- (void)executeGetSecondCategoryTaskWithCategory:(NSString *)categoryId Success:(SuccessBlock)success WithFailed:(FailedBlock)failed;
#pragma mark -
#pragma mark -购物车


#pragma mark -
#pragma mark -个人中心

@end
