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
        [self initFirstCategoryList:@"1000005"];
    } WithFailed:^(id obj) {
        DLog(@"WECategoryHomeVC---error->%@",obj);
    }];

}


/**
 *  产品二级分类列表
 */
- (void)initFirstCategoryList:(NSString *)categroyId
{
    
    WEHTTPHandler *handler =[[WEHTTPHandler alloc]init];
    [handler executeGetFirstCategoryTaskWithSuccess:^(id obj) {
        DLog(@"WECategoryHomeVC---json->%@",obj);
    } WithFailed:^(id obj) {
        DLog(@"WECategoryHomeVC---error->%@",obj);
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
    return _menuTitles.count;
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
    cell.contentLabel.text = _contentTitles[indexPath.row];
    cell.titleLabel.text = _menuTitles[indexPath.row];
    [cell.cateImg setImage:[UIImage imageNamed:_headers[indexPath.row]]];
    
    return cell;
}
#pragma mark -
#pragma mark - UITableViewDelegate

- (void)tableView:(UITableView*)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
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
