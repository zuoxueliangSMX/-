//
//  UIImageView+WebCacheImg.h
//  time
//
//  Created by zuo on 15/3/30.
//  Copyright (c) 2015年 chenyirong007. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImageView (WebCacheImg)
-  (void)setWebImgUrl:(NSString *)url;
-  (void)setWebImgUrl:(NSString *)url placeHolder:(UIImage *)placeHolder;
@end
