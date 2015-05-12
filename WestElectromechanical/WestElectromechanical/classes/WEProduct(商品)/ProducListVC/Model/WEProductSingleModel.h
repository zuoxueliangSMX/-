//
//  WEProductSingleModel.h
//  WestElectromechanical
//
//  Created by zuo on 15/5/9.
//  Copyright (c) 2015年 zuo. All rights reserved.
//

#import "BaseModel.h"
#define kProductId @"pid"
#define kProductName @"p_name"
#define kProductImgurl @"p_imgurl"
#define kProductOrderNum @"p_order_num" // 订货号
#define kProductPrice @"p_price"
#define kProductVPrice @"p_v_price"
#define kProductVersions @"p_version"
#define kProductBrand @"p_brand"
#define kProductScanTime @"p_scanTime"
@interface WEProductSingleModel : BaseModel<IEntity>
@property (nonatomic ,copy)NSString *p_brand;
@property (nonatomic ,copy)NSString *p_imgurl;
@property (nonatomic ,copy)NSString *p_name;
@property (nonatomic ,copy)NSString *p_order_num;
@property (nonatomic ,copy)NSString *p_price;
@property (nonatomic ,copy)NSString *p_v_price;
@property (nonatomic ,copy)NSString *p_version;
@property (nonatomic ,copy)NSString *pid;
@property (nonatomic ,copy)NSString *p_scanTime;
- (instancetype)initWithDict:(NSDictionary *)dict;
@end
