//
//  WEProductDetailVC.h
//  WestElectromechanical
//
//  Created by zuo on 15/5/7.
//  Copyright (c) 2015年 zuo. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WEProductDetailModel.h"
typedef void(^productDetailBlock) ();
@interface WEProductDetailVC : UIViewController
{
    __strong productDetailBlock _block;
}
@property (nonatomic ,copy)NSString * productId;
@property (nonatomic ,strong)WEProductDetailModel *detailModel;
- (void)setProductDetailBlock:(productDetailBlock)block;
@end
