//
//  WECartHomeCellMiddleInfoView.h
//  WestElectromechanical
//
//  Created by zuo on 15/4/28.
//  Copyright (c) 2015年 zuo. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef void (^cartchooseBtnBlock)(UIButton *chooseBtn);


@interface WECartHomeCellMiddleInfoView : UIView
{
    __strong cartchooseBtnBlock _chooseBtnBlock;

}
@property(nonatomic,strong)UIButton *chooseBtn;
@property(nonatomic,strong)UIImageView *productImg;
@property(nonatomic,strong)UILabel *productLabel;
@property(nonatomic,strong)UILabel *productCartIdLabel;
@property(nonatomic,strong)UILabel *versionBrandLa;
@property(nonatomic,strong)UILabel *priceLabel;
@property(nonatomic,strong)UIView  *moveView;
@property(nonatomic)BOOL deleteNoOrYes;
- (void)cartchooseBlock:(cartchooseBtnBlock)chooseBtnBlock;

@end
