//
//  AlertUtil.m
//  time
//
//  Created by liwei on 14/12/31.
//  Copyright (c) 2014年 chenyirong007. All rights reserved.
//

#import "AlertUtil.h"
#import "MBProgressHUD.h"
#import <QuartzCore/QuartzCore.h>
#import <SystemConfiguration/SystemConfiguration.h>
#import <netdb.h>

static MBProgressHUD *hudAlertView;

@implementation AlertUtil


+(void) showAlertWithText:(NSString *)text afterDelay:(NSTimeInterval) delay{
    [self performSelector:@selector(showAlertWithText:) withObject:text afterDelay:delay];
}

+ (void)showAlertWithText:(NSString *)text
{
    UIWindow *window = [UIApplication sharedApplication].keyWindow;
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:window animated:YES];
    
    hud.mode = MBProgressHUDModeText;
    hud.labelText = @"";
    hud.detailsLabelText = text;
    hud.detailsLabelFont = [UIFont systemFontOfSize:14];
    hud.margin = 10.f;
    hud.yOffset = -20;
    hud.removeFromSuperViewOnHide = YES;
    
    [hud hide:YES afterDelay:1.5];
}

+ (void)showCheckmarkAlert:(NSString *)text FailOrNot:(BOOL)success
{
    NSString *imgFileName = @"ic_checkmark_success";
    if (!success) {
        imgFileName = @"ic_checkmark_failure";
    }
    UIWindow *window = [UIApplication sharedApplication].keyWindow;
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:window animated:YES];
    
    hud.mode = MBProgressHUDModeCustomView;
    UIImageView *customView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:imgFileName]];
    [customView setBounds:CGRectMake(0, 0, 37, 37)];
    hud.customView = customView;
    
    hud.labelText = text;
    hud.margin = 10.f;
    hud.removeFromSuperViewOnHide = YES;
    
    [hud hide:YES afterDelay:1.5];
}


+ (void)showWaitingAlertWithText:(NSString *)text
{
    UIWindow *window = [UIApplication sharedApplication].keyWindow;
    hudAlertView = [MBProgressHUD showHUDAddedTo:window animated:YES];
    hudAlertView.labelText = ((text && text.length > 0) ? text : @"加载中...");
    [window addSubview:hudAlertView];
}


+ (void)performWaitingAlertDismiss
{
    [hudAlertView removeFromSuperview];
    hudAlertView = nil;
}


+ (BOOL)connectedToNetwork
{
    // Create zero addy
    struct sockaddr_in zeroAddress;
    bzero(&zeroAddress, sizeof(zeroAddress));
    zeroAddress.sin_len = sizeof(zeroAddress);
    zeroAddress.sin_family = AF_INET;
    
    // Recover reachability flags
    SCNetworkReachabilityRef defaultRouteReachability = SCNetworkReachabilityCreateWithAddress(NULL, (struct sockaddr *)&zeroAddress);
    SCNetworkReachabilityFlags flags;
    
    BOOL didRetrieveFlags = SCNetworkReachabilityGetFlags(defaultRouteReachability, &flags);
    CFRelease(defaultRouteReachability);
    
    if (!didRetrieveFlags)
    {
        printf("Error. Could not recover network reachability flags\n");
        return NO;
    }
    
    BOOL isReachable = ((flags & kSCNetworkFlagsReachable) != 0);
    BOOL needsConnection = ((flags & kSCNetworkFlagsConnectionRequired) != 0);
    return (isReachable && !needsConnection) ? YES : NO;
}

@end
