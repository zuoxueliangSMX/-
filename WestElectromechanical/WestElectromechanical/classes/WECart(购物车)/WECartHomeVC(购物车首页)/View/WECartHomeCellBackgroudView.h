//
//  WEHomeCellBackgroudView.h
//  WestElectromechanical
//
//  Created by zuo on 15/4/28.
//  Copyright (c) 2015年 zuo. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WECartHomeCellBottomView.h"
#import "WECartHomeCellMiddleInfoView.h"

typedef void (^cartHomeDeleteBtnBlock)(void);

@interface WECartHomeCellBackgroudView : UIView
{
    __strong cartHomeDeleteBtnBlock _deleteBtnBlock;
}
@property (nonatomic ,strong)MyCartM *myCartModel;
@property(nonatomic,weak)WECartHomeCellBottomView *bottomView;
@property(nonatomic,weak)WECartHomeCellMiddleInfoView *middleview;
- (void)setCartdeleteBlock:(cartHomeDeleteBtnBlock)deleteBtnBlock;



@end
