//
//  Common.h
//  WestElectromechanical
//
//  Created by zuo on 15/4/26.
//  Copyright (c) 2015年 zuo. All rights reserved.
//

#ifndef WestElectromechanical_Common_h
#define WestElectromechanical_Common_h


#endif
#import "AlertUtil.h"
#define kInvitationStateValid @"01" //有效
#define kInvitationStateRepeal @"02" //撤销
#define kInvitationMyStatusNotHandler @"01" //未进行操作
#define kInvitationMyStatusAgree @"02" //同意
#define kInvitationMyStatusIgnore @"03" //忽略
#define kInvitationMyStatusRefuse @"04" //拒绝
#define kInvitationPraiseRefuse @"01"//点赞
#define kInvitationPraiseAgree @"02" //未点赞
#define kPersonCenterSexMale @"01"//男
#define kPersonCenterSexFemale @"02" //女
#define kPhoneLinkPeopleStateFriend @"01"// 01:好友
#define kPhoneLinkPeopleStateUser @"02"// 02:注册用户
#define kPhoneLinkPeopleStateNotUser @"03"// 03:未注册用户


#define kHomeCityKey @"homeCityKey"


#import "UIColor+FlatUI.h"
#import "UIView+Extension.h"
#import "WENavitationController.h"
/*DEFINE_SINGLETON  Start
 */
#define keySqlTraceExecution YES //设定是否显示fmdb的sql语句执行过程
#define SERVER_PROTOCOL @"http://"
#define SERVER_PORT @"/ehsy/interface"
#define SERVER_HOST @"114.215.135.236" //开发版本
#define kColor(r,g,b) [UIColor colorWithRed:r green:g blue:b alpha:1]
#define kColorAlpha(r,g,b,a) [UIColor colorWithRed:r green:g blue:b alpha:a]
#define kHightLightedColor kColor(30.0/255,121.0/255,71.0/255)



#define CompareStringCaseInsenstive(thing1, thing2) [thing1 compare:thing2 options:NSCaseInsensitiveSearch|NSNumericSearch] == NSOrderedSame

#define DEFINE_SINGLETON_FOR_INTERFACE(className) \
\
+ (className *)shared##className;


#define DEFINE_SINGLETON_FOR_IMPLEMENTATION(className) \
\
+ (className *)shared##className { \
static className *shared##className = nil; \
static dispatch_once_t onceToken; \
dispatch_once(&onceToken, ^{ \
shared##className = [[self alloc] init]; \
}); \
return shared##className; \
}
/*DEFINE_SINGLETON  End
 */
#define font(measure) [UIFont fontWithName:@"HeiTi SC" size:measure]
#define kAnimationDuration 0.3f
#define IOS7_OR_LATER  [[UIDevice currentDevice].systemVersion floatValue]>=7.0f
#define SCREEN_WIDTH         [UIScreen mainScreen].bounds.size.width
#define SCREEN_HEIGHT         [UIScreen mainScreen].bounds.size.height
#define SCREEN_BOUNDS          [UIScreen mainScreen].bounds
// 是否为4inch
#define Iphone5Inch ([UIScreen mainScreen].bounds.size.height == 568.0)
#define Iphone6Inch ([UIScreen mainScreen].bounds.size.height == 667.0)
#define Iphone6PlusInch  ([UIScreen mainScreen].bounds.size.height > 759.0)

//#ifdef DEBUG
//#define DLog( s, ... ) NSLog( @"<%p %@:(%d)> %@", self, [[NSString stringWithUTF8String:__FILE__] lastPathComponent], __LINE__, [NSString stringWithFormat:(s), ##__VA_ARGS__] )
//#else
//#define DLog( s, ... )
//#endif
