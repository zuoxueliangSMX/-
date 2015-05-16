//
//  WECartHomeCellMiddleInfoView.m
//  WestElectromechanical
//
//  Created by zuo on 15/4/28.
//  Copyright (c) 2015年 zuo. All rights reserved.
//

#import "WECartHomeCellMiddleInfoView.h"
#import "UIImageView+WebCacheImg.h"
@interface WECartHomeCellMiddleInfoView()
{
    BOOL isClick;
}
/**
 *  选择btn
 */
@property(nonatomic,strong)UIButton *chooseBtn;
@property(nonatomic,weak)UIImageView *productImg;
@property(nonatomic,weak)UILabel *productLabel;
@property(nonatomic,weak)UILabel *productCartIdLabel;
@property(nonatomic,weak)UILabel *versionBrandLa;
@property(nonatomic,weak)UILabel *priceLabel;
@property(nonatomic,weak)UIView  *moveView;
@property(nonatomic)BOOL deleteNoOrYes;
@end
@implementation WECartHomeCellMiddleInfoView
- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        UIButton *chooseBtn =[UIButton buttonWithType:UIButtonTypeCustom];
        chooseBtn.frame =CGRectMake(10, frame.size.height*0.5-5, 20, 20);
        [chooseBtn setImage:[UIImage imageNamed:@"cart_notChose"] forState:UIControlStateNormal];
        [chooseBtn setImage:[UIImage imageNamed:@"cart_choseed"] forState:UIControlStateSelected];
        [chooseBtn setBackgroundColor:[UIColor clearColor]];
        [chooseBtn addTarget:self action:@selector(chooseClick:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:chooseBtn];
        _chooseBtn = chooseBtn;
        
        
        UIImageView *productImg =[[UIImageView alloc]init];
        productImg.frame =CGRectMake(CGRectGetMaxX(chooseBtn.frame)+10,frame.size.height * 0.5-40,80, 80);
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
        priceLabel.textColor =[UIColor redColor];
        priceLabel.backgroundColor =[UIColor clearColor];
        [self addSubview:priceLabel];
        _priceLabel = priceLabel;
    }
    return self;
}


- (void)setMyCartModel:(MyCartM *)myCartModel
{
    _myCartModel = myCartModel;
    
    _priceLabel.text =[NSString stringWithFormat:@"¥ %.2f",[myCartModel.p_price floatValue]];
    
    _versionBrandLa.text =[NSString stringWithFormat:@"型号:%@ 品牌:%@",myCartModel.p_version,myCartModel.p_brand];
    
    _productLabel.text =myCartModel.p_name;
    _productCartIdLabel.text =[NSString stringWithFormat:@"西域订货号:%@ ",myCartModel.p_order_num];
    [_productImg  setWebImgUrl:myCartModel.p_imgurl placeHolder:[UIImage imageNamed:@"Product_Placeholder"]];
    _chooseBtn.selected = myCartModel.isChoose;

}

- (void)setChosesBlock:(cartChoeseBlock)chosesBlock
{
    _chosesBlock =chosesBlock;

}


- (void)chooseClick:(UIButton *)btn{
    
    
    
    isClick = !isClick;
    
    if (isClick) {
        
        
        btn.selected =YES;
        self.deleteNoOrYes =YES;
        
        
    }else{
        
        
          btn.selected = NO;
        
         self.deleteNoOrYes =NO;
        
        
    }

    _chosesBlock(_chooseBtn);

    
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
