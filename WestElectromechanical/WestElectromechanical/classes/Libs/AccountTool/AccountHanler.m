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

+ (BOOL)isInvitationLogin
{
    return [UserDefaultsUtils boolValueWithKey:ACCOUNT_ISINVITATIONFIRST];

}
+ (void)saveIsInvitationLogin:(BOOL)isInvitationLogin
{
    if (isInvitationLogin) {
        
        [UserDefaultsUtils saveBoolValue:YES withKey:ACCOUNT_ISINVITATIONFIRST];
    }else{
        [UserDefaultsUtils saveBoolValue:NO withKey:ACCOUNT_ISINVITATIONFIRST];
    }
}


+ (BOOL)isFirstLogin
{
    return [UserDefaultsUtils boolValueWithKey:ACCOUNT_ISFIRST];

}
+ (void)saveIsFirstLogin:(BOOL)isFirstLogin
{
    if (isFirstLogin) {
        
        [UserDefaultsUtils saveBoolValue:YES withKey:ACCOUNT_ISFIRST];
    }else{
        [UserDefaultsUtils saveBoolValue:NO withKey:ACCOUNT_ISFIRST];
    }
    

}


+ (NSInteger)newFriendRequest{
    return [UserDefaultsUtils integerValueWithKey:ACCOUNT_NEW_FRIEND_REQUEST];
}
+ (void)saveNewFriendRequest:(NSInteger)request{
    [UserDefaultsUtils setIntegerValue:request withKey:ACCOUNT_NEW_FRIEND_REQUEST];
}
+ (void)saveNewFriendRequestAddOne{
    NSInteger old = [self newFriendRequest];
    old = old + 1;
    [UserDefaultsUtils setIntegerValue:old withKey:ACCOUNT_NEW_FRIEND_REQUEST];
}


/**
 *  邀约版本号
 */
+ (NSString *)appointment_version
{
      return [UserDefaultsUtils valueWithKey:ACCOUNT_APPOINTMENT_VERSION];
}
+ (void)saveAppointment_version:(NSString *)version
{
    if ([version isEqual:[NSNull null]]) {
        version = @"0";
    }
    
    int newVer = [version intValue];
    int oldVer = [[self appointment_version] intValue];
    if (newVer >= oldVer) {
        [UserDefaultsUtils saveValue:version forKey:ACCOUNT_APPOINTMENT_VERSION];
    }else if(newVer == 0){
        [UserDefaultsUtils saveValue:version forKey:ACCOUNT_APPOINTMENT_VERSION];
    }
}
/**
 *  地区
 */
+ (NSString *)area
{
 return [UserDefaultsUtils valueWithKey:ACCOUNT_AREA];
}
+ (void)saveArea:(NSString *)area
{
    if ([area isEqual:[NSNull null]]) {
        area = @" ";
    }
    [UserDefaultsUtils saveValue:area forKey:ACCOUNT_AREA];
}
/**
 *  生日
 */
+ (NSString *)birthday
{
     return [UserDefaultsUtils valueWithKey:ACCOUNT_BIRTHDAY];
}
+ (void)saveBirthday:(NSString *)birthday
{
    if ([birthday isEqual:[NSNull null]]) {
        birthday = @" ";
    }
    [UserDefaultsUtils saveValue:birthday forKey:ACCOUNT_BIRTHDAY];
}
/**
 *  积分
 */
+ (NSString *)integral
{
     return [UserDefaultsUtils valueWithKey:ACCOUNT_INTEGRAL];
}
+ (void)saveIntegral:(NSString *)integral
{
    if ([integral isEqual:[NSNull null]]) {
        integral = @" ";
    }
    [UserDefaultsUtils saveValue:integral forKey:ACCOUNT_INTEGRAL];
}
/**
 *  上次登录地区
 */
+ (NSString *)last_login_area
{
     return [UserDefaultsUtils valueWithKey:ACCOUNT_LAST_LOGIN_AREA];
}
+ (void)saveLast_login_area:(NSString *)last_login_area
{
    if ([last_login_area isEqual:[NSNull null]]) {
        last_login_area = @" ";
    }
    [UserDefaultsUtils saveValue:last_login_area forKey:ACCOUNT_LAST_LOGIN_AREA];
}
/**
 *  上次登录设备名
 */
+ (NSString *)last_login_devicename
{
    
     return [UserDefaultsUtils valueWithKey:ACCOUNT_LAST_LOGIN_DEVICENAME];
}
+ (void)saveLast_login_devicename:(NSString *)last_login_devicename
{
    if ([last_login_devicename isEqual:[NSNull null]]) {
        last_login_devicename = @" ";
    }
    [UserDefaultsUtils saveValue:last_login_devicename forKey:ACCOUNT_LAST_LOGIN_DEVICENAME];
}
/**
 *  上次登录时间
 yyyy+MM+dd hh:mm:ss
 */
+ (NSString *)last_login_time
{
     return [UserDefaultsUtils valueWithKey:ACCOUNT_LAST_LOGIN_TIME];
}
+ (void)saveLast_login_time:(NSString *)last_login_time
{
    if ([last_login_time isEqual:[NSNull null]]) {
        last_login_time = @" ";
    }
    [UserDefaultsUtils saveValue:last_login_time forKey:ACCOUNT_LAST_LOGIN_TIME];
}
/**
 *  邮箱地址
 */
+ (NSString *)mail_address
{
     return [UserDefaultsUtils valueWithKey:ACCOUNT_MAIL_ADDRESS];
}
+ (void)saveMail_address:(NSString *)mail_address
{
    if ([mail_address isEqual:[NSNull null]]) {
        mail_address = @" ";
    }
    [UserDefaultsUtils saveValue:mail_address forKey:ACCOUNT_MAIL_ADDRESS];
}
/**
 *  勋章
 */
+ (NSString *)medal
{
     return [UserDefaultsUtils valueWithKey:ACCOUNT_MEDAL];
}
+ (void)saveMedal:(NSString *)medal
{
    if ([medal isEqual:[NSNull null]]) {
        medal = @" ";
    }
    [UserDefaultsUtils saveValue:medal forKey:ACCOUNT_MEDAL];

}
/**
 *  昵称
 */
+ (NSString *)nickname
{
     return [UserDefaultsUtils valueWithKey:ACCOUNT_NICKNAME];
}
+ (void)saveNickname:(NSString *)nickname
{
    if ([nickname isEqual:[NSNull null]]) {
        nickname = @" ";
    }
    [UserDefaultsUtils saveValue:nickname forKey:ACCOUNT_NICKNAME];
}
/**
 *  头像
 */
+ (NSString *)photo
{
     return [UserDefaultsUtils valueWithKey:ACCOUNT_PHOTO];
}
+ (void)savePhoto:(NSString *)photo
{
    if ([photo isEqual:[NSNull null]]) {
        photo = @" ";
    }
    [UserDefaultsUtils saveValue:photo forKey:ACCOUNT_PHOTO];
}
/**
 *  上次登录设备id
 */
+ (NSString *)pridevice_id
{
     return [UserDefaultsUtils valueWithKey:ACCOUNT_PRIDEVICE_ID];
}
+ (void)savePridevice_id:(NSString *)pridevice_id
{
    if ([pridevice_id isEqual:[NSNull null]]) {
        pridevice_id = @" ";
    }
    [UserDefaultsUtils saveValue:pridevice_id forKey:ACCOUNT_PRIDEVICE_ID];
}
/**
 *  日程数据最后修改时间
 */
+ (NSString *)schedule_last_modify
{
     return [UserDefaultsUtils valueWithKey:ACCOUNT_SCHEDULE_LAST_MODIFY];
}
+ (void)saveSchedule_last_modify:(NSString *)schedule_last_modify
{
    if ([schedule_last_modify isEqual:[NSNull null]]) {
        schedule_last_modify = @" ";
    }
    [UserDefaultsUtils saveValue:schedule_last_modify forKey:ACCOUNT_SCHEDULE_LAST_MODIFY];
}
/**
 *  日程数据版本号
 */
+ (NSString *)schedule_version
{
     return [UserDefaultsUtils valueWithKey:ACCOUNT_SCHEDULE_VERSION];
}
+ (void)saveSchedule_version:(NSString *)schedule_version
{
    if ([schedule_version isEqual:[NSNull null]]) {
        schedule_version = @"0";
    }
    [UserDefaultsUtils saveValue:schedule_version forKey:ACCOUNT_SCHEDULE_VERSION];
}
/**
 *  性别
 */
+ (NSString *)sex
{
    NSString *gender;
    if ([[UserDefaultsUtils valueWithKey:ACCOUNT_SEX] isEqualToString:@""]) {
        gender=@"女";
    }else if ([[UserDefaultsUtils valueWithKey:ACCOUNT_SEX] isEqualToString:kPersonCenterSexMale]){
        gender=@"男";
    }else if ([[UserDefaultsUtils valueWithKey:ACCOUNT_SEX] isEqualToString:kPersonCenterSexFemale]){
        gender=@"女";
    }
     return gender;
}
+ (void)saveSex:(NSString *)sex
{
    if ([sex  isKindOfClass:[NSNull class]]) {
        sex = @"";
    }
    [UserDefaultsUtils saveValue:sex forKey:ACCOUNT_SEX];
}
/**
 *  手机号
 */
+ (NSString *)tel_number
{
     return [UserDefaultsUtils valueWithKey:ACCOUNT_TEL_NUMBER];
}
+ (void)saveTel_number:(NSString *)tel_number
{
    if ([tel_number isEqual:[NSNull null]]) {
        tel_number = @" ";
    }
    [UserDefaultsUtils saveValue:tel_number forKey:ACCOUNT_TEL_NUMBER];
}
/**
 *  第三方登入账号
 */
+ (NSString *)third_party_account
{
     return [UserDefaultsUtils valueWithKey:ACCOUNT_THIRD_PARTY_ACCOUNT];
}
+ (void)saveThird_party_account:(NSString *)third_party_account
{
    if ([third_party_account isEqual:[NSNull null]]) {
        third_party_account = @" ";
    }
    [UserDefaultsUtils saveValue:third_party_account forKey:ACCOUNT_THIRD_PARTY_ACCOUNT];
}
/**
 *  第三方登入token
 */
+ (NSString *)third_party_token
{
     return [UserDefaultsUtils valueWithKey:ACCOUNT_THIRD_PARTY_TOKEN];
}
+ (void)saveThird_party_token:(NSString *)third_party_token
{
    if ([third_party_token isEqual:[NSNull null]]) {
        third_party_token = @" ";
    }
    [UserDefaultsUtils saveValue:third_party_token forKey:ACCOUNT_THIRD_PARTY_TOKEN];
}
/**
 *  登陆token
 */
+ (NSString *)token
{
     return [UserDefaultsUtils valueWithKey:ACCOUNT_TOKEN];
}
+ (void)saveToken:(NSString *)token
{
    if ([token isEqual:[NSNull null]]) {
        token = @" ";
    }
    [UserDefaultsUtils saveValue:token forKey:ACCOUNT_TOKEN];
}
/**
 *  用户id
 */
+ (NSString *)user_id
{
    return [UserDefaultsUtils valueWithKey:ACCOUNT_USER_ID];
}
+ (void)saveUser_id:(NSString *)user_id
{
    if ([user_id isEqual:[NSNull null]]) {
        user_id = @" ";
    }
    [UserDefaultsUtils saveValue:user_id forKey:ACCOUNT_USER_ID];
}
/**
 *  用户类型
 */
+ (NSString *)user_type
{
     return [UserDefaultsUtils valueWithKey:ACCOUNT_USER_TYPE];
}
+ (void)saveUser_type:(NSString *)user_type
{
    if ([user_type isEqual:[NSNull null]]) {
        user_type = @" ";
    }
    [UserDefaultsUtils saveValue:user_type forKey:ACCOUNT_USER_TYPE];
}
/**
 *  个性签名
 */
+ (NSString *)signature
{
    return [UserDefaultsUtils valueWithKey:ACCOUNT_SIGNATURE];
}
+ (void)saveSignature:(NSString *)signature
{
    if ([signature isEqual:[NSNull null]]) {
        signature = @" ";
    }
    [UserDefaultsUtils saveValue:signature forKey:ACCOUNT_SIGNATURE];

}

/**
 *  电话
 */
+ (NSString *)account
{
   return [UserDefaultsUtils valueWithKey:ACCOUNT_ACCOUNT];
}
+ (void)saveAccount:(NSString *)account
{
    if ([account isEqual:[NSNull null]]) {
        account = @" ";
    }
    [UserDefaultsUtils saveValue:account forKey:ACCOUNT_ACCOUNT];
}

+(void)saveAccountInfo:(NSDictionary *)infoDict
{
    [AccountHanler saveAppointment_version:@"0"];
    [AccountHanler saveArea:[infoDict objectForKey:ACCOUNT_AREA]];
    [AccountHanler saveBirthday:[infoDict objectForKey:ACCOUNT_BIRTHDAY]];
    [AccountHanler saveIntegral:[infoDict objectForKey:ACCOUNT_INTEGRAL]];
    [AccountHanler saveLast_login_area:[infoDict objectForKey:ACCOUNT_LAST_LOGIN_AREA]];
    [AccountHanler saveLast_login_devicename:[infoDict objectForKey:ACCOUNT_LAST_LOGIN_DEVICENAME]];
    [AccountHanler saveLast_login_time:[infoDict objectForKey:ACCOUNT_LAST_LOGIN_TIME]];
    [AccountHanler saveMail_address:[infoDict objectForKey:ACCOUNT_MAIL_ADDRESS]];
    [AccountHanler saveMedal:[infoDict objectForKey:ACCOUNT_MEDAL]];
    [AccountHanler saveNickname:[infoDict objectForKey:ACCOUNT_NICKNAME]];
    [AccountHanler savePhoto:[infoDict objectForKey:ACCOUNT_PHOTO]];
    [AccountHanler savePridevice_id:[infoDict objectForKey:ACCOUNT_PRIDEVICE_ID]];
    [AccountHanler saveSchedule_last_modify:[infoDict objectForKey:ACCOUNT_SCHEDULE_LAST_MODIFY]];
    [AccountHanler saveSchedule_version:@"0"];
    [AccountHanler saveSex:[infoDict objectForKey:ACCOUNT_SEX]];
    [AccountHanler saveSignature:[infoDict objectForKey:ACCOUNT_SIGNATURE]];
    [AccountHanler saveTel_number:[infoDict objectForKey:ACCOUNT_TEL_NUMBER]];
    [AccountHanler saveThird_party_account:[infoDict objectForKey:ACCOUNT_THIRD_PARTY_ACCOUNT]];
    [AccountHanler saveThird_party_token:[infoDict objectForKey:ACCOUNT_THIRD_PARTY_TOKEN]];
    [AccountHanler saveToken:[infoDict objectForKey:ACCOUNT_TOKEN]];
    [AccountHanler saveUser_id:[infoDict objectForKey:ACCOUNT_USER_ID]];
    [AccountHanler saveUser_type:[infoDict objectForKey:ACCOUNT_USER_TYPE]];
    [AccountHanler saveIsFirstLogin:YES];
    [AccountHanler saveAccount:[infoDict objectForKey:ACCOUNT_ACCOUNT]];
    [AccountHanler saveIsInvitationLogin:YES];
}


+(void)deleteAccount{
//    [];
    
    [AccountHanler saveToken:nil];
    [AccountHanler saveAppointment_version:@"0"];
    [AccountHanler saveArea:nil];
    [AccountHanler saveBirthday:nil];
    [AccountHanler saveIntegral:nil];
    [AccountHanler saveLast_login_area:nil];
    [AccountHanler saveLast_login_devicename:nil];
    [AccountHanler saveLast_login_time:nil];
    [AccountHanler saveMail_address:nil];
    [AccountHanler saveMedal:nil];
    [AccountHanler saveNickname:nil];
    [AccountHanler savePhoto:nil];
    [AccountHanler savePridevice_id:nil];
    [AccountHanler saveSchedule_last_modify:nil];
    [AccountHanler saveSchedule_version:nil];
    [AccountHanler saveSex:nil];
    [AccountHanler saveTel_number:nil];
    [AccountHanler saveThird_party_account:nil];
    [AccountHanler saveThird_party_token:nil];
    [AccountHanler saveUser_id:nil];
    [AccountHanler saveUser_type:nil];
    [AccountHanler saveSignature:nil];
    [AccountHanler saveAccount:nil];
    [AccountHanler saveNewFriendRequest:0];
    [AccountHanler saveIsFirstLogin:YES];
    [AccountHanler saveIsInvitationLogin:YES];
    
}

@end
