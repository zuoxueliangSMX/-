//
//  WEMineOrderVC.m
//  WestElectromechanical
//
//  Created by zuo on 15/5/18.
//  Copyright (c) 2015年 zuo. All rights reserved.
//

#import "WEMineOrderVC.h"
#import "HTHorizontalSelectionList.h"
#import "GlanceCell.h"
#import "RDVTabBarController.h"
#import "MyOrderDetailVC.h"
#import "WEHTTPHandler.h"
#import "AccountHanler.h"
#import "MyOrderModel.h"
#import "OrderM.h"
#import "WEMineOrderCell.h"
#import "WEMyOrderFrame.h"
#import "TLAlertView.h"
#import "WEMineAddComentVC.h"
#import "ProductsM.h"
#import "NSDictionary+JsonString.h"
#import "Order.h"
#import "DataSigner.h"
#import <AlipaySDK/AlipaySDK.h>
#import "NSString+Base64.h"
#import "APAuthV2Info.h"
#import "GTMBase64.h"
#include <CommonCrypto/CommonCryptor.h>
#import "AccountHanler.h"
#import "Product.h"

@interface WEMineOrderVC()<HTHorizontalSelectionListDelegate,HTHorizontalSelectionListDataSource,UITableViewDelegate,UITableViewDataSource>
{
    UITableView *_table;
    NSArray *Arr;
    WEHTTPHandler *we;
    TLAlertView *alertView;

}

@property (nonatomic, strong) HTHorizontalSelectionList *selectionList;
@property (nonatomic, strong) NSArray *carMakes;

@property (nonatomic, strong) UILabel *selectedItemLabel;
@property (nonatomic ,strong)MyOrderModel *orderModel;
@end
@implementation WEMineOrderVC

#pragma mark -
#pragma mark - pop和push控制器时的操作
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
        [[self rdv_tabBarController] setTabBarHidden:YES animated:YES];
    
    
    [self sendRequest];

   }

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    [[self rdv_tabBarController] setTabBarHidden:NO animated:YES];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self addTopNavBar];
    self.title = @"我的订单";
    
    we = [[WEHTTPHandler alloc]init];
    VIEW_BACKGROUND
    
    _table = [[UITableView alloc]initWithFrame:CGRectMake(0, 40, self.view.frame.size.width, SCREEN_HEIGHT-64-40) style:UITableViewStylePlain];
    _table.delegate =self;
    _table.dataSource =self;
    _table.tableFooterView =[[UIView alloc]init];
    [self.view addSubview:_table];
  
}

-(void)sendRequest
{
    [we  executeQueryOrderTaskWithUserId:[AccountHanler userId] withState: [NSString stringWithFormat:@"%ld",(long)self.selectedItem] withPage:@"1" Success:^(id obj) {
        
        _orderModel =(MyOrderModel*)obj;
               [_table reloadData];
        
        
    } failed:^(id obj) {
        
    }];



}
-(void)addTopNavBar
{
    self.edgesForExtendedLayout = UIRectEdgeNone;
    
    self.selectionList = [[HTHorizontalSelectionList alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 40)];
    [self.selectionList setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
    
    [self.selectionList setTitleColor:[UIColor colorFromHexCode:@"333333"] forState:UIControlStateSelected];
    self.selectionList.selectionIndicatorColor =[UIColor colorWithRed:30.0/255 green:121.0/255 blue:71.0/255 alpha:1];
    self.selectionList.selectedButtonIndex =self.selectedItem;
    
    
    //添加竖线
    for (int i =1; i<4; i++) {
        UILabel *veticalLineLa= [[UILabel alloc]initWithFrame:CGRectMake(VIEW_WIDETH/4*i, 5, 1, 30)];
        veticalLineLa.tag = 100+i;
        veticalLineLa.backgroundColor = [UIColor lightGrayColor];
        [ self.selectionList addSubview:veticalLineLa];
    }
    self.selectionList.backgroundColor =[UIColor whiteColor];
    self.selectionList.delegate = self;
    self.selectionList.dataSource = self;
    
    self.carMakes = @[@"全  部",
                      @"待付款",
                      @"待收货",
                      @"已完成"
                      ];
    
    [self.view addSubview:self.selectionList];
    
    
    
}
#pragma mark - HTHorizontalSelectionListDataSource Protocol Methods

- (NSInteger)numberOfItemsInSelectionList:(HTHorizontalSelectionList *)selectionList {
    return self.carMakes.count;
}

- (NSString *)selectionList:(HTHorizontalSelectionList *)selectionList titleForItemWithIndex:(NSInteger)index {
    return self.carMakes[index];
}

#pragma mark - HTHorizontalSelectionListDelegate Protocol Methods

- (void)selectionList:(HTHorizontalSelectionList *)selectionList didSelectButtonWithIndex:(NSInteger)index {
  
    DLog(@"输出我点击的是几%@",self.carMakes[index]);
    switch (index) {
        case 0:
        {
            self.selectedItem =0;
        }
            break;
        case 1:
        {
            self.selectedItem =1;
        }
            break;
        case 2:
        {
            self.selectedItem =2;
        }
            break;
        case 3:
        {
             self.selectedItem =3;
        }
            break;


            
        default:
            break;
    }
    
    
    [self  sendRequest];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
           
    WEMyOrderFrame *orderFrame=[self.orderModel.orders  objectAtIndex:indexPath.row];
    return orderFrame.height+5;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.orderModel.orders.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
    static NSString *CellIdentifier = @"Cell";
    WEMineOrderCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if(cell == nil) {
        cell = [[WEMineOrderCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
        cell.backgroundColor =[UIColor colorFromHexCode:@"f2f2f2"];
        cell.selectionStyle =UITableViewCellSelectionStyleNone;
    }
    WEMyOrderFrame *orderFrame=[self.orderModel.orders  objectAtIndex:indexPath.row];
    cell.orderFrame = orderFrame;
    
    __weak WEMineOrderVC *bSelf = self;
    __weak WEMineOrderCell *bCell = cell;
    [cell.bottomView setOrderBottomViewBlock:^(UIButton *btn) {
        
        if ([btn.titleLabel.text isEqualToString:kOrderBtnTypeConfirm] ) {

            [we executeAffirmAcceptGoodsWithUserId:[AccountHanler userId] withOrderNum:orderFrame.orderModel.order_num Success:^(id obj) {
                if ([[obj objectForKey:@"message"] isEqualToString:@"0"]) {
                    [bSelf sendRequest];
                    alertView = [TLAlertView showInView:self.view withTitle:@"" message:@"我已经收到货，同意支付宝付款" confirmButtonTitle:@"确定" cancelButtonTitle:@"取消"];

                    [alertView handleCancel:^{
                        
                    } handleConfirm:^{
                        
                        WEMyOrderFrame *orderFrame=[self.orderModel.orders  objectAtIndex:indexPath.row];

                        WEMineAddComentVC *coment = [[WEMineAddComentVC alloc]init];
                        coment.orderFrame =orderFrame;
                        [self.navigationController pushViewController:coment animated:YES];
                        
                    }];
                    
                    alertView.TLAnimationType = (arc4random_uniform(10) % 2 == 0) ? TLAnimationType3D : tLAnimationTypeHinge;
                    
                    
                    
                    [alertView show];

                }

            } failed:^(id obj) {
                
            }];
        }else if ([btn.titleLabel.text isEqualToString:kOrderBtnTypePay]){
            
            
            WEHTTPHandler *handler =[[WEHTTPHandler alloc]init];
            [handler executePayInfoWithSuccess:^(id obj) {
                DLog(@"%@",obj);
                [bSelf sendOrder:[bSelf decryptUseDES:[obj objectForKey:@"a"] key:ctmKey] withSeller:[bSelf decryptUseDES:[obj objectForKey:@"pk"] key:ctmKey] privateKey:[bSelf decryptUseDES:[obj objectForKey:@"p"] key:ctmKey] withAllprice:bCell.orderFrame.orderModel.all_money withOrderNum:bCell.orderFrame.orderModel.order_num];
            } failed:^(id obj) {
                DLog(@"%@",obj);
            }];

        }
        
    }];
    return cell;
    
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    WEMyOrderFrame *orderFrame=[self.orderModel.orders  objectAtIndex:indexPath.row];

    MyOrderDetailVC *orderDetail = [[MyOrderDetailVC alloc]init];
   
       orderDetail.om  =  orderFrame.orderModel;
    [self.navigationController pushViewController:orderDetail animated:YES];
    
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


- (void)sendOrder:(NSString *)partner1 withSeller:(NSString *)seller1 privateKey:(NSString *)privateKey1 withAllprice:(NSString *)allPrice withOrderNum:(NSString *)orderNum
{
    
    Product *product = [[Product alloc] init];
    product.subject = @"西域电商订单";
//    product.body = self.orderNum;
    
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
        __weak WEMineOrderVC *bSelf = self;
        [[AlipaySDK defaultService] payOrder:orderString fromScheme:appScheme callback:^(NSDictionary *resultDic) {
            NSLog(@"reslut = %@",resultDic);
            if ([[resultDic objectForKey:@"resultStatus"] integerValue]==9000) {
                [[[WEHTTPHandler alloc] init] executePayOrderWithUserId:[AccountHanler userId] withOrderNum:orderNum withTotalMoney:allPrice Success:^(id obj) {
                    
                    
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


/*
 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }
 */


@end
