//
//  WECartHomeCellBottomView.h
//  WestElectromechanical
//
//  Created by zuo on 15/5/2.
//  Copyright (c) 2015年 zuo. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef void (^cartHomeCellBottomCutBlock)(NSInteger tfNum,UITextField *numTf,UILabel *totalPriceLa);
typedef void (^cartHomeCellBottomPlusBlock)(NSInteger tfNum,UITextField *numTf,UILabel *totalPriceLa);

@interface WECartHomeCellBottomView : UIView
{
    __strong cartHomeCellBottomCutBlock _cutBlock;
    __strong cartHomeCellBottomPlusBlock _plusBlock;

}
@property(nonatomic,strong)UIButton *rigBtn;
@property(nonatomic,strong)UIButton *leftBtn;
@property(nonatomic,strong) UITextField  *numTF;
@property(nonatomic,strong)UILabel *jineLa;
- (void)setCartHomeCellBottomCutBlock:(cartHomeCellBottomCutBlock)block;
- (void)setCartHomeCellBottomPlusBlock:(cartHomeCellBottomPlusBlock)block;

@end
