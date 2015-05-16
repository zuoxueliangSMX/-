//
//  WECartHomeCellMiddleInfoView.h
//  WestElectromechanical
//
//  Created by zuo on 15/4/28.
//  Copyright (c) 2015年 zuo. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MyCartM.h"
typedef void (^cartChoeseBlock)(UIButton *btn);
@interface WECartHomeCellMiddleInfoView : UIView
{
__strong cartChoeseBlock _chosesBlock;

}
@property (nonatomic ,strong)MyCartM *myCartModel;

- (void)setChosesBlock:(cartChoeseBlock)chosesBlock;


@end
