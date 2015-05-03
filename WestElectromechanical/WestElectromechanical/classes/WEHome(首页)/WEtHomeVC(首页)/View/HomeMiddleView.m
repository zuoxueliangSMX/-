//
//  HomeMiddleView.m
//  WestElectromechanical
//
//  Created by zuo on 15/4/26.
//  Copyright (c) 2015年 zuo. All rights reserved.
//

#import "HomeMiddleView.h"
#define kMiddleBtnCount 4
@interface HomeMiddleView()
@end
@implementation HomeMiddleView
- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        
        self.backgroundColor =[UIColor clearColor];
        for (int i = 0; i< kMiddleBtnCount; i++) {
            UIButton *btn =[UIButton buttonWithType:UIButtonTypeCustom];
            UIImage *img =[UIImage imageNamed:[NSString stringWithFormat:@"Home_Middle_0%d",i+1]];
            CGFloat margin =(frame.size.width-4*img.size.width)/5;
            btn.frame =CGRectMake(margin+(img.size.width+margin)*i,(frame.size.height-img.size.height)/2.0, img.size.width,img.size.height);
            [btn setBackgroundColor:[UIColor clearColor]];
            [btn setImage:[UIImage imageNamed:[NSString stringWithFormat:@"Home_Middle_0%d",i+1]] forState:UIControlStateNormal];
            [btn addTarget:self action:@selector(middleClick:) forControlEvents:UIControlEventTouchUpInside];
            [self addSubview:btn];
        }
    }
    return self;
}

- (void)middleClick:(UIButton *)btn
{
    
    
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
