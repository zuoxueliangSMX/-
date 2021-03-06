//
//  WEHTTPHandler.h
//  WestElectromechanical
//
//  Created by zuo on 15/5/2.
//  Copyright (c) 2015年 zuo. All rights reserved.
//

#import "BaseHandler.h"
#import "WECartsModel.h"
#import "WEProductComments.h"
@interface WEHTTPHandler : BaseHandler

#pragma mark -
#pragma mark -首页
/**
 *  1.首页数据
 */
- (void)executeGetHomeDataTaskWithCityName:(NSString *)cityName
                               withSuccess:(SuccessBlock)success
                                withFailed:(FailedBlock)failed;
/**
 *  2.公告详情
 */
- (void)executeGetHomeAdDetailTaskWithAdId:(NSString *)AdId
                               withSuccess:(SuccessBlock)success
                                withFailed:(FailedBlock)failed;



#pragma mark -
#pragma mark -搜索
/**
 *  3.获取搜索热门推荐
 */
- (void)executeGetHotRecommendWithCityName:(NSString *)cityName
                               withSuccess:(SuccessBlock)success
                                withFailed:(FailedBlock)failed;

/**
 *  4.根据内容搜索
 */
- (void)executeGetSearchDataWithSearchContent:(NSString *)content
                                  withSuccess:(SuccessBlock)success
                                   withFailed:(FailedBlock)failed;
/**
 *  搜索商品名字
 */

- (void)executeGetSearchDataWithSearchProductName:(NSString *)productName
                                      withSuccess:(SuccessBlock)success
                                       withFailed:(FailedBlock)failed;

#pragma mark -
#pragma mark - 产品详情
/**
 *  5.产品详情
 */
- (void)executeGetProductDetailDataWithProductId:(NSString *)productId
                                     withSuccess:(SuccessBlock)success
                                      withFailed:(FailedBlock)failed;

/**
 *  6.产品收藏
 */
- (void)executeProductCollectionTaskWithProductId:(NSString *)productId
                                       withUserId:(NSString *)userId
                                      withSuccess:(SuccessBlock)success
                                       withFailed:(FailedBlock)failed;

/**
 *  7.产品加入购物车
 */
- (void)executeProductAddCartTaskWithProductId:(NSString *)productId
                                    withUserId:(NSString *)userId
                                   withSuccess:(SuccessBlock)success
                                    withFailed:(FailedBlock)failed;


/**
 *  8.获取产品评论列表
 */
- (void)executeGetProductCommentListTaskWithProductId:(NSString *)productId
                                          withSuccess:(SuccessBlock)success
                                           withFailed:(FailedBlock)failed;

#pragma mark -
#pragma mark -分类
/**
 *  9.获取一级分类列表
 */
- (void)executeGetFirstCategoryTaskWithSuccess:(SuccessBlock)success
                                    WithFailed:(FailedBlock)failed;
/**
 *  9.获取二级分类列表
 */
- (void)executeGetSecondCategoryTaskWithCategory:(NSString *)categoryId
                                         Success:(SuccessBlock)success
                                      WithFailed:(FailedBlock)failed;
#pragma mark -
#pragma mark -购物车


#pragma mark -
#pragma mark -个人中心

/**
 *  10.注册
 */
- (void)executeRegistUserTaskWithName:(NSString *)nickName
                              withPaw:(NSString *)passWord
                            withEmail:(NSString *)email
                            withPhone:(NSString *)phone
                              success:(SuccessBlock)success
                               failed:(FailedBlock)failed;
/**
 *  11.登陆
 */

- (void)executeLoginUserTaskWithAccount:(NSString *)account
                                withPaw:(NSString *)passWord
                                success:(SuccessBlock)success
                                 failed:(FailedBlock)failed;
/**
 *  12.找回密码
 */
- (void)executeFindPwdTaskWithEmail:(NSString *)email
                            withPaw:(NSString *)passWord
                            success:(SuccessBlock)success
                             failed:(FailedBlock)failed;
/**
 *  13.用户注册协议
 */
- (void)executeGetUserRegistProtacolWithSuccess:(SuccessBlock)success
                                         failed:(FailedBlock)failed;

/**
 *  14.个人中心信息
 */
- (void)executeGetPersonCenterInfoWithUserId:(NSString *)userId
                                     Success:(SuccessBlock)success
                                      failed:(FailedBlock)failed;
/**
 *  15.个人信息
 */
- (void)executeGetUserInfoWithUserId:(NSString *)userId
                             Success:(SuccessBlock)success
                              failed:(FailedBlock)failed;
/**
 *  16.修改个人信息
 */
- (void)executeGetUserInfoWithUserId:(NSString *)userId
                           withPhone:(NSString *)phone
                           withEmail:(NSString *)email
                             Success:(SuccessBlock)success
                              failed:(FailedBlock)failed;
/**
 *  17.修改用户密码
 */
- (void)executeUpdateUserPwdWithUserId:(NSString *)userId
                          withOrderPwd:(NSString *)oldPwd
                            withNewPwd:(NSString *)newPwd
                               Success:(SuccessBlock)success
                                failed:(FailedBlock)failed;
/**
 *  18.我的收藏
 */
- (void)executeGetMyCollectionTaskWithUserId:(NSString *)userId
                                    withPage:(NSString *)page
                                     Success:(SuccessBlock)success
                                      failed:(FailedBlock)failed;
/**
 *  19.删除我的收藏
 */
- (void)executeDeleteMyCollectionTaskWithUserId:(NSString *)userId
                                 withProductIds:(NSString *)ids
                                        Success:(SuccessBlock)success
                                         failed:(FailedBlock)failed;
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
                                failed:(FailedBlock)failed;
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
                                   failed:(FailedBlock)failed;
/**
 *  22.删除收货地址
 */
- (void)executeDeleteAdressTaskWithUserId:(NSString *)userId
                       withAdressHandleId:(NSString *)aid
                                  Success:(SuccessBlock)success
                                   failed:(FailedBlock)failed;
/**
 *  23.设置某条收货地址为默认地址
 */
- (void)executeSetUpDefaultAdressTaskWithUserId:(NSString *)userId
                             withAdressHandleId:(NSString *)aid
                                        Success:(SuccessBlock)success
                                         failed:(FailedBlock)failed;
/**
 *  24.收货地址管理列表
 */
- (void)executeGetAdressListTaskWithUserId:(NSString *)userId
                                   Success:(SuccessBlock)success
                                    failed:(FailedBlock)failed;
/**
 *  25.购物车列表数据
 */
- (void)executeGetCartListTaskWithUserId:(NSString *)userId
                                withPage:(NSString *)page
                                 Success:(SuccessBlock)success
                                  failed:(FailedBlock)failed;
/**
 *  26.修改购物车里单个产品购买数量
 */
- (void)executeUpdateCartProductCountTaskWithUserId:(NSString *)userId
                                      withProductId:(NSString *)productId
                                            withNum:(NSString *)count
                                            Success:(SuccessBlock)success
                                             failed:(FailedBlock)failed;
/**
 *  27.删除购物车里的产品
 */
- (void)executeDeleteCartProductTaskWithUserId:(NSString *)userId
                                      withProductId:(NSString *)productId
                                            Success:(SuccessBlock)success
                                             failed:(FailedBlock)failed;




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
                             failed:(FailedBlock)failed;



/**
*  29.订单查询接口地址
*/
- (void)executeQueryOrderTaskWithUserId:(NSString *)userId
                              withState:(NSString *)state withPage:(NSString*)page
                                       Success:(SuccessBlock)success
                                        failed:(FailedBlock)failed;


/**
 *  30.确认收货
 */
- (void)executeAffirmAcceptGoodsWithUserId:(NSString *)userId
                              withOrderNum:(NSString *)state
                                Success:(SuccessBlock)success
                                 failed:(FailedBlock)failed;






/**
 *  31.订单详情
 */
- (void)executeOrderDetailWithUserId:(NSString *)userId
                              withOrderNum:(NSString *)orderNum
                                   Success:(SuccessBlock)success
                                    failed:(FailedBlock)failed;


/**
 *  35.订单评价
 */
- (void)executeOrderCommentsWithUserId:(NSString *)userId
                              withOrderNum:(NSString *)orderNum
                           withJsonStr:(NSString*)PinglunList
                                   Success:(SuccessBlock)success
                                    failed:(FailedBlock)failed;



/**
 *  31.订单支付
 */
- (void)executePayOrderWithUserId:(NSString *)userId
                            withOrderNum:(NSString *)orderNum
                             withTotalMoney:(NSString*)money
                             Success:(SuccessBlock)success
                              failed:(FailedBlock)failed;

/**
 *  32.支付宝信息
 */
- (void)executePayInfoWithSuccess:(SuccessBlock)success
                           failed:(FailedBlock)failed;

/**
 *  33.根据分类搜索产品并排序
 */
- (void)executeGetSearchDataWithSearchContent:(NSString *)content
                                    withOrder:(NSString *)order
                                  withSuccess:(SuccessBlock)success
                                   withFailed:(FailedBlock)failed;

/**
 *  34.搜索商品名字
 */

- (void)executeGetSearchDataWithSearchProductNameOrder:(NSString *)productName
                                             withOrder:(NSString *)order
                                           withSuccess:(SuccessBlock)success
                                            withFailed:(FailedBlock)failed;

/**
 *  34.意见反馈
 */

- (void)executeCommitOrderBackWithMessage:(NSString *)message
                              withSuccess:(SuccessBlock)success
                               withFailed:(FailedBlock)failed;



/**
 *  35.产品名字搜索
 */
- (void)executeDoProductFilterWithProductName:(NSString *)productName
                               withFirstPrice:(NSString*)firstPrice
                              withSecondPrice:(NSString *)secondPrice
                                    withBrand:(NSString *)Brand
                                     withPage:(NSString *)page
                                      Success:(SuccessBlock)success
                                       failed:(FailedBlock)failed;

/**
 *  36.产品分类搜索
 */

- (void)executeDoProductFilterWithProductCategory:(NSString *)categoryId
                                   withFirstPrice:(NSString*)firstPrice
                                  withSecondPrice:(NSString *)secondPrice
                                        withBrand:(NSString *)Brand
                                         withPage:(NSString *)page
                                          Success:(SuccessBlock)success
                                           failed:(FailedBlock)failed;


@end
