//
//  WECartVC.m
//  WestElectromechanical
//
//  Created by zuo on 15/4/26.
//  Copyright (c) 2015年 zuo. All rights reserved.
//

#import "WECartHomeVC.h"
#import "WECartHomeCell.h"
@interface WECartHomeVC ()<UITableViewDelegate,UITableViewDataSource>
{

   int _num;
    UILabel *totalPriceLa;
    UITextField *numTF;
    UITableView *cartTable;
}
/**
 *  购物车TableView
 */
@property (nonatomic ,weak)UITableView *cartTable;

@end

@implementation WECartHomeVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self initCartTable];
}

-(void)initCartTable
{   //新加的注释
    cartTable =[[UITableView alloc]init];
    cartTable.frame =CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT-49-44);
    cartTable.delegate =self;
    cartTable.dataSource =self;
    cartTable.backgroundColor =[UIColor clearColor];
    [self.view addSubview:cartTable];
    cartTable.tableFooterView =[[UIView alloc]init];
    _cartTable = cartTable;

}

#pragma mark -
#pragma mark - UITableViewDataSource

- (NSInteger)tableView:(UITableView*)tableView numberOfRowsInSection:(NSInteger)section {
    return 10;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 180;
}
- (UITableViewCell*)tableView:(UITableView*)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *CellIdentifier = @"Cell";
    WECartHomeCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if(cell == nil) {
        cell = [[WECartHomeCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    cell.wbgv.bottomView.jineLa.text =@"金额: ¥198";
      numTF=cell.wbgv.bottomView.numTF;
    [cell.wbgv.bottomView.leftBtn addTarget:self action:@selector(plusClick) forControlEvents:UIControlEventTouchUpInside];
    [cell.wbgv.bottomView.rigBtn addTarget:self action:@selector(cutClick) forControlEvents:UIControlEventTouchUpInside];

    return cell;
}
#pragma mark -
#pragma mark - UITableViewDelegate

- (void)tableView:(UITableView*)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


//加建的btn的方法
-(void)plusClick

{
    
    
    int i  = [numTF.text  intValue];
    i++;
    NSString *str = [NSString stringWithFormat:@"%d",i];
    numTF.text = str;
    NSLog(@"输出这个数字%@",numTF.text);

   
    
}
-(void)cutClick
{
    
    
    int i  = [numTF.text  intValue];
    i--;
    NSString *str = [NSString stringWithFormat:@"%d",i];
    numTF.text = str;
    if ([numTF.text  intValue]<=0) {
        numTF.text=@"1";
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
