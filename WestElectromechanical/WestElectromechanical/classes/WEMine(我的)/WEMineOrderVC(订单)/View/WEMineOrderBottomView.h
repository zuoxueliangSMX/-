//
//  WEMineOrderBottomView.h
//  WestElectromechanical
//
//  Created by zuo on 15/5/18.
//  Copyright (c) 2015年 zuo. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "OrderM.h"
#define kOrderBtnTypePay @"立即支付"
#define kOrderBtnTypeConfirm @"确认收货"
#define kOrderBtnTypeComment @"评价"
#define kOrderBtnTypeFinish @"已完成"
#define kOrderBtnTypeSend @"配送中"
typedef void(^orderBottomViewBlock) (UIButton *btn);
@interface WEMineOrderBottomView : UIView
{
    __strong orderBottomViewBlock _block;
}
- (void)setOrderBottomViewBlock:(orderBottomViewBlock)block;
@property (nonatomic ,strong)OrderM *orderModel;

@end
