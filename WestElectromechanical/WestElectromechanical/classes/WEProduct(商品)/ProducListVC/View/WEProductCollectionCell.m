//
//  WEProductCollectionCell.m
//  WestElectromechanical
//
//  Created by zuo on 15/5/6.
//  Copyright (c) 2015年 zuo. All rights reserved.
//

#import "WEProductCollectionCell.h"
#import "UIButton+Extension.h"
@interface WEProductCollectionCell()

@end
@implementation WEProductCollectionCell
- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        
        UIImageView *productImg =[[UIImageView alloc]init];
        productImg.frame =CGRectMake(5,5,frame.size.width-10, frame.size.width-10);
        [productImg setImage:[UIImage imageNamed:@"Product_Placeholder"]];
        productImg.backgroundColor =[UIColor clearColor];
        [self.contentView addSubview:productImg];
        productImg.userInteractionEnabled=YES;
        _productImg = productImg;
        
        _deleteBu = [UIButton buttonWithType:UIButtonTypeCustom];
        _deleteBu.hidden =YES;
        [_deleteBu setTitle:@"—" forState:UIControlStateNormal];
        [_deleteBu setTitle:@"" forState:UIControlStateHighlighted];
        [_deleteBu setFrame:CGRectMake(CGRectGetMaxX(productImg.frame)-30, CGRectGetMinY(productImg.frame)+5, 20, 20)];
        [_deleteBu setBackgroundColor:[UIColor redColor]];
        [_deleteBu.layer setMasksToBounds:YES];
        [_deleteBu.layer setCornerRadius:9];
//        [_deleteBu addTarget:self action:@selector(deleteClick) forControlEvents:UIControlEventTouchUpInside];
        [productImg addSubview:_deleteBu];
 
        
        
        
        UILabel *productTitle =[[UILabel alloc]init];
        productTitle.frame =CGRectMake(  CGRectGetMinX(productImg.frame),CGRectGetMaxY(productImg.frame)+5,frame.size.width-10,18);
        productTitle.numberOfLines =1;
        productTitle.font =font(16);
        productTitle.backgroundColor =[UIColor clearColor];
        [self.contentView addSubview:productTitle];
        _productTitle = productTitle;
        
        UILabel *productBrand =[[UILabel alloc]init];
        productBrand.frame =CGRectMake(  CGRectGetMinX(productImg.frame),CGRectGetMaxY(productTitle.frame)+5,(frame.size.width-15)/2.0,16);
        productBrand.numberOfLines =1;
        productBrand.font =font(14);
        productBrand.backgroundColor =[UIColor clearColor];
        [self.contentView addSubview:productBrand];
        _productBrand = productBrand;
        
        UILabel *productType =[[UILabel alloc]init];
        productType.frame =CGRectMake(  CGRectGetMaxX(productBrand.frame)+5,CGRectGetMaxY(productTitle.frame)+5,(frame.size.width-15)/2,16);
        productType.numberOfLines =1;
        productType.font =font(14);
        productType.backgroundColor =[UIColor clearColor];
        [self.contentView addSubview:productType];
        _productType = productType;
        
        UILabel *productOriPrice =[[UILabel alloc]init];
        productOriPrice.frame =CGRectMake(  CGRectGetMinX(productBrand.frame)+5,CGRectGetMaxY(productType.frame)+3,(frame.size.width-20)/3,16);
        productOriPrice.numberOfLines =1;
        productOriPrice.font =font(12);
        productOriPrice.textColor =[UIColor redColor];
        productOriPrice.backgroundColor =[UIColor clearColor];
        [self.contentView addSubview:productOriPrice];
        productOriPrice.text =@"￥ 32.6";

        _productType = productType;
        
        UILabel *productDiscountPrice =[[UILabel alloc]init];
        productDiscountPrice.frame =CGRectMake(  CGRectGetMaxX(productOriPrice.frame)+5,CGRectGetMaxY(productType.frame)+3,(frame.size.width-20)/3,16);
        productDiscountPrice.numberOfLines =1;
        productDiscountPrice.font =font(10);
        productDiscountPrice.textColor =[UIColor appLineColor];
        productDiscountPrice.backgroundColor =[UIColor clearColor];
        productDiscountPrice.text =@"￥ 18.6";
        [self.contentView addSubview:productDiscountPrice];
        _productType = productType;
        
        
        UIButton *btn =[UIButton buttonWithImageName:@"Product_AddCart" highImageName:@"Product_AddCart" target:self action:@selector(addCart:)];
        btn.frame = CGRectMake(frame.size.width-btn.size.width-20, CGRectGetMaxY(productType.frame)+3, btn.size.width, btn.size.height);
        [self.contentView addSubview:btn];
    }
    return self;
}

- (void)addCart:(UIButton *)btn
{
    DLog(@"添加到购物车");
}

@end
