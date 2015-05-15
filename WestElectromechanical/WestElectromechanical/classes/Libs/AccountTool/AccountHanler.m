//
//  AccountHanler.m
//  time
//
//  Created by zuo on 15/4/1.
//  Copyright (c) 2015年 chenyirong007. All rights reserved.
//

#import "AccountHanler.h"
#import "UserDefaultsUtils.h"

@implementation AccountHanler


/**
 *  用户号
 */
//@property (nonatomic ,copy)NSString * userId;
+ (NSString *)userId
{
    return [UserDefaultsUtils valueWithKey:ACCOUNT_USER_ID];
}
+ (void)saveUserId:(NSString *)userId
{
    [UserDefaultsUtils saveValue:userId forKey:ACCOUNT_USER_ID];
}
/**
 *  用户密码
 */

+ (NSString *)userCode{

    return [UserDefaultsUtils valueWithKey:ACCOUNT_USER_CODE];;
}
+ (void)saveUserCode:(NSString *)userCode
{
    [UserDefaultsUtils saveValue:userCode forKey:ACCOUNT_USER_CODE];


}


/**
 *  token验证号
 */
+ (NSString *)tokenId
{
    return [UserDefaultsUtils valueWithKey:ACCOUNT_TOKEN_ID];

}
+ (void)saveTokenId:(NSString *)tokenId
{
    [UserDefaultsUtils saveValue:tokenId forKey:ACCOUNT_TOKEN_ID];

}


/**
 *  用户名
 */
+ (NSString *)userName
{
    return [UserDefaultsUtils valueWithKey:ACCOUNT_USER_NAME];

}
+ (void)saveUserName:(NSString *)userName
{
    [UserDefaultsUtils saveValue:userName forKey:ACCOUNT_USER_NAME];
}

/**
 *  判断是否被验证
 */
+ (BOOL)isIdentification
{
    return [UserDefaultsUtils boolValueWithKey:ACCOUNT_IS_IDENTIFICATION];
}
+ (void)saveIsIdentification:(NSString *)isIdentification
{
    [UserDefaultsUtils saveBoolValue:[isIdentification boolValue] withKey:ACCOUNT_IS_IDENTIFICATION];

}


#pragma mark - 登录状态

+ (void)setLoginState:(NSInteger)state{
    
    [UserDefaultsUtils setIntegerValue:state withKey:LOGIN_STATE];
    
}
+ (NSInteger)loginState{
    return [UserDefaultsUtils integerValueWithKey:LOGIN_STATE];
}


#pragma mark phone
+(void)setMobilePhone:(NSString *)phone{
    
    [UserDefaultsUtils saveValue:phone forKey:MOBILE_PHONE];

}
+(NSString *)mobilePhone{
    
    return [UserDefaultsUtils valueWithKey:MOBILE_PHONE];
}

/**
 *  接受人手机号
 */
+(NSString *)recivePhone
{

 return [UserDefaultsUtils valueWithKey:RECIVE_PHONE];
}
+(void)setRecivePhone:(NSString *)phone
{
 [UserDefaultsUtils saveValue:phone forKey:RECIVE_PHONE];

}



/**
 *  地址
 */
+(NSString *)addres
{
    return [UserDefaultsUtils valueWithKey:ADDRESS];

}
+(void)setaddres:(NSString *)addres{

    [UserDefaultsUtils saveValue:addres forKey:ADDRESS];


}

/**
 *  收货人姓名
 */
+(NSString *)reciveName
{

 return [UserDefaultsUtils valueWithKey:RECIVE_NAME];
}
+(void)setreciveName:(NSString *)reciveName
{
    [UserDefaultsUtils saveValue:reciveName forKey:RECIVE_NAME];


}


/**
 *  发票类型
 */
+(NSString *)invoiceStyle
{

return [UserDefaultsUtils valueWithKey:INVOICESTYLE];

}
+(void)setInvoiceStyle:(NSString *)invoiceStyle
{
    [UserDefaultsUtils saveValue:invoiceStyle forKey:INVOICESTYLE];


}


/**
 *  发票抬头
 */
+(NSString *)invoiceHead

{
return [UserDefaultsUtils valueWithKey:INVOICEHEADE];

}
+(void)setInvoiceHead:(NSString *)invoiceHead
{

  [UserDefaultsUtils saveValue:invoiceHead forKey:INVOICEHEADE];
}


/**
 *  发票地址
 */
+(NSString *)invoiceAdress
{

return [UserDefaultsUtils valueWithKey:INVOICEADRESS];
}
+(void)setInvoiceAdress:(NSString *)invoiceAdress
{
[UserDefaultsUtils saveValue:invoiceAdress forKey:INVOICEADRESS];

}




+(void)saveAccountOtherInfo:(NSDictionary *)infoDict
{
    [AccountHanler saveIsIdentification:[infoDict objectForKey:ACCOUNT_IS_IDENTIFICATION]];
    [AccountHanler saveUserName:[infoDict objectForKey:ACCOUNT_USER_NAME]];

}

+(void)saveAccountInfo:(NSDictionary *)infoDict
{
    [AccountHanler saveTokenId:[infoDict objectForKey:ACCOUNT_TOKEN_ID]];
    [AccountHanler saveUserId:[infoDict objectForKey:ACCOUNT_USER_ID]];
}


+(void)deleteAccount{
    [AccountHanler saveTokenId:nil];
    [AccountHanler saveUserId:nil];
    [AccountHanler saveUserName:nil];
    [AccountHanler saveIsIdentification:nil];
}

@end
