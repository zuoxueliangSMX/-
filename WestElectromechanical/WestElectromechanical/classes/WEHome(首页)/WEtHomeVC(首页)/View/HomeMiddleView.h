//
//  HomeMiddleView.h
//  WestElectromechanical
//
//  Created by zuo on 15/4/26.
//  Copyright (c) 2015年 zuo. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ATLabel.h"
typedef void(^homeMiddleViewBlock) (NSInteger index);
typedef void(^homeMiddleViewAdLabelBlock) (NSInteger index);
@interface HomeMiddleView : UIView
{
    __strong homeMiddleViewBlock _block;
    __strong homeMiddleViewAdLabelBlock _adblock;
}
@property (nonatomic ,weak)ATLabel *adLabel;
- (void)setHomeMiddleVieBlock:(homeMiddleViewBlock)block;
- (void)setHomeMiddleViewAdLabelBlock:(homeMiddleViewAdLabelBlock)block;

@end
