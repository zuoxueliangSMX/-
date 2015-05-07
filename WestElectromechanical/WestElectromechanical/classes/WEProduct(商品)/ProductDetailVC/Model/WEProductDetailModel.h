//
//  WEProductDetailModel.h
//  WestElectromechanical
//
//  Created by zuo on 15/5/7.
//  Copyright (c) 2015年 zuo. All rights reserved.
//

#import "BaseModel.h"
#import "WEProductImgModel.h"
#import "WEProductModelImgModel.h"
@interface WEProductDetailModel : BaseModel
@property (nonatomic ,strong)NSMutableArray *imgs;
@property (nonatomic ,assign)BOOL isCollect;
@property (nonatomic ,assign)NSInteger message;
@property (nonatomic ,copy)NSString *p_brand;
@property (nonatomic ,copy)NSString * p_introduce;
/**
 *  评论条数
 */
@property (nonatomic ,copy)NSString *p_comment_num;
@property (nonatomic ,copy)NSString * p_model;
@property (nonatomic ,strong)NSMutableArray *p_more_introduces;
@property (nonatomic ,copy)NSString *p_name;
@property (nonatomic ,copy)NSString *p_order_number;
@property (nonatomic ,copy)NSString *p_price;
- (instancetype)initWithDict:(NSDictionary *)dict;
@end
