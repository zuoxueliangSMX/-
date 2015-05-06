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


//iphone5适配
#define iPhone5 ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(640, 1136), [[UIScreen mainScreen] currentMode].size) : NO)

#define VIEW_WIDETH self.view.frame.size.width
#define VIEW_HEIGHT self.view.frame.size.height



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

// 支付宝公钥
#define AlipayPubKey @"MIGfMA0GCSqGSIb3DQEBAQUAA4GNADCBiQKBgQCAAeeQyaIs+DvTe48pH56/cPZ/0gHlO0kHfrcQFRvpPOlerpWh1+QGVR1KhgeOOoSkQuguPKcpULIk8X+wUBVuswx9ZwO5f5cIjcDIc3ird7soBBSzS5paewpF1zJPT+51B71VqoOljlgSY5R9akeo35ziJXDCCGlPm6zm23FRwwIDAQAB"

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
