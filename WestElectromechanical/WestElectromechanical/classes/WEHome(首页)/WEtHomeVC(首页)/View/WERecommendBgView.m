//
//  WERecommendBgView.m
//  WestElectromechanical
//
//  Created by zuo on 15/5/1.
//  Copyright (c) 2015年 zuo. All rights reserved.
//

#import "WERecommendBgView.h"
#define kImgCount 4
#define kMargin 10
#define kTag 1000
@interface WERecommendBgView()
@end
@implementation WERecommendBgView
- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        _recommends = [NSMutableArray array];
        UIImageView *crossimg =[[UIImageView alloc]init];
        crossimg.center = CGPointMake(frame.size.width * 0.5, frame.size.height * 0.5);
        [crossimg setImage:[UIImage imageNamed:@"Home_Scroll_Cross"]];
        crossimg.bounds = CGRectMake(0, 0, 80/2.0, 80/2.0);
        crossimg.backgroundColor =[UIColor clearColor];
        [self addSubview:crossimg];
        
        for (int i = 0; i < kImgCount ; i++) {
            
            UIImageView *imageView =[[UIImageView alloc]init];
            imageView.frame =CGRectMake(kMargin+((frame.size.width-3*kMargin)/2+kMargin)*(i%2), kMargin+((frame.size.height-3*kMargin)/2+kMargin)*(i/2), (frame.size.width-3*kMargin)/2, (frame.size.height-3*kMargin)/2);
            imageView.tag = kTag + i;
            imageView.backgroundColor =[UIColor blueColor];
            [self addSubview:imageView];
            
            UITapGestureRecognizer *tap =[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(recommendClick:)];
            tap.numberOfTapsRequired = 1;
            tap.numberOfTouchesRequired = 1;
            [imageView addGestureRecognizer:tap];
        }
    }
    return self;
}

- (void)recommendClick:(UITapGestureRecognizer *)recognizer
{
    DLog(@"self--%ld----img-%ld",self.tag,recognizer.view.tag);
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
