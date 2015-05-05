//
//  WERecommendBgView.h
//  WestElectromechanical
//
//  Created by zuo on 15/5/1.
//  Copyright (c) 2015年 zuo. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef void(^recommendBgViewBlock) (NSInteger imgTag);
@interface WERecommendBgView : UIView
{
    __strong recommendBgViewBlock _block;
}
- (void)setRecommendBgViewBlock:(recommendBgViewBlock)block;
- (void)setUpBgViewData:(NSMutableArray *)recommends;
@end
