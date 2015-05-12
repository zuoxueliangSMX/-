//
//  SelectModel.h
//  time
//
//  Created by Elon on 15/5/7.
//  Copyright (c) 2015年 chenyirong007. All rights reserved.
//

#import "BaseModel.h"

#define kSelectFieldOne @"field_one"
//#define kSelectFieldTwo @"field_two"

@interface SelectModel : BaseModel<IEntity>
@property (nonatomic ,copy)NSString * fieldOne;
//@property (nonatomic ,copy)NSString * fieldTwo;
@end
