//
//  CommentImgListView.m
//  time
//
//  Created by zuo on 15/3/23.
//  Copyright (c) 2015年 chenyirong007. All rights reserved.
//

#import "CommentImgListView.h"
#import "UIImageView+WebCacheImg.h"
#import "WEProductImgModel.h"
#define HMStatusPhotosMaxCount 9
#define HMStatusPhotosMaxCols(photosCount) ((photosCount==4)?2:3)
#define HMStatusPhotoW (SCREEN_WIDTH -60)/3

#define HMStatusPhotoH HMStatusPhotoW
#define HMStatusPhotoMargin 1
@implementation CommentImgListView
- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        // 预先创建9个图片控件
        for (int i = 0; i<HMStatusPhotosMaxCount; i++) {
            UIImageView *photoView = [[UIImageView alloc] init];
            photoView.tag = i;
            [self addSubview:photoView];
            
            // 添加手势监听器（一个手势监听器 只能 监听对应的一个view）
            UITapGestureRecognizer *recognizer = [[UITapGestureRecognizer alloc] init];
            [recognizer addTarget:self action:@selector(tapPhoto:)];
            [photoView addGestureRecognizer:recognizer];
        }
    }
    return self;
}

/**
 *  监听图片的点击
 */
- (void)tapPhoto:(UITapGestureRecognizer *)recognizer
{
//    // 1.创建图片浏览器
//    MJPhotoBrowser *browser = [[MJPhotoBrowser alloc] init];
//    
//    // 2.设置图片浏览器显示的所有图片
//    NSMutableArray *photos = [NSMutableArray array];
//    int count = self.pic_urls.count;
//    for (int i = 0; i<count; i++) {
//        HMPhoto *pic = self.pic_urls[i];
//        
//        MJPhoto *photo = [[MJPhoto alloc] init];
//        // 设置图片的路径
//        photo.url = [NSURL URLWithString:pic.bmiddle_pic];
//        // 设置来源于哪一个UIImageView
//        photo.srcImageView = self.subviews[i];
//        [photos addObject:photo];
//    }
//    browser.photos = photos;
//    
//    // 3.设置默认显示的图片索引
//    browser.currentPhotoIndex = recognizer.view.tag;
//    
//    // 3.显示浏览器
//    [browser show];
}

- (void)setPic_urls:(NSArray *)pic_urls
{
    _pic_urls = pic_urls;
    
    for (int i = 0; i<HMStatusPhotosMaxCount; i++) {
        UIImageView *photoView = self.subviews[i];
        
        if (i < pic_urls.count) { // 显示图片
//            photoView.photo = pic_urls[i];
            WEProductImgModel *model = pic_urls[i];
            [photoView setWebImgUrl:model.imgurl placeHolder:[UIImage imageNamed:@"Product_Placeholder"]];
            photoView.hidden = NO;
        } else { // 隐藏
            photoView.hidden = YES;
        }
    }
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    NSInteger count = self.pic_urls.count;
    int maxCols = HMStatusPhotosMaxCols(count);
    for (int i = 0; i<count; i++) {
        UIImageView *photoView = self.subviews[i];
        photoView.frame =CGRectMake( (i % maxCols) * (HMStatusPhotoW + HMStatusPhotoMargin),(i / maxCols) * (HMStatusPhotoH + HMStatusPhotoMargin),HMStatusPhotoW, HMStatusPhotoH);
    }
}

+ (CGSize)sizeWithPhotosCount:(NSInteger)photosCount
{
    int maxCols = HMStatusPhotosMaxCols(photosCount);
    
    // 总列数
    NSInteger totalCols = photosCount >= maxCols ?  maxCols : photosCount;
    
    // 总行数
    NSInteger totalRows = (photosCount + maxCols - 1) / maxCols;
    
    // 计算尺寸
    CGFloat photosW = totalCols * HMStatusPhotoW + (totalCols - 1) * HMStatusPhotoMargin;
    CGFloat photosH = totalRows * HMStatusPhotoH + (totalRows - 1) * HMStatusPhotoMargin;
    
    return CGSizeMake(photosW, photosH);
}

@end
