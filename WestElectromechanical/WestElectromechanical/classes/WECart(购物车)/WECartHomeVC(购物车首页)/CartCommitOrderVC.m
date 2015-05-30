//
//  CartCommitOrderVC.m
//  WestElectromechanical
//
//  Created by 夏亚峰 on 15/5/20.
//  Copyright (c) 2015年 zuo. All rights reserved.
//

#import "CartCommitOrderVC.h"
#import "RDVTabBarController.h"
#import "WEHTTPHandler.h"
#import "Order.h"
#import "DataSigner.h"
#import <AlipaySDK/AlipaySDK.h>
#import "NSString+Base64.h"
#import "APAuthV2Info.h"
#import "GTMBase64.h"
#include <CommonCrypto/CommonCryptor.h>
#import "AccountHanler.h"
#import "Product.h"


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
    VIEW_BACKGROUND
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
    
    
    
    UILabel * succeedLa = [[UILabel alloc]initWithFrame:CGRectMake(SCREEN_WIDTH/2-100, CGRectGetMaxY(imgv.frame)+25, 200, 70)];
    succeedLa.text =@"                 恭喜你\n            订单提交成功";
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
   
    
}
-(void)instantPayBtnClick
{

    WEHTTPHandler *handler =[[WEHTTPHandler alloc]init];
    [handler executePayInfoWithSuccess:^(id obj) {
        DLog(@"%@",obj);
        [self sendOrder:[self decryptUseDES:[obj objectForKey:@"a"] key:ctmKey] withSeller:[self decryptUseDES:[obj objectForKey:@"ipk"] key:ctmKey] privateKey:[self decryptUseDES:[obj objectForKey:@"p"] key:ctmKey]];
    } failed:^(id obj) {
        DLog(@"%@",obj);
    }];
}

-(void)laterBtnClick
{
    [self.navigationController popToRootViewControllerAnimated:YES];
}
#pragma mark -
#pragma mark   ==============产生随机订单号==============


- (NSString *)generateTradeNO
{
    static int kNumber = 15;
    
    NSString *sourceStr = @"0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZ";
    NSMutableString *resultStr = [[NSMutableString alloc] init];
    srand(time(0));
    for (int i = 0; i < kNumber; i++)
    {
        unsigned index = rand() % [sourceStr length];
        NSString *oneStr = [sourceStr substringWithRange:NSMakeRange(index, 1)];
        [resultStr appendString:oneStr];
    }
    return resultStr;
}


- (void)sendOrder:(NSString *)partner1 withSeller:(NSString *)seller1 privateKey:(NSString *)privateKey1
{
    
    Product *product = [[Product alloc] init];
    product.subject = @"西域电商订单";
    product.body = self.orderNum;
    
    product.price = 0.01f;
    
    
    
    /*
     *商户的唯一的parnter和seller。
     *签约后，支付宝会为每个商户分配一个唯一的 parnter 和 seller。
     */
    
    /*============================================================================*/
    /*=======================需要填写商户app申请的===================================*/
    /*============================================================================*/
    NSString *partner = partner1;
    NSString *seller = seller1;
    NSString *privateKey = @"MIICeAIBADANBgkqhkiG9w0BAQEFAASCAmIwggJeAgEAAoGBAMoh77pOtTHB3En1Pn7q07hZvwJX7Abfjer0AqgKd8iqei9I8FOrZBTN5DAoa2QKmzb/QTzbzP+9FPDd+ekNlFtQlyxmrBWbWnVLDaXK3OYG5jTev9mmpY2ctS0+uLpbW/QT8iTBAFtpRhssoLRwsgpw30ZwgiIUuhA7dvNxV8BJAgMBAAECgYA4cE9aiv2G3iVfNS31DCZ/s/dkdR4/MQ6USvuu5fVaP1eMemY4RoPUV0TeuXp63YdHTPBvSMQtqCL/uks8aoFAmuk/3bni3E3PLfapdsuJAX7YLCT6C/Tov/oK/gidmgAkt1MbsdWUQMsVCWNvhtKciguZLP+F4+TPcZ4TTO3ELQJBAOhjoocWwo+Xybm9p9cPtI+2ByqGXWO396ieXYwdM8V23TUcb6uDg9DU7HVe36WE1sYBqaNB2Lvmq66xSGbNkHsCQQDeq1YuZ86oT7Hof9TNRga2U5A/oZTCMbhpexAbFs8rj8waKwuKu46wcakXo/iaoUGl6U4PAe902gFXjCvKITELAkEA2R0FIqrb+WX5nOQZJC9TJZUOGufP5rNg2ZOjmJ1L2ifUQaOgnSBRDdFwXbPWxQBX3ER/ZbzGLb80FREisJFLcwJBAJyTVrKjBEqOX8fhu73ss+OZtyFHeddkJwzlIFosG9nB7/+mrSMM6DVid0jMYJA7PHJyMBWVgtBkS/VH97LWzCkCQQDfxCMFcyEwGgszk/dCeBhzyI6vzzsfSCejzPaBwpAvSFJbZ8ZZWK0jObTLItFywjli53m7fEth5eJFv//6gwfp";
    /*============================================================================*/
    /*============================================================================*/
    /*============================================================================*/
    
    //partner和seller获取失败,提示
    if ([partner length] == 0 ||
        [seller length] == 0 ||
        [privateKey length] == 0)
    {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示"
                                                        message:@"缺少partner或者seller或者私钥。"
                                                       delegate:self
                                              cancelButtonTitle:@"确定"
                                              otherButtonTitles:nil];
        [alert show];
        return;
    }
    
    /*
     *生成订单信息及签名
     */
    //将商品信息赋予AlixPayOrder的成员变量
    Order *order = [[Order alloc] init];
    order.partner = partner;
    order.seller = seller;
    order.tradeNO = [self generateTradeNO]; //订单ID（由商家自行制定）
    order.productName = product.subject; //商品标题
    order.productDescription = product.body; //商品描述
    order.amount = [NSString stringWithFormat:@"%.2f",product.price]; //商品价格
    order.notifyURL =  @"http://www.eysa.com"; //回调URL
    
    order.service = @"mobile.securitypay.pay";
    order.paymentType = @"1";
    order.inputCharset = @"utf-8";
    order.itBPay = @"30m";
    order.showUrl = @"m.alipay.com";
    
    //应用注册scheme,在AlixPayDemo-Info.plist定义URL types
    NSString *appScheme = @"WestElectromechanicalAlipay";
    
    //将商品信息拼接成字符串
    NSString *orderSpec = [order description];
    NSLog(@"orderSpec = %@",orderSpec);
    
    //获取私钥并将商户信息签名,外部商户可以根据情况存放私钥和签名,只需要遵循RSA签名规范,并将签名字符串base64编码和UrlEncode
    id<DataSigner> signer = CreateRSADataSigner(privateKey);
    NSString *signedString = [signer signString:orderSpec];
    
    //将签名成功字符串格式化为订单字符串,请严格按照该格式
    NSString *orderString = nil;
    if (signedString != nil) {
        orderString = [NSString stringWithFormat:@"%@&sign=\"%@\"&sign_type=\"%@\"",
                       orderSpec, signedString, @"RSA"];
        __weak CartCommitOrderVC *bSelf = self;
        [[AlipaySDK defaultService] payOrder:orderString fromScheme:appScheme callback:^(NSDictionary *resultDic) {
            NSLog(@"reslut = %@",resultDic);
            if ([[resultDic objectForKey:@"resultStatus"] integerValue]==9000) {
                [[[WEHTTPHandler alloc] init] executePayOrderWithUserId:[AccountHanler userId] withOrderNum:bSelf.orderNum  withTotalMoney:bSelf.allPrice Success:^(id obj) {
                    
                    
                    if ([[obj objectForKey:@"message"] isEqualToString:@"0"]) {
                        
                        //                    [AlertUtil showAlertWithText:@"支付成功"];
                        WARN_ALERT(@"支付成功");
                        [bSelf.navigationController popToRootViewControllerAnimated:YES];
                    }
                    
                } failed:^(id obj) {
                    
                    
                }];
            }
            
        }];
    }

}

-(NSString*) decryptUseDES:(NSString*)cipherText key:(NSString*)key {
    // 利用 GTMBase64 解碼 Base64 字串
    NSData* cipherData = [GTMBase64 decodeString:cipherText];
    unsigned char buffer[1024];
    memset(buffer, 0, sizeof(char));
    size_t numBytesDecrypted = 0;
    
    // IV 偏移量不需使用
    CCCryptorStatus cryptStatus = CCCrypt(kCCDecrypt,
                                          kCCAlgorithmDES,
                                          kCCOptionPKCS7Padding | kCCOptionECBMode,
                                          [key UTF8String],
                                          kCCKeySizeDES,
                                          nil,
                                          [cipherData bytes],
                                          [cipherData length],
                                          buffer,
                                          1024,
                                          &numBytesDecrypted);
    NSString* plainText = nil;
    if (cryptStatus == kCCSuccess) {
        NSData* data = [NSData dataWithBytes:buffer length:(NSUInteger)numBytesDecrypted];
        plainText = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
    }
    return plainText;
}
-(NSString *) encryptUseDES:(NSString *)clearText key:(NSString *)key
{
    NSData *data = [clearText dataUsingEncoding:NSUTF8StringEncoding allowLossyConversion:YES];
    unsigned char buffer[1024];
    memset(buffer, 0, sizeof(char));
    size_t numBytesEncrypted = 0;
    
    CCCryptorStatus cryptStatus = CCCrypt(kCCEncrypt,
                                          kCCAlgorithmDES,
                                          kCCOptionPKCS7Padding | kCCOptionECBMode,
                                          [key UTF8String],
                                          kCCKeySizeDES,
                                          nil,
                                          [data bytes],
                                          [data length],
                                          buffer,
                                          1024,
                                          &numBytesEncrypted);
    
    NSString* plainText = nil;
    if (cryptStatus == kCCSuccess) {
        NSData *dataTemp = [NSData dataWithBytes:buffer length:(NSUInteger)numBytesEncrypted];
        plainText = [GTMBase64 stringByEncodingData:dataTemp];
    }else{
        NSLog(@"DES加密失败");
    }
    return plainText;
}


@end
