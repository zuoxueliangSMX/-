//
//  AlwaysUsedAddresVC.m
//  WestElectromechanical
//
//  Created by 夏亚峰 on 15/5/6.
//  Copyright (c) 2015年 zuo. All rights reserved.
//

#import "AlwaysUsedAddresVC.h"
#import "AddAdressVC.h"
#import "RDVTabBarController.h"
#import "WEHTTPHandler.h"
#import "AccountHanler.h"
#import "JsonToModel.h"
#import "AddressM.h"

#import "SendIFAPPDefault.h"
@interface AlwaysUsedAddresVC ()<UITableViewDataSource,UITableViewDelegate>
{

    WEHTTPHandler *we;
    UITableView *table;
    NSMutableArray *muarr;
}
@end

@implementation AlwaysUsedAddresVC


#pragma mark -
#pragma mark - pop和push控制器时的操作
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [[self rdv_tabBarController] setTabBarHidden:YES animated:YES];
    
    
    [we executeGetAdressListTaskWithUserId:[AccountHanler  userId] Success:^(id obj) {
        
        
        muarr = [[NSMutableArray alloc]initWithCapacity:0];
             NSDictionary *dic = [obj objectForKey:@"address"];
        for (NSDictionary *dv in dic) {
            
            AddressM *am =  [JsonToModel objectFromDictionary:dv className:@"AddressM"];
            [muarr addObject:am];
            [table reloadData];
        }
         DLog(@"输出我的%@",muarr);

    } failed:^(id obj) {
        
    }];

}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    [[self rdv_tabBarController] setTabBarHidden:NO animated:YES];
}




- (void)viewDidLoad {
    [super viewDidLoad];
    self.title =@"常用地址";
   we= [[WEHTTPHandler alloc]init];
    self.navigationItem.rightBarButtonItem =   [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(addClick)];
            self.navigationItem.rightBarButtonItem.tintColor =[UIColor whiteColor];
    table = [[UITableView alloc] initWithFrame:CGRectMake(0, 10,SCREEN_WIDTH,SCREEN_HEIGHT-64) style:UITableViewStylePlain];
    
    
    table.backgroundColor =SET_COLOR(234.0, 234.0, 234.0);
    
    self.view.backgroundColor =SET_COLOR(234.0, 234.0, 234.0);

    table.delegate =self;
    table.dataSource =self;
    [self.view addSubview:table];
    UIView *view =[[UIView alloc]init];
    table.tableFooterView = view;
}





- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
       return 70;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    
    return [muarr count];
}
- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
    
    NSString * cellidentifer = @"cell";
    UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:cellidentifer];
    if (cell ==nil) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellidentifer];
        cell.selectionStyle =UITableViewCellAccessoryNone;
        UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 65)] ;
        view.backgroundColor = [UIColor whiteColor];
          cell.backgroundColor = SET_COLOR(234.0, 234.0, 234.0);
        [cell addSubview:view];
         cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        
        UILabel *nameLa = [[UILabel alloc]initWithFrame:CGRectMake(10, 10, 100, 15)];
        nameLa.textColor =[UIColor blackColor];
        nameLa.tag =10;
        nameLa.font =[UIFont systemFontOfSize:12];
        UILabel *addresLa = [[UILabel alloc]initWithFrame:CGRectMake(15, CGRectGetMaxY(nameLa.frame), SCREEN_WIDTH-30, 40)];
        addresLa.textColor =[UIColor darkGrayColor];
        addresLa.font =[UIFont systemFontOfSize:13];
        addresLa.tag =11;
        addresLa.numberOfLines =2;
        [view addSubview:addresLa];
        [view addSubview:nameLa];
        
    }
    
    AddressM *adm =[muarr objectAtIndex:indexPath.row];
    UILabel *nameLa =(UILabel*)[cell viewWithTag:10];
    nameLa.text =adm.u_name;
    
    UILabel*addresLa  = (UILabel*)[cell viewWithTag:11];
    
    addresLa.text = adm.a_address;
    
    
    return cell;
    
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
      AddressM *adm =[muarr objectAtIndex:indexPath.row];
    
    
    if (self.identiferStr) {
        
        
        [AccountHanler setreciveName:adm.u_name];
        [AccountHanler setRecivePhone:adm.mobile];
        [AccountHanler setaddres:adm.a_address];
        
        
        [self.navigationController popViewControllerAnimated:YES];
        
        
    }else{
   
 
    
    AddAdressVC *add  =[[AddAdressVC alloc]init];
    add.am =adm;
    [self.navigationController pushViewController:add animated:YES];}
    
   
}


- (UITableViewCellEditingStyle)tableView:(UITableView *)tableView

           editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath

{
    
    
    
    return  UITableViewCellEditingStyleDelete;
    
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    
    
    if (editingStyle==UITableViewCellEditingStyleDelete) {
        
        AddressM *adm =[muarr objectAtIndex:indexPath.row];
        
        [we executeDeleteAdressTaskWithUserId:@"4516" withAdressHandleId:adm.a_id Success:^(id obj) {
        
        } failed:^(id obj) {
        
        }];
    
//        [SendIFPushDao  deletePUsh:pm.ID];
//        _muarr = [SendIFPushDao getAllpushInfos];
        
        [self viewWillAppear:YES];
        [tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationAutomatic];
        
        
        
        
//        [table reloadData];
    }
    
    
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)addClick
{
    AddAdressVC *add  =[[AddAdressVC alloc]init];
    
    [self.navigationController pushViewController:add animated:YES];



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
