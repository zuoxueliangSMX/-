//
//  WEHomeCityVC.h
//  WestElectromechanical
//
//  Created by zuo on 15/4/27.
//  Copyright (c) 2015年 zuo. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef void(^homeCityBlock) (NSString *city);
@interface WEHomeCityVC : UIViewController
{
    __strong homeCityBlock _block;
}
- (void)setHomeCityBlock:(homeCityBlock)block;
@end
