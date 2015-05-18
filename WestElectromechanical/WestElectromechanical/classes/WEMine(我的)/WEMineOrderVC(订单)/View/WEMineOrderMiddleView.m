//
//  WEMineOrderMiddleView.m
//  WestElectromechanical
//
//  Created by zuo on 15/5/18.
//  Copyright (c) 2015年 zuo. All rights reserved.
//

#import "WEMineOrderMiddleView.h"
#import "WEOrderMiddleSubProductView.h"
#define kSubViewCount 2
@interface WEMineOrderMiddleView()
@property (nonatomic ,weak)UIView *line1;
@property (nonatomic ,weak)UIView *line2;
@property (nonatomic ,weak)UIView *line3;

@end
@implementation WEMineOrderMiddleView
- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        
    }
    return self;
}

/**
 *  监听图片的点击
 */
- (void)tapSubView:(UITapGestureRecognizer *)recognizer
{

}

- (void)setSubViewArr:(NSMutableArray *)subViewArr
{
    _subViewArr = subViewArr;
    for (int i = 0; i<subViewArr.count; i++) {
        
        WEOrderMiddleSubProductView *subView = [[WEOrderMiddleSubProductView alloc] initWithFrame:CGRectMake(0, 2+i*100, SCREEN_WIDTH, 98)];
        subView.tag = i;
        subView.productModel = subViewArr[i];
        [self addSubview:subView];

    }

}


//- (void)layoutSubviews
//{
//    [super layoutSubviews];
//    NSInteger count = self.subViewArr.count;
////    int maxCols = HMStatusPhotosMaxCols(count);
//    for (int i = 0; i<count; i++) {
//        WEOrderMiddleSubProductView *subView = self.subviews[i];
//        subView.frame =CGRectMake(0, 2+i*100, SCREEN_WIDTH, 98);
////        photoView.frame =CGRectMake( (i % maxCols) * (HMStatusPhotoW + HMStatusPhotoMargin),(i / maxCols) * (HMStatusPhotoH + HMStatusPhotoMargin),HMStatusPhotoW, HMStatusPhotoH);
//    }
//}

+ (CGSize)sizeWithPhotosCount:(NSInteger)photosCount
{
    return CGSizeMake(SCREEN_WIDTH, 200);
}


@end
