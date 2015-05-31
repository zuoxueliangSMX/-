//
//  HomeHeaderScrollView.h
//  WestElectromechanical
//
//  Created by zuo on 15/4/26.
//  Copyright (c) 2015年 zuo. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ImagePlayerView.h"
#import "JCDetailTopic.h"

typedef void(^homeHeaderScrollViewBlock) (NSString *pid);
@interface HomeHeaderScrollView : UIView
{
    __strong homeHeaderScrollViewBlock _block;
}
@property (nonatomic ,weak)JCDetailTopic *imgPlayerView;
@property (nonatomic ,strong)NSMutableArray *imageURLs;
- (void)setHomeHeaderScrollViewBlock:(homeHeaderScrollViewBlock)block;
- (instancetype)initWithFrame:(CGRect)frame withType:(JCDetailTopicType)type;
@end
