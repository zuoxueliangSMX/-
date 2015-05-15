//
//  SheZhiVC.m
//  WestElectromechanical
//
//  Created by 夏亚峰 on 15/5/7.
//  Copyright (c) 2015年 zuo. All rights reserved.
//

#import "SheZhiVC.h"
#import "RDVTabBarController.h"
#import "WEHTTPHandler.h"
#import "AccountHanler.h"
#import "MarkSheetVC.h"
#import "TLAlertView.h"


@interface SheZhiVC ()<UITableViewDataSource,UITableViewDelegate,UIAlertViewDelegate>
{
    
    WEHTTPHandler *we;
    NSArray *imgArr;
    NSArray *titleArr;
    TLAlertView *alertView;
    
}


@end

@implementation SheZhiVC

-(void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [[self rdv_tabBarController] setTabBarHidden:YES animated:YES];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    [[self rdv_tabBarController] setTabBarHidden:NO animated:YES];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title =@"设置";
    
    we= [[WEHTTPHandler alloc]init];
    
           UITableView *table = [[UITableView alloc] initWithFrame:CGRectMake(0, 10,SCREEN_WIDTH,SCREEN_HEIGHT-64) style:UITableViewStylePlain];
    
    
    imgArr = @[@"Person_update",@"Person_advice",@"Person_share",@"Person_exit",];
    titleArr =@[@"版本更新",@"意见反馈评分",@"软件分享",@"注销"];
    table.backgroundColor =SET_COLOR(234.0, 234.0, 234.0);
    
    self.view.backgroundColor =SET_COLOR(234.0, 234.0, 234.0);
    
    table.delegate =self;
    table.dataSource =self;
    [self.view addSubview:table];
    UIView *view =[[UIView alloc]init];
    table.tableFooterView = view;
    
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}




- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
    return 70;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    
    return 4;
}
- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
    
    NSString * cellidentifer = @"cell";
    UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:cellidentifer];
    if (cell ==nil) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellidentifer];
        UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 65)] ;
        view.backgroundColor = [UIColor whiteColor];
        cell.backgroundColor = SET_COLOR(234.0, 234.0, 234.0);
        
        view.tag =10;
        [cell addSubview:view];
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    
        
        UIImageView *imgv =[[UIImageView alloc]initWithFrame:CGRectMake(10, 20, 30, 30)];
        imgv.tag =101;
        
        
        
        
        UILabel *nameLa = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(imgv.frame)+15, 20, 150, 30)];
        nameLa.textColor =[UIColor blackColor];
        nameLa.tag =100;
       
        

       [view addSubview:imgv];
       [view addSubview:nameLa];
        
    }
    
    UIView *view = (UIView*)[cell viewWithTag:10];
    
    UIImageView *imgv = (UIImageView*)[view viewWithTag:101];
    UILabel *nameLa = (UILabel*)[view viewWithTag:100];
    imgv.image =[UIImage imageNamed:[imgArr objectAtIndex:indexPath.row]];
    nameLa.text =[titleArr objectAtIndex:indexPath.row];
    
    
    
    return cell;
    
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    switch (indexPath.row) {
        case 0:
        {
        
        
         }
            break;
            
        case 1:
        {
            
            if ([AccountHanler loginState]==0) {
                
                ALERT_WARN(@"请先登录");
                return;
                
            }
            MarkSheetVC *mark = [MarkSheetVC alloc];
            [self.navigationController pushViewController:mark animated:YES];
            
        }
            break;
            
        case 2:
        {
            
            
        }
            break;
        case 3:
        {
            
            
            if ([AccountHanler loginState]==0) {
                
                ALERT_WARN(@"未登录");
                return;
                
            }
            
            alertView = [TLAlertView showInView:self.view withTitle:@"" message:@"你确定注销用户么？" confirmButtonTitle:@"确定" cancelButtonTitle:@"取消"];
            

            [alertView handleCancel:^{
                
            }         handleConfirm:^{
                
                [AccountHanler setInvoiceAdress:nil];
                [AccountHanler setInvoiceHead:nil];
                [AccountHanler setInvoiceStyle:nil];
                
                [AccountHanler setLoginState:0];
                
                [AccountHanler saveUserId:nil];
                
                [AccountHanler setreciveName:nil];
                [AccountHanler setRecivePhone:nil];
                [AccountHanler setaddres:nil];
                

                
                WARN_ALERT(@"注销成功");
                
                [self.navigationController popViewControllerAnimated:YES];
                
            }];
            
            alertView.TLAnimationType = (arc4random_uniform(10) % 2 == 0) ? TLAnimationType3D : tLAnimationTypeHinge;
            

            
             [alertView show];
                
           
                     }
            break;
            


        default:
            break;
    }
    
    
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
