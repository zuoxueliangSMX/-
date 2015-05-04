//
//  SendIFAPPDefault.m
//  LaoShan
//
//  Created by sendInfo on 2014-01-09.
//  Copyright (c) 2014年 dongMac. All rights reserved.
//

#import "SendIFAPPDefault.h"

@interface SendIFAPPDefault()
@property (nonatomic,strong)NSUserDefaults *defaults;
@end


@implementation SendIFAPPDefault
@synthesize defaults = _defaults;

+ (SendIFAPPDefault *)shareAppDefault{
    static id _sharedObj = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _sharedObj = [[SendIFAPPDefault alloc] initDefaults];
    });
    return _sharedObj;
}

- (id)initDefaults{
    
    self = [super init];
    if (self) {
        _defaults = [NSUserDefaults standardUserDefaults];
        [self registerSettings];
    }
    return self;
    
    
}
//程序启动时导入配置文件

- (void)registerSettings{
    
    NSString *settingsPath = [[NSBundle mainBundle] pathForResource:@"SendIFAPPDefault" ofType:@"plist"];
    NSDictionary *dic = [NSDictionary dictionaryWithContentsOfFile:settingsPath];
    [self.defaults registerDefaults:dic];
    
}
#pragma mark -
- (void)setIsFirstLanuch:(NSString *)isFirst{
    
    [self.defaults setObject:isFirst forKey:IS_FIRSTLANUCH];
    [self.defaults synchronize];

}
- (NSString *)isFirstLanuch{
    
    return [self.defaults stringForKey:IS_FIRSTLANUCH];

}
#pragma mark -
- (void)setSyncDate:(NSString *)date{
    [self.defaults setObject:date forKey:SYNC_DATE];
    [self.defaults synchronize];
}
- (NSString *)syncDate{
    
    return [self.defaults stringForKey:SYNC_DATE];

}
#pragma mark -
- (void)setCurrentUserID:(NSString *)userNum{
[self.defaults setObject:userNum forKey:CURRENT_USER_ID];
    [self.defaults synchronize];

}
- (NSString *)currentUserID{
    
    return [self.defaults stringForKey:CURRENT_USER_ID];

}
#pragma mark -
//登录状态
- (void)setLoginState:(NSString *)state{
    
    [self.defaults setObject:state forKey:LOGIN_STATE];
    [self.defaults synchronize];

}
- (NSString *)loginState{
    return [self.defaults stringForKey:LOGIN_STATE];
}
#pragma mark -
- (void)setLoginName:(NSString *)name{
    
    [self.defaults setObject:name forKey:LOGIN_NAME];
    [self.defaults synchronize];

}
- (NSString *)loginName{
    return [self.defaults stringForKey:LOGIN_NAME];

}

#pragma mark -手机号
- (void)setPhone:(NSString *)phone
{
    [self.defaults setObject:phone forKey:PHONE];
    [self.defaults synchronize];


}
- (NSString *)phone
{

    return [self.defaults stringForKey:PHONE];


}


#pragma mark -身份证号码
- (void)setIDnum:(NSString *)IDnum
{
    [self.defaults setObject:IDnum forKey:IDNUN];
    [self.defaults synchronize];
    
    
}
- (NSString *)IDnum
{
    
    return [self.defaults stringForKey:IDNUN];
    
    
}




- (void)setCurrentLocatLat:(NSString *)lat{
    [self.defaults setObject:lat forKey:LAT];
    [self.defaults synchronize];
}
- (NSString *)currentLocatLat{
    return [self.defaults stringForKey:LAT];
}
- (void)setCurrentLocatLongt:(NSString *)longt{
    [self.defaults setObject:longt forKey:LONGT];
    [self.defaults synchronize];
}
- (NSString *)CurrentLocatLongt{
    return [self.defaults stringForKey:LONGT];
}
-(void)setYesSymbole:(BOOL)num
{
    
    [self.defaults setBool:num forKey:YES_SYMBOLE];
    
    [self.defaults synchronize];
    
}
- (BOOL)YesSymbole{
    return [self.defaults boolForKey:YES_SYMBOLE];
    
}
-(void)setArr:(NSArray*)arr
{
    [self.defaults setObject:arr forKey:ARR];
    
    [self.defaults synchronize];

}
-(NSArray*)arr
{
    return [self.defaults arrayForKey:ARR];

}
-(void)deleteMessage
{
    
[self.defaults  removeObjectForKey:ARR];

}


//密码
- (void)setMima:(NSString *)mima
{

    [self.defaults setObject:mima forKey:MIMA];
    [self.defaults synchronize];



}
- (NSString *)mima
{

 return [self.defaults stringForKey:MIMA];
}

//用户名字

- (void)setNeckName:(NSString *)name{
    
    [self.defaults setObject:name forKey:NECK_NAME];
    [self.defaults synchronize];
    
}
- (NSString *)NeckName{
    return [self.defaults stringForKey:NECK_NAME];
    
}


-(void)setAppVersion:(NSString*)version
{
    
    [self.defaults setObject:version forKey:APP_VERSION];
    
    [self.defaults synchronize];
    
}
- (NSString*)AppVersion{
    return [self.defaults stringForKey:APP_VERSION];
    
}



@end
