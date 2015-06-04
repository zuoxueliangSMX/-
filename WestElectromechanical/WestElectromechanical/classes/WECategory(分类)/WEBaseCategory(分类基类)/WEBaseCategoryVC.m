//
//  WEBaseCategoryVC.m
//  WestElectromechanical
//
//  Created by zuo on 15/5/9.
//  Copyright (c) 2015年 zuo. All rights reserved.
//

#import "WEBaseCategoryVC.h"
#import "WECategorySingleModel.h"
@interface WEBaseCategoryVC ()<UITableViewDataSource,UITableViewDelegate>
{
    BOOL _isSelected;
}
@end

@implementation WEBaseCategoryVC
- (instancetype)init{
    if (self =[super init]) {


    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor =[UIColor colorFromHexCode:@"f2f2f2"];
    self.automaticallyAdjustsScrollViewInsets = NO;
    [self initLeftTableView];
    [self initRightTableView];
}

- (void)initLeftTableView
{
    UITableView *leftTable =[[UITableView alloc]init];
    leftTable.frame =CGRectMake(0, 64, SCREEN_WIDTH/2.0, SCREEN_HEIGHT-64);
    leftTable.delegate =self;
    leftTable.dataSource =self;
    leftTable.bounces = NO;
    leftTable.backgroundColor =[UIColor colorFromHexCode:@"f2f2f2"];
    [self.view addSubview:leftTable];
    _leftTable =leftTable;
    UIView *view =[[UIView alloc]init];
    leftTable.tableFooterView = view;
    _selectedIndex =[NSIndexPath indexPathForRow:_selectedRow inSection:0];
    

}

- (void)initRightTableView
{
    UITableView *leftTable =[[UITableView alloc]init];
    leftTable.frame =CGRectMake(SCREEN_WIDTH/2.0, 64, SCREEN_WIDTH/2.0, SCREEN_HEIGHT-64);
    leftTable.delegate =self;
    leftTable.bounces = NO;
    leftTable.dataSource =self;
    leftTable.backgroundColor =[UIColor colorFromHexCode:@"f2f2f2"];
    [self.view addSubview:leftTable];
    UIView *view =[[UIView alloc]init];
    leftTable.tableFooterView = view;
    _rightTable = leftTable;
}

#pragma mark -
#pragma mark - UITableViewDataSource

- (NSInteger)tableView:(UITableView*)tableView numberOfRowsInSection:(NSInteger)section {
    
    if (self.leftTable == tableView) {
        return _leftModel.types.count;
    }else{
        return _rightModel.types.count;

    }
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
        cell.accessoryType = UITableViewCellAccessoryNone;
        
    }
    
    
    if (self.leftTable == tableView) {
        cell.textLabel.text =[_leftModel.types[indexPath.row] t_name];
        cell.backgroundColor =[UIColor clearColor];
        if (!_isSelected) {
            if (indexPath == _selectedIndex) {
                cell.backgroundColor =[UIColor whiteColor];
                _isSelected =YES;
            }
            
        }
       
    }else{
        cell.backgroundColor =[UIColor whiteColor];
        cell.textLabel.text =[_rightModel.types[indexPath.row] t_name];
    }
    
    return cell;
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
