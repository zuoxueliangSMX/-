//
//  WEProductDetailModel.m
//  WestElectromechanical
//
//  Created by zuo on 15/5/7.
//  Copyright (c) 2015年 zuo. All rights reserved.
//

#import "WEProductDetailModel.h"
#import "NSString+Base64.h"
@implementation WEProductDetailModel
- (instancetype)initWithDict:(NSDictionary *)dict
{
    if (self = [super init]) {
        self.imgs =[NSMutableArray array];
        for (NSDictionary *img in [dict objectForKey:@"imgs"]) {
            WEProductImgModel *imgModel =[[WEProductImgModel alloc]initWithDict:img];
            [self.imgs addObject:imgModel];
        }
        self.isCollect =![[dict objectForKey:@"iscollect"] boolValue];
        self.message =[[dict objectForKey:@"message"] integerValue];
        self.p_brand =[self stringFromValue:[dict objectForKey:@"p_brand"]];
        self.p_introduce=[self stringFromValue:[[dict objectForKey:@"p_introduce"] base64DecodedString]];
        /**
         *  评论条数
         */
        self.p_comment_num=[self stringFromValue:[dict objectForKey:@"p_comment_num"]];
        self.p_model=[self stringFromValue:[dict objectForKey:@"p_model"]];
        self.p_more_introduces=[NSMutableArray array];
        
        for (NSDictionary * more in [dict objectForKey:@"p_more_introduces"]) {
            
            WEProductModelImgModel *moreModel =[[WEProductModelImgModel alloc]initWithDict:more];
            [self.p_more_introduces addObject:moreModel];
        }
        self.p_name=[self stringFromValue:[[dict objectForKey:@"p_name"] base64DecodedString]];
        self.p_order_number=[self stringFromValue:[dict objectForKey:@"p_order_number"]];
        self.p_price=[self stringFromValue:[dict objectForKey:@"p_price"]];
    }
    return self;
}
@end
