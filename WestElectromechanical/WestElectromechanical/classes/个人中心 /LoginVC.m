//
//  MeVC.m
//  Haerbing
//
//  Created by sendInfo on 2014-12-19.
//  Copyright (c) 2014年 sendInfo. All rights reserved.
//

#import "LoginVC.h"
#import "SendIFAPPDefault.h"
#import "AppDelegate.h"
//#import "NSString+MD5.h"
#import "MyRegisterVC.h"
#import "EmailForCodeVC.h"
#import "WEHTTPHandler.h"
#import "AccountHanler.h"
#define kGap 10


@interface LoginVC ()<UITextFieldDelegate,UIActionSheetDelegate>


{

    UIActionSheet *actsheet;

BOOL  isClick ;
WEHTTPHandler *whanle;

}
@property (strong, nonatomic) UITextField *namefi;
// 密码
@property (strong, nonatomic) UITextField *loginPass;
// 底View
@property (strong, nonatomic) UIScrollView *besView;


@property (strong, nonatomic) UIScrollView *succeedView;

@end

@implementation LoginVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"用户登录";
 
    self.view.backgroundColor = SET_COLOR(234.0, 234.0, 234.0);
    [self addUI];
    
    actsheet  =[[UIActionSheet alloc]initWithTitle:@"" delegate:self cancelButtonTitle:@"取消"destructiveButtonTitle:nil otherButtonTitles:@"通过邮箱找回密码", nil];
    
    whanle = [[WEHTTPHandler alloc]init];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)addUI
{
   
    
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"免费注册>" style:UIBarButtonItemStyleDone target:self action:@selector(zhuce)];
    
   
     
    

//    
//     UIImageView *meiconimg = [[UIImageView alloc]initWithFrame:CGRectMake((self.view.frame.size.width-50)/2, 7*kGap, 50, 50)];
//    
//    
////    meiconimg.image = [UIImage   imageNamed:@"header"];
//    [self.view  addSubview:meiconimg];
    
    
    _namefi = [[UITextField alloc] initWithFrame:CGRectMake(kGap+10,7*kGap+10, self.view.frame.size.width-2*kGap-30, 50)];
    _namefi.placeholder = @"       手机/用户名/邮箱";
    [_namefi setValue:[UIFont boldSystemFontOfSize:14] forKeyPath:@"_placeholderLabel.font"];
    
    _namefi.layer.borderWidth = 1.0;
    _namefi.layer.borderColor =[UIColor lightGrayColor].CGColor;
    [_namefi setKeyboardType:UIKeyboardTypeDefault];
    
    [_namefi.layer setMasksToBounds:YES];
    [_namefi.layer setCornerRadius:5];
    _namefi.delegate =self;
    [_namefi setClearButtonMode:UITextFieldViewModeWhileEditing];
    [_namefi setContentVerticalAlignment:UIControlContentVerticalAlignmentCenter];
    UIView *left  = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 30, 30)];
    UIImageView *leftimg = [[UIImageView alloc]initWithFrame:CGRectMake(10, 0, 20, 20)];
    [leftimg setImage: [UIImage imageNamed:@"ren"]];
    _namefi.leftViewMode = UITextFieldViewModeAlways;
    
    [left addSubview:leftimg];
    _namefi.leftView = left;
    [self.view addSubview:_namefi];
    
    
    
    UITextField *pswfi = [[UITextField alloc] initWithFrame:CGRectMake(kGap+10, CGRectGetMaxY(_namefi.frame)+10, self.view.frame.size.width-2*kGap-30, 50)];
    [pswfi setPlaceholder:@"        密码6至16字符"];
    
    if ( [[SendIFAPPDefault shareAppDefault] mima]!=nil) {
        pswfi.text =  [[SendIFAPPDefault shareAppDefault] mima];
        
        _namefi.text = [[SendIFAPPDefault shareAppDefault] loginName];

    }
    
    
    [pswfi setValue:[UIFont boldSystemFontOfSize:14] forKeyPath:@"_placeholderLabel.font"];
    [pswfi setSecureTextEntry:YES];
    [pswfi setClearButtonMode:UITextFieldViewModeWhileEditing];
    [pswfi setContentVerticalAlignment:UIControlContentVerticalAlignmentCenter];
    [pswfi setDelegate:self];
    
    pswfi.layer.borderWidth = 1.0;
    pswfi.layer.borderColor =[UIColor lightGrayColor].CGColor;
    [pswfi.layer setMasksToBounds:YES];
    [pswfi.layer setCornerRadius:5];

    UIView *psdleft  = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 30, 30)];
    UIImageView *psdleftimg = [[UIImageView alloc]initWithFrame:CGRectMake(10, 0, 20, 20)];
    [psdleftimg setImage: [UIImage imageNamed:@"lock"]];
    pswfi.leftViewMode = UITextFieldViewModeAlways;
    [psdleft addSubview:psdleftimg];
    pswfi.leftView = psdleft;
    self.loginPass = pswfi;
    [self.view addSubview:pswfi];
    
    
    

    
    UILabel *jizhumimaLa =[[UILabel alloc]initWithFrame:CGRectMake(50, CGRectGetMaxY(pswfi.frame)+20, 100, 22)];
    jizhumimaLa.text = @"记住密码";
    jizhumimaLa.font = [UIFont systemFontOfSize:12];
       [self.view addSubview:jizhumimaLa];
    
    
    
    UIButton *jizhumimaBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [jizhumimaBtn setFrame:CGRectMake(30, CGRectGetMaxY(pswfi.frame)+22, 15, 22)];
    
    [jizhumimaBtn setImage:[UIImage imageNamed:@"selected.jpg"] forState: UIControlStateNormal];
    [jizhumimaBtn setImage:[UIImage imageNamed:@"ico1"] forState:UIControlStateSelected];
    
    
    
    
    [jizhumimaBtn addTarget:self action:@selector(jizhumimaBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    
    
    if ([[SendIFAPPDefault shareAppDefault] mima].length>0) {
        jizhumimaBtn.selected = YES;
         isClick = YES;
        
        
    }

    [self.view addSubview:jizhumimaBtn];
    
    
        UIButton *forgotBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [forgotBtn setTitle:@"忘记密码>" forState:UIControlStateNormal];
        forgotBtn.titleLabel.font = [UIFont systemFontOfSize:12];
        [forgotBtn setBackgroundColor:[UIColor clearColor]];
        [forgotBtn setFrame:CGRectMake(CGRectGetMaxX(jizhumimaBtn.frame)+90+40, CGRectGetMaxY(pswfi.frame)+20, 100, 22)];
    
    
    
        [forgotBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [forgotBtn addTarget:self action:@selector(forgetClick) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:forgotBtn];
    
    
    
    UIButton *loginBu = [UIButton buttonWithType:UIButtonTypeCustom];
    [loginBu setTitle:@"登陆" forState:UIControlStateNormal];
    [loginBu setTitle:@"" forState:UIControlStateHighlighted];
    [loginBu setFrame:CGRectMake((self.view.frame.size.width-240)/2, CGRectGetMaxY(jizhumimaLa.frame)+20, 240, 44)];
    [loginBu setBackgroundColor:[UIColor orangeColor]];
    [loginBu.layer setMasksToBounds:YES];
    [loginBu.layer setCornerRadius:5];
    [loginBu setBackgroundImage:[UIImage imageNamed:@"queding"] forState:UIControlStateNormal];
    [loginBu setBackgroundImage:[UIImage imageNamed:@"sharesure.png"] forState:UIControlStateHighlighted];
    [loginBu addTarget:self action:@selector(login) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:loginBu];
    

    


    
}
#pragma mark textField代理方法
- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    
    
    [textField resignFirstResponder];
    
    return YES;
}

-(void)textFieldDidEndEditing:(UITextField *)textField
{

   
}

// 登录
- (void)login
{
    [self.view endEditing:YES];
    
    
    
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示" message:nil delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];

    
    [whanle executeLoginUserTaskWithAccount:_namefi.text withPaw:self.loginPass.text success:^(id obj) {
    
        
        NSLog(@"输出这个内容%@",[obj objectForKey:@"message"]);
        
        if ([[obj objectForKey:@"message"] isEqualToString:@"0"]) {
            
            [AccountHanler saveUserId:[obj objectForKey:@"uid"]];
            [AccountHanler setLoginState:1];
            
            [self.navigationController popViewControllerAnimated:YES];
            [alert  setTitle:@"登陆成功"];
            [alert show];
        }
        
    } failed:^(id obj) {
    
        DLog(@"会出现%@",obj);
        

    }];
    
    
    
    
    
    
   
//        NSDictionary *accountLogin = @{@"login":self.namefi.text,
//                                       @"pass":[self.loginPass.text md5]
//                                       
//                                       };
//        
//        
//        [HttpManager userLoginWithDataInfo:@{@"consumer":accountLogin} subKey:@"consumer" result:^(NSArray *result) {
//            
//            
//            NSString *userID = [result objectAtIndex:0];
//            NSString *login= [result objectAtIndex:1];
//            
//            [[SendIFAPPDefault shareAppDefault] setCurrentUserID:userID];
//            [[SendIFAPPDefault shareAppDefault] setLoginState:@"1"];
//            [[SendIFAPPDefault shareAppDefault] setLoginName:login];
//            
//            AppDelegate *app = (AppDelegate*)[UIApplication sharedApplication].delegate;
//            
//            
//            
//            
//            TabbarController *controller = [[TabbarController alloc] init];
//            
//            [UIApplication sharedApplication].idleTimerDisabled = NO;
//            [app.window setRootViewController:controller];
//            
//            [alert  setTitle:@"登陆成功"];
//            [alert show];
//            
//        }];
    }

    
// }

- (void)zhuce
{
        MyRegisterVC *zhuce = [[ MyRegisterVC alloc] init];
        [self.navigationController pushViewController:zhuce animated:YES];
}
-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    
    [self.view endEditing:YES];
 }



-(void)jizhumimaBtnClick:(UIButton*)btn
{
    
    isClick = !isClick;
    
    if (isClick) {
        
        btn.selected  =YES;
    
        [[SendIFAPPDefault shareAppDefault]setMima:self.loginPass.text ];



                return;
        
    }else{
    
        
        btn.selected = NO;
    
    
        [[SendIFAPPDefault shareAppDefault]setMima:@""];
        
    }

}


    
-(void)forgetClick
{


    [actsheet showInView:self.view];
}



- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex{
    
    
    if (buttonIndex == 0) {
        
        
        EmailForCodeVC *emailvc = [[EmailForCodeVC alloc]init];
        
        [self.navigationController pushViewController:emailvc animated:YES];
        
    }
}

@end
