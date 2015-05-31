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
#define kUserAccount @"kUserAccount"

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

- (void)backNav:(UIButton*)btn{
    DLog(@"返回");
    [self dismissViewControllerAnimated:YES completion:^{

    }];
}

- (void)setLoginBlock:(loginBlock)block
{
  _block = block;
}

- (void)addLeftItem
{
    UIBarButtonItem *right =[UIBarButtonItem itemWithImageName:@"back_icon" highImageName:@"back_icon" target:self action:@selector(backNav:)];
    /**
     *  width为负数时，相当于btn向右移动width数值个像素，由于按钮本身和边界间距为5pix，所以width设为-15时，间距正好调整
     *  为10；width为正数时，正好相反，相当于往左移动width数值个像素
     */
    UIBarButtonItem *negativeSpacer = [[UIBarButtonItem alloc]
                                       initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace
                                       target:nil action:nil];
    negativeSpacer.width = -5;
    self.navigationItem.leftBarButtonItems = @[negativeSpacer, right];

}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"登录";
 
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
   
    
    
    UIButton * zhuceBtn = [[UIButton alloc]initWithFrame:CGRectMake(0, 5, 80, 30)];
    [zhuceBtn setTitle:@"免费注册" forState:UIControlStateNormal];
    
    [zhuceBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [zhuceBtn addTarget:self action:@selector(zhuce) forControlEvents:UIControlEventTouchUpInside];
    zhuceBtn.titleLabel.font = [UIFont systemFontOfSize:14];
    UIBarButtonItem *item = [[UIBarButtonItem alloc]initWithCustomView:zhuceBtn];
    
    self. navigationItem.rightBarButtonItem = item;
    
   
    UIView *whiteBg = [[UIView  alloc]initWithFrame:CGRectMake(10,7*kGap+10, SCREEN_WIDTH-20, 110 )];
  
    whiteBg.backgroundColor = [UIColor whiteColor];
    [whiteBg.layer setMasksToBounds:YES];
    [whiteBg.layer setCornerRadius:5];
    [self.view addSubview:whiteBg];
    
    _namefi = [[UITextField alloc] initWithFrame:CGRectMake(15,5, SCREEN_WIDTH-30, 50)];
    _namefi.placeholder = @"手机/邮箱/用户名";
    [_namefi setValue:[UIFont boldSystemFontOfSize:14] forKeyPath:@"_placeholderLabel.font"];
    [_namefi setKeyboardType:UIKeyboardTypeDefault];
     _namefi.delegate =self;
    [_namefi setClearButtonMode:UITextFieldViewModeWhileEditing];
    [_namefi setContentVerticalAlignment:UIControlContentVerticalAlignmentCenter];
    UIView *left  = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 40, 40)];
    UIImageView *leftimg = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 40, 40)];
    leftimg.contentMode =UIViewContentModeCenter;
    [leftimg setImage: [UIImage imageNamed:@"Person_user"]];
    _namefi.leftViewMode = UITextFieldViewModeAlways;
    
    [left addSubview:leftimg];
    _namefi.leftView = left;
    [whiteBg addSubview:_namefi];
    
    
    UIImageView *imgv4 = [[UIImageView alloc] init];
    imgv4.frame = CGRectMake(10, CGRectGetMaxY(_namefi.frame)+1, whiteBg.frame.size.width-20, 1);
    imgv4.backgroundColor = [UIColor appLineColor];
    [whiteBg addSubview:imgv4];

    
    
    UITextField *pswfi = [[UITextField alloc] initWithFrame:CGRectMake(15, CGRectGetMaxY(_namefi.frame)+10, SCREEN_WIDTH-30, 50)];
    [pswfi setPlaceholder:@"请输入密码(6-16字符)"];
    
    pswfi.leftView =[[UIView alloc]initWithFrame:CGRectMake(0, 0, 15, 50)];
    pswfi.leftViewMode = UITextFieldViewModeAlways;
    if ( [AccountHanler userCode]!=nil) {
        pswfi.text =  [AccountHanler userCode];
        
        _namefi.text = [[SendIFAPPDefault shareAppDefault] loginName];

    }
    
    
    [pswfi setValue:[UIFont boldSystemFontOfSize:14] forKeyPath:@"_placeholderLabel.font"];
    [pswfi setSecureTextEntry:YES];
    [pswfi setClearButtonMode:UITextFieldViewModeWhileEditing];
    [pswfi setContentVerticalAlignment:UIControlContentVerticalAlignmentCenter];
    [pswfi setDelegate:self];
    


    UIView *psdleft  = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 40, 40)];
    UIImageView *psdleftimg = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 40,40)];
    [psdleftimg setImage: [UIImage imageNamed:@"Person_lock"]];
    psdleftimg.contentMode = UIViewContentModeCenter;
    pswfi.leftViewMode = UITextFieldViewModeAlways;
    [psdleft addSubview:psdleftimg];
    pswfi.leftView = psdleft;
    self.loginPass = pswfi;
    [whiteBg addSubview:pswfi];
    
    
    

    
    UILabel *jizhumimaLa =[[UILabel alloc]initWithFrame:CGRectMake(35, CGRectGetMaxY(whiteBg.frame)+20, 100, 22)];
    jizhumimaLa.text = @"记住账号";
    jizhumimaLa.font = [UIFont systemFontOfSize:14];
    jizhumimaLa.textColor =[UIColor darkGrayColor];
    [self.view addSubview:jizhumimaLa];
    
    
    
    UIButton *jizhumimaBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [jizhumimaBtn setFrame:CGRectMake(15, CGRectGetMaxY(whiteBg.frame)+22, 16, 17)];
    
    [jizhumimaBtn setImage:[UIImage imageNamed:@"login_square"] forState: UIControlStateNormal];
    [jizhumimaBtn setImage:[UIImage imageNamed:@"login_selected"] forState:UIControlStateSelected];
    [jizhumimaBtn addTarget:self action:@selector(jizhumimaBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    
    if ([[NSUserDefaults standardUserDefaults] objectForKey:kUserAccount]) {
        jizhumimaBtn.selected = YES;
        isClick = YES;
        _namefi.text =[[NSUserDefaults standardUserDefaults] objectForKey:kUserAccount];
    }
    [self.view addSubview:jizhumimaBtn];
    
    
        UIButton *forgotBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [forgotBtn setTitle:@"忘记密码?" forState:UIControlStateNormal];
        [forgotBtn setTitleColor:[UIColor darkGrayColor] forState:UIControlStateNormal];
        forgotBtn.titleLabel.font = [UIFont systemFontOfSize:14];
        [forgotBtn setBackgroundColor:[UIColor clearColor]];
        [forgotBtn setFrame:CGRectMake(SCREEN_WIDTH-100, CGRectGetMaxY(whiteBg.frame)+20, 100, 22)];
    
    
    
        [forgotBtn addTarget:self action:@selector(forgetClick) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:forgotBtn];
    
    
    
    UIButton *loginBu = [UIButton buttonWithType:UIButtonTypeCustom];
    [loginBu setTitle:@"登录" forState:UIControlStateNormal];
    [loginBu setTitle:@"" forState:UIControlStateHighlighted];
    [loginBu setFrame:CGRectMake((self.view.frame.size.width-300)/2, CGRectGetMaxY(jizhumimaLa.frame)+20, 300, 44)];
     loginBu.backgroundColor =[UIColor redColor];
    [loginBu.layer setMasksToBounds:YES];
    loginBu.layer.borderColor =[UIColor redColor].CGColor;
    loginBu.layer.borderWidth =1;
    loginBu.layer.cornerRadius = 5;
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
    
//    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示" message:nil delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];

    __weak LoginVC *bSelf = self;
    [whanle executeLoginUserTaskWithAccount:_namefi.text withPaw:self.loginPass.text success:^(id obj) {
    
        
        NSLog(@"输出这个内容%@",[obj objectForKey:@"message"]);
        
        if ([[obj objectForKey:@"message"] isEqualToString:@"0"]) {
            
            if (isClick) {
                
                [[NSUserDefaults standardUserDefaults] setObject:_namefi.text forKey:kUserAccount];
            }
            [AccountHanler saveUserId:[obj objectForKey:@"uid"]];
            [AccountHanler setLoginState:1];
            [[[WEHTTPHandler alloc]init] executeGetCartListTaskWithUserId:[AccountHanler userId] withPage:@"1" Success:^(id obj) {
                
            } failed:^(id obj) {
                
            }];

            
            [bSelf dismissViewControllerAnimated:YES completion:^{
                if (_block) {
                    _block();
                }
            }];
            

        }
    } failed:^(id obj) {
    
        DLog(@"会出现%@",obj);
        if([[obj objectForKey:@"message"] isEqualToString:@"1"]){
            [AlertUtil showAlertWithText:@"登录失败"];
            
        }else if([[obj objectForKey:@"message"] isEqualToString:@"2"]){
            [AlertUtil showAlertWithText:@"用户不存在"];
            
        }else if([[obj objectForKey:@"message"] isEqualToString:@"3"]){
            [AlertUtil showAlertWithText:@"密码错误"];
            
        }else{
            [AlertUtil showAlertWithText:@"网络错误"];

        }

        

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
    
//        [AccountHanler saveUserCode:self.loginPass.text];

        return;
        
    }else{

        btn.selected = NO;

//       [AccountHanler saveUserCode:@""];
        
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
