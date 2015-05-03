//
//  AccountHanler.h
//  time
//
//  Created by zuo on 15/4/1.
//  Copyright (c) 2015年 chenyirong007. All rights reserved.
//

#import <Foundation/Foundation.h>
static NSString * const ACCOUNT_LOGIN_TYPE = @"user_id";
static NSString * const ACCOUNT_NICKNAME = @"nickname";
static NSString * const ACCOUNT_TEL_NUMBER = @"tel_number";
static NSString * const ACCOUNT_MAIL_ADDRESS = @"mail_address";
static NSString * const ACCOUNT_SEX = @"sex";
static NSString * const ACCOUNT_BIRTHDAY = @"birthday";
static NSString * const ACCOUNT_PHOTO = @"photo";
static NSString * const ACCOUNT_AREA = @"area";
static NSString * const ACCOUNT_INTEGRAL = @"integral";
static NSString * const ACCOUNT_MEDAL = @"medal";
static NSString * const ACCOUNT_LAST_LOGIN_TIME = @"last_login_time";
static NSString * const ACCOUNT_LAST_LOGIN_DEVICENAME = @"last_login_devicename";
static NSString * const ACCOUNT_LAST_LOGIN_AREA = @"last_login_area";
static NSString * const ACCOUNT_SCHEDULE_VERSION = @"schedule_version";
static NSString * const ACCOUNT_SCHEDULE_LAST_MODIFY = @"schedule_last_modify";
static NSString * const ACCOUNT_THIRD_PARTY_ACCOUNT = @"third_party_account";
static NSString * const ACCOUNT_APPOINTMENT_VERSION = @"appointment_version";
static NSString * const ACCOUNT_THIRD_PARTY_TOKEN = @"third_party_token";
static NSString * const ACCOUNT_TOKEN = @"token";
static NSString * const ACCOUNT_SIGNATURE = @"signature";
static NSString * const ACCOUNT_PRIDEVICE_ID = @"pridevice_id";
static NSString * const ACCOUNT_USER_TYPE =@"user_type";
static NSString * const ACCOUNT_USER_ID =@"user_id";
static NSString * const ACCOUNT_ISFIRST =@"first";
static NSString * const ACCOUNT_ACCOUNT =@"account";
static NSString * const ACCOUNT_ISINVITATIONFIRST =@"firstInvitation";

static NSString * const ACCOUNT_NEW_FRIEND_REQUEST = @"new_friend_request";

@interface AccountHanler : NSObject

@property (nonatomic ,assign)BOOL isInvitationLogin;
+ (BOOL)isInvitationLogin;
+ (void)saveIsInvitationLogin:(BOOL)isInvitationLogin;



@property (nonatomic ,assign)BOOL isFirstLogin;
+ (BOOL)isFirstLogin;
+ (void)saveIsFirstLogin:(BOOL)isFirstLogin;


/**
 *  收到的好友请求数目
 */
@property (nonatomic ,assign)NSInteger newFriendRequest;
+ (NSInteger)newFriendRequest;
+ (void)saveNewFriendRequest:(NSInteger)request;
+ (void)saveNewFriendRequestAddOne;//收到push通知后自动加一



/**
 *  邀约版本号
 */
@property (nonatomic ,copy)NSString *appointment_version;
+ (NSString *)appointment_version;
+ (void)saveAppointment_version:(NSString *)version;
/**
 *  地区
 */
@property (nonatomic ,copy)NSString * area;
+ (NSString *)area;
+ (void)saveArea:(NSString *)area;
/**
 *  生日
 */
@property (nonatomic ,copy)NSString * birthday;
+ (NSString *)birthday;
+ (void)saveBirthday:(NSString *)birthday;

/**
 *  积分
 */
@property (nonatomic ,copy)NSString * integral;
+ (NSString *)integral;
+ (void)saveIntegral:(NSString *)integral;
/**
 *  上次登录地区
 */
@property (nonatomic ,copy)NSString * last_login_area;
+ (NSString *)last_login_area;
+ (void)saveLast_login_area:(NSString *)last_login_area;

/**
 *  上次登录设备名
 */
@property (nonatomic ,copy)NSString * last_login_devicename;
+ (NSString *)last_login_devicename;
+ (void)saveLast_login_devicename:(NSString *)last_login_devicename;
/**
 *  上次登录时间
 yyyy+MM+dd hh:mm:ss
 */
@property (nonatomic ,copy)NSString * last_login_time;
+ (NSString *)last_login_time;
+ (void)saveLast_login_time:(NSString *)last_login_time;
/**
 *  邮箱地址
 */
@property (nonatomic ,copy)NSString * mail_address;
+ (NSString *)mail_address;
+ (void)saveMail_address:(NSString *)mail_address;
/**
 *  勋章
 */
@property (nonatomic ,copy)NSString * medal;
+ (NSString *)medal;
+ (void)saveMedal:(NSString *)medal;

/**
 *  昵称
 */
@property (nonatomic ,copy)NSString * nickname;
+ (NSString *)nickname;
+ (void)saveNickname:(NSString *)nickname;
/**
 *  登录结果
 */
@property (nonatomic ,copy)NSString * result;

/**
 *  头像
 */
@property (nonatomic ,copy)NSString * photo;
+ (NSString *)photo;
+ (void)savePhoto:(NSString *)photo;
/**
 *  上次登录设备id
 */
@property (nonatomic ,copy)NSString * pridevice_id;
+ (NSString *)pridevice_id;
+ (void)savePridevice_id:(NSString *)pridevice_id;
/**
 *  日程数据最后修改时间
 */
@property (nonatomic ,copy)NSString * schedule_last_modify;
+ (NSString *)schedule_last_modify;
+ (void)saveSchedule_last_modify:(NSString *)schedule_last_modify;
/**
 *  日程数据版本号
 */
@property (nonatomic ,copy)NSString * schedule_version;
+ (NSString *)schedule_version;
+ (void)saveSchedule_version:(NSString *)schedule_version;
/**
 *  性别
 */
@property (nonatomic ,copy)NSString * sex;
+ (NSString *)sex;
+ (void)saveSex:(NSString *)sex;
/**
 *  手机号
 */
@property (nonatomic ,copy)NSString * tel_number;
+ (NSString *)tel_number;
+ (void)saveTel_number:(NSString *)tel_number;
/**
 *  第三方登入账号
 */
@property (nonatomic ,copy)NSString * third_party_account;
+ (NSString *)third_party_account;
+ (void)saveThird_party_account:(NSString *)third_party_account;
/**
 *  第三方登入token
 */
@property (nonatomic ,copy)NSString * third_party_token;
+ (NSString *)third_party_token;
+ (void)saveThird_party_token:(NSString *)third_party_token;
/**
 *  登陆token
 */
@property (nonatomic ,copy)NSString * token;
+ (NSString *)token;
+ (void)saveToken:(NSString *)token;
/**
 *  用户id
 */
@property (nonatomic ,copy)NSString * user_id;
+ (NSString *)user_id;
+ (void)saveUser_id:(NSString *)user_id;
/**
 *  用户类型
 */
@property (nonatomic ,copy)NSString * user_type;
+ (NSString *)user_type;
+ (void)saveUser_type:(NSString *)user_type;
/**
 *  个性签名
 */
@property (nonatomic ,copy)NSString * signature;
+ (NSString *)signature;
+ (void)saveSignature:(NSString *)signature;
/**
 *  电话
 */
@property (nonatomic ,copy)NSString * account;
+ (NSString *)account;
+ (void)saveAccount:(NSString *)account;

+(void)deleteAccount;
+(void)saveAccountInfo:(NSDictionary *)infoDict;
@end
