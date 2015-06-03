//
//  SoftWareShareVC.m
//  WestElectromechanical
//
//  Created by 夏亚峰 on 15/6/1.
//  Copyright (c) 2015年 zuo. All rights reserved.
//

#import "SoftWareShareVC.h"
#import "GCPlaceholderTextView.h"
#import "RDVTabBarController.h"
#import <ShareSDK/ShareSDK.h>
#import "WXApi.h"
#import "NSString+Extension.h"
@interface SoftWareShareVC ()<UITextViewDelegate>
{
    GCPlaceholderTextView *tv;
}
@end

@implementation SoftWareShareVC
#pragma mark -
#pragma mark - pop和push控制器时的操作
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [[self rdv_tabBarController] setTabBarHidden:YES animated:YES];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    [[self rdv_tabBarController] setTabBarHidden:NO animated:YES];
}

- (void)shareContentWeChatText
{
    //只需要在响应分享按钮的方法中添加以下代码即可
    UIImage *img = [UIImage imageNamed:@"launcher_Icon"];
    NSData *data =UIImageJPEGRepresentation(img, 1.0);
    
    //构造分享内容
    
    id<ISSContent> publishContent = [ShareSDK content:tv.text
                                       defaultContent:@""
                                                image:[ShareSDK imageWithData:data fileName:@"icon" mimeType:@"png"]
                                                title:@"推荐应用"
                                                  url:@"http://www.ehsy.com"
                                          description:@""
                                            mediaType:SSPublishContentMediaTypeNews];
    
    
    //创建弹出菜单容器
    id<ISSContainer> container = [ShareSDK container];
    //    [container setIPadContainerWithView:sender arrowDirect:UIPopoverArrowDirectionUp];
    
    //自定义标题栏相关委托
    id<ISSAuthOptions> authOptions = [ShareSDK authOptionsWithAutoAuth:YES
                                                         allowCallback:NO
                                                         authViewStyle:SSAuthViewStyleFullScreenPopup
                                                          viewDelegate:nil
                                               authManagerViewDelegate:nil];
    [ShareSDK showShareActionSheet:container
                         shareList:nil
                           content:publishContent
                     statusBarTips:YES
                       authOptions:authOptions
                      shareOptions:nil
                            result:^(ShareType type, SSResponseState state, id<ISSPlatformShareInfo> statusInfo, id<ICMErrorInfo> error, BOOL end) {
                                
                                if (state == SSResponseStateSuccess)
                                {
                                    NSLog(NSLocalizedString(@"TEXT_ShARE_SUC", @"分享成功"));
                                }
                                else if (state == SSResponseStateFail)
                                {
                                    NSLog(NSLocalizedString(@"TEXT_ShARE_FAI", @"分享失败,错误码:%d,错误描述:%@"), [error errorCode], [error errorDescription]);
                                }
                            }];
    
}





- (void)shareContentWeChatLocalImg
{
    //只需要在响应分享按钮的方法中添加以下代码即可
    UIImage *img = [UIImage imageNamed:@"launcher_Icon"];
    NSData *data =UIImageJPEGRepresentation(img, 1.0);
    
    //构造分享内容
    
    id<ISSContent> publishContent = [ShareSDK content:@"西域电商是一款功能强大的app"
                                       defaultContent:@""
                                                image:[ShareSDK imageWithData:data fileName:@"icon" mimeType:@"png"]
                                                title:@"推荐应用"
                                                  url:@"http://www.ehsy.com"
                                          description:@""
                                            mediaType:SSPublishContentMediaTypeNews];
    
    
    //创建弹出菜单容器
    id<ISSContainer> container = [ShareSDK container];
    //    [container setIPadContainerWithView:sender arrowDirect:UIPopoverArrowDirectionUp];
    
    //自定义标题栏相关委托
    id<ISSAuthOptions> authOptions = [ShareSDK authOptionsWithAutoAuth:YES
                                                         allowCallback:NO
                                                         authViewStyle:SSAuthViewStyleFullScreenPopup
                                                          viewDelegate:nil
                                               authManagerViewDelegate:nil];
    [ShareSDK showShareActionSheet:container
                         shareList:nil
                           content:publishContent
                     statusBarTips:YES
                       authOptions:authOptions
                      shareOptions:nil
                            result:^(ShareType type, SSResponseState state, id<ISSPlatformShareInfo> statusInfo, id<ICMErrorInfo> error, BOOL end) {
                                
                                if (state == SSResponseStateSuccess)
                                {
                                    NSLog(NSLocalizedString(@"TEXT_ShARE_SUC", @"分享成功"));
                                }
                                else if (state == SSResponseStateFail)
                                {
                                    NSLog(NSLocalizedString(@"TEXT_ShARE_FAI", @"分享失败,错误码:%d,错误描述:%@"), [error errorCode], [error errorDescription]);
                                }
                            }];
    
}




- (void)viewDidLoad {
    [super viewDidLoad];
    VIEW_BACKGROUND
    
    
   tv=[[GCPlaceholderTextView alloc] initWithFrame:CGRectMake(10,64+10,SCREEN_WIDTH-20, 150)];
    tv.contentInset = UIEdgeInsetsMake(-70, 0, 0, 0);
    tv.delegate = self;
    tv.backgroundColor = [UIColor whiteColor];
    tv.placeholder=@"西域机电分享";
    tv.font= [UIFont systemFontOfSize:13];
    tv.layer.borderColor = [UIColor lightGrayColor].CGColor;
    tv.layer.cornerRadius =4.0;
  
    
    tv.layer.borderWidth =0.8;
    
    
    [self.view addSubview:tv];
    
   
//    UIImageView *imgv1 = [[UIImageView alloc] init];
//    imgv1.frame = CGRectMake(0, CGRectGetMaxY(tv.frame)+20,(VIEW_WIDETH-120)/2, 1);
//    imgv1.backgroundColor = [UIColor appLineColor];
//    [self.view addSubview:imgv1];
    
//    UILabel *sharela = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(imgv1.frame)+20,CGRectGetMaxY(tv.frame) , 80, 40)];
//    sharela.text =@"分享到";
//    sharela.textAlignment =NSTextAlignmentCenter;
//    sharela.textColor =[UIColor darkGrayColor];
//    [self.view  addSubview:sharela];
//    
//    
//    
//    
//    UIImageView *imgv2 = [[UIImageView alloc] init];
//    imgv2.frame = CGRectMake(VIEW_WIDETH-(VIEW_WIDETH-120)/2, CGRectGetMaxY(tv.frame)+20,(VIEW_WIDETH-120)/2, 1);
//    imgv2.backgroundColor = [UIColor appLineColor];
//    [self.view addSubview:imgv2];

    
    
    
    
    
    
    UIButton *shareBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [shareBtn setFrame:CGRectMake(15, CGRectGetMaxY(tv.frame)+20, SCREEN_WIDTH-30, 40)];
    [shareBtn setTitle:@"分享" forState:UIControlStateNormal];
    [shareBtn setBackgroundColor:[UIColor redColor]];
    [shareBtn addTarget:self action:@selector(shareBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [shareBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [self.view addSubview:shareBtn];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [self.view endEditing:YES];
}
- (void)textViewDidBeginEditing:(UITextView *)textView {
    
}

- (void)textViewDidEndEditing:(UITextView *)textView{
    
    [tv resignFirstResponder];
    
}

-(void)shareBtnClick
{
    [tv resignFirstResponder];

    if ([[NSString deleteSpacing:tv.text] length]>0) {
        
        [self shareContentWeChatText];
    }else{
        [self shareContentWeChatLocalImg];
    }
}


-(BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString*)text
{
    if ([text isEqualToString:@"\n"]) {
        [textView resignFirstResponder];
        return NO;
    }
    return YES;
}

@end
