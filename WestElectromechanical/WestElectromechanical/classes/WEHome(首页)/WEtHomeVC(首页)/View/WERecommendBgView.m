//
//  WERecommendBgView.m
//  WestElectromechanical
//
//  Created by zuo on 15/5/1.
//  Copyright (c) 2015年 zuo. All rights reserved.
//

#import "WERecommendBgView.h"
#import "UIImageView+WebCacheImg.h"
#import "WERecommendModel.h"
#define kImgCount 4
#define kMargin 10
#define kTag 1000
@interface WERecommendBgView()
@property (nonatomic ,strong)NSMutableArray *imgs;
@end
@implementation WERecommendBgView
- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        self.userInteractionEnabled = YES;
        _imgs =[NSMutableArray array];
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
            imageView.userInteractionEnabled = YES;
            imageView.backgroundColor =[UIColor blueColor];
            [self addSubview:imageView];
            [_imgs addObject:imageView];
            UITapGestureRecognizer *tap =[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(recommendClick:)];
            tap.numberOfTapsRequired = 1;
            tap.numberOfTouchesRequired = 1;
            [imageView addGestureRecognizer:tap];
        }
    }
    return self;
}
- (void)setUpBgViewData:(NSMutableArray *)recommends
{
    for (int i = 0; i < kImgCount; i++) {
        UIImageView *imgView =[_imgs objectAtIndex:i];
        WERecommendModel *recommendModel =[recommends objectAtIndex:i];
        [imgView setWebImgUrl:recommendModel.Imgurl placeHolder:[UIImage imageNamed:@"Person_header_bg"]];
    }
}
- (void)setRecommendBgViewBlock:(recommendBgViewBlock)block
{
    _block = block;
}
- (void)recommendClick:(UITapGestureRecognizer *)recognizer
{
    
    DLog(@"self--%ld----img-%ld",self.tag,recognizer.view.tag);
    if (_block) {
        _block(recognizer.view.tag-kTag);
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
