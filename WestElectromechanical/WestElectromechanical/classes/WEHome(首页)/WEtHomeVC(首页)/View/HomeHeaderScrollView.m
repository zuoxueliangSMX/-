//
//  HomeHeaderScrollView.m
//  WestElectromechanical
//
//  Created by zuo on 15/4/26.
//  Copyright (c) 2015年 zuo. All rights reserved.
//

#import "HomeHeaderScrollView.h"
#import "TAPageControl.h"
@interface HomeHeaderScrollView()<JCTopicDelegate>
@property (nonatomic ,weak)TAPageControl *pageControl;
@end
@implementation HomeHeaderScrollView
- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        
        _imageURLs =[NSMutableArray array];
        
        JCTopic *imagePlayerView = [[JCTopic alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, frame.size.height)];
//        imagePlayerView.backgroundColor = [UIColor blueColor];
        imagePlayerView.JCdelegate =self;
        [self addSubview:imagePlayerView];
        _imgPlayerView = imagePlayerView;
        
        
        TAPageControl *pageControl = [[TAPageControl alloc]initWithFrame:CGRectMake(0, frame.size.height-20, frame.size.width, 10)];;
        pageControl.currentDotImage =[UIImage imageNamed:@"Home_Green_Highlighted"];
        pageControl.dotImage =[UIImage imageNamed:@"Home_Green_Normal"];
        pageControl.backgroundColor =[UIColor clearColor];
        pageControl.numberOfPages=_imageURLs.count;
        [self addSubview:pageControl];
        _pageControl = pageControl;

    }
    return self;
}

- (void)setImageURLs:(NSMutableArray *)imageURLs
{
    _imageURLs = imageURLs;
    _imgPlayerView.pics = _imageURLs;;
    
}
- (void)setHomeHeaderScrollViewBlock:(homeHeaderScrollViewBlock)block
{
    _block = block;
}
-(void)didClick:(id)data{
    DLog(@"点击的是1张图");
    NSDictionary *dataDict = (NSDictionary *)data;
    if (_block) {
        _block([dataDict objectForKey:@"pId"]);
    }
}
-(void)currentPage:(int)page total:(NSUInteger)total{
    
    _pageControl.numberOfPages = total;
    _pageControl.currentPage = page;
}


/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
