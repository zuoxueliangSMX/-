//
//  AlertUtil.h
//  time
//
//  Created by liwei on 14/12/31.
//  Copyright (c) 2014年 chenyirong007. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface AlertUtil : NSObject


+(void) showAlertWithText:(NSString *)text afterDelay:(NSTimeInterval) delay;
+ (void)showAlertWithText:(NSString *)text;

+ (void)showCheckmarkAlert:(NSString *)text FailOrNot:(BOOL)success;

+ (void)showWaitingAlertWithText:(NSString *)text;

+ (void)performWaitingAlertDismiss;

+ (BOOL)connectedToNetwork;

@end
