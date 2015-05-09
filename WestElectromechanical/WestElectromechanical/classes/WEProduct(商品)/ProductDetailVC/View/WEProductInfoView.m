//
//  WEProductInfoView.m
//  WestElectromechanical
//
//  Created by zuo on 15/5/8.
//  Copyright (c) 2015年 zuo. All rights reserved.
//

#import "WEProductInfoView.h"
#define kLeftMargin 10
#define kTopMargin 5
@interface WEProductInfoView()
@property (nonatomic ,weak)UILabel *prodcutName;
@property (nonatomic ,weak)UILabel *prodictPrice;
@property (nonatomic ,weak)UILabel *productOriType;
@property (nonatomic ,weak)UILabel *productBrand;
@property (nonatomic ,weak)UILabel *productOrderId;
@property (nonatomic ,weak)UILabel *productIntroduce;
@property (nonatomic ,weak)UILabel *line;
@end
@implementation WEProductInfoView
- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {

        UILabel *prodcutName =[[UILabel alloc]init];
        prodcutName.numberOfLines =1;
        prodcutName.font =font(16);
        prodcutName.backgroundColor =[UIColor clearColor];
        [self addSubview:prodcutName];
        _prodcutName = prodcutName;
        
        UILabel *prodictPrice =[[UILabel alloc]init];
        prodictPrice.numberOfLines =1;
        prodictPrice.font =font(16);
        prodictPrice.backgroundColor =[UIColor clearColor];
        [self addSubview:prodictPrice];
        _prodictPrice = prodictPrice;

        UILabel *productOriType =[[UILabel alloc]init];
        productOriType.numberOfLines =1;
        productOriType.font =font(16);
        productOriType.backgroundColor =[UIColor clearColor];
        [self addSubview:productOriType];
        _productOriType= productOriType;

        UILabel *productBrand =[[UILabel alloc]init];
        productBrand.numberOfLines =1;
        productBrand.font =font(16);
        productBrand.backgroundColor =[UIColor clearColor];
        [self addSubview:productBrand];
        _productBrand = productBrand;

        UILabel *productOrderId =[[UILabel alloc]init];
        productOrderId.numberOfLines =1;
        productOrderId.font =font(16);
        productOrderId.backgroundColor =[UIColor clearColor];
        [self addSubview:productOrderId];
        _productOrderId = productOrderId;

        
        UILabel *line =[[UILabel alloc]init];
        line.backgroundColor =[UIColor appLineColor];
        [self addSubview:line];
        _line = line;
        
        UILabel *productIntroduce =[[UILabel alloc]init];
        productIntroduce.numberOfLines =1;
        productIntroduce.font =font(16);
        productIntroduce.backgroundColor =[UIColor clearColor];
        
        [self addSubview:productIntroduce];
        _productIntroduce = productIntroduce;

    }
    return self;
}

- (void)setDetailModel:(WEProductDetailModel *)detailModel
{
    _detailModel = detailModel;
    CGFloat contentW =SCREEN_WIDTH-20;
    NSDictionary *dic = [NSDictionary dictionaryWithObjectsAndKeys:font(16),NSFontAttributeName, nil];

    NSString *name =[NSString stringWithFormat:@"商品名 : %@",detailModel.p_name];
    
    NSString *price =[NSString stringWithFormat:@"价格 : %@",detailModel.p_price];
    
    NSString *type =[NSString stringWithFormat:@"原始型号 : %@",detailModel.p_model];
    NSString *brand =[NSString stringWithFormat:@"品牌 : %@",detailModel.p_brand];
    NSString *orderNumber =[NSString stringWithFormat:@"西域订货号 : %@",detailModel.p_order_number];
    NSString *introduce =[NSString stringWithFormat:@"%@",detailModel.p_introduce];
    
    CGSize typeSize = [type boundingRectWithSize:CGSizeMake(contentW, CGFLOAT_MAX) options:NSStringDrawingUsesLineFragmentOrigin attributes:dic context:nil].size;
    CGSize nameSize = [name boundingRectWithSize:CGSizeMake(contentW, CGFLOAT_MAX) options:NSStringDrawingUsesLineFragmentOrigin attributes:dic context:nil].size;
    CGSize priceSize = [price boundingRectWithSize:CGSizeMake(contentW, CGFLOAT_MAX) options:NSStringDrawingUsesLineFragmentOrigin attributes:dic context:nil].size;
    CGSize brandSize = [brand boundingRectWithSize:CGSizeMake(contentW, CGFLOAT_MAX) options:NSStringDrawingUsesLineFragmentOrigin attributes:dic context:nil].size;
    CGSize orderNumberSize = [orderNumber boundingRectWithSize:CGSizeMake(contentW, CGFLOAT_MAX) options:NSStringDrawingUsesLineFragmentOrigin attributes:dic context:nil].size;
    
    CGSize introduceSize = [introduce boundingRectWithSize:CGSizeMake(contentW, CGFLOAT_MAX) options:NSStringDrawingUsesLineFragmentOrigin attributes:dic context:nil].size;

    
    self.prodcutName.text =name;
    self.prodictPrice.text =price;
    self.productOriType.text =type;
    self.productBrand.text = brand;
    self.productOrderId.text = orderNumber;
    self.productIntroduce.text = introduce;
    self.prodcutName.frame = CGRectMake(kLeftMargin, kTopMargin, nameSize.width, nameSize.height);
    
    self.prodictPrice.frame = CGRectMake(kLeftMargin, CGRectGetMaxY(_prodcutName.frame) + kTopMargin, priceSize.width, priceSize.height);
    
    self.productOriType.frame = CGRectMake(kLeftMargin, CGRectGetMaxY(_prodictPrice.frame) + kTopMargin, typeSize.width, typeSize.height);
    
    self.productBrand.frame = CGRectMake(kLeftMargin, CGRectGetMaxY(_productOriType.frame) + kTopMargin, brandSize.width, brandSize.height);
    
    self.productOrderId.frame = CGRectMake(kLeftMargin, CGRectGetMaxY(_productBrand.frame) + kTopMargin, orderNumberSize.width, orderNumberSize.height);
    
    self.line.frame = CGRectMake(kLeftMargin, CGRectGetMaxY(self.productOrderId.frame)+kTopMargin, contentW, 0.5);
    
    self.productIntroduce.frame = CGRectMake(kLeftMargin, CGRectGetMaxY(_productOrderId.frame) + 2*kTopMargin, introduceSize.width, introduceSize.height);
}


+ (CGSize)sizeWithDetailModel:(WEProductDetailModel *)model
{
    
//    @property (nonatomic ,strong)NSMutableArray *imgs;
//    @property (nonatomic ,assign)BOOL isCollect;
//    @property (nonatomic ,assign)NSInteger message;
//    @property (nonatomic ,copy)NSString *p_brand;
//    @property (nonatomic ,copy)NSString * p_introduce;
//    /**
//     *  评论条数
//     */
//    @property (nonatomic ,copy)NSString *p_comment_num;
//    @property (nonatomic ,copy)NSString * p_model;
//    @property (nonatomic ,strong)NSMutableArray *p_more_introduces;
//    @property (nonatomic ,copy)NSString *p_name;
//    @property (nonatomic ,copy)NSString *p_order_number;
//    @property (nonatomic ,copy)NSString *p_price;
    
    CGFloat height = 0;
    CGFloat contentW =SCREEN_WIDTH-20;
    NSDictionary *dic = [NSDictionary dictionaryWithObjectsAndKeys:font(16),NSFontAttributeName, nil];
    NSString *name =[NSString stringWithFormat:@"商品名 : %@",model.p_name];
 
    NSString *price =[NSString stringWithFormat:@"价格 : %@",model.p_price];

    NSString *type =[NSString stringWithFormat:@"原始型号 : %@",model.p_model];
    NSString *brand =[NSString stringWithFormat:@"品牌 : %@",model.p_brand];
    NSString *orderNumber =[NSString stringWithFormat:@"西域订货号 : %@",model.p_order_number];
    NSString *introduce =[NSString stringWithFormat:@"%@",model.p_introduce];
    
    CGSize typeSize = [type boundingRectWithSize:CGSizeMake(contentW, CGFLOAT_MAX) options:NSStringDrawingUsesLineFragmentOrigin attributes:dic context:nil].size;
    CGSize nameSize = [name boundingRectWithSize:CGSizeMake(contentW, CGFLOAT_MAX) options:NSStringDrawingUsesLineFragmentOrigin attributes:dic context:nil].size;
    CGSize priceSize = [price boundingRectWithSize:CGSizeMake(contentW, CGFLOAT_MAX) options:NSStringDrawingUsesLineFragmentOrigin attributes:dic context:nil].size;
    CGSize brandSize = [brand boundingRectWithSize:CGSizeMake(contentW, CGFLOAT_MAX) options:NSStringDrawingUsesLineFragmentOrigin attributes:dic context:nil].size;
    CGSize orderNumberSize = [orderNumber boundingRectWithSize:CGSizeMake(contentW, CGFLOAT_MAX) options:NSStringDrawingUsesLineFragmentOrigin attributes:dic context:nil].size;
    
    CGSize introduceSize = [introduce boundingRectWithSize:CGSizeMake(contentW, CGFLOAT_MAX) options:NSStringDrawingUsesLineFragmentOrigin attributes:dic context:nil].size;
    
    height = 6*kTopMargin+nameSize.height+priceSize.height+typeSize.height+brandSize.height+orderNumberSize.height+priceSize.height+introduceSize.height;
    return CGSizeMake(SCREEN_WIDTH, height);
    
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
