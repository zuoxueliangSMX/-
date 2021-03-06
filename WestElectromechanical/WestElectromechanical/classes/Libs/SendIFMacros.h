//
//  SendIFMacros.h
//  TravelHeNan
//
//  Created by Apple on 13-12-11.
//  Copyright (c) 2013年 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

#ifndef SendIFMacros_h
#define SendIFMacros_h










//*******************支付宝*******************//
//合作身份者id，以2088开头的16位纯数字
#define PartnerID @"2088301235096243"
//收款支付宝账号
#define SellerID  @"lunyi2015@163.com"

//安全校验码（MD5）密钥，以数字和字母组成的32位字符
#define MD5_KEY @"9u66u3titp5u758th8lzioaiqpga61ph"

//商户私钥，自助生成
#define PartnerPrivKey  @"MIICdgIBADANBgkqhkiG9w0BAQEFAASCAmAwggJcAgEAAoGBAOPJv8E8/cPQPTRE/petWSZZ/E6rUpTuiZvGybG84K4lTQV0w9/XufqMoi/235EO4WICRMAuWCNQ1AFcRBj1v2Fs6oHonHZx94l/ER9jRPf3QHi57XZQ4F+NRcTWJL8bZe/kg5o8szFGTh8wNs3Se3G4sEchDxbj6fNrvJrq1mfPAgMBAAECgYAFPOdm5yMitJAjuo5sKHVLV3hgyrm8aPvLFDghGSnFd2AdBwFWDVzecQtttOyRJllyaoDwNmCad0pYualrNYNwC/T+/BFztO1+uaSn0MMCwxbWP1CrifBv08dAM/qvMmQGTiHtCrAT2Ht+FwoZAg9Fyho2InH4FKEkUYsUXUfV2QJBAP6zB6+AtsLjvbsuJNLFTLRtqB6EIqDSAsx7u7oMZdNB9ZdpJdd8HkyE/9VAi5WD6KivrMC6lUIhAuQfWeY2KaMCQQDk84mrsvmL4RAH8QAZclRwP3odjIP/j60RIFWvDiBcfN+askrXhSAheosiiCwguF4wybGJl4RrDDfuJocdZMPlAkEA+0CM0lp87+BNqDqq5KjxNAQAlqnupwrE7AcbdzsHr9Effk+hnuK32PBSl4HmsIXBm7ZBCpaE6wk5muQ6gNjpVQJALKkVAdk3tIGCjwoD6vLSZdL8DyeJ2CA+skiMbkljJqd1NsfwsXnWerFc0q+dbASK2xl8+EoGGpuXjW0WjjVJwQJAIrPjgFV/jqhS1OtiTeaRkLFJsvjQs4ds5OrDNEXYxBrMaYYxXJQihYb4khXrgo9Kf0IHs4LY5UTACJqWRg/LYw=="


//支付宝公钥
#define AlipayPubKey  @"MIGfMA0GCSqGSIb3DQEBAQUAA4GNADCBiQKBgQCnxj/9qwVfgoUh/y2W89L6BkRAFljhNhgPdyPuBV64bfQNN1PjbCzkIM6qRdKBoLPXmKKMiFYnkd6rAoprih3/PrQEB/VsW8OoM8fxn67UDYuyBTqA23MML9q1+ilIZwBC2AQ2UBVOrFXfFl75p6/B5KsiNG9zpgmLCUYuLkxpLQIDAQAB"

//支付宝回掉url
#define kALiPayNotifyUrl    @"http://115.29.178.110/alipay/notify_url.php"
//@"http://115.29.178.110/?c=pay"


//iphone5适配
#define iPhone5 ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(640, 1136), [[UIScreen mainScreen] currentMode].size) : NO)

#define VIEW_WIDETH self.view.frame.size.width
#define VIEW_HEIGHT self.view.frame.size.height



#define IS_IPAD (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)
#define IS_IPHONE (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone)
#define IS_RETINA ([[UIScreen mainScreen] scale] >= 2.0)
#define SCREEN_MAX_LENGTH (MAX(SCREEN_WIDTH, SCREEN_HEIGHT))
#define SCREEN_MIN_LENGTH (MIN(SCREEN_WIDTH, SCREEN_HEIGHT))

#define IS_IPHONE_4_OR_LESS (IS_IPHONE && SCREEN_MAX_LENGTH < 568.0)
#define IS_IPHONE_5 (IS_IPHONE && SCREEN_MAX_LENGTH == 568.0)
#define IS_IPHONE_6 (IS_IPHONE && SCREEN_MAX_LENGTH == 667.0)
#define IS_IPHONE_6P (IS_IPHONE && SCREEN_MAX_LENGTH == 736.0)




#define WARN_ALERT(MSG) [[[UIAlertView alloc] initWithTitle:@"提示" message:MSG delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil,nil] show]


//输出详细log,显示方法及所在的行数
// 2.日志输出宏定义
#ifdef DEBUG
// 调试状态
#define DLog(format, ...) do {                                              \
fprintf(stderr, ">------------------------------\n<%s : %d> %s\n",                                           \
[[[NSString stringWithUTF8String:__FILE__] lastPathComponent] UTF8String],  \
__LINE__, __func__);                                                        \
(NSLog)((format), ##__VA_ARGS__);                                           \
fprintf(stderr, "-----------------------------------\n");                                               \
} while (0)
#else
// 发布状态
#define DLog(...)
#endif

#define VIEW_BACKGROUND [self.view setBackgroundColor:[UIColor colorFromHexCode:@"#f2f2f2"]];

//当前系统版本
#define isIOS6 [[UIDevice currentDevice].systemVersion intValue]==6?1:0

#define BGCOLER [UIColor colorWithRed:25.f/255 green:45.f/255 blue:133.f/255 alpha:1]

#define SET_COLOR(A,B,C) ([UIColor colorWithRed:A/255 green:B/255 blue:C/255 alpha:1])

#define ALERT_WARN(MESSAGE) ([[[UIAlertView alloc] initWithTitle:@"提示" message:MESSAGE delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil] show])

#define INT_TO_STRING(PRA) [NSString stringWithFormat:@"%d",[resultSet intForColumn:PRA]]

//APPID 0 表示黄果树，1表示蓬莱
#ifndef APP_TYPE
#define APP_TYPE 0
#endif

#if APP_TYPE == 0
static NSString *const appId = @"4d47771b978c4d5b872c72d09237a158";
#elif APP_TYPE == 1
static NSString *const appId = @"";
#endif



//切换内外网，0表示内网，1表示外网

#ifndef SERVER_TYPE
#define SERVER_TYPE 1
#endif


//服务器suffPath
#define SERVER_PATH @"hgs/port/do.htm"

//测试服务器
#if SERVER_TYPE == 0
static NSString *const SendIFServer = @"http://192.168.0.200:8088";
//正式服务器
#elif SERVER_TYPE == 1
static NSString *const SendIFServer = @"http://app.ehgs.net:8094";
#endif


#define APP_URL @"https://itunes.apple.com/lookup?id=284910350"

#define DEFAULT_CITY_ID @"bdb3e546a86646039490b122812fbd17"



//通知
#define KNotification                 @"BuyNotification"
#define KNotifi_HideRearVC_UpdateData @"KNotifi_HideRearVC_UpdateData"
#define KNotifi_LoginSuccess          @"KNotifi_LoginSuccess"
#define KNotifi_RegisterSuccess       @"KNotifi_RegisterSuccess"

//打电话
#define CALL_PHONE(PHONE) ([[UIApplication sharedApplication] openURL:[NSURL URLWithString:[NSString stringWithFormat:@"tel://%@",PHONE]]])

//移除侧滑手势
#define REMOVE_SLIDERGESTURE [self.navigationController.navigationBar removeGestureRecognizer:self.navigationBarPanGestureRecognizer]

//返回
#define BACK_POP UIBarButtonItem *left = [[UIBarButtonItem alloc] initWithTitle:@"< 返回" style:UIBarButtonItemStyleDone target:self action:@selector(back)];\
self.navigationItem.leftBarButtonItem = left;

#define POP [self.navigationController popViewControllerAnimated:YES];
#define PUSH(ovc) [self.navigationController pushViewController:ovc animated:YES];

#define KNOTIFYNameNETWORKERROR @"NETWORKERROR"
#define KNOTIFYNameHeadViewClick @"HEADVIEWCLICK"
#define KNotificationNameEndUpdateData @"ENDUPDATEDATA"
#define KNotificationNeedShadow @"NEEDSHADOW"
#define KNotificationNOTNeedShadow @"NOTNEEDSHADOW"
#endif
