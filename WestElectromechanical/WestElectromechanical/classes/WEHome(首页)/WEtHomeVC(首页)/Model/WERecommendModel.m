//
//  WERecommendModel.m
//  WestElectromechanical
//
//  Created by zuo on 15/5/5.
//  Copyright (c) 2015年 zuo. All rights reserved.
//

#import "WERecommendModel.h"

@implementation WERecommendModel
- (instancetype)initWithDict:(NSDictionary *)dict
{
    if (self = [super init]) {
       self.contentid =[self stringFromValue:[dict objectForKey:@"contentid"]];
       self.Imgurl=[NSString stringWithFormat:@"%@%@",kWEProductImgUrl,[self stringFromValue:[dict objectForKey:@"imgurl"]]];
        DLog(@"Imgurl------>%@",self.Imgurl);
       self.p_id=[self stringFromValue:[dict objectForKey:@"p_id"]];
    }
    return self;
}
@end
