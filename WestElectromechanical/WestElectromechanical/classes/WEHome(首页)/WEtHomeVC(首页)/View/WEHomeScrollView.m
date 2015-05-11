//
//  WEHomeScrollView.m
//  WestElectromechanical
//
//  Created by zuo on 15/4/26.
//  Copyright (c) 2015年 zuo. All rights reserved.
//

#import "WEHomeScrollView.h"
@interface WEHomeScrollView()
@end
@implementation WEHomeScrollView
- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {

        UIImage *img =[UIImage imageNamed:@"Home_Middle_01"];

        HomeHeaderScrollView *headerView =[[HomeHeaderScrollView alloc]initWithFrame:CGRectMake(0, 0, self.frame.size.width,(SCREEN_HEIGHT-64-49-10-img.size.height)*0.4)];
        headerView.backgroundColor =[UIColor clearColor];
        [self addSubview:headerView];
        _headerView = headerView;
        
        HomeMiddleView *middleView =[[HomeMiddleView alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(_headerView.frame), SCREEN_WIDTH, img.size.height+30)];
        middleView.backgroundColor =[UIColor clearColor];
        [self addSubview:middleView];
        _middleView = middleView;
        
        WEHomeBottomScrollView *bottomView =[[WEHomeBottomScrollView alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(_middleView.frame)+5, self.frame.size.width, (SCREEN_HEIGHT-64-49-30-img.size.height)*0.6)];
        [self addSubview:bottomView];
        _bottomView = bottomView;
        
    }
    return self;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
