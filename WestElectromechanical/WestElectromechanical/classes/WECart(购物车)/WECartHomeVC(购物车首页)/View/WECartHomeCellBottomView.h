//
//  WECartHomeCellBottomView.h
//  WestElectromechanical
//
//  Created by zuo on 15/5/2.
//  Copyright (c) 2015年 zuo. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MyCartM.h"
typedef void (^cartHomeCellBottomCutBlock)(NSInteger tfNum,UILabel *numTf,UILabel *totalPriceLa);
typedef void (^cartHomeCellBottomPlusBlock)(NSInteger tfNum,UILabel *numTf,UILabel *totalPriceLa);

@interface WECartHomeCellBottomView : UIView
{
    __strong cartHomeCellBottomCutBlock _cutBlock;
    __strong cartHomeCellBottomPlusBlock _plusBlock;

}
@property (nonatomic ,strong)MyCartM *myCartModel;

- (void)setCartHomeCellBottomCutBlock:(cartHomeCellBottomCutBlock)block;
- (void)setCartHomeCellBottomPlusBlock:(cartHomeCellBottomPlusBlock)block;

@end
