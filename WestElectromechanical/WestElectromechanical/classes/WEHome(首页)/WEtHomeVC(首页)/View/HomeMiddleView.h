//
//  HomeMiddleView.h
//  WestElectromechanical
//
//  Created by zuo on 15/4/26.
//  Copyright (c) 2015年 zuo. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef void(^homeMiddleViewBlock) (NSInteger index);
@interface HomeMiddleView : UIView
{
    __strong homeMiddleViewBlock _block;
}
- (void)setHomeMiddleVieBlock:(homeMiddleViewBlock)block;
@end
