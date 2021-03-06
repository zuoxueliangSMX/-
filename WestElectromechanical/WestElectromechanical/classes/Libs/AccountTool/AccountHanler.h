//
//  AccountHanler.h
//  time
//
//  Created by zuo on 15/4/1.
//  Copyright (c) 2015年 chenyirong007. All rights reserved.
//

#import <Foundation/Foundation.h>

static NSString * const ACCOUNT_USER_ID = @"uid";

static NSString * const ACCOUNT_USER_CODE = @"code";
static NSString * const ACCOUNT_TOKEN_ID = @"tokenid";
static NSString * const ACCOUNT_USER_NAME = @"U_name";
static NSString * const ACCOUNT_IS_IDENTIFICATION = @"is_identification";

#define LOGIN_STATE @"login_state"
#define MOBILE_PHONE @"mobilephone"
#define ADDRESS @"address"
#define RECIVE_NAME @"recive_name"
#define RECIVE_PHONE @"recive_phone"

#define INVOICESTYLE @"invoice_style"
#define INVOICEHEADE @"invoice_heade"
#define INVOICEADRESS @"invoice_adress"

@interface AccountHanler : NSObject

/**
 *  用户号
 */
@property (nonatomic ,copy)NSString * userId;
+ (NSString *)userId;
+ (void)saveUserId:(NSString *)userId;



/**
 *  用户密码
 */
@property (nonatomic ,copy)NSString *userCode;
+ (NSString *)userCode;
+ (void)saveUserCode:(NSString *)userCode;


/**
 *  token验证号
 */
@property (nonatomic ,copy)NSString* tokenId;
+ (NSString *)tokenId;
+ (void)saveTokenId:(NSString *)tokenId;

/**
 *  用户名
 */
@property (nonatomic ,copy)NSString* userName;
+ (NSString *)userName;
+ (void)saveUserName:(NSString *)userName;

/**
 *  判断是否被验证
 */
@property (nonatomic ,assign)BOOL isIdentification;
+ (BOOL)isIdentification;
+ (void)saveIsIdentification:(NSString *)isIdentification;

/**
 *  登录状态
 */
+ (void)setLoginState:(NSInteger)state;
+ (NSInteger)loginState;
/**
 *  手机号
 */
+(NSString *)mobilePhone;
+(void)setMobilePhone:(NSString *)phone;

/**
 *  接受人手机号
 */
+(NSString *)recivePhone;
+(void)setRecivePhone:(NSString *)phone;


/**
 *  地址
 */
+(NSString *)addres;
+(void)setaddres:(NSString *)addres;


/**
 *  收货人姓名
 */
+(NSString *)reciveName;
+(void)setreciveName:(NSString *)reciveName;






/**
 *  发票类型
 */
+(NSString *)invoiceStyle;
+(void)setInvoiceStyle:(NSString *)invoiceStyle;


/**
 *  发票抬头
 */
+(NSString *)invoiceHead;
+(void)setInvoiceHead:(NSString *)invoiceHead;


/**
 *  发票地址
 */
+(NSString *)invoiceAdress;
+(void)setInvoiceAdress:(NSString *)invoiceAdress;



+(void)deleteAccount;
+(void)saveAccountOtherInfo:(NSDictionary *)infoDict;
+(void)saveAccountInfo:(NSDictionary *)infoDict;
@end
