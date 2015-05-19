//
//  WEProductTableCell.h
//  WestElectromechanical
//
//  Created by zuo on 15/5/7.
//  Copyright (c) 2015年 zuo. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WEProductSingleModel.h"
typedef void(^productAddCartBlock) (NSString *productId);
@interface WEProductTableCell : UITableViewCell
{
    __strong productAddCartBlock _block;
}
@property (nonatomic ,strong)WEProductSingleModel *singleModel;
- (void)setProductAddCartBlock:(productAddCartBlock)block;
@end
