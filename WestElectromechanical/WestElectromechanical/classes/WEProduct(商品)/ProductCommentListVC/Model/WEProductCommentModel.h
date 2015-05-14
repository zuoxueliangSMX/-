//
//  WEProductCommentModel.h
//  WestElectromechanical
//
//  Created by zuo on 15/5/14.
//  Copyright (c) 2015年 zuo. All rights reserved.
//

#import "BaseModel.h"
#import "WEProductPicsModel.h"
@interface WEProductCommentModel : BaseModel

@property (nonatomic ,copy)NSString * u_name;
@property (nonatomic ,copy)NSString * date;
@property (nonatomic ,copy)NSString * conmment;
@property (nonatomic ,strong)NSMutableArray * pics;
- (instancetype)initWithDict:(NSDictionary *)dict;

@end
