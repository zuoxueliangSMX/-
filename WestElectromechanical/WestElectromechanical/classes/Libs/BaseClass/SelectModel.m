//
//  SelectModel.m
//  time
//
//  Created by Elon on 15/5/7.
//  Copyright (c) 2015年 chenyirong007. All rights reserved.
//

#import "SelectModel.h"

@implementation SelectModel
+ (NSArray*) getAllFields
{
    return @[kSelectFieldOne];
}
-(void) setFieldValue:(NSString*) fieldName value:(NSObject *)value{
    if([fieldName isEqualToString:kSelectFieldOne]){
        self.fieldOne = (NSString *)value;
    }
//    else if ([fieldName isEqualToString:kSelectFieldTwo]){
//        self.fieldTwo = (NSString *)value;
//    }
}
- (id)getFromFieldValue:(NSString *)fieldName{
    if([fieldName isEqualToString:kSelectFieldOne]){
        return self.fieldOne;
    }
//    else if ([fieldName isEqualToString:kSelectFieldTwo]){
//        return self.fieldTwo;
//    }
    return nil;
}
@end
