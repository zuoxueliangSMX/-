//
//  WEOrderMiddleSubProductView.m
//  WestElectromechanical
//
//  Created by zuo on 15/5/18.
//  Copyright (c) 2015年 zuo. All rights reserved.
//

#import "WEOrderMiddleSubProductView.h"
#import "UIImageView+WebCacheImg.h"
@interface WEOrderMiddleSubProductView()
@property(nonatomic,weak)UIImageView *productImg;
@property(nonatomic,weak)UILabel *productLabel;
@property(nonatomic,weak)UILabel *productCartIdLabel;
@property(nonatomic,weak)UILabel *versionBrandLa;
@property(nonatomic,weak)UILabel *priceLabel;
@property (nonatomic ,weak)UIView *line;
@end
@implementation WEOrderMiddleSubProductView
- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        
        UIImageView *productImg =[[UIImageView alloc]init];
        productImg.frame =CGRectMake(15,frame.size.height * 0.5-40,80, 80);
        [productImg setImage:[UIImage imageNamed:@"ProductPlaceholder"]];
        [self addSubview:productImg];
        _productImg = productImg;
        
        UILabel *productLabel =[[UILabel alloc]init];
        productLabel.frame =CGRectMake(CGRectGetMaxX(productImg.frame)+10,CGRectGetMinY(productImg.frame),SCREEN_WIDTH-CGRectGetMaxX(productLabel.frame)-10-20,15);
        productLabel.numberOfLines =1;
        productLabel.font =[UIFont systemFontOfSize:12.0];
        productLabel.textColor =[UIColor darkGrayColor];
        productLabel.backgroundColor =[UIColor clearColor];
        [self addSubview:productLabel];
        _productLabel = productLabel;
        
        UILabel * productCartIdLabel =[[UILabel alloc]init];
        productCartIdLabel.frame =CGRectMake(CGRectGetMaxX(productImg.frame)+10,CGRectGetMaxY(productLabel.frame),SCREEN_WIDTH-CGRectGetMaxX(productImg.frame)-10-20,24);
        productCartIdLabel.numberOfLines =2;
        productCartIdLabel.font =[UIFont systemFontOfSize:12.0];
        productCartIdLabel.textColor =[UIColor lightGrayColor];
        productCartIdLabel.backgroundColor =[UIColor clearColor];
        [self addSubview:productCartIdLabel];
        _productCartIdLabel = productCartIdLabel;
        
        UILabel * versionBrandLa =[[UILabel alloc]init];
        versionBrandLa.frame =CGRectMake(CGRectGetMaxX(productImg.frame)+10,CGRectGetMaxY(productCartIdLabel.frame)+3,SCREEN_WIDTH-CGRectGetMinX(productCartIdLabel.frame)-10-20,15);
        versionBrandLa.numberOfLines =1;
        versionBrandLa.font =[UIFont systemFontOfSize:12.0];
        versionBrandLa.text =@"hdjkslkadsldkl";
        versionBrandLa.textColor =[UIColor lightGrayColor];
        versionBrandLa.backgroundColor =[UIColor clearColor];
        [self addSubview:versionBrandLa];
        _versionBrandLa = versionBrandLa;
        
        UILabel * priceLabel =[[UILabel alloc]init];
        priceLabel.frame =CGRectMake(CGRectGetMaxX(productImg.frame)+10,CGRectGetMaxY(versionBrandLa.frame)+3,SCREEN_WIDTH-CGRectGetMinX(productCartIdLabel.frame)-10-20,15);
        priceLabel.numberOfLines =1;
        priceLabel.font =[UIFont systemFontOfSize:12.0];
        priceLabel.textColor =[UIColor orangeColor];
        priceLabel.backgroundColor =[UIColor clearColor];
        [self addSubview:priceLabel];
        _priceLabel = priceLabel;
        
        UIView *line =[[UIView alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(productImg.frame)+5, SCREEN_WIDTH, 1)];
        line.backgroundColor =[UIColor colorFromHexCode:@"c2c2c2"];
        [self addSubview:line];
        _line = line;
    }
    return self;
}

- (void)setProductModel:(ProductsM *)productModel
{
    _productModel = productModel;
    
    
    _priceLabel.text =[NSString stringWithFormat:@"¥ %.2f x %@",[productModel.p_price floatValue],productModel.p_num];
    
    _versionBrandLa.text =[NSString stringWithFormat:@"型号:%@ 品牌:%@",productModel.p_version,productModel.p_brand];
    
    _productLabel.text =productModel.p_name;
    _productCartIdLabel.text =[NSString stringWithFormat:@"西域订货号:%@ ",productModel.p_order_num];
    [_productImg  setWebImgUrl:productModel.p_imgurl placeHolder:[UIImage imageNamed:@"Product_Placeholder"]];

}

@end
