//
//  WEProductPicsModel.h
//  WestElectromechanical
//
//  Created by zuo on 15/5/14.
//  Copyright (c) 2015年 zuo. All rights reserved.
//

#import "BaseModel.h"

@interface WEProductPicsModel : BaseModel
@property (nonatomic ,copy)NSString * Imgurl;
- (instancetype)initWithDict:(NSDictionary *)dict;
@end
