//
//  MeVC.h
//  Haerbing
//
//  Created by sendInfo on 2014-12-19.
//  Copyright (c) 2014年 sendInfo. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef void(^loginBlock) (void);
@interface LoginVC : UIViewController
{
    __strong loginBlock _block;
}

- (void)setLoginBlock:(loginBlock)block;
@end
