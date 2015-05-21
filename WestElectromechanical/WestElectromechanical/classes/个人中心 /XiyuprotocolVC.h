//
//  XiyuprotocolVC.h
//  WestElectromechanical
//
//  Created by 夏亚峰 on 15/5/20.
//  Copyright (c) 2015年 zuo. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef void(^xiyuprotocolVCBlock) (NSInteger tag);
@interface XiyuprotocolVC : UIViewController
{
    __strong xiyuprotocolVCBlock _block;
}
@property(nonatomic,strong)NSString *text;
- (void)setXiyuprotocolVCBlock:(xiyuprotocolVCBlock)block;
@end
