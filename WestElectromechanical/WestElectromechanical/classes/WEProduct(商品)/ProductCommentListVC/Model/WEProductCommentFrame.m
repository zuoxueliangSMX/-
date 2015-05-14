//
//  WEProductCommentFrame.m
//  WestElectromechanical
//
//  Created by zuo on 15/5/14.
//  Copyright (c) 2015年 zuo. All rights reserved.
//

#import "WEProductCommentFrame.h"
#define kVerticalMargin 10
#define kHorizontalMargin 10
@implementation WEProductCommentFrame
- (void)setCommentModel:(WEProductCommentModel *)commentModel
{
    _commentModel = commentModel;
    CGFloat contentW = SCREEN_WIDTH - 2*kHorizontalMargin -2*kVerticalMargin;
    CGFloat contentBgW =SCREEN_WIDTH - kHorizontalMargin -kVerticalMargin;
    
    CGSize userNameSize = [[NSString stringWithFormat:@"用户名:%@",commentModel.u_name] sizeWithAttributes:[NSDictionary dictionaryWithObjectsAndKeys:font(16),NSFontAttributeName, nil]];
    _commentUserNameframe =CGRectMake(kHorizontalMargin, kVerticalMargin, userNameSize.width, userNameSize.height);
    
    CGSize dateSize = [commentModel.date sizeWithAttributes:[NSDictionary dictionaryWithObjectsAndKeys:font(16),NSFontAttributeName, nil]];
    _commentDateFrame =CGRectMake(SCREEN_WIDTH - 2*kHorizontalMargin-10-dateSize.width, CGRectGetMinY(_commentUserNameframe), dateSize.width, dateSize.height);
    
    _commentLineFrame = CGRectMake(10, CGRectGetMaxY(_commentUserNameframe)+15/2.0, contentW, 1);
    
    CGSize listSize = [CommentImgListView sizeWithPhotosCount:commentModel.pics.count];
    
    if (commentModel.conmment.length>0) {
        
        CGRect contentRect = [commentModel.conmment boundingRectWithSize:CGSizeMake(contentW, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:[NSDictionary dictionaryWithObjectsAndKeys:font(16),NSFontAttributeName, nil] context:nil];
        _commentContentFrame = CGRectMake(kHorizontalMargin, CGRectGetMaxY(_commentUserNameframe)+15, contentRect.size.width, contentRect.size.height);
        
        if (commentModel.pics.count>0) {
            
            _commentImgsFrame =CGRectMake(_commentContentFrame.origin.x, CGRectGetMaxY(_commentContentFrame)+kVerticalMargin, listSize.width, listSize.height);
            _commentBgFrame = CGRectMake(kHorizontalMargin, kVerticalMargin, contentBgW, CGRectGetMaxY(_commentImgsFrame)+kVerticalMargin);
        }else{
            
            _commentBgFrame = CGRectMake(kHorizontalMargin, kVerticalMargin, contentBgW, CGRectGetMaxY(_commentContentFrame)+kVerticalMargin);
        }
        
    }else{
        if (commentModel.pics.count>0) {
            _commentImgsFrame =CGRectMake(_commentUserNameframe.origin.x, CGRectGetMaxY(_commentUserNameframe)+15, listSize.width, listSize.height);
            _commentBgFrame = CGRectMake(kHorizontalMargin, kVerticalMargin, contentBgW, CGRectGetMaxY(_commentImgsFrame)+kVerticalMargin);
        }
    }

    _commentHeight = CGRectGetMaxY(_commentBgFrame)+kVerticalMargin;
    
}
@end
