//
//  WEProductModelImgModel.m
//  WestElectromechanical
//
//  Created by zuo on 15/5/7.
//  Copyright (c) 2015年 zuo. All rights reserved.
//

#import "WEProductModelImgModel.h"

@implementation WEProductModelImgModel
- (instancetype)initWithDict:(NSDictionary *)dict
{
    if (self = [super init]) {
        self.p_imgurl =[self stringFromValue:[dict objectForKey:@"p_imgurl"]];
    }
    return self;
}
@end
