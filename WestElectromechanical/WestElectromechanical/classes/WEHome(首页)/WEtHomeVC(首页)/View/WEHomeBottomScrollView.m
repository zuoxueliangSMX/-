//
//  WEHomeBottomScrollView.m
//  WestElectromechanical
//
//  Created by zuo on 15/5/1.
//  Copyright (c) 2015年 zuo. All rights reserved.
//

#import "WEHomeBottomScrollView.h"
#import "JCTopic.h"
#import "WERecommendBgView.h"
#import "TAPageControl.h"
#import "WERecommendModel.h"
#define kBottomViewCount 3
#define kBgViewTag 1000
@interface WEHomeBottomScrollView()<UIScrollViewDelegate>
@property (nonatomic ,weak)UIView *recommendBgView;
@property (nonatomic ,weak)TAPageControl *pageControl;
@property (nonatomic ,strong)NSMutableArray *bgViews;
@end
@implementation WEHomeBottomScrollView
- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {

        self.userInteractionEnabled = YES;
        _bgViews =[NSMutableArray array];
        UIView * recommendBgView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, frame.size.width, frame.size.height)];
        [recommendBgView setBackgroundColor:[UIColor whiteColor]];
        [self addSubview:recommendBgView];
        
        // 热门推荐图标
        UIImageView *recommendlogo = [[UIImageView alloc] initWithFrame:CGRectMake(5, 5,31/2.0, 32/2.0)];
        [recommendlogo setImage:[UIImage imageNamed:@"Home_Recommend"]];
        [recommendBgView addSubview:recommendlogo];
        
        // 本月推荐
        UILabel *hotlabel = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(recommendlogo.frame)+10, 5,200, 32/2.0)];
        hotlabel.font = font(16);
        hotlabel.textColor=[UIColor colorWithRed:0.0/255 green:128.0/255 blue:0.0/255 alpha:1];
        hotlabel.textColor =[UIColor blackColor];
        hotlabel.backgroundColor =[UIColor clearColor];
        hotlabel.text = @"本月推荐";
        [recommendBgView addSubview:hotlabel];
        
        UIScrollView *bottomScroll =[[UIScrollView alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(hotlabel.frame)+3, frame.size.width, frame.size.height - CGRectGetMaxY(hotlabel.frame)-10)];
        bottomScroll.showsHorizontalScrollIndicator = NO;
        bottomScroll.showsVerticalScrollIndicator = NO;
        bottomScroll.contentSize = CGSizeMake(frame.size.width*3, frame.size.height - CGRectGetMaxY(hotlabel.frame)-10);
        bottomScroll.delegate = self;
        bottomScroll.bounces = NO;
        bottomScroll.pagingEnabled= YES;
        [self addSubview:bottomScroll];
        
        for (int i = 0; i < kBottomViewCount; i++) {
            WERecommendBgView *bgView =[[WERecommendBgView alloc]initWithFrame:CGRectMake(frame.size.width*i, 0, frame.size.width, bottomScroll.size.height-15)];
            bgView.tag =kBgViewTag +i;
            [bgView setRecommendBgViewBlock:^(NSInteger imgTag) {
                if (_block) {
                    _block(i,imgTag);
                }
            }];
            bgView.backgroundColor =[UIColor clearColor];
            [bottomScroll addSubview:bgView];
            [_bgViews addObject:bgView];
        }
        
        TAPageControl *pageControl = [[TAPageControl alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(bottomScroll.frame)-15, frame.size.width, 10)];;
        pageControl.currentDotImage =[UIImage imageNamed:@"Home_ScrollLine_Highlighted"];
        pageControl.dotImage =[UIImage imageNamed:@"Home_ScrollLine_Normal"];
        pageControl.backgroundColor =[UIColor clearColor];
        pageControl.numberOfPages=kBottomViewCount;
        [self addSubview:pageControl];
        _pageControl = pageControl;
    }
    return self;
}

- (void)setUpRecommendsData:(NSMutableArray *)recommends
{
    NSMutableArray *tem1 =[NSMutableArray array];
    NSMutableArray *tem2 =[NSMutableArray array];
    NSMutableArray *tem3 =[NSMutableArray array];
    if (recommends.count%3==0&&recommends.count%4==0) {
        for (int i = 0; i<recommends.count; i++) {
            WERecommendModel *model =[recommends objectAtIndex:i];
            
            if (i<recommends.count/3) {
                [tem1 addObject:model];
            }
            if (i>recommends.count/3-1&&i<recommends.count/3*2) {
                [tem2 addObject:model];
            }
            if (i>recommends.count/3*2-1&&i<recommends.count/3*3) {
                [tem3 addObject:model];
            }
        }

    }else{
        for (int i = 0; i<recommends.count; i++) {

            WERecommendModel *model =[recommends objectAtIndex:i];
            
            if (i<recommends.count/2) {
                [tem1 addObject:model];
            }
            if (i>recommends.count/2-1&&i<recommends.count/2*2) {
                [tem2 addObject:model];
            }
            

        }
        [tem3 addObjectsFromArray:tem2];
     
    }

//    for (int i = 0; i<recommends.count; i++) {
//        WERecommendModel *model =[recommends objectAtIndex:i];
//
//        if (i<recommends.count/3) {
//            [tem1 addObject:model];
//        }
//        if (i>recommends.count/3-1&&i<recommends.count/3*2) {
//            [tem2 addObject:model];
//        }
//        if (i>recommends.count/3*2-1&&i<recommends.count/3*3) {
//            [tem3 addObject:model];
//        }
//    }
    NSArray *tem =@[tem1,tem2,tem3];
    for (int i = 0; i < kBottomViewCount; i++) {
       WERecommendBgView *bgView =  [_bgViews objectAtIndex:i];
        if (i==0) {
            bgView.backgroundColor =[UIColor redColor];

        }else if(i==1){
            bgView.backgroundColor =[UIColor blueColor];

        }else{
            bgView.backgroundColor =[UIColor orangeColor];

        }
        [bgView setUpBgViewData:tem[i]];
    }
}


- (void)setHomeBottomScrollViewBlock:(homeBottomScrollViewBlock)block
{
    _block = block;
}


- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
 

}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    // 获得页码
    int doublePage = scrollView.contentOffset.x / scrollView.width;
    //    int intPage = (int)(doublePage + 0.5);
    // 设置页码
    _pageControl.currentPage = doublePage;
}

//- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate
//{
//    // 获得页码
//    int doublePage = scrollView.contentOffset.x / scrollView.width;
////    int intPage = (int)(doublePage + 0.5);
//    // 设置页码
//    _pageControl.currentPage = doublePage;
//}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
