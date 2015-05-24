//
//  CartCommitOrderVC.m
//  WestElectromechanical
//
//  Created by 夏亚峰 on 15/5/20.
//  Copyright (c) 2015年 zuo. All rights reserved.
//

#import "CartCommitOrderVC.h"
#import "RDVTabBarController.h"


#define key @"MIICoTAbBgkqhkiG9w0BBQMwDgQIdOc2kI1/NhECAggABIICgMFk8eloJYIcI8LZz9U0w1UYAzEDrIvbuX7L6kNrW3Bt5zdSEO4SuxnWeJup6wxgo6NAKFMxhbF61coeQsph+8njp0o0CxGeXLM2s8kX3vFdkGzH7HkHvwzzMo9CZkGOkE3YYRWns2Ynery0LcHZa2azNGOpS7ou6rrBo62jibUGpUVykq2L+Oc6T+2Ij5f1vlKgafjSIBK+15TpV9zajYjHeaVwo0WKHQ1ggzeMjQVi+faTjtGILTJfc1emqpjvl/RD30hY1qwSXemdOxBiYlQgtdvApGOCobzBE8L9VWfg0/tLSapGHAoJYt3VG4AIBWE0sCQ0uIEbbyjxPw5CoBmLiOIqezUOs8lywSIAnBK2aSq813QxM1xSFr/A39buDKdTNMxQVnSwkpNGEUuvdROS0DRMhKkcrGMdIVeN+cyKn8Hu8dePQMfo96AizeU59EDReDsMbKE7jK+iDIQnGunJi9IfxyVg87A+WU+AC0wWKc+ri+mR6Cki5EHPMjSzhmWitjd5mDRBm0Rpl9iu/7jMyk5pKysOjq+/boVojFdr7Kjqeq2eORj6NpL78HpndlvKRbBtjVh1Zh//091yTcng9YrTG4le0IEH9XQCZm4xYTMTjF0IxqqlPrw5UKcy5QOpIDrDlOY/WpqvsxQFQWEagM8ao6JdhTbWtz21eZG65hO7mjLaDOnUu+InzgUndpuU0KfPynPFPlvwSEX+Fc67tIhs2aJKP3sR+lOfbx9caaMdDyk74BzzKe9XiCuZio0HtQtxZOk+o5Sj84e22GmuZ4+tYSzz3qYKUJfoaOabCP6F93rOhgo6Q3+N8G2G7oQsHwG8W/He4qsBOlOMDGA="
@interface CartCommitOrderVC ()

@end

@implementation CartCommitOrderVC
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
    
    self.title =@"提交订单";
    [self  addUI];

 }

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    }
-(void)addUI
{

    UILabel *orderNumLa = [[UILabel alloc]initWithFrame:CGRectMake(10, 74, SCREEN_WIDTH, 30)];
    orderNumLa.textColor = [UIColor lightGrayColor];
    
    orderNumLa.text =[NSString stringWithFormat:@"订单号：%@",self.orderNum];
    
    orderNumLa.font = [UIFont systemFontOfSize:14];
    [self.view addSubview:orderNumLa];
     UILabel *priceLa = [[UILabel alloc]initWithFrame:CGRectMake(10, CGRectGetMaxY(orderNumLa.frame)+10, SCREEN_WIDTH, 30)];
    
    priceLa.textColor = [UIColor lightGrayColor];
    priceLa.text =[NSString stringWithFormat:@"价格：%@",self.allPrice];
    priceLa.font = [UIFont systemFontOfSize:14];

    [self.view addSubview:priceLa];

    
    
  UIImageView *imgv= [[UIImageView alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(priceLa.frame)+15, SCREEN_WIDTH, 1)];
    
     imgv.backgroundColor =  [UIColor appLineColor];
    
    [self.view  addSubview:imgv];
    
    
    
    UILabel * succeedLa = [[UILabel alloc]initWithFrame:CGRectMake(SCREEN_WIDTH/2-75, CGRectGetMaxY(imgv.frame)+25, 150, 70)];
    succeedLa.text =@"       恭喜你       \n订单提交成功";
    succeedLa.numberOfLines =2;
    succeedLa.textColor =[UIColor darkGrayColor];
    [self.view addSubview:succeedLa];


    
   UIButton * instantPayBtn = [[UIButton alloc] initWithFrame:CGRectMake(35, CGRectGetMaxY(succeedLa.frame)+10, 110, 30)];
    [instantPayBtn setTitle:@"支付宝立即支付" forState:UIControlStateNormal];
    
    instantPayBtn.backgroundColor = [UIColor orangeColor];
    
    instantPayBtn.titleLabel.font = [UIFont systemFontOfSize:15];
    [instantPayBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [instantPayBtn addTarget:self action:@selector(instantPayBtnClick) forControlEvents:UIControlEventTouchUpInside];
       [self.view addSubview:instantPayBtn];
    
    
     UIButton *laterBtn = [[UIButton alloc] initWithFrame:CGRectMake(SCREEN_WIDTH-110-35, CGRectGetMaxY(succeedLa.frame)+10, 110, 30)];
    [laterBtn setTitle:@"稍后支付" forState:UIControlStateNormal];
    laterBtn.titleLabel.font = [UIFont systemFontOfSize:15];

    [laterBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [laterBtn addTarget:self action:@selector(laterBtnClick) forControlEvents:UIControlEventTouchUpInside];
    
    [laterBtn setBackgroundImage:[UIImage imageNamed:@"Person_BlackLine"] forState:UIControlStateNormal];
    [self.view addSubview:laterBtn];
   
    
    [self.view addSubview:laterBtn];
    
    
}
-(void)instantPayBtnClick
{

}

-(void)laterBtnClick
{
    
}

@end
