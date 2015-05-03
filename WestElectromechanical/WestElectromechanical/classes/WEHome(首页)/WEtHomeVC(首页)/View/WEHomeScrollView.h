//
//  WEHomeScrollView.h
//  WestElectromechanical
//
//  Created by zuo on 15/4/26.
//  Copyright (c) 2015年 zuo. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HomeHeaderScrollView.h"
#import "HomeMiddleView.h"
#import "WEHomeBottomScrollView.h"

@interface WEHomeScrollView : UIScrollView
@property (nonatomic ,weak)HomeHeaderScrollView *headerView;
@property (nonatomic ,weak)HomeMiddleView *middleView;
@property (nonatomic ,weak)WEHomeBottomScrollView *bottomView;
@end
