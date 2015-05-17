//
//  APIConfig.h
//  WestElectromechanical
//
//  Created by zuo on 15/4/26.
//  Copyright (c) 2015年 zuo. All rights reserved.
//

#ifndef WestElectromechanical_APIConfig_h
#define WestElectromechanical_APIConfig_h

#define gold @"12"
#define kWEImgUrl @"http://114.215.135.236/ehsy/"
#define kWEProductImgUrl @"http://www.ehsy.com"
#endif
#define BASEPARAMS [NSMutableDictionary dictionaryWithDictionary:\
@{\
@"device_type":@"iOS",\
@"device_name":[[UIDevice currentDevice] localizedModel],\
@"device_language":@"zh-CN",\
@"device_id":[[[UIDevice currentDevice] identifierForVendor] UUIDString],\
}\
];\

/**
 *  首页数据
 */
#define API_HOME_DATA @"/json_index.php"
/**
 *  公告详情
 */
#define API_HOME_AD_DETAIL @"/json_notice.php"

/**
 *  搜索热门推荐
 */
#define API_SEARCH_HOTRECOMMEND @"/json_hot.php"

/**
 *  搜索产品
 */
#define API_SEARCH_SEARCH @"/json_search.php"

/**
 *  产品详情
 */
#define API_PRODUCT_DETAIL @"/json_productdetail.php"

/**
 *  产品收藏
 */
#define API_PRODUCT_COLLECTION @"/json_collection.php"
/**
 *  产品加入购物车
 */
#define API_PRODUCT_ADDCART @"/json_shoppingadd.php"

/**
 *  产品评论列表
 */
#define API_PRODUCT_COMMENTLIST @"/json_productevaluationlist.php"

/**
 *  一级分类列表
 */
#define API_PRODUCT_FIRSTCATEGORYLIST @"/json_productclass.php"

/**
 *  二级分类列表
 */
#define API_PRODUCT_SECONDCATEGORYLIST @"/json_productclass.php"


/**
 *  注册
 */
#define API_REGIST @"/json_regist.php"

/**
 *  登陆
 */
#define API_Login @"/json_login.php"

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

/**
 *  18.我的收藏
 */
#define API_MYCOLLECTION @"/json_collectionmy.php"
/**
 *  19.删除我的收藏
 */
#define API_DELETEMYCOLLECTION @"/json_collectionmydelete.php"
/**
 *  20.添加收货地址
 */
#define API_ADDADRESS @"/json_addressadd.php"
/**
 *  21.修改收货地址
 */
#define API_UPDATEADDRESS @"/json_addressupdate.php"
/**
 *  22.删除收货地址
 */
#define API_DELETEMYADRESS @"/json_addressdelete.php"
/**
*  23.设置某条收货地址为默认地址
*/
#define API_SETDEFAULTADRESS @"/json_addresset.php"
/**
*  24.收货地址管理列表
*/
#define API_ADRESSLIST @"/json_address.php"
/**
*  25.购物车列表数据
*/
#define API_CARTLIST @"/json_shoppinglist.php"
/**
*  26.修改购物车里单个产品购买数量
*/
#define API_UPDATECARTPRODUCTCOUNT @"/json_shoppingnumber.php"

/**
 *  27.删除购物车里单个产品
 */
#define API_DELETECARTPRODUCT @"/json_shoppingdelete.php"

/**
 *  29.订单查询
 */
#define API_QUERYORDER @"/json_order.php"

























