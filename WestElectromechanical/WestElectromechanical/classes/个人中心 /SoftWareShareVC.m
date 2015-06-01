//
//  SoftWareShareVC.m
//  WestElectromechanical
//
//  Created by 夏亚峰 on 15/6/1.
//  Copyright (c) 2015年 zuo. All rights reserved.
//

#import "SoftWareShareVC.h"
#import "GCPlaceholderTextView.h"

@interface SoftWareShareVC ()<UITextViewDelegate >
{
    GCPlaceholderTextView *tv;
}
@end

@implementation SoftWareShareVC

- (void)viewDidLoad {
    [super viewDidLoad];
    VIEW_BACKGROUND
    
    
   tv=[[GCPlaceholderTextView alloc] initWithFrame:CGRectMake(10,64+10,SCREEN_WIDTH-20, 150)];
    tv.contentInset = UIEdgeInsetsMake(-70, 0, 0, 0);
    tv.delegate = self;
    tv.backgroundColor = [UIColor whiteColor];
    tv.placeholder=@"西域机电分享";
    
    
    tv.font= [UIFont systemFontOfSize:13];
    tv.layer.borderColor = [UIColor lightGrayColor].CGColor;
    tv.layer.cornerRadius =4.0;
  
    
    tv.layer.borderWidth =0.8;
    
    
    [self.view addSubview:tv];
    
   
    UIImageView *imgv1 = [[UIImageView alloc] init];
    imgv1.frame = CGRectMake(0, CGRectGetMaxY(tv.frame)+20,(VIEW_WIDETH-120)/2, 1);
    imgv1.backgroundColor = [UIColor appLineColor];
    [self.view addSubview:imgv1];
    
    UILabel *sharela = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(imgv1.frame)+20,CGRectGetMaxY(tv.frame) , 80, 40)];
    sharela.text =@"分享到";
    sharela.textAlignment =NSTextAlignmentCenter;
    sharela.textColor =[UIColor darkGrayColor];
    [self.view  addSubview:sharela];
    
    
    
    
    UIImageView *imgv2 = [[UIImageView alloc] init];
    imgv2.frame = CGRectMake(VIEW_WIDETH-(VIEW_WIDETH-120)/2, CGRectGetMaxY(tv.frame)+20,(VIEW_WIDETH-120)/2, 1);
    imgv2.backgroundColor = [UIColor appLineColor];
    [self.view addSubview:imgv2];

    
    
    
    
    
    
    UIButton *shareBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [shareBtn setFrame:CGRectMake(15, CGRectGetMaxY(sharela.frame)+20, SCREEN_WIDTH-30, 40)];
    [shareBtn setTitle:@"分享" forState:UIControlStateNormal];
    [shareBtn setBackgroundColor:[UIColor redColor]];
    [shareBtn addTarget:self action:@selector(shareBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [shareBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [self.view addSubview:shareBtn];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    
    
    
    [self.view endEditing:YES];
    
    
    
}
- (void)textViewDidBeginEditing:(UITextView *)textView {
    
}

- (void)textViewDidEndEditing:(UITextView *)textView{
    
    [tv resignFirstResponder];
    
}

-(void)shareBtnClick
{


}

@end
