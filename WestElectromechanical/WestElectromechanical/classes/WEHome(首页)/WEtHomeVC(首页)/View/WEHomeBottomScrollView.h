//
//  WEHomeBottomScrollView.h
//  WestElectromechanical
//
//  Created by zuo on 15/5/1.
//  Copyright (c) 2015年 zuo. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef void(^homeBottomScrollViewBlock) (NSInteger bgTag ,NSInteger imgTag);
@interface WEHomeBottomScrollView : UIView
{
    __strong homeBottomScrollViewBlock _block;
}
- (void)setUpRecommendsData:(NSMutableArray *)recommends;
- (void)setHomeBottomScrollViewBlock:(homeBottomScrollViewBlock)block;
@end
