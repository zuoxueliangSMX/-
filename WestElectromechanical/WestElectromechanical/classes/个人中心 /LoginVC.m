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
#import "RDVTabBarController.h"
#import "UIBarButtonItem+Extension.h"
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

#pragma mark -
#pragma mark - pop和push控制器时的操作
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [[self rdv_tabBarController] setTabBarHidden:YES animated:YES];
    [self addLeftItem];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    [[self rdv_tabBarController] setTabBarHidden:NO animated:YES];
}

//- (void)backNav:(UIButton*)btn{
//    NSLog(@"返回");
//    [self dismissViewControllerAnimated:YES completion:^{
//        
//    }];
//}



- (void)addLeftItem
{
//    UIBarButtonItem *right =[UIBarButtonItem itemWithImageName:@"navigationbar_back" highImageName:@"navigationbar_back_highlighted" target:self action:@selector(backNav:)];
    /**
     *  width为负数时，相当于btn向右移动width数值个像素，由于按钮本身和边界间距为5pix，所以width设为-15时，间距正好调整
     *  为10；width为正数时，正好相反，相当于往左移动width数值个像素
     */
//    UIBarButtonItem *negativeSpacer = [[UIBarButtonItem alloc]
//                                       initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace
//                                       target:nil action:nil];
//    negativeSpacer.width = -15;
//    self.navigationItem.leftBarButtonItems = @[negativeSpacer, right];
//
}
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
    
   
     
    
    _namefi = [[UITextField alloc] initWithFrame:CGRectMake(15,7*kGap+10, SCREEN_WIDTH-30, 50)];
    _namefi.placeholder = @"                     手机/用户名/邮箱";
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
    UIImageView *leftimg = [[UIImageView alloc]initWithFrame:CGRectMake(10, 5, 20, 20)];
    [leftimg setImage: [UIImage imageNamed:@"Person_user"]];
    _namefi.leftViewMode = UITextFieldViewModeAlways;
    
    [left addSubview:leftimg];
    _namefi.leftView = left;
    [self.view addSubview:_namefi];
    
    
    
    UITextField *pswfi = [[UITextField alloc] initWithFrame:CGRectMake(15, CGRectGetMaxY(_namefi.frame)+10, SCREEN_WIDTH-30, 50)];
    [pswfi setPlaceholder:@"                         密码6至16字符"];
    
    if ( [AccountHanler userCode]!=nil) {
        pswfi.text =  [AccountHanler userCode];
        
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
    UIImageView *psdleftimg = [[UIImageView alloc]initWithFrame:CGRectMake(10, 5, 20, 20)];
    [psdleftimg setImage: [UIImage imageNamed:@"Person_lock"]];
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
    
    [jizhumimaBtn setImage:[UIImage imageNamed:@"Person_selected"] forState: UIControlStateNormal];
    [jizhumimaBtn setImage:[UIImage imageNamed:@"Person_selected_btn"] forState:UIControlStateSelected];
    
    
    
    
    [jizhumimaBtn addTarget:self action:@selector(jizhumimaBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    
    
    if ([AccountHanler userCode].length>0) {
        jizhumimaBtn.selected = YES;
         isClick = YES;
        
        
    }

    [self.view addSubview:jizhumimaBtn];
    
    
        UIButton *forgotBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [forgotBtn setTitle:@"忘记密码>" forState:UIControlStateNormal];
        forgotBtn.titleLabel.font = [UIFont systemFontOfSize:12];
        [forgotBtn setBackgroundColor:[UIColor clearColor]];
        [forgotBtn setFrame:CGRectMake(SCREEN_WIDTH-150, CGRectGetMaxY(pswfi.frame)+20, 100, 22)];
    
    
    
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
    
        [AccountHanler saveUserCode:self.loginPass.text ];



                return;
        
    }else{
    
        
        btn.selected = NO;
    
    
       [AccountHanler saveUserCode:@""];
        
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
