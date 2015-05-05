//
//  EmailForCodeVC.m
//  WestElectromechanical
//
//  Created by 夏亚峰 on 15/5/4.
//  Copyright (c) 2015年 zuo. All rights reserved.
//

#import "EmailForCodeVC.h"
#import "WEHTTPHandler.h"
#import "NSString+val.h"
#define kGap 10

@interface EmailForCodeVC ()<UITextFieldDelegate>
@property (strong, nonatomic) UITextField *namefi,*surePsdTF,*NewPsdTF;
@end

@implementation EmailForCodeVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
     self.view.backgroundColor = SET_COLOR(234.0, 234.0, 234.0);
    _namefi = [[UITextField alloc] initWithFrame:CGRectMake(kGap+10,7*kGap+10, self.view.frame.size.width-2*kGap-30, 50)];
    _namefi.placeholder = @"     输入已注册的邮箱";
    [_namefi setValue:[UIFont boldSystemFontOfSize:14] forKeyPath:@"_placeholderLabel.font"];
    
    _namefi.layer.borderWidth = 1.0;
    _namefi.layer.borderColor =[UIColor lightGrayColor].CGColor;
    [_namefi setKeyboardType:UIKeyboardTypeDefault];
    
    [_namefi.layer setMasksToBounds:YES];
    [_namefi.layer setCornerRadius:5];
    _namefi.delegate =self;
    [_namefi setClearButtonMode:UITextFieldViewModeWhileEditing];
    [_namefi setContentVerticalAlignment:UIControlContentVerticalAlignmentCenter];
    UIView *left  = [[UIView alloc]initWithFrame:CGRectMake(10, 0, 30, 30)];
    UIImageView *leftimg = [[UIImageView alloc]initWithFrame:CGRectMake(10, 0, 20, 20)];
    [leftimg setImage: [UIImage imageNamed:@"e"]];
    _namefi.leftViewMode = UITextFieldViewModeAlways;
    
    [left addSubview:leftimg];
    _namefi.leftView = left;
    [self.view addSubview:_namefi];
    
    
    
    
    
    UITextField *NewTF = [[UITextField alloc] initWithFrame:CGRectMake(10+10, CGRectGetMaxY(_namefi.frame)+10, self.view.frame.size.width-2*10-30, 50)];
    [NewTF setPlaceholder:@"        新密码（6-11字符）"];
    
    
    
    [NewTF setValue:[UIFont boldSystemFontOfSize:14] forKeyPath:@"_placeholderLabel.font"];
    [NewTF setSecureTextEntry:YES];
    [NewTF setClearButtonMode:UITextFieldViewModeWhileEditing];
    [NewTF setContentVerticalAlignment:UIControlContentVerticalAlignmentCenter];
    [NewTF setDelegate:self];
    NewTF.layer.borderWidth = 1.0;
    NewTF.layer.borderColor =[UIColor lightGrayColor].CGColor;
    
    [NewTF.layer setMasksToBounds:YES];
    [NewTF.layer setCornerRadius:5];
    UIView *psdleft  = [[UIView alloc]initWithFrame:CGRectMake(10, 0, 30, 30)];
    UIImageView *psdleftimg = [[UIImageView alloc]initWithFrame:CGRectMake(10, 0, 20, 20)];
    [psdleftimg setImage: [UIImage imageNamed:@"lock"]];
    NewTF.leftViewMode = UITextFieldViewModeAlways;
    [psdleft addSubview:psdleftimg];
    NewTF.leftView = psdleft;
    _NewPsdTF = NewTF;
//    UIImageView *imgv2 = [[UIImageView alloc] init];
//    imgv2.backgroundColor = [UIColor appLineColor];
//    imgv2.frame = CGRectMake(10, CGRectGetMaxY(NewTF.frame)+1, self.view.frame.size.width-20, 1);
//    [self.view addSubview:imgv2];
    
    
    
    
    [self.view addSubview:NewTF];
    
    
    
    
    
    _surePsdTF = [[UITextField alloc] initWithFrame:CGRectMake(10+10,CGRectGetMaxY(NewTF.frame)+10, self.view.frame.size.width-20-30, 50)];
    _surePsdTF.placeholder = @"       确认新密码";
    [_surePsdTF setValue:[UIFont boldSystemFontOfSize:14] forKeyPath:@"_placeholderLabel.font"];
    
    [_surePsdTF setKeyboardType:UIKeyboardTypeDefault];
     [_surePsdTF setSecureTextEntry:YES];
    
    _surePsdTF.layer.borderWidth = 1.0;
    _surePsdTF.layer.borderColor =[UIColor lightGrayColor].CGColor;
    [_surePsdTF.layer setMasksToBounds:YES];
    [_surePsdTF.layer setCornerRadius:5];
    _surePsdTF.delegate =self;
    [_surePsdTF setClearButtonMode:UITextFieldViewModeWhileEditing];
    [_surePsdTF setContentVerticalAlignment:UIControlContentVerticalAlignmentCenter];
    UIView *left2  = [[UIView alloc]initWithFrame:CGRectMake(10, 0, 30, 30)];
    UIImageView *leftimg2 = [[UIImageView alloc]initWithFrame:CGRectMake(10, 0, 20, 20)];
    [leftimg2 setImage: [UIImage imageNamed:@"lock"]];
    _surePsdTF.leftViewMode = UITextFieldViewModeAlways;
    [left2 addSubview:leftimg2];
    _surePsdTF.leftView = left2;
    
//    UIImageView *imgv3 = [[UIImageView alloc] init];
//    imgv3.backgroundColor = [UIColor appLineColor];
//    imgv3.frame = CGRectMake(10, CGRectGetMaxY(_surePsdTF.frame)+1, self.view.frame.size.width-20, 1);
//    [self.view addSubview:imgv3];
    
    
    
    [self.view addSubview:_surePsdTF];
    

    
    
    UIButton *loginBu = [UIButton buttonWithType:UIButtonTypeCustom];
    [loginBu setTitle:@"确定" forState:UIControlStateNormal];
    [loginBu setTitle:@"" forState:UIControlStateHighlighted];
    [loginBu setFrame:CGRectMake((self.view.frame.size.width-240)/2, CGRectGetMaxY(_surePsdTF.frame)+30, 240, 44)];
    [loginBu setBackgroundColor:[UIColor orangeColor]];
    [loginBu.layer setMasksToBounds:YES];
    [loginBu.layer setCornerRadius:5];
    [loginBu setBackgroundImage:[UIImage imageNamed:@"queding"] forState:UIControlStateNormal];
    [loginBu setBackgroundImage:[UIImage imageNamed:@"sharesure.png"] forState:UIControlStateHighlighted];
    [loginBu addTarget:self action:@selector(sureclick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:loginBu];

    

}
- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    
    
    [textField resignFirstResponder];
    
    
    
    
    return YES;
}

-(void)textFieldDidEndEditing:(UITextField *)textField
{

    if (textField==_namefi){
        if ( [NSString  isValidateEmail:_namefi.text]==NO) {
            WARN_ALERT(@"检查你的邮箱");
            
            return;
        }
    }

}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)sureclick{

    if (!([ _NewPsdTF.text isEqualToString:_surePsdTF.text]&&_surePsdTF.text!=nil)) {
        
        ALERT_WARN(@"两次输入的密码不一致,请重新输入");
        return;
    }

    

    WEHTTPHandler *we= [[WEHTTPHandler alloc]init];
    
    [we executeFindPwdTaskWithEmail:_namefi.text withPaw:_NewPsdTF.text success:^(id obj) {
        DLog(@"输出%@",obj);
    } failed:^(id obj) {

    }];

}
-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    
    [self.view endEditing:YES];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
