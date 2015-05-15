//
//  AddAdressVC.m
//  WestElectromechanical
//
//  Created by 夏亚峰 on 15/5/6.
//  Copyright (c) 1515年 zuo. All rights reserved.
//

#import "AddAdressVC.h"
#import "PAPickView.h"
#import "RDVTabBarController.h"
#import "NSString+val.h"
#import "WEHTTPHandler.h"
#import "AccountHanler.h"
#import "GCPlaceholderTextView.h"


@interface AddAdressVC ()<UITextFieldDelegate,UITextViewDelegate>{

UITextField *phoneNumTF,*streetAdressTF,*emadilCodeTf,*valCodeTf,*userNameTf,*addressTf;
    WEHTTPHandler *we;
    GCPlaceholderTextView *tv;
   }
@property(nonatomic,strong)PAPickView *pickView;
@end

@implementation AddAdressVC




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
    
    self.title =@"添加地址";
    we = [[WEHTTPHandler alloc]init];
       self.view.backgroundColor = SET_COLOR(234.0, 234.0, 234.0);
    UIView * squareView = [[UIView alloc]initWithFrame:CGRectMake(15, 80, SCREEN_WIDTH-30, 90)];
    squareView.backgroundColor = [UIColor whiteColor];
    squareView.layer.cornerRadius =4;
    [self.view addSubview:squareView];
    
    

    
    UIView * squareView2 = [[UIView alloc]initWithFrame:CGRectMake(15, CGRectGetMaxY(squareView.frame)+15, SCREEN_WIDTH-30, 130)];
    squareView2.backgroundColor = [UIColor whiteColor];
    squareView2.layer.cornerRadius =4;
    [self.view addSubview:squareView2];

    
    
    //收货人姓名
    
    userNameTf = [[UITextField alloc] initWithFrame:CGRectMake(15, 5, SCREEN_WIDTH-30, 40)];
    [userNameTf setBorderStyle:UITextBorderStyleNone];
    userNameTf.textColor = [UIColor blackColor];
    [userNameTf setPlaceholder:@"收货人姓名（4-20个字符）"];
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
    
    
    
    
    
    // 手机号
    phoneNumTF = [[UITextField alloc] initWithFrame:CGRectMake(15, CGRectGetMaxY(userNameTf.frame), SCREEN_WIDTH-30, 40)];
    [phoneNumTF setBorderStyle:UITextBorderStyleNone];
    phoneNumTF.textColor = [UIColor blackColor];
    [phoneNumTF setPlaceholder:@"手机号（11位）"];
    [phoneNumTF setKeyboardType:UIKeyboardTypeDefault];
    [phoneNumTF setClearButtonMode:UITextFieldViewModeWhileEditing];
    //    [LogNmTextF setTextAlignment:NSTextAlignmentCenter];
    [phoneNumTF setContentVerticalAlignment:UIControlContentVerticalAlignmentCenter];
    UIButton *but1 = [UIButton buttonWithType:UIButtonTypeCustom];
    [but1 setImage:[UIImage imageNamed:@"person_phone"] forState:UIControlStateNormal];
    [but1 setBounds:CGRectMake(0, 0, 50, 40)];
    [but1 setUserInteractionEnabled:NO];
    
    phoneNumTF.leftViewMode = UITextFieldViewModeAlways;
    [phoneNumTF setLeftView:but1];
    [phoneNumTF setDelegate:self];
    [squareView addSubview:phoneNumTF];
    
    
    
    // 地域信息
    addressTf = [[UITextField alloc] initWithFrame:CGRectMake(15, 5, SCREEN_WIDTH-30, 40)];
    [addressTf setBorderStyle:UITextBorderStyleNone];
    addressTf.textColor = [UIColor blackColor];
    [addressTf setPlaceholder:@"地域信息"];
    [addressTf setKeyboardType:UIKeyboardTypeDefault];
    [addressTf setClearButtonMode:UITextFieldViewModeWhileEditing];
    //    [LogNmTextF setTextAlignment:NSTextAlignmentCenter];
    [addressTf setContentVerticalAlignment:UIControlContentVerticalAlignmentCenter];
    UIButton *but2 = [UIButton buttonWithType:UIButtonTypeCustom];
    [but2 setImage:[UIImage imageNamed:@"Person_location"] forState:UIControlStateNormal];
    [but2 setBounds:CGRectMake(0, 0, 50, 40)];
     [but2 setUserInteractionEnabled:NO];
    
    addressTf.leftViewMode = UITextFieldViewModeAlways;
    [addressTf setLeftView:but2];
    
    UIButton *butright = [UIButton buttonWithType:UIButtonTypeCustom];
    [butright setImage:[UIImage imageNamed:@"Person_arrow_right"] forState:UIControlStateNormal];
    [butright setBounds:CGRectMake(0, 0, 80, 25)];
      addressTf.rightViewMode = UITextFieldViewModeAlways;
    [addressTf setRightView:butright];
    [butright addTarget:self action:@selector(locationBtnClick) forControlEvents:UIControlEventTouchUpInside];

    [addressTf setDelegate:self];
    [squareView2 addSubview:addressTf];
    
    UIImageView *imgv2 = [[UIImageView alloc] init];
    imgv2.frame = CGRectMake(10, CGRectGetMaxY(addressTf.frame)+1, squareView.frame.size.width-20, 1);
    imgv2.backgroundColor = [UIColor appLineColor];
    [squareView2 addSubview:imgv2];
    
    
    
    
    
    
  tv=[[GCPlaceholderTextView alloc] initWithFrame:CGRectMake(60, CGRectGetMaxY(addressTf.frame)+5, 220, 35)];
    tv.contentInset = UIEdgeInsetsMake(0, 0, 0, 0);
    tv.delegate = self;
    
    tv.keyboardType = UIKeyboardTypeDefault;
    tv.placeholder=@"街道门牌信息";
    tv.autoresizingMask =  UIViewAutoresizingFlexibleHeight;
    tv.scrollEnabled = YES;//是否可以拖动
    
    
    UIButton *pwdBut = [UIButton buttonWithType:UIButtonTypeCustom];
    [pwdBut setImage:[UIImage imageNamed:@"Person_streetnum"] forState:UIControlStateNormal];
    pwdBut.frame =CGRectMake(CGRectGetMinX(tv.frame)-45, CGRectGetMinY(tv.frame), 50, 40);
    [pwdBut setUserInteractionEnabled:NO];
    [squareView2 addSubview:pwdBut];

    
    tv.font= [UIFont systemFontOfSize:17];
    tv.layer.borderColor = [UIColor whiteColor].CGColor;
    
    tv.layer.borderWidth =0.8;
    
    [squareView2 addSubview:tv];
    
    
    UIImageView *imgv3 = [[UIImageView alloc] init];
    imgv3.frame = CGRectMake(10, CGRectGetMaxY(tv.frame)+1, squareView.frame.size.width-20, 1);
    imgv3.backgroundColor = [UIColor appLineColor];
    [squareView2 addSubview:imgv3];

    
    
    // 邮政编码
    emadilCodeTf = [[UITextField alloc] initWithFrame:CGRectMake(15, CGRectGetMaxY(tv.frame), SCREEN_WIDTH-30, 40)];
    [emadilCodeTf setBorderStyle:UITextBorderStyleNone];
    emadilCodeTf.textColor = [UIColor blackColor];
    [emadilCodeTf setClearButtonMode:UITextFieldViewModeWhileEditing];
    [emadilCodeTf setContentVerticalAlignment:UIControlContentVerticalAlignmentCenter];
    UIButton *surepwdBut = [UIButton buttonWithType:UIButtonTypeCustom];
    [surepwdBut setImage:[UIImage imageNamed:@"Person_emailnum"] forState:UIControlStateNormal];
    [surepwdBut setBounds:CGRectMake(0, 0, 50, 40)];
    emadilCodeTf.leftViewMode = UITextFieldViewModeAlways;
    [emadilCodeTf setLeftView:surepwdBut];
    [surepwdBut setUserInteractionEnabled:NO];
    [emadilCodeTf setDelegate:self];
    emadilCodeTf.returnKeyType=UIReturnKeyGo;//返回键的类型
    [emadilCodeTf setPlaceholder:@"邮政编码"]; //默认显示的字
    //    [pwdNmTextF setTextAlignment:NSTextAlignmentCenter];
    [squareView2 addSubview:emadilCodeTf];
    
    
    
    
      // 保存
    UIButton *loginBut = [UIButton buttonWithType:UIButtonTypeCustom];
    [loginBut setFrame:CGRectMake(15, 265+90, SCREEN_WIDTH-30, 40)];
    [loginBut setTitle:@"保存" forState:UIControlStateNormal];
    [loginBut setBackgroundColor:[UIColor pumpkinColor]];
    [loginBut addTarget:self action:@selector(saveBtnclick) forControlEvents:UIControlEventTouchUpInside];
    [loginBut setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [self.view addSubview:loginBut];
    
    
    PAPickView *pick =[[PAPickView alloc]initWithFrame:CGRectMake(0, SCREEN_HEIGHT, SCREEN_WIDTH, 260)];
    pick.backgroundColor = SET_COLOR(234.0, 234.0, 234.0);
    [pick setPAPickViewBlock:^(NSInteger tag) {
        if (tag == 1000) {
            [_pickView cancelPicker];
        }else{
            NSLog(@"%@赶紧出来 %@ %@",_pickView.location.state,_pickView.location.city,_pickView.location.district);
            addressTf.text =[NSString stringWithFormat:@"%@%@%@",_pickView.location.state,_pickView.location.city,_pickView.location.district];
            [_pickView cancelPicker];
        }
    }];
    _pickView =pick;
    [self.view addSubview:pick];
    
    
    
    //  添加地址和修改地址  由于界面一样   写在了一个类里
    
    if (self.am) {
        self.title =@"修改地址";
        
        userNameTf.text =self.am.u_name;
        phoneNumTF.text =self.am.mobile;
        addressTf.text =self.am.a_address;
        streetAdressTF.text =self.am.doorplate;
        emadilCodeTf.text =self.am.postalcode;
        
    }
   
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)saveBtnclick
{
    
    if (self.am) {

        [we  executeUpdateAdressTaskWithUserId:[AccountHanler userId] withUserName:userNameTf.text withMobile:phoneNumTF.text withAddress:addressTf.text withDoorPlate:tv.text withPostalcode:emadilCodeTf.text withPhone:@"0398-2963733" withAdressHandleId:self.am.a_id Success:^(id obj) {

            
            DLog(@"输出我的修改地址信息%@",obj);
            

            
            
        } failed:^(id obj) {
        
            
            
        }];
        
    }else{
        

    [we executeAddAdressTaskWithUserId:[AccountHanler userId] withUserName:userNameTf.text withMobile:phoneNumTF.text withAddress:addressTf.text withDoorPlate:tv.text withPostalcode:emadilCodeTf.text withPhone:phoneNumTF.text Success:^(id obj) {
        
        DLog(@"输出保存地址是否成功%@",obj);
        
        
        if ([[obj  objectForKey:@"message"] isEqualToString:@"0"]) {
            WARN_ALERT(@"保存成功");
        }
      
    } failed:^(id obj) {
        }];
    }
}
-(void)locationBtnClick
{

    [_pickView showInView:self.view];
}


- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField
{

    return YES;
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
        
    }else if (textField==phoneNumTF){
        if ([NSString phoneValidate:phoneNumTF.text]==NO) {
            WARN_ALERT(@"检查你的电话号码");
            return;
        }
        
        
    }
    
    
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
