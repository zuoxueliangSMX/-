//
//  CommentImgListView.h
//  time
//
//  Created by zuo on 15/3/23.
//  Copyright (c) 2015年 chenyirong007. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CommentImgListView : UIView
/**
 *  图片数据（里面都是Photo模型）
 */
@property (nonatomic, strong) NSArray *pic_urls;

/**
 *  根据图片个数计算相册的最终尺寸
 */
+ (CGSize)sizeWithPhotosCount:(NSInteger)photosCount;
@end
