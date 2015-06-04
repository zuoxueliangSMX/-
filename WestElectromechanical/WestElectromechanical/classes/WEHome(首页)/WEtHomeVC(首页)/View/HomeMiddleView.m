//
//  HomeMiddleView.m
//  WestElectromechanical
//
//  Created by zuo on 15/4/26.
//  Copyright (c) 2015年 zuo. All rights reserved.
//

#import "HomeMiddleView.h"

#define kMiddleBtnCount 4
#define kMiddleBtnTag 1000
@interface HomeMiddleView()
@end
@implementation HomeMiddleView
- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        
        self.backgroundColor =[UIColor clearColor];
        self.userInteractionEnabled = YES;
        
        UIView *adBgView =[[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 20)];
        adBgView.backgroundColor =[UIColor lightGrayColor];
        adBgView.userInteractionEnabled = YES;
        [self addSubview:adBgView];
        
        UIImageView *noticeImgView =[[UIImageView alloc]init];
        noticeImgView.frame =CGRectMake(13/2.0,9.0/2.0,27/2.0, 22.0/2.0);
        [noticeImgView setImage:[UIImage imageNamed:@"Home_Advertisement"]];
        noticeImgView.backgroundColor =[UIColor clearColor];
        [adBgView addSubview:noticeImgView];
        
        ATLabel *adLabel =[[ATLabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(noticeImgView.frame)+5, 3, SCREEN_WIDTH, 14)];
        adLabel.tag = 1000;
        adLabel.userInteractionEnabled = YES;
        adLabel.font = font(14);
        [adBgView addSubview:adLabel];
        _adLabel = adLabel;

        UITapGestureRecognizer *tap =[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tap:)];
        tap.numberOfTapsRequired = 1;
        tap.numberOfTouchesRequired = 1;
        [adLabel addGestureRecognizer:tap];
        
        
        for (int i = 0; i< kMiddleBtnCount; i++) {
            UIButton *btn =[UIButton buttonWithType:UIButtonTypeCustom];
            btn.tag = kMiddleBtnTag+i;
            UIImage *img =[UIImage imageNamed:[NSString stringWithFormat:@"Home_Middle_0%d",1]];
            CGFloat margin =(frame.size.width-4*img.size.width)/5;
            btn.frame =CGRectMake(margin+(img.size.width+margin)*i,CGRectGetMaxY(adBgView.frame)+5, img.size.width,img.size.height);
            [btn setBackgroundColor:[UIColor clearColor]];
            [btn setImage:[UIImage imageNamed:[NSString stringWithFormat:@"Home_Middle_0%d",i+1]] forState:UIControlStateNormal];
            [btn addTarget:self action:@selector(middleClick:) forControlEvents:UIControlEventTouchUpInside];
            [self addSubview:btn];
        }
    }
    return self;
}

- (void)setHomeMiddleVieBlock:(homeMiddleViewBlock)block
{
    _block = block;
}

- (void)middleClick:(UIButton *)btn
{
    if (_block) {
        _block(btn.tag-kMiddleBtnTag);
    }
    
}

- (void)setHomeMiddleViewAdLabelBlock:(homeMiddleViewAdLabelBlock)block
{
    _adblock = block;
}
- (void)tap:(UITapGestureRecognizer *)recognizer
{
    DLog(@"%@",[(ATLabel *)recognizer.view text]);
    DLog(@"%ld",recognizer.view.tag);
    if (_adblock) {
        _adblock(recognizer.view.tag);
    }
}


/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
