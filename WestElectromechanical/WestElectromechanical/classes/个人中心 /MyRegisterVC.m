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
#import "NSDate+Helper.h"
#import "XiyuprotocolVC.h"
#import "NSString+Base64.h"
@interface MyRegisterVC ()<UITextFieldDelegate>{

    
    UITextField *LogNmTextF,*pwdNmTextF,*sureTf,*valCodeTf,*userNameTf,*emailTf;
    UILabel *_numLab;
    NSString *checkCode,*secsLeft;
    
    BOOL  isClick ;
    
    BOOL  agreeProtecol;
    
    WEHTTPHandler *we;

}
@property (nonatomic ,weak)UIButton *protolcBtn;
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
    UIView * squareView = [[UIView alloc]initWithFrame:CGRectMake(15, 80, SCREEN_WIDTH-30, 225)];
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
    

    
//    // yan密码
//    valCodeTf = [[UITextField alloc] initWithFrame:CGRectMake(15, CGRectGetMaxY(sureTf.frame), 220, 40)];
//    [valCodeTf setBorderStyle:UITextBorderStyleNone];
//    [valCodeTf setSecureTextEntry:YES]; //设置成密码格式
//    valCodeTf.textColor = [UIColor blackColor];
//    [valCodeTf setClearButtonMode:UITextFieldViewModeWhileEditing];
//    [valCodeTf setContentVerticalAlignment:UIControlContentVerticalAlignmentCenter];
//    UIButton *codeBut = [UIButton buttonWithType:UIButtonTypeCustom];
//    [codeBut setImage:[UIImage imageNamed:@"Person_email"] forState:UIControlStateNormal];
//    [codeBut setBounds:CGRectMake(0, 0, 50, 40)];
//    [codeBut setUserInteractionEnabled:NO];
//    valCodeTf.leftViewMode = UITextFieldViewModeAlways;
//    [valCodeTf setLeftView:codeBut];
//    [valCodeTf setDelegate:self];
//    valCodeTf.returnKeyType=UIReturnKeyGo;//返回键的类型
//    [valCodeTf setPlaceholder:@"验证码"]; //默认显示的字
//    //    [pwdNmTextF setTextAlignment:NSTextAlignmentCenter];
//    [squareView addSubview:valCodeTf];
//    
//    UIButton *getCodeBtn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
//    [getCodeBtn setTitle:@"获取验证码" forState:UIControlStateNormal];
//    getCodeBtn.tag = 10081;
//    [getCodeBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
//    [getCodeBtn setBackgroundColor:[UIColor orangeColor]];
//    [getCodeBtn setFrame:CGRectMake(CGRectGetMaxX(valCodeTf.frame)-60, CGRectGetMaxY(valCodeTf.frame)-30, 80, 25)];
//    [getCodeBtn addTarget:self action:@selector(getCodeClick) forControlEvents:UIControlEventTouchUpInside];
//    [squareView addSubview:getCodeBtn];
//
//    _numLab = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(valCodeTf.frame)-40, CGRectGetMaxY(valCodeTf.frame)-30, 64, 25)];
//    _numLab.backgroundColor = [UIColor redColor];
//    _numLab.textColor = [UIColor whiteColor];
//    _numLab.textAlignment = NSTextAlignmentCenter;
//    [squareView addSubview:_numLab];
//    _numLab.hidden = YES;
//    
//    UIImageView *imgv5 = [[UIImageView alloc] init];
//    imgv5.frame = CGRectMake(10, CGRectGetMaxY(valCodeTf.frame)+1, squareView.frame.size.width-20, 1);
//    imgv5.backgroundColor = [UIColor appLineColor];
//    [squareView addSubview:imgv5];
    

    
    
    
    
    //同意协议
    
    UILabel *protolcLa =[[UILabel alloc]initWithFrame:CGRectMake(50, 265+90, 90, 22)];
    protolcLa.text = @"同意协议";
    protolcLa.font = [UIFont systemFontOfSize:12];
    [self.view addSubview:protolcLa];
    
    
    
    UIButton *protolcBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [protolcBtn setFrame:CGRectMake(30, 265+90, 15, 22)];
    
    [protolcBtn setImage:[UIImage imageNamed:@"Person_selected"] forState: UIControlStateNormal];
    [protolcBtn setImage:[UIImage imageNamed:@"Person_selected_btn"] forState:UIControlStateSelected];
    
    
    
    
    [protolcBtn addTarget:self action:@selector(protolcBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    
    [self.view addSubview:protolcBtn];
    
    _protolcBtn =protolcBtn;
    // 协议
    UIButton *protolcoDetailBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [protolcoDetailBtn setFrame:CGRectMake(CGRectGetMaxX(protolcLa.frame)-30, CGRectGetMinY(protolcLa.frame), 130, 25)];
    [protolcoDetailBtn setTitle:@"《西域机电注册协议》" forState:UIControlStateNormal];
    
    protolcoDetailBtn.titleLabel.font = [UIFont systemFontOfSize:13];
    protolcoDetailBtn.backgroundColor = [UIColor clearColor];
    [protolcoDetailBtn addTarget:self action:@selector(protolcoDetailClick11) forControlEvents:UIControlEventTouchUpInside];
    [protolcoDetailBtn setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
    [self.view addSubview:protolcoDetailBtn];

    
    
    
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
        
//        ALERT_WARN(@"两次输入的密码不一致,请重新输入");
        [AlertUtil showAlertWithText:@"两次输入的密码不一致,请重新输入"];

        return;
    }
    
  
    
    [pwdNmTextF resignFirstResponder];
    [LogNmTextF resignFirstResponder];
    [sureTf resignFirstResponder];
    [valCodeTf resignFirstResponder];
    
  
    if (agreeProtecol==NO) {
//        ALERT_WARN(@"同意协议方可注册");
        [AlertUtil showAlertWithText:@"同意协议方可注册"];

        return;
    }

    
      we =[[WEHTTPHandler alloc]init];
    
    __weak MyRegisterVC *bSelf = self;
    [we executeRegistUserTaskWithName:userNameTf.text withPaw:pwdNmTextF.text withEmail:emailTf.text withPhone:LogNmTextF.text success:^(id obj) {

        if ([[obj objectForKey:@"message"]intValue]==0) {
            
            [AlertUtil showAlertWithText:@"注册成功"];
//                         WARN_ALERT(@"注册成功");
            
        }
        
        
        [bSelf.navigationController popViewControllerAnimated:YES];
        
       
    } failed:^(id obj) {
//        [AlertUtil showAlertWithText:@"注册失败"];
        if ([[obj objectForKey:@"message"]intValue]==1){
            [AlertUtil showAlertWithText:@"用户名存在"];
            //              WARN_ALERT(@"用户名存在");
//            return ;
        }else if ([[obj objectForKey:@"message"]intValue]==2){
            [AlertUtil showAlertWithText:@"手机号码存在"];
            //          WARN_ALERT(@"手机号码存在");
//            return;
        }else if([[obj objectForKey:@"message"]intValue]==3) {
            //           WARN_ALERT(@"邮箱存在");
            [AlertUtil showAlertWithText:@"邮箱存在"];
            
//            return;
        }else{
            [AlertUtil showAlertWithText:@"注册失败"];
            
            //         WARN_ALERT(@"");
        }
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
            [AlertUtil showAlertWithText:@"检查你的电话号码"];
//            WARN_ALERT(@"检查你的电话号码");
             return;
        }
        
    
    }else if (textField==emailTf){
        if ( [NSString  isValidateEmail:emailTf.text]==NO) {
            [AlertUtil showAlertWithText:@"检查你的邮箱"];

//            WARN_ALERT(@"检查你的邮箱");
            
            return;
        }
    
    }
    
}


-(void)protolcBtnClick:(UIButton*)btn
{
    
    isClick = !isClick;
    
    if (isClick) {
        
        btn.selected  =YES;
        
        
        agreeProtecol =YES;
        
        
        return;
        
    }else{
        
        
        btn.selected = NO;
        
        
        agreeProtecol =NO;
        
    }
    
}

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    
    [self.view endEditing:YES];
}

-(void)protolcoDetailClick11{
    
    
    NSString *protacol =@"“法律百科”所提供的各项服务的所有权和运作权属于其运营商。用户必须同意下述所有服务条款并完成注册程序，才能成为“法律百科”的正式会员并使用“法律百科”提供的各项服务。服务条款的修改权归“法律百科”运营商所有。 　　一、 “法律百科”运用自己的操作系统，通过国际互联网络等手段为会员提供法律信息交流平台。“法律百科”有权在必要时修改服务条款，服务条款一旦发生变动，将会在重要页面上提示修改内容或通过其他形式告知会员。如果会员不同意所改动的内容，可以主动取消获得的网络服务。如果会员继续享用网络服务，则视为接受服务条款的变动。“法律百科”保留随时修改或中断服务而不需知照会员的权利。“法律百科”行使修改或中断服务的权利，不需对会员或第三方负责。 　　二、保护会员隐私权 　　您注册“法律百科”相关服务时，跟据网站要求提供相关个人信息；在您使用“法律百科”服务、参加网站活动、或访问网站网页时，网站自动接收并记录的您浏览器上的服务器数据，包括但不限于IP地址、网站Cookie中的资料及您要求取用的网页记录；“法律百科”承诺不公开或透露您的密码、手机号码等在本站的非公开信息。除非因会员本人的需要、法律或其他合法程序的要求、服务条款的改变或修订等。 　　为服务用户的目的，“法律百科”可能通过使用您的个人信息，向您提供服务，包括但不限于向您发出活动和服务信息等。 　　同时会员须做到： 　　● 用户名和昵称的注册与使用应符合网络道德，遵守中华人民共和国的相关法律法规。 　　● 用户名和昵称中不能含有威胁、淫秽、漫骂、非法、侵害他人权益等有争议性的文字。 　　● 注册成功后，会员必须保护好自己的帐号和密码，因会员本人泄露而造成的任何损失由会员本人负责。 　　● 不得盗用他人帐号，由此行为造成的后果自负。 　　您的个人信息将在下述情况下部分或全部被披露： 　　● 经您同意，向第三方披露； 　　● 如您是合资格的知识产权投诉人并已提起投诉，应被投诉人要求，向被投诉人披露，以便双方处理可能的权利纠纷； 　　● 根据法律的有关规定，或者行政或司法机构的要求，向第三方或者行政、司法机构披露； 　　● 如果您出现违反中国有关法律或者网站政策的情况，需要向第三方披露； 　　● 为提供你所要求的产品和服务，而必须和第三方分享您的个人信息； 　　● 其他本网站根据法律或者网站政策认为合适的披露 　　三、责任说明 　　基于技术和不可预见的原因而导致的服务中断，或者因会员的非法操作而造成的损失，“法律百科”不负责任。会员应当自行承担一切因自身行为而直接或者间接导致的民事或刑事法律责任。 　　四、会员必须做到： 　　1、不得利用本站危害国家安全、泄露国家秘密，不得侵犯国家社会集体的和公民的合法权益，不得利用本站制作、复制和传播下列信息： 　　（1）煽动抗拒、破坏宪法和法律、行政法规实施的； 　　（2）煽动颠覆国家政权，推翻社会主义制度的； 　　（3）煽动分裂国家、破坏国家统一的； 　　（4）煽动民族仇恨、民族歧视，破坏民族团结的； 　　（5）捏造或者歪曲事实，散布谣言，扰乱社会秩序的； 　　（6）宣扬封建迷信、淫秽、色情、赌博、暴力、凶杀、恐怖、教唆犯罪的； 　　（7）公然侮辱他人或者捏造事实诽谤他人的，或者进行其他恶意攻击的； 　　（8）损害国家机关信誉的； 　　（9）其他违反宪法和法律行政法规的； 　　（10）进行商业广告行为的。 　　2、未经本站的授权或许可，任何会员不得借用本站的名义从事任何商业活动，也不得将本站作为从事商业活动的场所、平台或其他任何形式的媒介。禁止将本站用作从事各种非法活动的场所、平台或者其他任何形式的媒介。违反者若触犯法律，一切后果自负，本站不承担任何责任。 　　五、版权说明： 　　任何会员在本站发表任何形式的信息，均表明该用户主动将该信息的发表权、汇编权、修改权、信息网络传播权无偿独家转让给“法律百科”运营商。本协议已经构成《著作权法》第二十五条所规定的书面协议，并在用户同意本注册协议时生效，其效力及于用户此后在法律百科发布的任何内容。 　　会员同意并明确了解上述条款，不将已发表于本站的信息，以任何形式发布或授权其它网站（及媒体）使用。 　　同时，“法律百科”保留删除站内各类不符合规定点评而不通知会员的权利： 　　六、免责声明： 　　● “法律百科”是为互联网用户提供信息存储空间的互联网服务提供者，对于任何包含、经由或连接、下载或从任何与有关本网站所获得的任何内容、信息或广告，不声明或保证其正确性或可靠性；并且对于用户经本网站上的内容、广告、展示而购买、取得的任何产品、信息或资料，“法律百科”不负保证责任。用户自行负担使用本网站的风险。 　　● “法律百科”有权但无义务，改善或更正本网站任何部分之任何疏漏、错误。 　　● 本站内相关信息内容仅代表发布者的个人观点，并不表示本站赞同其观点或证实其描述，本站不承担由此引发的法律责任。";
    
    WEHTTPHandler *httphandler =[[WEHTTPHandler alloc]init];
    __weak MyRegisterVC *bself =self;
    [httphandler executeGetUserRegistProtacolWithSuccess:^(id obj) {
        DLog(@"什么什么");
        if ([[obj objectForKey:@"message"] isEqualToString:@"0"]) {
            
            NSString *textStr =[[obj objectForKey:@"info"] base64DecodedString];
            XiyuprotocolVC *xiyu = [[XiyuprotocolVC alloc]init];
            xiyu.text =textStr;
            [xiyu setXiyuprotocolVCBlock:^(NSInteger tag) {
                if (tag == 1000) {
                    isClick = NO;
                    bself.protolcBtn.selected = NO;
                    agreeProtecol =NO;
                }else{
                    isClick = YES;
                    bself.protolcBtn.selected = YES;
                    agreeProtecol =YES;
                }
            }];

            [self.navigationController pushViewController:xiyu animated:YES];
            
            
        }
        

    } failed:^(id obj) {
        DLog(@"ssjjs");
        
        XiyuprotocolVC *xiyu = [[XiyuprotocolVC alloc]init];
        xiyu.text =protacol;
        [xiyu setXiyuprotocolVCBlock:^(NSInteger tag) {
            if (tag == 1000) {
                isClick = NO;
                bself.protolcBtn.selected = NO;
                agreeProtecol =NO;
            }else{
                isClick = YES;
                bself.protolcBtn.selected = YES;
                agreeProtecol =YES;
            }
        }];
        [self.navigationController pushViewController:xiyu animated:YES];

    }];
    
    

    
}
@end
