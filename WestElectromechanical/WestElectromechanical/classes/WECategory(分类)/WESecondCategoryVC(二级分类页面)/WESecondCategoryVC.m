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
    __weak WESecondCategoryVC *bSelf = self;
    
    [handler executeGetSecondCategoryTaskWithCategory:categroyId Success:^(id obj) {
        WEThirdCategoryVC *thirdCategoryVC =[[WEThirdCategoryVC alloc]init];
        thirdCategoryVC.leftModel = (WECategorysModel *)obj;
        WECategorysModel *categorysModel =(WECategorysModel *)obj;
        WECategorySingleModel *singleModel =categorysModel.types[0];
        WEHTTPHandler *secondhandler =[[WEHTTPHandler alloc]init];
        
        [secondhandler executeGetSecondCategoryTaskWithCategory:singleModel.t_id Success:^(id obj) {
            thirdCategoryVC.rightModel = (WECategorysModel *)obj;
            [bSelf.navigationController pushViewController:thirdCategoryVC animated:YES];
            
        } WithFailed:^(id obj) {
            
        }];
    } WithFailed:^(id obj) {
        
    }];
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    if (tableView == self.leftTable) {
        UITableViewCell *selectedCell =[tableView cellForRowAtIndexPath:self.selectedIndex];
        selectedCell.backgroundColor =[UIColor whiteColor];
        self.selectedIndex = indexPath;
        UITableViewCell *cell =[tableView cellForRowAtIndexPath:self.selectedIndex];
        cell.backgroundColor =[UIColor lightGrayColor];
        
        WECategorySingleModel *singleModel =self.leftModel.types[indexPath.row];
        [self getRightData:singleModel.t_id];
        
    }else{
        
        
        WECategorySingleModel *singleModel =self.leftModel.types[indexPath.row];
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
