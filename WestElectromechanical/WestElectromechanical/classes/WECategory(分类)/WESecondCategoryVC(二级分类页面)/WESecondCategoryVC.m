//
//  WESecondCategoryVC.m
//  WestElectromechanical
//
//  Created by zuo on 15/5/9.
//  Copyright (c) 2015年 zuo. All rights reserved.
//

#import "WESecondCategoryVC.h"
#import "RDVTabBarController.h"
#import "WECategorySingleModel.h"
#import "WEHTTPHandler.h"
#import "WEThirdCategoryVC.h"
@interface WESecondCategoryVC ()

@end

@implementation WESecondCategoryVC
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
        self.rightModel = nil;
        self.rightModel = (WECategorysModel *)obj;
        [self.rightTable reloadData];
        
    } WithFailed:^(id obj) {
        
    }];
}


/**
 *  获取下一个控制器的数据
 */
- (void)getNextVCData:(WECategorySingleModel *)singleModel withCategoryName:(NSString *)name withIndex:(NSIndexPath *)index
{
    
    WEHTTPHandler *handler =[[WEHTTPHandler alloc]init];
    __weak WESecondCategoryVC *bSelf = self;
    
    [handler executeGetSecondCategoryTaskWithCategory:singleModel.t_id Success:^(id obj) {
        WEThirdCategoryVC *thirdCategoryVC =[[WEThirdCategoryVC alloc]init];
        thirdCategoryVC.title = name;
        thirdCategoryVC.leftModel = self.rightModel;
//        thirdCategoryVC.selectedIndex = index;
        thirdCategoryVC.selectedRow = index.row;
        WECategorysModel *categorysModel =(WECategorysModel *)obj;
        thirdCategoryVC.rightModel =categorysModel;
        [bSelf.navigationController pushViewController:thirdCategoryVC animated:YES];
        
    } WithFailed:^(id obj) {
        
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
        self.title =singleModel.t_name;
        [self getRightData:singleModel.t_id];
        
    }else{
        
        
        WECategorySingleModel *singleModel =self.rightModel.types[indexPath.row];
        DLog(@"%@-----%@-----%@",singleModel.t_name,singleModel.t_id,singleModel.t_types);
        [self getNextVCData:singleModel withCategoryName:singleModel.t_name withIndex:indexPath];

        
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
