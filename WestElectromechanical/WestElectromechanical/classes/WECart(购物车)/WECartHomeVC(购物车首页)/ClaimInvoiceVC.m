//
//  ClaimInvoiceVC.m
//  WestElectromechanical
//
//  Created by 夏亚峰 on 15/5/15.
//  Copyright (c) 2015年 zuo. All rights reserved.
//

#import "ClaimInvoiceVC.h"
#import "NSString+val.h"
#import "AccountHanler.h"
#import "GCPlaceholderTextView.h"
#import "RDVTabBarController.h"
@interface ClaimInvoiceVC ()<UITextFieldDelegate,UITextViewDelegate>{
    
    UITextField *invoidceAddressTf,*streetAdressTF,*emadilCodeTf,*valCodeTf,*invoiceHeadeTf,*addressTf;
    GCPlaceholderTextView *tv;
    
     UIButton * _currentbtn;
    
    UIView * squareView2 ;
}
@end
@implementation ClaimInvoiceVC
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
    self.title =@"索要发票";
    self.view.backgroundColor = SET_COLOR(234.0, 234.0, 234.0);
    
   
    UIView * squareView = [[UIView alloc]initWithFrame:CGRectMake(15, 80, SCREEN_WIDTH-30, 130)];
    squareView.backgroundColor = [UIColor whiteColor];
    squareView.layer.cornerRadius =4;
    [self.view addSubview:squareView];
   squareView2 = [[UIView alloc]initWithFrame:CGRectMake(15, CGRectGetMaxY(squareView.frame)+15, SCREEN_WIDTH-30, 90)];
    squareView2.backgroundColor = [UIColor whiteColor];
     squareView2.hidden =NO;
    squareView2.layer.cornerRadius =4;
    [self.view addSubview:squareView2];
    
    
    
 
    
    
    
    //发票抬头
    
    invoiceHeadeTf = [[UITextField alloc] initWithFrame:CGRectMake(10, 5, SCREEN_WIDTH-30, 40)];
    [invoiceHeadeTf setBorderStyle:UITextBorderStyleNone];
    invoiceHeadeTf.textColor = [UIColor blackColor];
    [invoiceHeadeTf setPlaceholder:@"发票抬头"];
    [invoiceHeadeTf setKeyboardType:UIKeyboardTypeDefault];
    [invoiceHeadeTf setClearButtonMode:UITextFieldViewModeWhileEditing];
    //    [LogNmTextF setTextAlignment:NSTextAlignmentCenter];
    [invoiceHeadeTf setContentVerticalAlignment:UIControlContentVerticalAlignmentCenter];
    UIButton *but0 = [UIButton buttonWithType:UIButtonTypeCustom];
    [but0 setImage:[UIImage imageNamed:@"invoice_Header"] forState:UIControlStateNormal];
    [but0 setFrame:CGRectMake(0, 0, 50, 40)];
    [but0 setUserInteractionEnabled:NO];
    
    invoiceHeadeTf.leftViewMode = UITextFieldViewModeAlways;
    [invoiceHeadeTf setLeftView:but0];
    [invoiceHeadeTf setDelegate:self];
    [squareView2 addSubview:invoiceHeadeTf];
    
    UIImageView *imgv0 = [[UIImageView alloc] init];
    imgv0.backgroundColor = [UIColor darkGrayColor];
    
    imgv0.frame = CGRectMake(10, CGRectGetMaxY(invoiceHeadeTf.frame)+1, squareView.frame.size.width-20, 0.5);
    [squareView2 addSubview:imgv0];
    
    
    
    
    
    // 发票地址
    invoidceAddressTf = [[UITextField alloc] initWithFrame:CGRectMake(10, CGRectGetMaxY(invoiceHeadeTf.frame), SCREEN_WIDTH-30, 40)];
    [invoidceAddressTf setBorderStyle:UITextBorderStyleNone];
    invoidceAddressTf.textColor = [UIColor blackColor];
    [invoidceAddressTf setPlaceholder:@"发票地址"];
    [invoidceAddressTf setKeyboardType:UIKeyboardTypeDefault];
    [invoidceAddressTf setClearButtonMode:UITextFieldViewModeWhileEditing];
    //    [LogNmTextF setTextAlignment:NSTextAlignmentCenter];
    [invoidceAddressTf setContentVerticalAlignment:UIControlContentVerticalAlignmentCenter];
    UIButton *but1 = [UIButton buttonWithType:UIButtonTypeCustom];
    [but1 setImage:[UIImage imageNamed:@"invoice_address"] forState:UIControlStateNormal];
    [but1 setBounds:CGRectMake(0, 0, 50, 40)];
    [but1 setUserInteractionEnabled:NO];
    
    invoidceAddressTf.leftViewMode = UITextFieldViewModeAlways;
    [invoidceAddressTf setLeftView:but1];
    [invoidceAddressTf setDelegate:self];
    [squareView2 addSubview:invoidceAddressTf];
    
    
    
    NSArray * titileArr =@[@"无需发票",@"普票",@"增值发票"];
    for (int i =0; i <3; i++) {
        
        UIButton *roundBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        roundBtn.backgroundColor =[UIColor clearColor];
        [roundBtn  addTarget:self action:@selector(click:) forControlEvents:  UIControlEventTouchUpInside];
        [roundBtn setImage:[UIImage imageNamed:@"invoice_selected"] forState:UIControlStateSelected];
        [roundBtn  setImage:[UIImage imageNamed:@"invoice_notSelected"] forState:UIControlStateNormal];
        roundBtn.tag =100+i;
         roundBtn.frame = CGRectMake(15, 10+i*(50/2.2+20), 50/2.2, 50/2.2);
         UILabel * roundBtnLa = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(roundBtn.frame)+10, 10+i*(50/2.2+20), 80, 50/2.2)];
        roundBtnLa.textColor = [UIColor darkGrayColor];
        roundBtnLa.text = [titileArr objectAtIndex:i];
        
        
            UIImageView *imgv3 = [[UIImageView alloc] init];
            imgv3.frame = CGRectMake(10, 10+50/2.2+10+i*(50/2.2+20), squareView.frame.size.width-20, 0.5);
            imgv3.tag =i+200;
            imgv3.backgroundColor = [UIColor darkGrayColor];
            [squareView addSubview:imgv3];
   
        
        
        [squareView addSubview:roundBtn];
        [squareView  addSubview:roundBtnLa];
    }
      UIImageView * imgv3 =(UIImageView*)[squareView viewWithTag:202];
    
      [imgv3  removeFromSuperview];
    // 保存
    UIButton *sureBut = [UIButton buttonWithType:UIButtonTypeCustom];
    [sureBut setFrame:CGRectMake(15, 265+90, SCREEN_WIDTH-30, 40)];
    [sureBut setTitle:@"确定" forState:UIControlStateNormal];
    [sureBut setBackgroundColor:[UIColor redColor]];
    [sureBut addTarget:self action:@selector(saveBtnclick) forControlEvents:UIControlEventTouchUpInside];
    [sureBut setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [self.view addSubview:sureBut];
    
    
    
    
    
}

-(void)click:(UIButton*)btn
{
    
        
    
    
    _currentbtn.selected =NO;  //  当前的BTN  设为no
    btn.selected =YES;         //显示  当前button选中状态
    _currentbtn =btn;
    DLog(@"%ld",_currentbtn.tag);
    if (btn.tag==100&&btn.selected==YES) {
        squareView2.hidden =YES;
    }else{
    
    squareView2.hidden =NO;
    }
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)saveBtnclick
{
    if (_currentbtn.tag==100) {
        
        [AccountHanler setInvoiceAdress:nil];
        [AccountHanler setInvoiceHead:nil];
         [AccountHanler setInvoiceStyle:@"无需发票"];
          
    }else
    {
        if (invoiceHeadeTf.text.length==0||invoidceAddressTf.text.length==0) {
            
            WARN_ALERT(@"检查你的输入");
            return;
        }
        
        
        [AccountHanler setInvoiceAdress:invoidceAddressTf.text];
        [AccountHanler setInvoiceHead:invoiceHeadeTf.text];
        
        if (_currentbtn.tag==101) {
             [AccountHanler setInvoiceStyle:@"普票"];
        }else if(_currentbtn.tag==102) {
        
        [AccountHanler setInvoiceStyle:@"增值发票"];
        
        }
       
       
    
    
    }
    
     [self.navigationController popViewControllerAnimated:YES];
}


- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField
{
    
    return YES;
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    
    [textField resignFirstResponder];
    return YES;
    
}
-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [self.view endEditing:YES];
}


@end
