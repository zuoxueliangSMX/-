//
//  WEProductSingleModel.m
//  WestElectromechanical
//
//  Created by zuo on 15/5/9.
//  Copyright (c) 2015年 zuo. All rights reserved.
//

#import "WEProductSingleModel.h"
#import "NSString+val.h"
@implementation WEProductSingleModel
- (instancetype)initWithDict:(NSDictionary *)dict
{
    if (self = [super init]) {
        self.p_brand =[self stringFromValue:[dict objectForKey:@"p_brand"]];
        self.p_imgurl=[NSString stringWithFormat:@"%@/%@",kWEProductImgUrl,[self stringFromValue:[dict objectForKey:@"p_imgurl"]]];
        self.p_name=[self stringFromValue:[dict objectForKey:@"p_name"]];
        self.p_order_num=[self stringFromValue:[dict objectForKey:@"p_order_num"]];
        self.p_price=[self stringFromValue:[dict objectForKey:@"p_price"]];
        self.p_v_price=[self stringFromValue:[dict objectForKey:@"p_v_price"]];
        self.p_version=[self stringFromValue:[dict objectForKey:@"p_version"]];
        self.pid=[self stringFromValue:[dict objectForKey:@"pid"]];
        self.p_scanTime =@"0";

    }
    return self;
}


+ (NSArray*) getAllFields
{
    return @[kProductId,kProductBrand,kProductImgurl,kProductName,kProductOrderNum,kProductPrice,kProductVersions,kProductVPrice,kProductScanTime];
}

-(void) setFieldValue:(NSString*) fieldName value:(NSObject *)value{
    if([fieldName isEqualToString:kProductId]){
        self.pid = (NSString *)value;
    }
    else if ([fieldName isEqualToString:kProductVersions]){
        self.p_version = (NSString *)value;
    }
    else if ([fieldName isEqualToString:kProductPrice]){
        self.p_price = (NSString *)value;
    }
    else if([fieldName isEqualToString:kProductOrderNum]){
        self.p_order_num = (NSString *)value;
    }
    else if([fieldName isEqualToString:kProductName]){
        self.p_name = (NSString *)value;
    }
    else if([fieldName isEqualToString:kProductImgurl]){
        self.p_imgurl = (NSString *)value;
    }
    else if([fieldName isEqualToString:kProductBrand]){
        self.p_brand = (NSString *)value;
    }
    else if([fieldName isEqualToString:kProductVPrice]){
        self.p_v_price = (NSString *)value;
    }else if([fieldName isEqualToString:kProductScanTime]){
        self.p_scanTime =[NSString getDateStringWithDate:[NSDate date] DateFormat:@"yyyy-MM-dd HH:mm:ss"];
    }
}
- (id)getFromFieldValue:(NSString *)fieldName{
    if([fieldName isEqualToString:kProductId]){
        return self.pid;
    }
    else if ([fieldName isEqualToString:kProductVersions]){
        return self.p_version;
    }
    else if ([fieldName isEqualToString:kProductPrice]){
        return self.p_price;
    }
    else if([fieldName isEqualToString:kProductName]){
        return self.p_name;
    }
    else if ([fieldName isEqualToString:kProductImgurl]){
        return self.p_imgurl;
    }
    else if([fieldName isEqualToString:kProductBrand]){
        return self.p_brand;
    }else if([fieldName isEqualToString:kProductVPrice]){
        return self.p_v_price;
    }else if([fieldName isEqualToString:kProductOrderNum]){
        return self.p_order_num;
    }
    return nil;
}

@end
