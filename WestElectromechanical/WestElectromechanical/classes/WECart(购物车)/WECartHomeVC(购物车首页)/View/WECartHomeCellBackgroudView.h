//
//  WEHomeCellBackgroudView.h
//  WestElectromechanical
//
//  Created by zuo on 15/4/28.
//  Copyright (c) 2015年 zuo. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WECartHomeCellBottomView.h"
#import "WECartHomeCellMiddleInfoView.h"
typedef void (^cartHomeDeleteBtnBlock)(UIView *moveView,UIImageView *productImg,UIButton *chooseBtn);

@interface WECartHomeCellBackgroudView : UIView{
    

    UIButton *deleteBtn;
    
     __strong cartHomeDeleteBtnBlock _deleteBtnBlock;

}
@property(nonatomic,strong)WECartHomeCellBottomView *bottomView;
@property(nonatomic,strong)WECartHomeCellMiddleInfoView *middleview;

- (void)setCartdeleteBlock:(cartHomeDeleteBtnBlock)deleteBtnBlock;


@end
