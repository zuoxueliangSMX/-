//
//  WECartBottomView.h
//  WestElectromechanical
//
//  Created by zuo on 15/5/16.
//  Copyright (c) 2015年 zuo. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef void(^cartBottomViewClearingBlock) (void);
typedef void(^cartBottomViewAllChooseBlock) (BOOL isSelected);

@interface WECartBottomView : UIView
{
    __strong cartBottomViewClearingBlock _clearingBlcok;
    __strong cartBottomViewAllChooseBlock _allChooseBlcok;

}
@property (nonatomic ,weak)UIButton *allButton;
@property (nonatomic ,weak)UILabel *totalCountLa;
@property (nonatomic ,weak)UIButton *clearingBtn;
@property (nonatomic ,weak)UILabel *allPriceLa;
- (void)setCartBottomViewClearingBlock:(cartBottomViewClearingBlock)block;
- (void)setCartBottomViewAllChooseBlock:(cartBottomViewAllChooseBlock)block;

@end
