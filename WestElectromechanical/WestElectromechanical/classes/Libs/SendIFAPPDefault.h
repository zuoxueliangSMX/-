//
//  SendIFAPPDefault.h
//  LaoShan
//
//  Created by sendInfo on 2014-01-09.
//  Copyright (c) 2014年 dongMac. All rights reserved.
//

#import <Foundation/Foundation.h>

#define IS_FIRSTLANUCH @"is_firstlanuch"
#define SYNC_DATE @"syncDate"
#define CURRENT_USER_ID @"current_user_id"
#define LOGIN_STATE @"login_state"
#define LOGIN_NAME @"logname"
#define LAT @"LATI"
#define LONGT @"LONGTI"
#define ACCOUNTID  @"accountID"
#define KMsgBadge  @"kmsgbadge"
#define YES_SYMBOLE @"yessymbole"
#define IDNUN   @"idnum"
#define PHONE @"phone"
#define ARR @"arr"
#define NECK_NAME  @"neckname"
#define APP_VERSION @"appversion"



#define ADDRESS @"address"
#define RECIVE_NAME @"recive_name"
#define RECIVE_PHONE @"recive_phone"

#define MIMA @"mima"



@interface SendIFAPPDefault : NSObject


+ (SendIFAPPDefault *)shareAppDefault;

//是否是第一次启动
- (void)setIsFirstLanuch:(NSString *)isFirst;
- (NSString *)isFirstLanuch;
//同步时间
- (void)setSyncDate:(NSString *)date;
- (NSString *)syncDate;
//当前用户id
- (void)setCurrentUserID:(NSString *)userNum;
- (NSString *)currentUserID;
//登录状态
- (void)setLoginState:(NSString *)state;

- (NSString *)loginState;
//登录名
- (void)setLoginName:(NSString *)name;
- (NSString *)loginName;


/**
 *  接受人手机号
 */
-(NSString *)recivePhone;
-(void)setRecivePhone:(NSString *)phone;


/**
 *  地址
 */
-(NSString *)addres;
-(void)setaddres:(NSString *)addres;


/**
 *  收货人姓名
 */
-(NSString *)reciveName;
-(void)setreciveName:(NSString *)reciveName;



//手机号
- (void)setPhone:(NSString *)phone;
- (NSString *)phone;

//
- (void)setCurrentLocatLat:(NSString *)lat;
- (NSString *)currentLocatLat;
- (void)setCurrentLocatLongt:(NSString *)longt;
- (NSString *)CurrentLocatLongt;



-(void)setIconNUM:(NSString*)num;
- (NSString *)IconNUM;

-(void)setYesSymbole:(BOOL)num;
- (BOOL )YesSymbole;


-(void)deleteMessage;
-(void)setArr:(NSArray*)arr;
-(NSArray*)arr;





#pragma mark -身份证号码
- (void)setIDnum:(NSString *)IDnum;
- (NSString *)IDnum;



#pragma mark -密码
- (void)setMima:(NSString *)mima;
- (NSString *)mima;



//用户名字

- (void)setNeckName:(NSString *)name;
- (NSString *)NeckName;

//APP版本号
-(void)setAppVersion:(NSString*)version;
- (NSString*)AppVersion;

@end
