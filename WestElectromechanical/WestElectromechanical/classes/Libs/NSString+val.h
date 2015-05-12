//
//
//  WTInternship
//
//  Created by gh on 13-7-9.
//  Copyright (c) 2013年 Wanting3. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString(val)
//手机号是否有效
+ (BOOL)phoneValidate:(NSString *)phoneNum;
//密码是否有效
+ (BOOL)passwordValidate:(NSString *)password;
//学号是否有效
+ (BOOL)studentNumberValidate:(NSString *)number;
//判断是否为空
+ (BOOL)stringLeng:(NSString *)str;
//判断姓名的输入正确性
+ (BOOL)userNameValidate:(NSString *)name;
//身份证号
+ (BOOL) validateIdentityCard: (NSString *)identityCard;

+ (NSString *)stringFromHtml:(NSString*)htm;

//判断邮箱
+ (BOOL)isValidateEmail:(NSString *)Email;
+ (NSString *)filterMark:(NSString *)html;
//将date时间戳转变成时间字符串
//@paaram   date            用于转换的时间
//@param    formatString    时间格式(yyyy-MM-dd HH:mm:ss)
//@return   NSString        返回字字符如（2012－8－8 11:11:11）
+ (NSString *)getDateStringWithDate:(NSDate *)date
                         DateFormat:(NSString *)formatString;

@end
