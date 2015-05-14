//
//  WEProductComments.h
//  WestElectromechanical
//
//  Created by zuo on 15/5/14.
//  Copyright (c) 2015年 zuo. All rights reserved.
//

#import "BaseModel.h"
#import "WEProductCommentFrame.h"
@interface WEProductComments : BaseModel

@property (nonatomic ,copy)NSString * message;
@property (nonatomic ,strong)NSMutableArray *comments;
@property (nonatomic ,copy)NSString *page;
@property (nonatomic ,copy)NSString *pagej;
- (instancetype)initWithDict:(NSDictionary *)dict;

@end
