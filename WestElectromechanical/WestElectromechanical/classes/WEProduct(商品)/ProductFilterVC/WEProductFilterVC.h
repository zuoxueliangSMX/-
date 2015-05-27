//
//  WEProductFilterVC.h
//  WestElectromechanical
//
//  Created by zuo on 15/5/17.
//  Copyright (c) 2015年 zuo. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef void(^productFilterBlock) (void);
@interface WEProductFilterVC : UIViewController
{
    __strong productFilterBlock _block;
}
@property (nonatomic ,copy)NSString *t_id;
@property (nonatomic ,copy)NSString *productName;

- (void)setProductFilterBlock:(productFilterBlock)block;
@end
