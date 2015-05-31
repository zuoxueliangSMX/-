//
//  ChangePsdVC.m
//  WestElectromechanical
//
//  Created by 夏亚峰 on 15/5/5.
//  Copyright (c) 2015年 zuo. All rights reserved.
//

#import "ChangePsdVC.h"
#import "WEHTTPHandler.h"
#import "AccountHanler.h"
#import "RDVTabBarController.h"
@interface ChangePsdVC ()<UITextFieldDelegate>

@property (strong, nonatomic) UITextField *oldPsdTF,*surePsdTF;
@property (strong, nonatomic) UITextField *NewPsdTF;
@end

@implementation ChangePsdVC

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


- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title =@"修改密码";
    self.view.backgroundColor = SET_COLOR(234.0, 234.0, 234.0);
    UIView * squareView = [[UIView alloc]initWithFrame:CGRectMake(15, 80, SCREEN_WIDTH-30, 160)];
    squareView.backgroundColor = [UIColor whiteColor];
    squareView.layer.cornerRadius =4;
    [self.view addSubview:squareView];
    
    
    
    
    _oldPsdTF = [[UITextField alloc] initWithFrame:CGRectMake(10+10,5, self.view.frame.size.width-2*10-30, 50)];
    _oldPsdTF.placeholder = @"       输入您的原始密码";
    [_oldPsdTF setValue:[UIFont boldSystemFontOfSize:14] forKeyPath:@"_placeholderLabel.font"];
    
    [_oldPsdTF setKeyboardType:UIKeyboardTypeDefault];
    
    [_oldPsdTF.layer setMasksToBounds:YES];
    [_oldPsdTF.layer setCornerRadius:5];
    _oldPsdTF.delegate =self;
    [_oldPsdTF setClearButtonMode:UITextFieldViewModeWhileEditing];
    [_oldPsdTF setContentVerticalAlignment:UIControlContentVerticalAlignmentCenter];
    UIView *left  = [[UIView alloc]initWithFrame:CGRectMake(10, 0, 30, 30)];
    UIImageView *leftimg = [[UIImageView alloc]initWithFrame:CGRectMake(10, 0, 20, 20)];
    [leftimg setImage: [UIImage imageNamed:@"Person_lock"]];
    _oldPsdTF.leftViewMode = UITextFieldViewModeAlways;
    
    UIImageView *imgv1 = [[UIImageView alloc] init];
    imgv1.backgroundColor = [UIColor appLineColor];
    imgv1.frame = CGRectMake(10, CGRectGetMaxY(_oldPsdTF.frame)+1, squareView.frame.size.width-20, 1);
    [squareView addSubview:imgv1];
    
    
    [left addSubview:leftimg];
    _oldPsdTF.leftView = left;
    [squareView addSubview:_oldPsdTF];
    
    
    
    UITextField *NewTF = [[UITextField alloc] initWithFrame:CGRectMake(10+10, CGRectGetMaxY(_oldPsdTF.frame), self.view.frame.size.width-2*10-30, 50)];
    [NewTF setPlaceholder:@"        新密码（6-11字符）"];
    
    
    
    [NewTF setValue:[UIFont boldSystemFontOfSize:14] forKeyPath:@"_placeholderLabel.font"];
    [NewTF setSecureTextEntry:YES];
    [NewTF setClearButtonMode:UITextFieldViewModeWhileEditing];
    [NewTF setContentVerticalAlignment:UIControlContentVerticalAlignmentCenter];
    [NewTF setDelegate:self];
    
    [NewTF.layer setMasksToBounds:YES];
    [NewTF.layer setCornerRadius:5];
    UIView *psdleft  = [[UIView alloc]initWithFrame:CGRectMake(10, 0, 30, 30)];
    UIImageView *psdleftimg = [[UIImageView alloc]initWithFrame:CGRectMake(10, 0, 20, 20)];
    [psdleftimg setImage: [UIImage imageNamed:@"Person_lock"]];
    NewTF.leftViewMode = UITextFieldViewModeAlways;
    [psdleft addSubview:psdleftimg];
    NewTF.leftView = psdleft;
    _NewPsdTF = NewTF;
    UIImageView *imgv2 = [[UIImageView alloc] init];
    imgv2.backgroundColor = [UIColor appLineColor];
    imgv2.frame = CGRectMake(10, CGRectGetMaxY(NewTF.frame)+1, squareView.frame.size.width-20, 1);
    [squareView addSubview:imgv2];
    
    
    
    
    [squareView addSubview:NewTF];
    
    
    
    
    
    _surePsdTF = [[UITextField alloc] initWithFrame:CGRectMake(10+10,CGRectGetMaxY(NewTF.frame), self.view.frame.size.width-20-30, 50)];
    _surePsdTF.placeholder = @"       确认新密码";
    [_surePsdTF setValue:[UIFont boldSystemFontOfSize:14] forKeyPath:@"_placeholderLabel.font"];
    
    [_surePsdTF setKeyboardType:UIKeyboardTypeDefault];
    
    [_surePsdTF.layer setMasksToBounds:YES];
    [_surePsdTF.layer setCornerRadius:5];
    _surePsdTF.delegate =self;
    [_surePsdTF setClearButtonMode:UITextFieldViewModeWhileEditing];
    [_surePsdTF setContentVerticalAlignment:UIControlContentVerticalAlignmentCenter];
    UIView *left2  = [[UIView alloc]initWithFrame:CGRectMake(10, 0, 30, 30)];
    UIImageView *leftimg2 = [[UIImageView alloc]initWithFrame:CGRectMake(10, 0, 20, 20)];
    [leftimg2 setImage: [UIImage imageNamed:@"Person_lock"]];
    _surePsdTF.leftViewMode = UITextFieldViewModeAlways;
    [left2 addSubview:leftimg2];
    _surePsdTF.leftView = left2;
    
    UIImageView *imgv3 = [[UIImageView alloc] init];
    imgv3.backgroundColor = [UIColor appLineColor];
    imgv3.frame = CGRectMake(10, CGRectGetMaxY(_surePsdTF.frame)+1, squareView.frame.size.width-20, 1);
    [squareView addSubview:imgv3];
    
    
    
    [squareView addSubview:_surePsdTF];
    
    
    
    // 确定
    UIButton *sureBut = [UIButton buttonWithType:UIButtonTypeCustom];
    [sureBut setFrame:CGRectMake(20, 260, SCREEN_WIDTH-40, 40)];
    [sureBut setTitle:@"确定" forState:UIControlStateNormal];
    [sureBut setBackgroundColor:[UIColor redColor]];
    [sureBut addTarget:self action:@selector(sureBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [sureBut setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [self.view addSubview:sureBut];


}


- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    
    [textField resignFirstResponder];
    return YES;
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)sureBtnClick
{
    if (!([ _NewPsdTF.text isEqualToString:_surePsdTF.text]&&_surePsdTF.text!=nil)) {
        
        ALERT_WARN(@"两次输入的密码不一致,请重新输入");
        return;
    }

    WEHTTPHandler  *weh = [[WEHTTPHandler alloc]init];
    if ([AccountHanler loginState]==0) {
        WARN_ALERT(@"请先登录");
    }
    [weh executeUpdateUserPwdWithUserId:[AccountHanler userId] withOrderPwd:_oldPsdTF.text withNewPwd:_surePsdTF.text Success:^(id obj) {
        if ([[obj objectForKey:@"message"] isEqualToString:@"0"]) {
            
            WARN_ALERT(@"修改成功");
            
            [self.navigationController popToViewController:[self.navigationController.viewControllers objectAtIndex:0] animated:YES];
        }
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
