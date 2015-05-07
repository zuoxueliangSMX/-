//
//  WEProductImgModel.h
//  WestElectromechanical
//
//  Created by zuo on 15/5/7.
//  Copyright (c) 2015年 zuo. All rights reserved.
//

#import "BaseModel.h"

@interface WEProductImgModel : BaseModel
@property (nonatomic ,copy)NSString *imgurl;
- (instancetype)initWithDict:(NSDictionary *)dict;
@end
