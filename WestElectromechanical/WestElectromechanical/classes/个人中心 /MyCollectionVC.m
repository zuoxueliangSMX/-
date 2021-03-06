//
//  MyCollectionVC.m
//  WestElectromechanical
//
//  Created by 夏亚峰 on 15/5/5.
//  Copyright (c) 2015年 zuo. All rights reserved.
//

#import "MyCollectionVC.h"
#import "RDVTabBarController.h"
#import "UIBarButtonItem+Extension.h"
#import "UIButton+Extension.h"
#import "WEProductCollectionCell.h"
#import "WEHTTPHandler.h"
#import "AccountHanler.h"
#import "CollectionM.h"
#import "JsonToModel.h"
#import "NSString+Base64.h"
#import "UIImageView+WebCacheImg.h"
#import "WECartHomeVC.h"
#import "WEProductDetailVC.h"
#import "LoginVC.h"
#import "AccountHanler.h"
#import "AppDelegate.h"
@interface MyCollectionVC ()<UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout>{
    UIButton *shopingCartBtn,*editBtn,*deleteBtn;

    WEHTTPHandler *we;
   }
@property (nonatomic ,weak)UICollectionView *productCollection;
@property (nonatomic ,strong) NSMutableArray *arr;
@property (nonatomic ,weak)UILabel *dotImage;
@end

@implementation MyCollectionVC
#pragma mark -
#pragma mark - pop和push控制器时的操作
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [[self rdv_tabBarController] setTabBarHidden:YES animated:YES];
    if (![[NSUserDefaults standardUserDefaults] objectForKey:kProductCount]) {
        _dotImage.text = @"0";
    }else{
        
        if ([[[NSUserDefaults standardUserDefaults] objectForKey:kProductCount] integerValue]>99) {
            _dotImage.text =@"99";
        }else{
            _dotImage.text =[[NSUserDefaults standardUserDefaults] objectForKey:kProductCount];
        }
        
    }
    
    [self initNetData:1];
    

}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    [[self rdv_tabBarController] setTabBarHidden:NO animated:YES];
}

- (void)addRightItem{
    shopingCartBtn =[UIButton buttonWithType:UIButtonTypeCustom];
    shopingCartBtn.frame = CGRectMake(5, (44-18)/2.0, 36/2.0,34/2.0 );
    shopingCartBtn.backgroundColor = [UIColor clearColor];
    [shopingCartBtn setBackgroundImage:[UIImage imageNamed:@"Navitation_Cart"] forState:UIControlStateNormal];
    [shopingCartBtn addTarget:self action:@selector(shopingCartClick:) forControlEvents:UIControlEventTouchUpInside];
    
    UILabel *dotImage = [[UILabel alloc] init];
    dotImage.textAlignment = 1;
    
    dotImage.backgroundColor = [UIColor whiteColor];
    //    dotImage.tag = RED_DOT_TAG;
    
    //    CGRect btnFrame = btn.frame;
    
    CGFloat x = ceilf(0.94 * shopingCartBtn.size.width);
    
    CGFloat y = -ceilf(0.2 * shopingCartBtn.size.height);
    dotImage.textColor =kNavBarColor;
    dotImage.frame = CGRectMake(x, y, 15, 15);
    
    //创建圆形遮罩，把用户头像变成圆形
    UIBezierPath* path = [UIBezierPath bezierPathWithArcCenter:CGPointMake(dotImage.frame.size.width/2,dotImage.frame.size.width/2) radius:dotImage.frame.size.width/2 startAngle:0 endAngle:2*M_PI clockwise:YES];
    CAShapeLayer* shape = [CAShapeLayer layer];
    shape.path = path.CGPath;
    dotImage.layer.mask = shape;
    [shopingCartBtn addSubview:dotImage];
    dotImage.font = font(7);
    _dotImage = dotImage;
    
    if (![[NSUserDefaults standardUserDefaults] objectForKey:kProductCount]) {
        dotImage.text = @"0";
    }else{
        
        if ([[[NSUserDefaults standardUserDefaults] objectForKey:kProductCount] integerValue]>99) {
            dotImage.text =@"99";
        }else{
            dotImage.text =[[NSUserDefaults standardUserDefaults] objectForKey:kProductCount];
        }
        
    }
    
    
    
    
    editBtn = [[UIButton alloc] initWithFrame:CGRectMake(CGRectGetMaxX(shopingCartBtn.frame)+20, 5, 30, 30)];
    editBtn.backgroundColor = [UIColor clearColor];
    [editBtn setTitle:@"编辑" forState:UIControlStateNormal];
    
    [editBtn setTitle:@"取消" forState:UIControlStateSelected];
    editBtn.titleLabel.font =[UIFont systemFontOfSize:15];
    [editBtn addTarget:self action:@selector(rigBtnClick:) forControlEvents:UIControlEventTouchUpInside];
     UIView * view =[[UIView alloc]init];
    [view addSubview:shopingCartBtn];
    [view addSubview:editBtn];
    view.bounds = CGRectMake(0, 0, 70, 44);
    
       UIBarButtonItem *item = [[UIBarButtonItem alloc] initWithCustomView:view];
    self.navigationItem.rightBarButtonItem = item;
}


- (void)viewDidLoad {
    [super viewDidLoad];
     we=[[WEHTTPHandler alloc]init];
    _arr = [[NSMutableArray alloc] initWithCapacity:0];
    VIEW_BACKGROUND;
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.title = @"我的收藏";

    
   self.navigationController.navigationBar.titleTextAttributes = [NSDictionary dictionaryWithObject:[UIColor whiteColor] forKey:NSForegroundColorAttributeName];
    
    
    [self addRightItem];
    [self initCollectionView];
        }


- (void)initNetData:(NSInteger)page
{
    [we executeGetMyCollectionTaskWithUserId:[AccountHanler userId] withPage:[NSString stringWithFormat:@"%d",page] Success:^(id obj) {
        
        
      
        NSDictionary *dic = [obj objectForKey:@"products"];
        [_arr removeAllObjects];
        for (NSDictionary *dv in dic) {
            
            CollectionM *cm =  [JsonToModel objectFromDictionary:dv className:@"CollectionM"];
            [_arr addObject:cm];
            [self.productCollection reloadData];
        }
          NSLog(@"输出我的收藏的%@",_arr);
    } failed:^(id obj) {
        
        
        
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (void)initCollectionView
{
    UICollectionViewFlowLayout *flowLayout=[[UICollectionViewFlowLayout alloc] init];
    [flowLayout setScrollDirection:UICollectionViewScrollDirectionVertical];
    UICollectionView *  productCollection=[[UICollectionView alloc] initWithFrame:CGRectMake(0, 64, SCREEN_WIDTH, SCREEN_HEIGHT-64) collectionViewLayout:flowLayout];
    productCollection.dataSource=self;
    productCollection.delegate=self;
    [productCollection setBackgroundColor:[UIColor colorFromHexCode:@"f2f2f2"]];
    
    [productCollection registerClass:[WEProductCollectionCell class] forCellWithReuseIdentifier:@"UICollectionViewCell"];
    [productCollection registerClass:[UICollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"header"];
    [productCollection registerClass:[UICollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:@"footer"];
    _productCollection =productCollection;
    [self.view addSubview:productCollection];
    
}

#pragma mark -- UICollectionViewDataSource

//定义展示的UICollectionViewCell的个数
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return [_arr count];
}

//定义展示的Section的个数
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}


//每个UICollectionView展示的内容
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString * CellIdentifier = @"UICollectionViewCell";
    WEProductCollectionCell * cell = [collectionView dequeueReusableCellWithReuseIdentifier:CellIdentifier forIndexPath:indexPath];
    cell.backgroundColor =[UIColor whiteColor];
    CollectionM *cm = [_arr objectAtIndex:indexPath.row];
    
   
    cell.productTitle.text = [cm.p_name  base64DecodedString];
    cell.productType.text = cm.p_version;
    
    cell.productBrand.text =cm.p_brand;
    cell.deleteBu.tag=[indexPath row]+1;
    
    
    cell.addCartBtn.tag=[indexPath row]+100;
    


    
    
    cell.productOriPrice.text =[NSString stringWithFormat:@"¥%@",cm.p_v_price];
//    cell.productOriPrice.frame =CGRectMake(CGRectGetMinX(cell.productBrand.frame)-10,CGRectGetMaxY(cell.productType.frame)+3,((SCREEN_WIDTH-30)/2-20)/3+10,16);
    cell.prodcutSalePrice.text =[NSString stringWithFormat:@"¥%@",cm.p_price];
    
     NSString *path = [NSString stringWithFormat:@"%@/%@",kWEProductImgUrl,cm.p_imgurl];
    
   
    [ cell.productImg  setWebImgUrl:path placeHolder:[UIImage imageNamed:@"Product_Placeholder"]];

    
    deleteBtn =cell.deleteBu;
    [deleteBtn addTarget:self action:@selector(deleteClick:) forControlEvents:UIControlEventTouchUpInside];
    [cell.addCartBtn  addTarget:self action:@selector(addCart:) forControlEvents:UIControlEventTouchUpInside];

    return cell;
}



#pragma mark --UICollectionViewDelegateFlowLayout
//定义每个Item 的大小
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    return CGSizeMake((SCREEN_WIDTH-30)/2,(SCREEN_WIDTH-30)/2+60);
}

//定义每个UICollectionView 的 margin
-(UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
{
    
    return UIEdgeInsetsMake(10,10,10,10);
}


- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section{
    
    return 10;
    
}
//设置每行的间距
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section
{
    
    return 10;
}


#pragma mark --UICollectionViewDelegate

//UICollectionView被选中时调用的方法
-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{

    CollectionM  *cm =[_arr objectAtIndex: indexPath.row];
    DLog(@"点击的是----%ld",indexPath.row);
    
    [self getProductDetailInfo:cm.p_id];
    
    
}
BOOL  isClick ;
-(void)rigBtnClick:(UIButton *)btn
{
    
    
    [[NSNotificationCenter
      defaultCenter] postNotificationName:@"acceptShow"
     
     object:self];

    if ( btn ==editBtn) {
        isClick = !isClick;
        
        if (isClick) {
            
            
            
            [btn setTitle:@"取消" forState:UIControlStateNormal ];
            return;
            
            
        }else {
            
            [btn setTitle:@"编辑" forState:UIControlStateNormal];
        }
        
  
    }else if (btn==shopingCartBtn){
    
    
    
    
    }
     }


-(void)deleteClick:(UIButton*)btn
{



//      NSLog(@"MyRow:%d",[_productCollection indexPathForCell:((WEProductCollectionCell*)[[btn superview]superview])].row);	//这个方便一点点，不用设置tag。

       NSInteger row= ((WEProductCollectionCell*)[[btn superview]superview]).tag;
    
        CollectionM  *cm =[_arr objectAtIndex: row];
    
    
        [_arr removeObject:cm];
     [we  executeDeleteMyCollectionTaskWithUserId:[AccountHanler userId] withProductIds:cm.p_id Success:^(id obj) {
          DLog(@"删除%@",obj);
         if ([[obj objectForKey:@"message"] isEqualToString:@"0"]) {
           
           

             dispatch_async(dispatch_get_main_queue(), ^{
                 
                 [self.productCollection reloadData];
                 WARN_ALERT(@"删除成功");

                 
             });
             
           
            


             
                      }
     } failed:^(id obj) {
         
     }];

}
-(void)shopingCartClick:(UIButton*)btn
{
    
    [self.navigationController popToRootViewControllerAnimated:NO];
    AppDelegate *delegate =(AppDelegate *)[UIApplication sharedApplication].delegate;
    delegate.tabBarController.selectedIndex =3;

}
- (void)addCart:(UIButton *)btn
{
    DLog(@"添加到购物车mm");
    
    NSInteger row2= btn.tag-100;
    
    CollectionM  *cm =[_arr objectAtIndex: row2];
    if (![AccountHanler userId]) {
        LoginVC *loginVC =[[LoginVC alloc]init];
        WENavitationController *nav =[[WENavitationController alloc]initWithRootViewController:loginVC];
        [self presentViewController:nav animated:YES completion:^{
            
        }];
        
        
    }else{
        WEHTTPHandler *HTTPhandler =[[WEHTTPHandler alloc]init];
        __weak MyCollectionVC *bSelf =self;
        [HTTPhandler executeProductAddCartTaskWithProductId:cm.p_id withUserId:[AccountHanler userId] withSuccess:^(id obj) {
            DLog(@"%@",obj);
            WECartHomeVC *homeVC =[[WECartHomeVC alloc]init];
            homeVC.cartType = WECartHomeTypeAdd;
            [bSelf.navigationController pushViewController:homeVC animated:YES];
        } withFailed:^(id obj) {
            DLog(@"加入购物车失败");
        }];
        
    }

}








- (void)getProductDetailInfo:(NSString *)productId
{
    WEHTTPHandler *handler =[[WEHTTPHandler alloc]init];
    [handler executeGetProductDetailDataWithProductId:productId withSuccess:^(id obj) {
        DLog(@"%@",obj);
        WEProductDetailVC *detailVC =[[WEProductDetailVC alloc]init];
        detailVC.productId =productId;
        detailVC.detailModel = (WEProductDetailModel *)obj;
        [self.navigationController pushViewController:detailVC animated:YES];
    } withFailed:^(id obj) {
        
    }];
}

@end
