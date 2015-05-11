//
//  WESearchHomeVC.m
//  WestElectromechanical
//
//  Created by zuo on 15/4/26.
//  Copyright (c) 2015年 zuo. All rights reserved.
//

#import "WESearchHomeVC.h"
#import "WEHTTPHandler.h"
#import "WEHotRecommendModel.h"
#import "WEProductListVC.h"
@interface WESearchHomeVC ()<UITableViewDataSource,UITableViewDelegate,UISearchBarDelegate>
@property (nonatomic, strong) NSArray *items;
@property (nonatomic ,weak)UISearchBar *mySearchBar;
@property (nonatomic ,weak)UITableView *searchTable;
@property (nonatomic ,strong)WEHotRecommendModel *hotRecommendModel;
@end

@implementation WESearchHomeVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor =[UIColor colorFromHexCode:@"#f2f2f2"];
    self.items = @[@"断路器附件    |    继电器    |    接触器", @"断路器附件    |    继电器    |    接触器"];
    UITableView *searchTable =[[UITableView alloc]init];
    searchTable.frame =CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT-49-64);
    searchTable.separatorInset = UIEdgeInsetsMake(0,10, 0, 10);
    searchTable.delegate =self;
    searchTable.dataSource =self;
    searchTable.backgroundColor =[UIColor clearColor];
    [self.view addSubview:searchTable];
    searchTable.tableFooterView =[[UIView alloc]init];

    UISearchBar *mySearchBar =[[UISearchBar alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 40)];
    [mySearchBar setAutocapitalizationType:UITextAutocapitalizationTypeNone];
    mySearchBar.delegate =self;
    [mySearchBar setPlaceholder:@"搜索分类"];
    [mySearchBar setClearsContextBeforeDrawing:YES];
    [mySearchBar setAutocapitalizationType:UITextAutocapitalizationTypeNone];
    [mySearchBar sizeToFit];
    mySearchBar.backgroundImage =[self imageWithColor:[UIColor clearColor] size:mySearchBar.bounds.size];
    _mySearchBar = mySearchBar;
    _searchTable = searchTable;
    searchTable.tableHeaderView = mySearchBar;
    [self initNetData:@"北京"];
}

/**
 *  获取热门推荐数据
 */
- (void)initNetData:(NSString *)cityName{
    WEHTTPHandler *handler =[[WEHTTPHandler alloc]init];
    [handler executeGetHotRecommendWithCityName:cityName withSuccess:^(id obj) {
        DLog(@"WESearchHomeVC--->%@",obj);
        _hotRecommendModel = (WEHotRecommendModel *)obj;
        [_searchTable reloadData];
        
    } withFailed:^(id obj) {
        DLog(@"WESearchHomeVC--->%@",obj);
    }];
    
}


/**
 *  根据内容搜索
 */
- (void)initSearchProductContent:(NSString *)content
{
    WEHTTPHandler *handler =[[WEHTTPHandler alloc]init];
    __weak WESearchHomeVC *bSelf = self;
    [handler executeGetSearchDataWithSearchProductName:content withSuccess:^(id obj) {
        DLog(@"%@",obj);
        WEProductListVC *productListVC =[[WEProductListVC alloc]init];
        productListVC.products = (WEProductsModel *)obj;
        [bSelf.navigationController pushViewController:productListVC animated:YES];
    } withFailed:^(id obj) {
        DLog(@"%@",obj);

    }];
}
/**
 *  根据内容搜索
 */
- (void)initSearchContent:(NSString *)content
{
    WEHTTPHandler *handler =[[WEHTTPHandler alloc]init];

    [handler executeGetSearchDataWithSearchContent:content withSuccess:^(id obj) {
        DLog(@"WESearchHomeVC--->%@",obj);
        [self initProductCommentList:@"12168005"];
    } withFailed:^(id obj) {
        DLog(@"WESearchHomeVC--->%@",obj);
    }];
    
}
/**
 *  产品加入购物车
 */
- (void)initProductCommentList:(NSString *)productId
{
    WEHTTPHandler *handler =[[WEHTTPHandler alloc]init];
    
    [handler executeGetProductCommentListTaskWithProductId:productId withSuccess:^(id obj) {
        DLog(@"WESearchHomeVC-----ProductCommentList--->%@",obj);
    } withFailed:^(id obj) {
        DLog(@"WESearchHomeVC-----ProductCommentList---->%@",obj);
    }];
}




/**
 *  产品详情
 */
- (void)initProductDetailData:(NSString *)productId{
    WEHTTPHandler *handler =[[WEHTTPHandler alloc]init];
    [handler executeGetProductDetailDataWithProductId:productId withSuccess:^(id obj) {
        DLog(@"WESearchHomeVC--->%@",obj);

        [self initProductCollectionWithProductId:@"12168006"withUserId:@"1002"];
    } withFailed:^(id obj) {
        DLog(@"WESearchHomeVC--->%@",obj);
    }];
    
}

/**
 *  产品收藏
 */
- (void)initProductCollectionWithProductId:(NSString *)productId withUserId:(NSString *)userId{
    WEHTTPHandler *handler =[[WEHTTPHandler alloc]init];
    [handler executeProductCollectionTaskWithProductId:productId withUserId:userId withSuccess:^(id obj) {
             DLog(@"WESearchHomeVC-Collection-->%@",obj);
        [self initProductAddCartWithProductId:@"12168006" withUserId:@"1002"];
    } withFailed:^(id obj) {
        DLog(@"WESearchHomeVC-Collection-->%@",obj);
        [self initProductAddCartWithProductId:@"12168006" withUserId:@"1002"];

    }];

    
}

/**
 *  产品加入购物车
 */
- (void)initProductAddCartWithProductId:(NSString *)productId withUserId:(NSString *)userId
{
    WEHTTPHandler *handler =[[WEHTTPHandler alloc]init];
    [handler executeProductAddCartTaskWithProductId:productId withUserId:userId withSuccess:^(id obj) {
        DLog(@"WESearchHomeVC-Collection-->%@",obj);
        
    } withFailed:^(id obj) {
        DLog(@"WESearchHomeVC-Collection-->%@",obj);
        [self initSearchContent:@"1001521"];
        
    }];
}

//取消searchbar背景色
- (UIImage *)imageWithColor:(UIColor *)color size:(CGSize)size
{
    CGRect rect = CGRectMake(0, 0, size.width, size.height);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, rect);
    
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return image;
}


#pragma mark -
#pragma mark - UISearchBarDelegate 和 UISearchDisplayDelegate
//searchBar开始编辑时改变取消按钮的文字
- (void)searchBarTextDidBeginEditing:(UISearchBar *)searchBar
{
    _mySearchBar.showsCancelButton = YES;
    
    NSArray *subViews;
    
    if (IOS7_OR_LATER) {
        subViews = [(_mySearchBar.subviews[0]) subviews];
    }
    else {
        subViews = _mySearchBar.subviews;
    }
    
    for (id view in subViews) {
        if ([view isKindOfClass:[UIButton class]]) {
            UIButton* cancelbutton = (UIButton* )view;
            [cancelbutton setTitle:@"取消" forState:UIControlStateNormal];
            break;
        }
    }
}

- (void)searchBarCancelButtonClicked:(UISearchBar *)searchBar
{
//    [_searchResults removeAllObjects];
    _mySearchBar.showsCancelButton = NO;

    [searchBar resignFirstResponder];
    
}
////searchBar进行搜索
//- (void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText
//{
//}
- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar
{
    [self initSearchProductContent:@"通电"];
    [searchBar resignFirstResponder];
}


#pragma mark -
#pragma mark - UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 44;
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView *header =[[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_HEIGHT, 44)];
    header.backgroundColor =kHightLightedColor;
    UILabel *Label =[[UILabel alloc]init];
    Label.frame =CGRectMake( 15,0,SCREEN_WIDTH-30,44);
    Label.numberOfLines =1;
    Label.textColor =[UIColor whiteColor];
    Label.font =[UIFont systemFontOfSize:18.0];
    Label.backgroundColor =[UIColor clearColor];
    Label.text = @"热门推荐";
    [header addSubview:Label];
    return header;
}
- (NSInteger)tableView:(UITableView*)tableView numberOfRowsInSection:(NSInteger)section {
    return _hotRecommendModel.infos.count;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 44;
}
- (UITableViewCell*)tableView:(UITableView*)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if(cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    cell.textLabel.text = [_hotRecommendModel.infos[indexPath.row] name];
    
    return cell;
}
#pragma mark -
#pragma mark - UITableViewDelegate

- (void)tableView:(UITableView*)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    [self initSearchProductContent:[_hotRecommendModel.infos[indexPath.row] name]];
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
