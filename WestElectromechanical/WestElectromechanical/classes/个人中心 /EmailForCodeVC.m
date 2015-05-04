//
//  EmailForCodeVC.m
//  WestElectromechanical
//
//  Created by 夏亚峰 on 15/5/4.
//  Copyright (c) 2015年 zuo. All rights reserved.
//

#import "EmailForCodeVC.h"
#define kGap 10

@interface EmailForCodeVC ()<UITextFieldDelegate>
@property (strong, nonatomic) UITextField *namefi;
@end

@implementation EmailForCodeVC

- (void)viewDidLoad {
    [super viewDidLoad];
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
    UIView *left  = [[UIView alloc]initWithFrame:CGRectMake(10, 0, 20, 20)];
    UIImageView *leftimg = [[UIImageView alloc]initWithFrame:CGRectMake(10, 0, 20, 20)];
    [leftimg setImage: [UIImage imageNamed:@"e"]];
    _namefi.leftViewMode = UITextFieldViewModeAlways;
    
    [left addSubview:leftimg];
    _namefi.leftView = left;
    [self.view addSubview:_namefi];
    
    
    
    
    
    UIButton *loginBu = [UIButton buttonWithType:UIButtonTypeCustom];
    [loginBu setTitle:@"确定" forState:UIControlStateNormal];
    [loginBu setTitle:@"" forState:UIControlStateHighlighted];
    [loginBu setFrame:CGRectMake((self.view.frame.size.width-240)/2, CGRectGetMaxY(_namefi.frame)+20, 240, 44)];
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

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)sureclick{




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
