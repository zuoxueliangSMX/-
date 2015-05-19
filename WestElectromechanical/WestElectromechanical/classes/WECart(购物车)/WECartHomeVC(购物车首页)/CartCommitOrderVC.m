//
//  CartCommitOrderVC.m
//  WestElectromechanical
//
//  Created by 夏亚峰 on 15/5/20.
//  Copyright (c) 2015年 zuo. All rights reserved.
//

#import "CartCommitOrderVC.h"

@interface CartCommitOrderVC ()

@end

@implementation CartCommitOrderVC

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
    
    orderNumLa.text =@"订单号：2387947238971504";
    
    orderNumLa.font = [UIFont systemFontOfSize:14];
    [self.view addSubview:orderNumLa];
     UILabel *priceLa = [[UILabel alloc]initWithFrame:CGRectMake(10, CGRectGetMaxY(orderNumLa.frame)+10, SCREEN_WIDTH, 30)];
    
    priceLa.textColor = [UIColor lightGrayColor];
    priceLa.text =@"价格：10000";
    priceLa.font = [UIFont systemFontOfSize:14];

    [self.view addSubview:priceLa];

    
    
  UIImageView *imgv= [[UIImageView alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(priceLa.frame)+15, SCREEN_WIDTH, 1)];
    
     imgv.backgroundColor =  [UIColor appLineColor];
    
    [self.view  addSubview:imgv];
    
    
    
    UILabel * succeedLa = [[UILabel alloc]initWithFrame:CGRectMake(SCREEN_WIDTH/2-75, CGRectGetMaxY(imgv.frame)+25, 150, 70)];
    succeedLa.text =@"      恭喜你 \n订单提交成功";
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
