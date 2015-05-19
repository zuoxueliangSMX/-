//
//  WECategoryHomeVC.m
//  WestElectromechanical
//
//  Created by zuo on 15/4/26.
//  Copyright (c) 2015年 zuo. All rights reserved.
//

#import "WECategoryHomeVC.h"
#import "WECategoryHomeCell.h"
#import "WEHTTPHandler.h"
#import "WESecondCategoryVC.h"
#import "WECategorysModel.h"
#import "UIImageView+WebCacheImg.h"
#import "WECategorySingleModel.h"
@interface WECategoryHomeVC ()<UITableViewDelegate,UITableViewDataSource>
/**
 *  分类的tableview
 */
@property (nonatomic ,weak)UITableView *categoryTable;
/**
 *  cell标题数组
 */
@property (nonatomic ,strong)NSArray *menuTitles;
/**
 *  cell内容数组
 */
@property (nonatomic ,strong)NSArray *contentTitles;
/**
 *  cell图片数组
 */
@property (nonatomic ,strong)NSArray *headers;

@property (nonatomic ,strong)WECategorysModel *categorys;
@end

@implementation WECategoryHomeVC

- (void)viewDidLoad {
    [super viewDidLoad];
    UITableView *categoryView =[[UITableView alloc]init];
    categoryView.frame =CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT-49);
    categoryView.delegate =self;
    categoryView.dataSource =self;
    categoryView.backgroundColor =[UIColor clearColor];
    categoryView.separatorInset = UIEdgeInsetsMake(0,10, 0, 10);
    [self.view addSubview:categoryView];
    _categoryTable = categoryView;
    
    categoryView.tableFooterView =[[UIView alloc]init];
    _menuTitles = [NSArray arrayWithObjects:@"工具 | 工具耗材",@"量刃具 | 机床附件| 润滑胶粘",@"物业 | 清洁办公|照明",@"物料搬运 | 存储|包材",@"紧固件 | 密封件|五金件",@"焊接 | 磨料磨具",@"工业检测 | 仪表",@"泵 | 阀门 | 管件", nil];
    _contentTitles = [NSArray arrayWithObjects:@"工具套装 扳手/手动套筒 螺丝刀 钳/夹",@"卡尺千分尺千分表孔加工工具螺纹工具数控刀片",@"对讲机工业擦拭办公家具标签打印机地垫垃圾桶",@"平板手推车油桶搬运工位器具周转箱登高梯",@"平板手推车油桶搬运工位器具周转箱登高梯",@"平板手推车油桶搬运工位器具周转箱登高梯",@"平板手推车油桶搬运工位器具周转箱登高梯",@"平板手推车油桶搬运工位器具周转箱登高梯", nil];
    _headers =[NSArray arrayWithObjects:@"Category_spanner",@"Category_ruler",@"Category_brush",@"Category_trolley",@"Category_pliers",@"Category_weld",@"Category_instrument",@"Category_instrument",nil];
    
    
    [self initFirstCategoryList];
    
}
/**
 *  产品分类列表
 */
- (void)initFirstCategoryList
{

    WEHTTPHandler *handler =[[WEHTTPHandler alloc]init];
    [handler executeGetFirstCategoryTaskWithSuccess:^(id obj) {
        DLog(@"WECategoryHomeVC---json->%@",obj);
        _categorys = (WECategorysModel *)obj;
        [_categoryTable reloadData];
        
    } WithFailed:^(id obj) {
        DLog(@"WECategoryHomeVC---error->%@",obj);
    }];

}
//     [self initFirstCategoryList:@"1000005"];
/**
 *  产品二级分类列表
 */
- (void)initFirstCategoryList:(NSString *)categroyId
{
    
    WEHTTPHandler *handler =[[WEHTTPHandler alloc]init];
    __weak WECategoryHomeVC *bSelf = self;
    
    [handler executeGetSecondCategoryTaskWithCategory:categroyId Success:^(id obj) {
        WESecondCategoryVC *secondCategoryVC =[[WESecondCategoryVC alloc]init];
        secondCategoryVC.leftModel = (WECategorysModel *)obj;
        WECategorysModel *categorysModel =(WECategorysModel *)obj;
        WECategorySingleModel *singleModel =categorysModel.types[0];
        WEHTTPHandler *secondhandler =[[WEHTTPHandler alloc]init];
        
        [secondhandler executeGetSecondCategoryTaskWithCategory:singleModel.t_id Success:^(id obj) {
            secondCategoryVC.rightModel = (WECategorysModel *)obj;
            [bSelf.navigationController pushViewController:secondCategoryVC animated:YES];
            
        } WithFailed:^(id obj) {
            
        }];
    } WithFailed:^(id obj) {
        
    }];
    
}


/**
 *  产品三级分类列表
 */
- (void)initThirdCategoryList:(NSString *)categroyId
{
    
    WEHTTPHandler *handler =[[WEHTTPHandler alloc]init];
    [handler executeGetFirstCategoryTaskWithSuccess:^(id obj) {
        DLog(@"WECategoryHomeVC---json->%@",obj);
    } WithFailed:^(id obj) {
        DLog(@"WECategoryHomeVC---error->%@",obj);
    }];
    
}



#pragma mark -
#pragma mark - UITableViewDataSource

- (NSInteger)tableView:(UITableView*)tableView numberOfRowsInSection:(NSInteger)section {
    return _categorys.types.count;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 67;
}
- (UITableViewCell*)tableView:(UITableView*)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *CellIdentifier = @"Cell";
    WECategoryHomeCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if(cell == nil) {
        cell = [[WECategoryHomeCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    cell.titleLabel.text = [_categorys.types[indexPath.row] t_name];
    cell.contentLabel.text = _menuTitles[indexPath.row%_menuTitles.count];
    [cell.cateImg setWebImgUrl:[_categorys.types[indexPath.row] t_imgurl] placeHolder:[UIImage imageNamed:_headers[indexPath.row%_headers.count]]];
    
     DLog(@"这个数组里是什么%@",_categorys.types);
    
    
    return cell;
}
#pragma mark -
#pragma mark - UITableViewDelegate

- (void)tableView:(UITableView*)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    
    [self initFirstCategoryList:[_categorys.types[indexPath.row] t_name]];
    
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
