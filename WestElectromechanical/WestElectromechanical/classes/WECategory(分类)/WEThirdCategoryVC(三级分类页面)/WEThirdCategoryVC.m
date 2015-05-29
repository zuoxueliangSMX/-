//
//  WEThirdCategoryVC.m
//  WestElectromechanical
//
//  Created by zuo on 15/5/9.
//  Copyright (c) 2015年 zuo. All rights reserved.
//

#import "WEThirdCategoryVC.h"
#import "RDVTabBarController.h"
#import "WECategorySingleModel.h"
#import "WECategorysModel.h"
#import "WEHTTPHandler.h"
#import "WEProductListVC.h"
@interface WEThirdCategoryVC ()

@end

@implementation WEThirdCategoryVC
#pragma mark -
#pragma mark - pop和push控制器时的操作
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [[self rdv_tabBarController] setTabBarHidden:YES animated:YES];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    [[self rdv_tabBarController] setTabBarHidden:NO animated:YES];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)getRightData:(NSString *)categoryId
{
    WEHTTPHandler *handler =[[WEHTTPHandler alloc]init];
    [handler executeGetSecondCategoryTaskWithCategory:categoryId Success:^(id obj) {
        self.rightModel = (WECategorysModel *)obj;
        [self.rightTable reloadData];
        
    } WithFailed:^(id obj) {
        
    }];
}


/**
 *  获取下一个控制器的数据
 */
- (void)getNextVCData:(NSString *)categroyId
{
    WEHTTPHandler *handler =[[WEHTTPHandler alloc]init];
    __weak WEThirdCategoryVC *bSelf =self;
    [handler executeGetSearchDataWithSearchContent:categroyId withSuccess:^(id obj) {
        WEProductListVC *productListVC =[[WEProductListVC alloc]init];
        productListVC.products = (WEProductsModel *)obj;
        productListVC.t_id = categroyId;
        [bSelf.navigationController pushViewController:productListVC animated:YES];

    } withFailed:^(id obj) {
        
    }];
    
}




- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    if (tableView == self.leftTable) {
        UITableViewCell *selectedCell =[tableView cellForRowAtIndexPath:self.selectedIndex];
        selectedCell.backgroundColor =[UIColor clearColor];
        self.selectedIndex = indexPath;
        UITableViewCell *cell =[tableView cellForRowAtIndexPath:self.selectedIndex];
        cell.backgroundColor =[UIColor whiteColor];
        
        WECategorySingleModel *singleModel =self.leftModel.types[indexPath.row];
        [self getRightData:singleModel.t_id];
        
    }else{
        
        
        WECategorySingleModel *singleModel =self.rightModel.types[indexPath.row];
        [self getNextVCData:singleModel.t_id];
        
        
    }
    
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
