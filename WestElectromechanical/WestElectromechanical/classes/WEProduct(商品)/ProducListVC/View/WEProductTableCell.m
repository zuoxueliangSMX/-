//
//  WEProductTableCell.m
//  WestElectromechanical
//
//  Created by zuo on 15/5/7.
//  Copyright (c) 2015年 zuo. All rights reserved.
//

#import "WEProductTableCell.h"
#import "UIButton+Extension.h"
#import "UIImageView+WebCacheImg.h"
@interface WEProductTableCell()
@property (nonatomic ,weak)UIImageView *productImg;
@property (nonatomic ,weak)UILabel *productTitle;
@property (nonatomic ,weak)UILabel *productOrder;
@property (nonatomic ,weak)UILabel *productType;
@property (nonatomic ,weak)UILabel *productBrand;
@property (nonatomic ,weak)UILabel *productPrice;
@property (nonatomic ,weak)UILabel *productSalePrice;
@property (nonatomic ,weak)UIButton *acrtBtn;
@end
@implementation WEProductTableCell
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self =[super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        UIView *bgView =[[UIView alloc]initWithFrame:CGRectMake(0, 5, SCREEN_WIDTH, 100)];
        bgView.backgroundColor =[UIColor whiteColor];
        [self.contentView addSubview:bgView];
        
        UIImageView *productImg =[[UIImageView alloc]init];
        productImg.frame =CGRectMake(10,10,80,80);
        [productImg setImage:[UIImage imageNamed:@"Product_Placeholder"]];
        productImg.backgroundColor =[UIColor clearColor];
        [bgView addSubview:productImg];
        productImg.userInteractionEnabled=YES;
        _productImg = productImg;
        
        UILabel *productTitle =[[UILabel alloc]init];
        productTitle.frame =CGRectMake(CGRectGetMaxX(productImg.frame)+5,CGRectGetMinY(productImg.frame),SCREEN_WIDTH-CGRectGetMaxX(productImg.frame)-20,18);
        productTitle.numberOfLines =1;
        productTitle.font =font(16);
        productTitle.backgroundColor =[UIColor clearColor];
        [bgView addSubview:productTitle];
        _productTitle = productTitle;
        
        UILabel *productOrder =[[UILabel alloc]init];
        productOrder.frame =CGRectMake(CGRectGetMaxX(productImg.frame)+5,CGRectGetMaxY(productTitle.frame)+5,SCREEN_WIDTH-CGRectGetMaxX(productImg.frame)-20,18);
        productOrder.numberOfLines =1;
        productOrder.font =font(14);
        productOrder.backgroundColor =[UIColor clearColor];
        [bgView addSubview:productOrder];
        _productOrder = productOrder;
        
        
        UILabel *productType =[[UILabel alloc]init];
        productType.frame =CGRectMake(  CGRectGetMinX(productTitle.frame)+5,CGRectGetMaxY(productOrder.frame)+5,(CGRectGetWidth(productTitle.frame)-20)/2.0,16);
        productType.numberOfLines =1;
        productType.font =font(14);
        productType.backgroundColor =[UIColor clearColor];
        [bgView addSubview:productType];
        _productType = productType;

        
        UILabel *productBrand =[[UILabel alloc]init];
        productBrand.frame =CGRectMake(CGRectGetMaxX(productType.frame)+5,CGRectGetMaxY(productOrder.frame)+5,(CGRectGetWidth(productTitle.frame)-20)/2.0,16);
        productBrand.numberOfLines =1;
        productBrand.font =font(14);
        productBrand.backgroundColor =[UIColor clearColor];
        [bgView addSubview:productBrand];
        _productBrand = productBrand;
        

        UILabel *productOriPrice =[[UILabel alloc]init];
        productOriPrice.frame =CGRectMake(CGRectGetMinX(productType.frame),CGRectGetMaxY(productType.frame)+3,(CGRectGetWidth(productTitle.frame)-20)/3.0,16);
        productOriPrice.numberOfLines =1;
        productOriPrice.font =font(12);
        productOriPrice.textColor =[UIColor redColor];
        productOriPrice.backgroundColor =[UIColor clearColor];
        [bgView addSubview:productOriPrice];
        productOriPrice.text =@"￥ 32.6";
        _productPrice = productOriPrice;
        
        
        UILabel *productDiscountPrice =[[UILabel alloc]init];
        productDiscountPrice.frame =CGRectMake( CGRectGetMaxX(productOriPrice.frame)+5,CGRectGetMaxY(productType.frame)+3,(CGRectGetWidth(productTitle.frame)-20)/3.0,16);
        productDiscountPrice.numberOfLines =1;
        productDiscountPrice.font =font(10);
        productDiscountPrice.textColor =[UIColor appLineColor];
        productDiscountPrice.backgroundColor =[UIColor clearColor];
        productDiscountPrice.text =@"￥ 18.6";
        [bgView addSubview:productDiscountPrice];
        _productSalePrice = productDiscountPrice;
        
        
        UIButton *btn =[UIButton buttonWithImageName:@"Product_AddCart" highImageName:@"Product_AddCart" target:self action:@selector(addProductCart:)];
        btn.frame = CGRectMake(SCREEN_WIDTH-btn.size.width-20, CGRectGetMaxY(productType.frame)+3, btn.size.width, btn.size.height);
        [bgView addSubview:btn];

    }
    
    return self;
}


- (void)setSingleModel:(WEProductSingleModel *)singleModel
{
    _singleModel = singleModel;
    self.productTitle.text = singleModel.p_name;
    self.productType.text =  singleModel.p_version;
    self.productBrand.text = singleModel.p_brand;
    self.productOrder.text = singleModel.p_order_num;

    [self.productImg setWebImgUrl:singleModel.p_imgurl placeHolder:[UIImage imageNamed:@"Product_Placeholder"]];
    self.productPrice.text = [NSString stringWithFormat:@"￥ %@",singleModel.p_price];
    self.productSalePrice.text = [NSString stringWithFormat:@"￥ %@",singleModel.p_v_price];
    
}

- (void)addProductCart:(UIButton *)btn
{
    
}
@end
