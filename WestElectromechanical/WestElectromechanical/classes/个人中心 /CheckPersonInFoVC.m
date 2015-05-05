//
//  CheckPersonInFoVC.m
//  WestElectromechanical
//
//  Created by 夏亚峰 on 15/5/5.
//  Copyright (c) 2015年 zuo. All rights reserved.
//

#import "CheckPersonInFoVC.h"
#import "ChangePsdVC.h"
#define kGap 10

@interface CheckPersonInFoVC ()<UITextFieldDelegate>


@property (strong, nonatomic) UITextField *namefi,*emailTF;
@property (strong, nonatomic) UITextField *phoneTF;
@end


@implementation CheckPersonInFoVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"个人信息";
    self.view.backgroundColor = SET_COLOR(234.0, 234.0, 234.0);
    UIView * squareView = [[UIView alloc]initWithFrame:CGRectMake(20, 80, 280, 160)];
    squareView.backgroundColor = [UIColor whiteColor];
    squareView.layer.cornerRadius =4;
    [self.view addSubview:squareView];

    
    
    
    _namefi = [[UITextField alloc] initWithFrame:CGRectMake(kGap+10,5, self.view.frame.size.width-2*kGap-30, 50)];
    _namefi.placeholder = @"       用户";
    [_namefi setValue:[UIFont boldSystemFontOfSize:14] forKeyPath:@"_placeholderLabel.font"];
    
    [_namefi setKeyboardType:UIKeyboardTypeDefault];
    
    [_namefi.layer setMasksToBounds:YES];
    [_namefi.layer setCornerRadius:5];
    _namefi.delegate =self;
    [_namefi setClearButtonMode:UITextFieldViewModeWhileEditing];
    [_namefi setContentVerticalAlignment:UIControlContentVerticalAlignmentCenter];
    UIView *left  = [[UIView alloc]initWithFrame:CGRectMake(10, 0, 20, 20)];
    UIImageView *leftimg = [[UIImageView alloc]initWithFrame:CGRectMake(10, 0, 20, 20)];
    [leftimg setImage: [UIImage imageNamed:@"ren"]];
    _namefi.leftViewMode = UITextFieldViewModeAlways;
    
    UIImageView *imgv1 = [[UIImageView alloc] init];
    imgv1.backgroundColor = [UIColor appLineColor];
    imgv1.frame = CGRectMake(10, CGRectGetMaxY(_namefi.frame)+1, squareView.frame.size.width-20, 1);
    [squareView addSubview:imgv1];
    
    
    _namefi.enabled =NO;
    [left addSubview:leftimg];
    _namefi.leftView = left;
    [squareView addSubview:_namefi];
    
    
    
    UITextField *phoneNumTF = [[UITextField alloc] initWithFrame:CGRectMake(kGap+10, CGRectGetMaxY(_namefi.frame), self.view.frame.size.width-2*kGap-30, 50)];
    [phoneNumTF setPlaceholder:@"        手机号码"];
    
    
    
    [phoneNumTF setValue:[UIFont boldSystemFontOfSize:14] forKeyPath:@"_placeholderLabel.font"];
    [phoneNumTF setSecureTextEntry:YES];
    [phoneNumTF setClearButtonMode:UITextFieldViewModeWhileEditing];
    [phoneNumTF setContentVerticalAlignment:UIControlContentVerticalAlignmentCenter];
    [phoneNumTF setDelegate:self];
    
      [phoneNumTF.layer setMasksToBounds:YES];
    [phoneNumTF.layer setCornerRadius:5];
    phoneNumTF.enabled =NO;
    UIView *psdleft  = [[UIView alloc]initWithFrame:CGRectMake(10, 0, 20, 20)];
    UIImageView *psdleftimg = [[UIImageView alloc]initWithFrame:CGRectMake(10, 0, 20, 20)];
    [psdleftimg setImage: [UIImage imageNamed:@"lock"]];
    phoneNumTF.leftViewMode = UITextFieldViewModeAlways;
    [psdleft addSubview:psdleftimg];
    phoneNumTF.leftView = psdleft;
    self.phoneTF = phoneNumTF;
    UIImageView *imgv2 = [[UIImageView alloc] init];
    imgv2.backgroundColor = [UIColor appLineColor];
    imgv2.frame = CGRectMake(10, CGRectGetMaxY(phoneNumTF.frame)+1, squareView.frame.size.width-20, 1);
    [squareView addSubview:imgv2];
    

    
    
    [squareView addSubview:phoneNumTF];
    
    
    
    
    
    _emailTF = [[UITextField alloc] initWithFrame:CGRectMake(kGap+10,CGRectGetMaxY(phoneNumTF.frame), self.view.frame.size.width-2*kGap-30, 50)];
    _emailTF.placeholder = @"       邮箱";
    [_emailTF setValue:[UIFont boldSystemFontOfSize:14] forKeyPath:@"_placeholderLabel.font"];
    
       [_emailTF setKeyboardType:UIKeyboardTypeDefault];
    
    [_emailTF.layer setMasksToBounds:YES];
    [_emailTF.layer setCornerRadius:5];
    _emailTF.delegate =self;
    [_emailTF setClearButtonMode:UITextFieldViewModeWhileEditing];
    [_emailTF setContentVerticalAlignment:UIControlContentVerticalAlignmentCenter];
    UIView *left2  = [[UIView alloc]initWithFrame:CGRectMake(10, 0, 20, 20)];
    UIImageView *leftimg2 = [[UIImageView alloc]initWithFrame:CGRectMake(10, 0, 20, 20)];
    [leftimg2 setImage: [UIImage imageNamed:@"t"]];
    _emailTF.leftViewMode = UITextFieldViewModeAlways;
    _emailTF.enabled =NO;
    [left2 addSubview:leftimg2];
    _emailTF.leftView = left2;
    
    UIImageView *imgv3 = [[UIImageView alloc] init];
    imgv3.backgroundColor = [UIColor appLineColor];
    imgv3.frame = CGRectMake(10, CGRectGetMaxY(_emailTF.frame)+1, squareView.frame.size.width-20, 1);
    [squareView addSubview:imgv3];

    
    
    [squareView addSubview:_emailTF];

    
    
    
    
    // 修改密码
    UIButton *loginBut = [UIButton buttonWithType:UIButtonTypeCustom];
    [loginBut setFrame:CGRectMake(0, 260, self.view.width, 40)];
    [loginBut setTitle:@"修改密码" forState:UIControlStateNormal];

    [loginBut setBackgroundColor:[UIColor whiteColor]];
    [loginBut addTarget:self action:@selector(changePsd) forControlEvents:UIControlEventTouchUpInside];
    [loginBut setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
    [loginBut setImage:[UIImage imageNamed:@"lock"] forState:UIControlStateNormal];
    loginBut.imageEdgeInsets = UIEdgeInsetsMake(0.0, -180, 0.0, 0.0);
    loginBut.titleEdgeInsets = UIEdgeInsetsMake(0.0, -145.0, 0.0, 0.0);


    
    
    [self.view addSubview:loginBut];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)changePsd
{
    ChangePsdVC *cpsd = [[ChangePsdVC alloc]init];
    
    [self.navigationController pushViewController:cpsd animated:YES];

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
