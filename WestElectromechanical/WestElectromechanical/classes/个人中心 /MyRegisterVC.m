//
//  MyRegisterVC.m
//  HgsNew
//
//  Created by sendInfo on 2015-01-22.
//  Copyright (c) 2015年 sendInfo. All rights reserved.
//

#import "MyRegisterVC.h"
//#import "HttpManager.h"
//#import "UIView+Toast.h"
#import "SendIFAppDefault.h"
#import "WEHTTPHandler.h"
#import "NSString+val.h"
#import "RDVTabBarController.h"

@interface MyRegisterVC ()<UITextFieldDelegate>{

    
    UITextField *LogNmTextF,*pwdNmTextF,*sureTf,*valCodeTf,*userNameTf,*emailTf;
    UILabel *_numLab;
    NSString *checkCode,*secsLeft;
    
    BOOL  isClick ;

}

@end

@implementation MyRegisterVC

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



- (void)back{

    POP
}
- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title =@"注册";
    // Do any additional setup after loading the view.
   
     self.view.backgroundColor = SET_COLOR(234.0, 234.0, 234.0);
    UIView * squareView = [[UIView alloc]initWithFrame:CGRectMake(15, 80, SCREEN_WIDTH-30, 265)];
     squareView.backgroundColor = [UIColor whiteColor];
    squareView.layer.cornerRadius =4;
    [self.view addSubview:squareView];
    
    BACK_POP
    //用户名
    
    userNameTf = [[UITextField alloc] initWithFrame:CGRectMake(15, 5, SCREEN_WIDTH-30, 40)];
    [userNameTf setBorderStyle:UITextBorderStyleNone];
    userNameTf.textColor = [UIColor blackColor];
    [userNameTf setPlaceholder:@"用户名（4-20个字符）"];
    [userNameTf setKeyboardType:UIKeyboardTypeDefault];
    [userNameTf setClearButtonMode:UITextFieldViewModeWhileEditing];
    //    [LogNmTextF setTextAlignment:NSTextAlignmentCenter];
    [userNameTf setContentVerticalAlignment:UIControlContentVerticalAlignmentCenter];
    UIButton *but0 = [UIButton buttonWithType:UIButtonTypeCustom];
    [but0 setImage:[UIImage imageNamed:@"Person_user"] forState:UIControlStateNormal];
    [but0 setFrame:CGRectMake(0, 0, 50, 40)];
    [but0 setUserInteractionEnabled:NO];
    
    userNameTf.leftViewMode = UITextFieldViewModeAlways;
    [userNameTf setLeftView:but0];
    [userNameTf setDelegate:self];
    [squareView addSubview:userNameTf];
    
    UIImageView *imgv0 = [[UIImageView alloc] init];
    imgv0.backgroundColor = [UIColor appLineColor];
    
    imgv0.frame = CGRectMake(10, CGRectGetMaxY(userNameTf.frame)+1, squareView.frame.size.width-20, 1);
    [squareView addSubview:imgv0];

    
    
    
    
    // 手机
    LogNmTextF = [[UITextField alloc] initWithFrame:CGRectMake(15, CGRectGetMaxY(userNameTf.frame), SCREEN_WIDTH-30, 40)];
    [LogNmTextF setBorderStyle:UITextBorderStyleNone];
    LogNmTextF.textColor = [UIColor blackColor];
    [LogNmTextF setPlaceholder:@"请输入你的手机号"];
    [LogNmTextF setKeyboardType:UIKeyboardTypeDefault];
    [LogNmTextF setClearButtonMode:UITextFieldViewModeWhileEditing];
    //    [LogNmTextF setTextAlignment:NSTextAlignmentCenter];
    [LogNmTextF setContentVerticalAlignment:UIControlContentVerticalAlignmentCenter];
    UIButton *but1 = [UIButton buttonWithType:UIButtonTypeCustom];
    [but1 setImage:[UIImage imageNamed:@"person_phone"] forState:UIControlStateNormal];
    [but1 setBounds:CGRectMake(0, 0, 50, 40)];
    [but1 setUserInteractionEnabled:NO];
    
    LogNmTextF.leftViewMode = UITextFieldViewModeAlways;
    [LogNmTextF setLeftView:but1];
    [LogNmTextF setDelegate:self];
    [squareView addSubview:LogNmTextF];
    
    UIImageView *imgv1 = [[UIImageView alloc] init];
    
    
    imgv1.backgroundColor = [UIColor appLineColor];
    imgv1.frame = CGRectMake(10, CGRectGetMaxY(LogNmTextF.frame)+1, squareView.frame.size.width-20, 1);
    [squareView addSubview:imgv1];
    
    
    
    
    // 邮箱
    emailTf = [[UITextField alloc] initWithFrame:CGRectMake(15, CGRectGetMaxY(LogNmTextF.frame), SCREEN_WIDTH-30, 40)];
    [emailTf setBorderStyle:UITextBorderStyleNone];
    emailTf.textColor = [UIColor blackColor];
    [emailTf setPlaceholder:@"邮箱（输入您的常用邮箱）"];
    [emailTf setKeyboardType:UIKeyboardTypeDefault];
    [emailTf setClearButtonMode:UITextFieldViewModeWhileEditing];
    //    [LogNmTextF setTextAlignment:NSTextAlignmentCenter];
    [emailTf setContentVerticalAlignment:UIControlContentVerticalAlignmentCenter];
    UIButton *but2 = [UIButton buttonWithType:UIButtonTypeCustom];
    [but2 setImage:[UIImage imageNamed:@"Person_e"] forState:UIControlStateNormal];
    [but2 setBounds:CGRectMake(0, 0, 50, 40)];
    [but2 setUserInteractionEnabled:NO];
    
    emailTf.leftViewMode = UITextFieldViewModeAlways;
    [emailTf setLeftView:but2];
    [emailTf setDelegate:self];
    [squareView addSubview:emailTf];
    
    UIImageView *imgv2 = [[UIImageView alloc] init];
    imgv2.frame = CGRectMake(10, CGRectGetMaxY(emailTf.frame)+1, squareView.frame.size.width-20, 1);
    imgv2.backgroundColor = [UIColor appLineColor];
    [squareView addSubview:imgv2];
    
    
    
    
    // 密码
    pwdNmTextF = [[UITextField alloc] initWithFrame:CGRectMake(15, CGRectGetMaxY(emailTf.frame), SCREEN_WIDTH-30, 40)];
    [pwdNmTextF setBorderStyle:UITextBorderStyleNone];
    [pwdNmTextF setSecureTextEntry:YES]; //设置成密码格式
    pwdNmTextF.textColor = [UIColor blackColor];
    [pwdNmTextF setClearButtonMode:UITextFieldViewModeWhileEditing];
    [pwdNmTextF setContentVerticalAlignment:UIControlContentVerticalAlignmentCenter];
    UIButton *pwdBut = [UIButton buttonWithType:UIButtonTypeCustom];
    [pwdBut setImage:[UIImage imageNamed:@"Person_lock"] forState:UIControlStateNormal];
    [pwdBut setBounds:CGRectMake(0, 0, 50, 40)];
    [pwdBut setUserInteractionEnabled:NO];
    pwdNmTextF.leftViewMode = UITextFieldViewModeAlways;
    [pwdNmTextF setLeftView:pwdBut];
    [pwdNmTextF setDelegate:self];
    pwdNmTextF.returnKeyType=UIReturnKeyGo;//返回键的类型
    [pwdNmTextF setPlaceholder:@"输入你的密码（6—16字符"]; //默认显示的字
    //    [pwdNmTextF setTextAlignment:NSTextAlignmentCenter];
    [squareView addSubview:pwdNmTextF];
    
    UIImageView *imgv3 = [[UIImageView alloc] init];
    imgv3.frame = CGRectMake(10, CGRectGetMaxY(pwdNmTextF.frame)+1, squareView.frame.size.width-20, 1);
    imgv3.backgroundColor = [UIColor appLineColor];
    [squareView addSubview:imgv3];

    
    // sure密码
    sureTf = [[UITextField alloc] initWithFrame:CGRectMake(15, CGRectGetMaxY(pwdNmTextF.frame), SCREEN_WIDTH-30, 40)];
    [sureTf setBorderStyle:UITextBorderStyleNone];
    [sureTf setSecureTextEntry:YES]; //设置成密码格式
    sureTf.textColor = [UIColor blackColor];
    [sureTf setClearButtonMode:UITextFieldViewModeWhileEditing];
    [sureTf setContentVerticalAlignment:UIControlContentVerticalAlignmentCenter];
    UIButton *surepwdBut = [UIButton buttonWithType:UIButtonTypeCustom];
    [surepwdBut setImage:[UIImage imageNamed:@"Person_lock"] forState:UIControlStateNormal];
    [surepwdBut setBounds:CGRectMake(0, 0, 50, 40)];
    [surepwdBut setUserInteractionEnabled:NO];
    sureTf.leftViewMode = UITextFieldViewModeAlways;
    [sureTf setLeftView:surepwdBut];
    [sureTf setDelegate:self];
    sureTf.returnKeyType=UIReturnKeyGo;//返回键的类型
    [sureTf setPlaceholder:@"请再次输入密码"]; //默认显示的字
    //    [pwdNmTextF setTextAlignment:NSTextAlignmentCenter];
    [squareView addSubview:sureTf];
    
    
    UIImageView *imgv4 = [[UIImageView alloc] init];
    imgv4.frame = CGRectMake(10, CGRectGetMaxY(sureTf.frame)+1, squareView.frame.size.width-20, 1);
    imgv4.backgroundColor = [UIColor appLineColor];
    [squareView addSubview:imgv4];
    

    
    // yan密码
    valCodeTf = [[UITextField alloc] initWithFrame:CGRectMake(15, CGRectGetMaxY(sureTf.frame), 220, 40)];
    [valCodeTf setBorderStyle:UITextBorderStyleNone];
    [valCodeTf setSecureTextEntry:YES]; //设置成密码格式
    valCodeTf.textColor = [UIColor blackColor];
    [valCodeTf setClearButtonMode:UITextFieldViewModeWhileEditing];
    [valCodeTf setContentVerticalAlignment:UIControlContentVerticalAlignmentCenter];
    UIButton *codeBut = [UIButton buttonWithType:UIButtonTypeCustom];
    [codeBut setImage:[UIImage imageNamed:@"Person_email"] forState:UIControlStateNormal];
    [codeBut setBounds:CGRectMake(0, 0, 50, 40)];
    [codeBut setUserInteractionEnabled:NO];
    valCodeTf.leftViewMode = UITextFieldViewModeAlways;
    [valCodeTf setLeftView:codeBut];
    [valCodeTf setDelegate:self];
    valCodeTf.returnKeyType=UIReturnKeyGo;//返回键的类型
    [valCodeTf setPlaceholder:@"验证码"]; //默认显示的字
    //    [pwdNmTextF setTextAlignment:NSTextAlignmentCenter];
    [squareView addSubview:valCodeTf];
    
    UIButton *getCodeBtn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [getCodeBtn setTitle:@"获取验证码" forState:UIControlStateNormal];
    getCodeBtn.tag = 10081;
    [getCodeBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [getCodeBtn setBackgroundColor:[UIColor orangeColor]];
    [getCodeBtn setFrame:CGRectMake(CGRectGetMaxX(valCodeTf.frame)-60, CGRectGetMaxY(valCodeTf.frame)-30, 80, 25)];
    [getCodeBtn addTarget:self action:@selector(getCodeClick) forControlEvents:UIControlEventTouchUpInside];
    [squareView addSubview:getCodeBtn];

    _numLab = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(valCodeTf.frame)-40, CGRectGetMaxY(valCodeTf.frame)-30, 64, 25)];
    _numLab.backgroundColor = [UIColor redColor];
    _numLab.textColor = [UIColor whiteColor];
    _numLab.textAlignment = NSTextAlignmentCenter;
    [squareView addSubview:_numLab];
    _numLab.hidden = YES;
    
    UIImageView *imgv5 = [[UIImageView alloc] init];
    imgv5.frame = CGRectMake(10, CGRectGetMaxY(valCodeTf.frame)+1, squareView.frame.size.width-20, 1);
    imgv5.backgroundColor = [UIColor appLineColor];
    [squareView addSubview:imgv5];
    

    
    
    
    
    //同意协议
    
    UILabel *protolcLa =[[UILabel alloc]initWithFrame:CGRectMake(50, 265+90, 100, 22)];
    protolcLa.text = @"同意协议";
    protolcLa.font = [UIFont systemFontOfSize:12];
    [self.view addSubview:protolcLa];
    
    
    
    UIButton *protolcBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [protolcBtn setFrame:CGRectMake(30, 265+90, 15, 22)];
    
    [protolcBtn setImage:[UIImage imageNamed:@"Person_selected"] forState: UIControlStateNormal];
    [protolcBtn setImage:[UIImage imageNamed:@"Person_selected_btn"] forState:UIControlStateSelected];
    
    
    
    
    [protolcBtn addTarget:self action:@selector(protolcBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    
    [self.view addSubview:protolcBtn];
    
    // 注册
    UIButton *loginBut = [UIButton buttonWithType:UIButtonTypeCustom];
    [loginBut setFrame:CGRectMake(15, 265+130, SCREEN_WIDTH-30, 40)];
    [loginBut setTitle:@"注册" forState:UIControlStateNormal];
       [loginBut setBackgroundColor:[UIColor pumpkinColor]];
    [loginBut addTarget:self action:@selector(registerBtn) forControlEvents:UIControlEventTouchUpInside];
    [loginBut setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [self.view addSubview:loginBut];
    
    
    
   
    
}

- (void)getCodeClick{

    [self.view endEditing:YES];
    if (LogNmTextF.text.length == 0) {
        
        ALERT_WARN(@"请输入手机号！");
        return;
    }
    
//    NSDictionary *para = @{@"mobile":LogNmTextF.text,@"checkCodeType":@"1",};
//    [HttpManager requestGetValCodeWithDataInfo:@{@"consumer":para} subKey:@"consumer" SuccessDic:^(id succDic) {
//        
//        secsLeft = [succDic objectForKey:@"secsLeft"];
//        checkCode = [succDic objectForKey:@"checkCode"];
//        UIButton *codeB = (UIButton *)[self.view viewWithTag:10081];
//        
//        __block int timeout= [secsLeft intValue];//倒计时时间
//        dispatch_queue_t queue =dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT,0);
//        dispatch_source_t _timer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER,0,0,queue);
//        dispatch_source_set_timer(_timer,dispatch_walltime(NULL,0),1.0*NSEC_PER_SEC, 0);//每秒执行
//        dispatch_source_set_event_handler(_timer,^{
//            
//            if(timeout<=0){//倒计时结束，关闭
//                dispatch_source_cancel(_timer);
//                // dispatch_release(_timer);
//                dispatch_async(dispatch_get_main_queue(), ^{
//                    //设置界面的按钮显示 根据自己需求设置
//                    _numLab.hidden = YES;
//                    codeB.hidden = NO;
//                });
//                
//            }else{
//                
//                int minutes=timeout/60;
//                int seconds=timeout%60;
//                NSString * strTime=[NSString stringWithFormat:@"%d分%.2d",minutes, seconds];
//                dispatch_async(dispatch_get_main_queue(),^{
//                    _numLab.text = strTime;
//                    _numLab.hidden = NO;
//                    codeB.hidden = YES;
//                    
//                    
//                });
//                timeout--;
//                
//            }
//        });
//        
//        dispatch_resume(_timer);
//        
//    } failure:^(NSError *MSGerror) {
//        
//        
//        
//    }];

    
}
- (void)registerBtn{


    if ( userNameTf.text.length==0) {
        [self animationForTextfield:userNameTf];
    }
    
    if (LogNmTextF.text.length == 0) {
        [self animationForTextfield:LogNmTextF];
    }
    
    
    
    if (emailTf.text.length == 0) {
        [self animationForTextfield:emailTf];
    }

    
    if (pwdNmTextF.text.length == 0) {
        
        [self animationForTextfield:pwdNmTextF];
    }
    
    
    
    
    if (sureTf.text.length == 0 && sureTf!=nil) {
        [self animationForTextfield:sureTf];
    }

    
    
    if (emailTf.text.length==0||userNameTf.text.length==0||LogNmTextF.text.length == 0||pwdNmTextF.text.length==0 ) {
        
        return;
    }
    
    if (sureTf !=nil&&sureTf.text.length == 0) {
        return;
    }
    
    if (![pwdNmTextF.text isEqualToString:sureTf.text] && sureTf.text!=nil) {
        
        ALERT_WARN(@"两次输入的密码不一致,请重新输入");
        return;
    }
    


    
    [pwdNmTextF resignFirstResponder];
    [LogNmTextF resignFirstResponder];
    [sureTf resignFirstResponder];
    [valCodeTf resignFirstResponder];
    

    
    
      WEHTTPHandler *we =[[WEHTTPHandler alloc]init];
    
    
    [we executeRegistUserTaskWithName:userNameTf.text withPaw:pwdNmTextF.text withEmail:emailTf.text withPhone:LogNmTextF.text success:^(id obj) {
        
        
        DLog(@"输出%@",obj);
    } failed:^(id obj) {
        
         DLog(@"输出%@",obj);
    }];
    
}
#pragma mark -
- (void)animationForTextfield:(UIView*)view{
    
    CALayer *lbl = [view layer];
    CGPoint posLbl = [lbl position];
    CGPoint y = CGPointMake(posLbl.x-5, posLbl.y);
    CGPoint x = CGPointMake(posLbl.x+5, posLbl.y);
    CABasicAnimation * animation = [CABasicAnimation animationWithKeyPath:@"position"];
    [animation setTimingFunction:[CAMediaTimingFunction
                                  functionWithName:kCAMediaTimingFunctionEaseInEaseOut]];
    [animation setFromValue:[NSValue valueWithCGPoint:x]];
    [animation setToValue:[NSValue valueWithCGPoint:y]];
    [animation setAutoreverses:YES];
    [animation setDuration:0.08];
    [animation setRepeatCount:3];
    [lbl addAnimation:animation forKey:nil];
}
- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    
    [textField resignFirstResponder];
    return YES;
    
}

-(void)textFieldDidEndEditing:(UITextField *)textField
{
    if (textField==userNameTf) {
//        if ([NSString userNameValidate:userNameTf.text]==NO) {
//            WARN_ALERT(@"不超过四个汉字");
//             return;
//
//        }
        
    }else if (textField==LogNmTextF){
        if ([NSString phoneValidate:LogNmTextF.text]==NO) {
            WARN_ALERT(@"检查你的电话号码");
             return;
        }
        
    
    }else if (textField==emailTf){
        if ( [NSString  isValidateEmail:emailTf.text]==NO) {
            WARN_ALERT(@"检查你的邮箱");
            
            return;
        }
    
    }
    
}


-(void)protolcBtnClick:(UIButton*)btn
{
    
    isClick = !isClick;
    
    if (isClick) {
        
        btn.selected  =YES;
        
        
        
        
        
        return;
        
    }else{
        
        
        btn.selected = NO;
        
        
       
        
    }
    
}

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    
    [self.view endEditing:YES];
}


@end
