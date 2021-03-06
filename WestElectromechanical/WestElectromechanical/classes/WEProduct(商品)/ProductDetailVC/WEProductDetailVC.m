//
//  WEProductDetailVC.m
//  WestElectromechanical
//
//  Created by zuo on 15/5/7.
//  Copyright (c) 2015年 zuo. All rights reserved.
//

#import "WEProductDetailVC.h"
#import "RDVTabBarController.h"
#import "UIBarButtonItem+Extension.h"
#import "HomeHeaderScrollView.h"
#import "UIButton+Extension.h"
#import "WEHTTPHandler.h"
#import "WEProductInfoView.h"
#import "WEProductDetailInfoCell.h"
#import "AccountHanler.h"
#import "LoginVC.h"
#import "WEAdModel.h"
#import "WEProdcutCommentListVC.h"
#import "WECartHomeVC.h"
#import "WEHTTPHandler.h"
#import <ShareSDK/ShareSDK.h>
#import "WXApi.h"

#define TS_APP_SHARE_TEXT _detailModel.p_introduce
#define TS_APP_SHARE_INSTALL_URL @"http://www.ehsy.com"

#define TS_APP_SHARE_TITLE _detailModel.p_name
#define FIRIM_APP__URL [NSString stringWithFormat:@"http://www.ehsy.com/show.php?contentid=%@",_productId]
@interface WEProductDetailVC ()<UITableViewDataSource,UITableViewDelegate,UIWebViewDelegate>
{
    CGFloat _height;
}
@property (nonatomic ,weak)HomeHeaderScrollView *headerView;
@property (nonatomic ,weak)UIWebView *aWebView;
@property (nonatomic ,weak)UITableView *productForm;
@property (nonatomic ,weak)UILabel *dotImage;

@end

@implementation WEProductDetailVC


- (void)shareContentWeChatLocalImg
{
    //只需要在响应分享按钮的方法中添加以下代码即可
    UIImage *img = [UIImage imageNamed:@"launcher_Icon"];
    NSData *data =UIImageJPEGRepresentation(img, 1.0);
    
    //构造分享内容
    
   id<ISSContent> publishContent = [ShareSDK content:[NSString stringWithFormat:@"%@\n%@",TS_APP_SHARE_TEXT,TS_APP_SHARE_INSTALL_URL]
                        defaultContent:@""
                                 image:[ShareSDK imageWithData:data fileName:@"icon" mimeType:@"png"]
                                 title:TS_APP_SHARE_TITLE
                                   url:FIRIM_APP__URL
                           description:@""
                             mediaType:SSPublishContentMediaTypeNews];
    
    
    //创建弹出菜单容器
    id<ISSContainer> container = [ShareSDK container];
    //    [container setIPadContainerWithView:sender arrowDirect:UIPopoverArrowDirectionUp];
    
    //自定义标题栏相关委托
    id<ISSAuthOptions> authOptions = [ShareSDK authOptionsWithAutoAuth:YES
                                                         allowCallback:NO
                                                         authViewStyle:SSAuthViewStyleFullScreenPopup
                                                          viewDelegate:nil
                                               authManagerViewDelegate:nil];
    [ShareSDK showShareActionSheet:container
                         shareList:nil
                           content:publishContent
                     statusBarTips:YES
                       authOptions:authOptions
                      shareOptions:nil
                            result:^(ShareType type, SSResponseState state, id<ISSPlatformShareInfo> statusInfo, id<ICMErrorInfo> error, BOOL end) {
                                
                                if (state == SSResponseStateSuccess)
                                {
                                    NSLog(NSLocalizedString(@"TEXT_ShARE_SUC", @"分享成功"));
                                }
                                else if (state == SSResponseStateFail)
                                {
                                    NSLog(NSLocalizedString(@"TEXT_ShARE_FAI", @"分享失败,错误码:%d,错误描述:%@"), [error errorCode], [error errorDescription]);
                                }
                            }];
 
}

- (void)shareContentWeChat
{
 
    
    //只需要在响应分享按钮的方法中添加以下代码即可
    
    //构造分享内容
    
    NSString *imgUrl = [_detailModel.imgs[0] imgurl];
    id<ISSContent> publishContent = [ShareSDK content:[NSString stringWithFormat:@"%@\n%@",TS_APP_SHARE_TEXT,TS_APP_SHARE_INSTALL_URL]
                        defaultContent:@""
                                 image:[ShareSDK imageWithUrl:imgUrl]
                                 title:TS_APP_SHARE_TITLE
                                   url:FIRIM_APP__URL
                           description:@""
                             mediaType:SSPublishContentMediaTypeNews];
//    if (_detailModel.imgs.count>0) {
//
//    }else{
//        publishContent = [ShareSDK content:[NSString stringWithFormat:@"%@\n%@",TS_APP_SHARE_TEXT,TS_APP_SHARE_INSTALL_URL]
//                            defaultContent:@""
//                                     image:[ShareSDK imageWithData:data fileName:@"icon" mimeType:@"png"]
//                                     title:TS_APP_SHARE_TITLE
//                                       url:FIRIM_APP__URL
//                               description:@""
//                                 mediaType:SSPublishContentMediaTypeText];
//    }

    
    //创建弹出菜单容器
    id<ISSContainer> container = [ShareSDK container];
    //    [container setIPadContainerWithView:sender arrowDirect:UIPopoverArrowDirectionUp];
    
    //自定义标题栏相关委托
    id<ISSAuthOptions> authOptions = [ShareSDK authOptionsWithAutoAuth:YES
                                                         allowCallback:NO
                                                         authViewStyle:SSAuthViewStyleFullScreenPopup
                                                          viewDelegate:nil
                                               authManagerViewDelegate:nil];
    [ShareSDK showShareActionSheet:container
                         shareList:nil
                           content:publishContent
                     statusBarTips:YES
                       authOptions:authOptions
                      shareOptions:nil
                            result:^(ShareType type, SSResponseState state, id<ISSPlatformShareInfo> statusInfo, id<ICMErrorInfo> error, BOOL end) {
                                
                                if (state == SSResponseStateSuccess)
                                {
                                    NSLog(NSLocalizedString(@"TEXT_ShARE_SUC", @"分享成功"));
                                }
                                else if (state == SSResponseStateFail)
                                {
                                    NSLog(NSLocalizedString(@"TEXT_ShARE_FAI", @"分享失败,错误码:%d,错误描述:%@"), [error errorCode], [error errorDescription]);
                                }
                            }];
    
}



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

}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    [[self rdv_tabBarController] setTabBarHidden:NO animated:YES];
}
- (void)addRightItem{
    UIBarButtonItem *right1 =[UIBarButtonItem itemWithImageName:@"Navitation_Cart" highImageName:@"Navitation_Cart" target:self action:@selector(addCart:)];
//    UIBarButtonItem *right2 =[UIBarButtonItem itemWithImageName:@"Navitation_Cart" highImageName:@"Navitation_Cart" target:self action:@selector(shareProduct:)];
    
    UILabel *dotImage = [[UILabel alloc] init];
    dotImage.textAlignment = 1;
    
    dotImage.backgroundColor = [UIColor whiteColor];
    //    dotImage.tag = RED_DOT_TAG;
    
//    CGRect btnFrame = btn.frame;
    
    CGFloat x = ceilf(0.94 * right1.customView.size.width);
    
    CGFloat y = -ceilf(0.2 * right1.customView.size.height);
    dotImage.textColor =kNavBarColor;
    dotImage.frame = CGRectMake(x, y, 15, 15);
    
    //创建圆形遮罩，把用户头像变成圆形
    UIBezierPath* path = [UIBezierPath bezierPathWithArcCenter:CGPointMake(dotImage.frame.size.width/2,dotImage.frame.size.width/2) radius:dotImage.frame.size.width/2 startAngle:0 endAngle:2*M_PI clockwise:YES];
    CAShapeLayer* shape = [CAShapeLayer layer];
    shape.path = path.CGPath;
    dotImage.layer.mask = shape;
    [right1.customView addSubview:dotImage];
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

    
    
    
    
    UIBarButtonItem *right2 =[UIBarButtonItem itemWithImageName:@"" withTitle:@"分享" highImageName:nil withHighTitle:@"分享" target:self action:@selector(shareProduct:)];
    /**
     *  width为负数时，相当于btn向右移动width数值个像素，由于按钮本身和边界间距为5pix，所以width设为-15时，间距正好调整
     *  为10；width为正数时，正好相反，相当于往左移动width数值个像素
     */
    
    
    
    
    
    UIBarButtonItem *negativeSpacer = [[UIBarButtonItem alloc]
                                       initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace
                                       target:nil action:nil];
    negativeSpacer.width = -15;
    
    UIBarButtonItem *negativeSpacer1= [[UIBarButtonItem alloc]
                                       initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace
                                       target:nil action:nil];
    negativeSpacer1.width = -5;
    self.navigationItem.rightBarButtonItems = @[negativeSpacer, right2,negativeSpacer1,right1];
//    self.navigationItem.rightBarButtonItems =@[negativeSpacer, right1];
    
}
- (void)addCart:(UIButton*)btn{
    NSLog(@"添加到购物车");
    

    [self productAddCart:_productId];
}
- (void)shareProduct:(UIButton*)btn{
    NSLog(@"分享产品");
    
    if (_detailModel.imgs.count>0) {
        [self shareContentWeChat];

    }else{
        [self shareContentWeChatLocalImg];
    }

}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self addRightItem];
    self.view.backgroundColor =[UIColor colorFromHexCode:@"f2f2f2"];
    self.title = @"商品详情";
    
    self.automaticallyAdjustsScrollViewInsets = NO;
    [self initWebView];

}
- (void)initWebView
{
    UIWebView *webView =[[UIWebView alloc]initWithFrame:CGRectMake(0,0, SCREEN_WIDTH, 1)];
    webView.delegate = self;
    
    [self.view addSubview:webView];
    _aWebView = webView;
    [self loadHtml:_detailModel.p_introduce];
}
- (void)loadHtml:(NSString *)htmlStr
{
    //[_webView loadHTMLString:htmlStr baseURL:nil];
    
    /**
     *  修改htmlstr  添加viewport
     */
    //    if([htmlStr rangeOfString:@"viewport"].location == NSNotFound)
    //    {
    //          NSMutableString *htmlStr = [NSMutableString stringWithString:[_descriptionArray objectAtIndex:selectedButtonIndex];
    //        NSString*  htmlStrUpdate = [NSString stringWithFormat:@"<html><meta name=\"viewport\" content=\"width=320, height=10, user-scalable=yes, initial-scale=2.5, maximum-scale=5.0, minimun-scale=0.1\"><head></head><body>%@</body></html>",htmlStr];
    
    [_aWebView setScalesPageToFit:NO];
    NSString *htmlStr1 = [NSString stringWithFormat:@"<html><body>%@<script type=\"text/javascript\">for(var i = 0;i<document.images.length;++i){document.images[i].style.width = %f;document.images[i].style.height = %f/document.images[i].width*document.images[i].height;}</script>",htmlStr,self.view.bounds.size.width-20,self.view.bounds.size.width-20];
    
    
    [_aWebView loadHTMLString:htmlStr baseURL:[NSURL URLWithString:@"http://www.ehsy.com"]];
    //    }
    //    else
    //    {
    //        [_webView loadHTMLString:htmlStr baseURL:[NSURL URLWithString:@"http://115.29.178.110/"]];
    //    }
    
}
- (void)webViewDidFinishLoad:(UIWebView *)webView
{
    
     [webView stringByEvaluatingJavaScriptFromString:@"document.body.style.width=320"]; 
    
    //        //设置缩放
    //修改服务器页面的meta的值
    NSString *meta = [NSString stringWithFormat:@"document.getElementsByName(\"viewport\")[0].content = \"width=%f, initial-scale=1.0, minimum-scale=1.0, maximum-scale=6.0, user-scalable=yes",SCREEN_WIDTH];
    [webView stringByEvaluatingJavaScriptFromString:meta];
    ////
    //给网页增加utf-8编码
    [webView stringByEvaluatingJavaScriptFromString:
     @"var tagHead =document.documentElement.firstChild;"
     "var tagMeta = document.createElement(\"meta\");"
     "tagMeta.setAttribute(\"http-equiv\", \"Content-Type\");"
     "tagMeta.setAttribute(\"content\", \"text/html; charset=utf-8\");"
     "var tagHeadAdd = tagHead.appendChild(tagMeta);"];
    //
    //        //给网页增加css样式
    [webView stringByEvaluatingJavaScriptFromString:
     @"var tagHead =document.documentElement.firstChild;"
     "var tagStyle = document.createElement(\"style\");"
     "tagStyle.setAttribute(\"type\", \"text/css\");"
     "tagStyle.appendChild(document.createTextNode(\"BODY{padding: 5pt 5pt}\"));"
     "var tagHeadAdd = tagHead.appendChild(tagStyle);"];
    
    ;
    [webView stringByEvaluatingJavaScriptFromString:[NSString stringWithFormat:@"document.getElementsByTagName('img')[0].style.maxWidth = '%f';document.getElementsByTagName('img')[0].style.width = '%f';document.getElementsByTagName('img')[0].width = '%f';",self.view.bounds.size.width,self.view.bounds.size.width,self.view.bounds.size.width]];
    //    [webView stringByEvaluatingJavaScriptFromString:html];
    //    [webView stringByEvaluatingJavaScriptFromString:@"ResizeImages();"];
    /**
     *  stq
     此处设置广告图和WEB
     */
    //    [self setADImgAfterLoadHtml];
    
    
    CGRect frame = webView.frame;
    int old_height = frame.size.height;
    frame.size = CGSizeMake(SCREEN_WIDTH, 0);
    webView.frame = frame;
    float content_height = [[webView stringByEvaluatingJavaScriptFromString:@"document.body.offsetHeight;"] floatValue];
    frame = webView.frame;
    frame.size = CGSizeMake(SCREEN_WIDTH, content_height + 20);
    webView.frame = frame;
    DLog(@"SIZES - %i - %i",old_height + 4,(int) frame.size.height);
    _height = webView.scrollView.contentSize.height;
    _aWebView.delegate = nil;
    [_aWebView removeFromSuperview];
    [self initTableView];
    [self initTableHeaderView];
    [self initTableFooterView];
}
- (void)initTableView
{
    UITableView *productForm =[[UITableView alloc]init];
    productForm.frame =CGRectMake(0, 64, SCREEN_WIDTH, SCREEN_HEIGHT-64);
    productForm.delegate =self;
    productForm.dataSource =self;
    productForm.bounces = NO;
    productForm.backgroundColor =[UIColor clearColor];
    [self.view addSubview:productForm];
    _productForm = productForm;
    
}
- (void)initTableHeaderView
{
    HomeHeaderScrollView *headerView =[[HomeHeaderScrollView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH,(SCREEN_HEIGHT-64)*0.3) withType:JCDetailTopicDetail];
    headerView.backgroundColor =[UIColor clearColor];
    [self.view addSubview:headerView];
    _headerView = headerView;
    
    UIButton * collectionBtn =[UIButton buttonWithBgImageName:@"Product_collectionBtnBg" bgHighImageName:@"Product_collectionBtnBg" title:@"收藏" selectedTitle:@"已收藏" target:self action:@selector(collectionClick:)];
    collectionBtn.selected = _detailModel.isCollect;
    collectionBtn.frame = CGRectMake(SCREEN_WIDTH-80, CGRectGetHeight(_headerView.frame)-40, 60, 25);
    [_headerView addSubview:collectionBtn];
    _productForm.tableHeaderView = _headerView;
    
    NSMutableArray *temArray =[NSMutableArray array];
    UIImage * PlaceholderImage = [UIImage imageNamed:@"product_advert_default"];
    NSInteger index = 1;
    for (WEProductImgModel *adModel in _detailModel.imgs) {
        //网络图片
        //***********************//
        //key pic = 地址 NSString
        //key title = 显示的标题 NSString
        //key isLoc = 是否本地图片 Bool
        //key placeholderImage = 网络图片加载失败时显示的图片 UIImage
        //***********************//
        NSString *picTag =[NSString stringWithFormat:@"PIC%ld",index];
        DLog(@"%@",adModel.imgurl);

        DLog(@"%@",[NSDictionary dictionaryWithObjects:@[adModel.imgurl,picTag,@NO,PlaceholderImage] forKeys:@[@"pic",@"title",@"isLoc",@"placeholderImage"]]);
        [temArray addObject:[NSDictionary dictionaryWithObjects:@[adModel.imgurl,picTag,@NO,PlaceholderImage] forKeys:@[@"pic",@"title",@"isLoc",@"placeholderImage"]]];
    }
    headerView.imageURLs = temArray;
    if (temArray.count >0) {
        [headerView.imgPlayerView upDate];
    }
}

- (void)collectionClick:(UIButton *)btn
{
    DLog(@"收藏");
    WEHTTPHandler *handler =[[WEHTTPHandler alloc]init];

    if ([AccountHanler userId]) {
        if (btn.selected) {
            
            [handler executeDeleteMyCollectionTaskWithUserId:[AccountHanler userId] withProductIds:self.productId Success:^(id obj) {
                btn.selected = NO;
            } failed:^(id obj) {
                
            }];
        }else{
            [handler executeProductCollectionTaskWithProductId:self.productId withUserId:[AccountHanler userId] withSuccess:^(id obj) {
                btn.selected = YES;
            } withFailed:^(id obj) {
                
            }];
            
            
        }

    }else{
        
        LoginVC *loginVC =[[LoginVC alloc]init];
        WENavitationController *nav =[[WENavitationController alloc]initWithRootViewController:loginVC];
        [self presentViewController:nav animated:YES completion:^{
            
        }];
    }
    
    
}

- (void)initTableFooterView
{
    UIView *footer =[[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 50)];
    UIButton *button =[UIButton addTarget:self WithNorTitle:@"加入购物车" withNorColor:[UIColor whiteColor] withSelectedTitle:@"加入购物车" withSelectedColor:[UIColor whiteColor] withBackgroundColor:[UIColor redColor] withTileSize:font(16) action:@selector(addProductCart:)];
    button.frame = CGRectMake(5, 5, SCREEN_WIDTH-10, 40);
    button.layer.cornerRadius = 5;
    [footer addSubview:button];
    
    _productForm.tableFooterView = footer;
}
- (void)addProductCart:(UIButton *)btn
{
    [self productAddCart:_productId];
}
#pragma mark -
#pragma mark - UITableViewDataSource

- (NSInteger)tableView:(UITableView*)tableView numberOfRowsInSection:(NSInteger)section {
    return 2;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row<1) {
        return [WEProductInfoView sizeWithDetailModel:_detailModel].height+_height+10;
    }
    return 44;
}
- (UITableViewCell*)tableView:(UITableView*)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *CellIdentifier = @"Cell";
    WEProductDetailInfoCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if(cell == nil) {
        cell = [[WEProductDetailInfoCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;

    }
    if (indexPath.row > 0) {

        if (indexPath.row ==1) {
            cell.textLabel.text = @"商品评论";
        }
    }else{
        cell.height = _height;
         cell.detailModel =_detailModel;
    }
    
    return cell;
}
#pragma mark -
#pragma mark - UITableViewDelegate

- (void)tableView:(UITableView*)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {

    if (indexPath.row == 1){
        WEProdcutCommentListVC *commentListVC =[[WEProdcutCommentListVC alloc]init];
        commentListVC.productId =_productId;
        [self.navigationController pushViewController:commentListVC animated:YES];
    }
}



- (void)productAddCart:(NSString *)productId
{
    __weak WEProductDetailVC *bSelf =self;

    if (![AccountHanler userId]) {
        LoginVC *loginVC =[[LoginVC alloc]init];
        [loginVC setLoginBlock:^{
            [bSelf productRedreshProductData];
        }];
        WENavitationController *nav =[[WENavitationController alloc]initWithRootViewController:loginVC];
        [self presentViewController:nav animated:YES completion:^{
            
        }];
        
        
    }else{
        
        if ([_detailModel.p_price integerValue]>99999999.9999) {
            
            [AlertUtil showAlertWithText:@"商品暂不出售，请联系我们方可商谈价格"];
        }else{
            WEHTTPHandler *handler =[[WEHTTPHandler alloc]init];
            [handler executeProductAddCartTaskWithProductId:productId withUserId:[AccountHanler userId] withSuccess:^(id obj) {
                DLog(@"%@",obj);
                WECartHomeVC *homeVC =[[WECartHomeVC alloc]init];
                homeVC.cartType = WECartHomeTypeAdd;
                [bSelf.navigationController pushViewController:homeVC animated:YES];
            } withFailed:^(id obj) {
                DLog(@"加入购物车失败");
            }];
        }
        
        
       
        
    }
}



// 刷新产品相信数据
- (void)productRedreshProductData
{
    __weak WEProductDetailVC *bSelf = self;

    [[[WEHTTPHandler alloc]init] executeGetProductDetailDataWithProductId:self.productId withSuccess:^(id obj) {
        
        bSelf.detailModel = (WEProductDetailModel*)obj;
        NSIndexPath *indexPath =[NSIndexPath indexPathForRow:0 inSection:0];
       WEProductDetailInfoCell * cell = (WEProductDetailInfoCell *)[self.productForm cellForRowAtIndexPath:indexPath];
        cell.detailModel = bSelf.detailModel;
        if (_block) {
            _block();
        }
        
    } withFailed:^(id obj) {
        
    }];
}

- (void)setProductDetailBlock:(productDetailBlock)block
{
    _block = block;
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
