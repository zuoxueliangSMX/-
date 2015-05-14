//
//  WEProductCommentModel.m
//  WestElectromechanical
//
//  Created by zuo on 15/5/14.
//  Copyright (c) 2015年 zuo. All rights reserved.
//

#import "WEProductCommentModel.h"

@implementation WEProductCommentModel
- (instancetype)initWithDict:(NSDictionary *)dict
{
    if (self = [super init]) {
        
        self.u_name =[self stringFromValue:[dict objectForKey:@"u_name"]];
        self.date =[self stringFromValue:[dict objectForKey:@"date"]];
        self.conmment =[self stringFromValue:[dict objectForKey:@"conmment"]];
        self.pics =[NSMutableArray arrayWithCapacity:0];
        for (NSDictionary *pic in [dict objectForKey:@"pics"]) {
            WEProductPicsModel *picModel =[[WEProductPicsModel alloc]initWithDict:pic];
            [self.pics addObject:picModel];
        }
    }
    return self;
}
@end
