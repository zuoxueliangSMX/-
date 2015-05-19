//
//  WEProductCollectionCell.h
//  WestElectromechanical
//
//  Created by zuo on 15/5/6.
//  Copyright (c) 2015年 zuo. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WEProductSingleModel.h"
@interface WEProductCollectionCell : UICollectionViewCell

@property (nonatomic ,strong)WEProductSingleModel *singleModel;

/**
 *  产品图片
 */
@property (nonatomic ,weak)UIImageView *productImg;
/**
 *  产品名称
 */
@property (nonatomic ,weak)UILabel *productTitle;
/**
 *  品牌
 */
@property (nonatomic ,weak)UILabel *productBrand;
/**
 *  型号
 */
@property (nonatomic ,weak)UILabel *productType;

@property (nonatomic ,weak)UILabel *productOriPrice;
@property (nonatomic ,weak)UILabel *prodcutSalePrice;
/**
 删除按钮
 **/
@property (nonatomic ,weak)UIButton *deleteBu;


/**
添加到购物车
**/
@property (nonatomic ,weak)UIButton *addCartBtn;



@end
