//
//  WEProductComments.m
//  WestElectromechanical
//
//  Created by zuo on 15/5/14.
//  Copyright (c) 2015年 zuo. All rights reserved.
//

#import "WEProductComments.h"

@implementation WEProductComments
- (instancetype)initWithDict:(NSDictionary *)dict
{
    if (self = [super init]) {
        self.message =[dict objectForKey:@"message"];
        self.comments = [NSMutableArray array];
        
        self.page =[self stringFromValue:[dict objectForKey:@"page"]];
        self.pagej =[self stringFromValue:[dict objectForKey:@"pagej"]];
        
        for (NSDictionary *comment in [dict objectForKey:@"p_comments"]) {
            WEProductCommentModel *commentModel =[[WEProductCommentModel alloc]initWithDict:comment];
            WEProductCommentFrame *frame =[[WEProductCommentFrame alloc]init];
            frame.commentModel = commentModel;
            [self.comments addObject:frame];
        }
    
    }
    return self;
}
@end
