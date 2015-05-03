//
//  UIImageView+WebCacheImg.m
//  time
//
//  Created by zuo on 15/3/30.
//  Copyright (c) 2015年 chenyirong007. All rights reserved.
//

#import "UIImageView+WebCacheImg.h"
#import "UIImageView+AFNetworking.h"
@implementation UIImageView (WebCacheImg)
-  (void)setWebImgUrl:(NSString *)url placeHolder:(UIImage *)placeHolder
{
    [self setImageWithURL:[NSURL URLWithString:url] placeholderImage:placeHolder];
}

-  (void)setWebImgUrl:(NSString *)url
{
    [self setWebImgUrl:url placeHolder:nil];
}
@end
