//
//  WEProductCollectionCell.m
//  WestElectromechanical
//
//  Created by zuo on 15/5/6.
//  Copyright (c) 2015年 zuo. All rights reserved.
//

#import "WEProductCollectionCell.h"
#import "UIButton+Extension.h"
#import "UIImageView+WebCacheImg.h"
@interface WEProductCollectionCell()
{

    BOOL isClick;
}

@end
@implementation WEProductCollectionCell
- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        
        
        
        
        
        [[NSNotificationCenter
          defaultCenter] addObserver: self
         
         selector:
         @selector(acceptShow)
         
         name:
         @"acceptShow"
         
         object:
         nil];

        UIImageView *productImg =[[UIImageView alloc]init];
        productImg.frame =CGRectMake(5,5,frame.size.width-10, frame.size.width-10);
//        [productImg setImage:[UIImage imageNamed:@"Product_Placeholder"]];
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
        productTitle.font =font(13);
        productTitle.backgroundColor =[UIColor clearColor];
        [self.contentView addSubview:productTitle];
        _productTitle = productTitle;
        
        UILabel *productBrand =[[UILabel alloc]init];
        productBrand.frame =CGRectMake(  CGRectGetMinX(productImg.frame),CGRectGetMaxY(productTitle.frame)+5,(frame.size.width-15)/2.0,16);
        productBrand.numberOfLines =1;
        productBrand.font =font(10);
        productBrand.textColor = [UIColor lightGrayColor];
        productBrand.backgroundColor =[UIColor clearColor];
        [self.contentView addSubview:productBrand];
        _productBrand = productBrand;
        
        UILabel *productType =[[UILabel alloc]init];
        productType.frame =CGRectMake(  CGRectGetMaxX(productBrand.frame)+5,CGRectGetMaxY(productTitle.frame)+5,(frame.size.width-15)/2,16);
        productType.numberOfLines =1;
        productType.font =font(10);
          productType.textColor = [UIColor lightGrayColor];
        productType.backgroundColor =[UIColor clearColor];
        [self.contentView addSubview:productType];
        _productType = productType;
        
        UILabel *productOriPrice =[[UILabel alloc]init];
        productOriPrice.frame =CGRectMake(  CGRectGetMinX(productBrand.frame)+5,CGRectGetMaxY(productType.frame)+3,(frame.size.width-20)/3,16);
        productOriPrice.numberOfLines =1;
        productOriPrice.font =font(10);
               productOriPrice.textColor =[UIColor redColor];
        productOriPrice.backgroundColor =[UIColor clearColor];
        [self.contentView addSubview:productOriPrice];
        _productOriPrice = productOriPrice;
        
        UILabel *productDiscountPrice =[[UILabel alloc]init];
        productDiscountPrice.frame =CGRectMake(  CGRectGetMaxX(productOriPrice.frame)+5,CGRectGetMaxY(productType.frame)+3,(frame.size.width-20)/3,16);
        productDiscountPrice.numberOfLines =1;
        productDiscountPrice.font =font(10);
        productDiscountPrice.textColor =[UIColor appLineColor];
        productDiscountPrice.backgroundColor =[UIColor clearColor];
        [self.contentView addSubview:productDiscountPrice];
        _prodcutSalePrice = productDiscountPrice;
        
        
        UIButton *btn =[UIButton buttonWithImageName:@"Product_AddCart" highImageName:@"Product_AddCart" target:self action:@selector(addCart:)];
        btn.frame = CGRectMake(frame.size.width-btn.size.width-20, CGRectGetMaxY(productType.frame)+3, btn.size.width, btn.size.height);
        [self.contentView addSubview:btn];
    }
    return self;
}

//
//- (void)setSingleModel:(WEProductSingleModel *)singleModel
//{
//    _singleModel = singleModel;
//    
//    self.productTitle.text = singleModel.p_name;
//    self.productType.text =  singleModel.p_version;
//    self.productBrand.text = singleModel.p_brand;
////    self.productOrder.text = singleModel.p_order_num;
//    [self.productImg setWebImgUrl:singleModel.p_imgurl placeHolder:[UIImage imageNamed:@"Product_Placeholder"]];
//    self.productOriPrice.text = [NSString stringWithFormat:@"￥ %@",singleModel.p_price];
//    self.prodcutSalePrice.text = [NSString stringWithFormat:@"￥ %@",singleModel.p_v_price];
//    
//}

- (void)addCart:(UIButton *)btn
{
    DLog(@"添加到购物车");
}

-(void)acceptShow{

    isClick =!isClick;
    
    if (isClick) {
         self.deleteBu.hidden =NO;
    }else{
    
     self.deleteBu.hidden =YES;
    
    
    }
   

}


@end
