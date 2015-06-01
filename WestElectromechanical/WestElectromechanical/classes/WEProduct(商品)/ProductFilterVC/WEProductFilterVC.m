//
//  WEProductFilterVC.m
//  WestElectromechanical
//
//  Created by zuo on 15/5/17.
//  Copyright (c) 2015年 zuo. All rights reserved.
//

#import "WEProductFilterVC.h"
#import "RDVTabBarController.h"
#import "UIButton+Extension.h"
#import "WEHTTPHandler.h"
#import "NSString+Extension.h"
@interface WEProductFilterVC ()<UITableViewDataSource,UITableViewDelegate,UITextFieldDelegate>
@property (nonatomic ,strong)NSArray *priceArr;
@property (nonatomic ,weak)UILabel *priceInterval;
@property (nonatomic ,copy)NSString *firstPrice;
@property (nonatomic ,copy)NSString *secondPrice;
@property (nonatomic ,weak)UITextField *brandTf;

@end

@implementation WEProductFilterVC
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
- (void)setProductFilterBlock:(productFilterBlock)block
{
    _block = block;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor =[UIColor colorFromHexCode:@"f2f2f2"];
    self.title = @"筛选";
    
    
    _priceArr =@[@"全部",@"0~50",@"50~100",@"100~500",@"500~1000",@"1000~2000",@"2000~5000",@"5000~10000"];
    
    UITableView *filterList =[[UITableView alloc]initWithFrame:CGRectMake(10, 0, SCREEN_WIDTH-20, SCREEN_HEIGHT-50) style:UITableViewStyleGrouped];
    filterList.delegate =self;
    filterList.dataSource =self;
    filterList.showsHorizontalScrollIndicator = NO;
    filterList.showsVerticalScrollIndicator = NO;
    filterList.layer.borderColor = [UIColor colorFromHexCode:@"f2f2f2"].CGColor;
    filterList.layer.borderWidth = 1;
    filterList.layer.cornerRadius =5;
    filterList.bounces = NO;
    filterList.backgroundColor =[UIColor clearColor];
    [self.view addSubview:filterList];
    

    UIView *bottomView = [[UIView alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(filterList.frame), SCREEN_WIDTH, 50)];
    bottomView.backgroundColor =[UIColor colorFromHexCode:@"f2f2f2"];
    [self.view addSubview:bottomView];

    UIButton *button =[UIButton addTarget:self WithNorTitle:@"筛选" withNorColor:[UIColor whiteColor] withSelectedTitle:@"筛选" withSelectedColor:[UIColor whiteColor] withBackgroundColor:[UIColor orangeColor] withTileSize:font(16) action:@selector(filterProduct:)];
    button.frame = CGRectMake(10, 3, SCREEN_WIDTH-20, 44);
    [bottomView addSubview:button];
    
}


- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [_brandTf resignFirstResponder];
    return YES;
}


- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [_brandTf resignFirstResponder];

}
- (void)filterProduct:(UIButton *)btn
{
//    [AlertUtil showAlertWithText:@"没有搜出您需要的产品"];

    
    if ([[NSString deleteSpacing:_brandTf.text] length] == 0) {
        [AlertUtil showAlertWithText:@"请输入您选择的品牌"];
        return;
    }
    
    __weak WEProductFilterVC *bSelf =self;
    if (_productName.length>0) {
        
        [[[WEHTTPHandler alloc]init] executeDoProductFilterWithProductName:_productName withFirstPrice:_firstPrice withSecondPrice:_secondPrice withBrand:_brandTf.text withPage:@"1" Success:^(id obj) {
            
            if (_block) {
                _block((WEProductsModel *)obj);
            }
            [bSelf.navigationController popViewControllerAnimated:YES];
        } failed:^(id obj) {
            
        }];
        
    }else{
        [[[WEHTTPHandler alloc]init] executeDoProductFilterWithProductCategory:_t_id withFirstPrice:_firstPrice withSecondPrice:_secondPrice withBrand:_brandTf.text withPage:@"1" Success:^(id obj) {
            
            if (_block) {
                _block((WEProductsModel *)obj);
            }
            [bSelf.navigationController popViewControllerAnimated:YES];
        } failed:^(id obj) {
            
        }];
    }
    
    
}

#pragma mark -
#pragma mark - UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 2;
}
- (NSInteger)tableView:(UITableView*)tableView numberOfRowsInSection:(NSInteger)section {
    
    if (section == 0) {
        return 0;
    }else return _priceArr.count;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    if (section == 0) {
        UIView *view =[[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH-20, 50)];
        UITextField *tf =[[UITextField alloc]initWithFrame:CGRectMake(0, 5, SCREEN_WIDTH-30, 40)];
        
        UILabel *productBrand =[[UILabel alloc]initWithFrame:CGRectMake(0, 0, 40, 40)];
        productBrand.backgroundColor =[UIColor whiteColor];
        productBrand.text =@"品牌";
        productBrand.textColor =[UIColor colorFromHexCode:@"c2c2c2"];
        productBrand.font = font(16);
        productBrand.textAlignment = 1;
        tf.leftView =productBrand;
        tf.leftViewMode = UITextFieldViewModeAlways;
        tf.placeholder = @"请输入你想要查找的品牌";
        tf.backgroundColor =[UIColor whiteColor];
        tf.layer.borderWidth = 1;
        tf.layer.borderColor =[UIColor colorFromHexCode:@"f2f2f2"].CGColor;
        tf.layer.cornerRadius =5;
        tf.delegate = self;
        [view addSubview:tf];
        view.backgroundColor =[UIColor clearColor];
        _brandTf = tf;
        return view;
        
    }else{
        UIView *view =[[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH-20, 50)];
        view.backgroundColor =[UIColor whiteColor];
        
        UILabel *price =[[UILabel alloc]init];
        price.frame =CGRectMake(  10,0,40,50);
        price.numberOfLines =1;
        price.text = @"价格";
        price.textAlignment = 1;
        price.font =[UIFont systemFontOfSize:18.0];
        price.backgroundColor =[UIColor clearColor];
        [view addSubview:price];
        
        
        UILabel *priceInterval =[[UILabel alloc]init];
        priceInterval.frame =CGRectMake(  60,0,SCREEN_WIDTH-20-70,50);
        priceInterval.numberOfLines =1;
        priceInterval.text = @"全部";
        priceInterval.textAlignment = NSTextAlignmentRight;
        priceInterval.font =[UIFont systemFontOfSize:18.0];
        priceInterval.textColor =[UIColor orangeColor];
        priceInterval.backgroundColor =[UIColor clearColor];
        [view addSubview:priceInterval];
        _priceInterval = priceInterval;
        return view;
    }
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 50;
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
        cell.backgroundColor =[UIColor whiteColor];
    }
    
    cell.textLabel.text =[_priceArr objectAtIndex:indexPath.row];
    
    return cell;
}
#pragma mark -
#pragma mark - UITableViewDelegate

- (void)tableView:(UITableView*)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [_brandTf resignFirstResponder];

    UITableViewCell *cell =[tableView cellForRowAtIndexPath:indexPath];
    _priceInterval.text = cell.textLabel.text;
    
    
    if ([_priceInterval.text isEqualToString:@"全部"]) {
        _firstPrice = @"0";
        _firstPrice = @"100000000";
    }else{
      NSArray * priceArr = [_priceInterval.text componentsSeparatedByString:@"~"];
        _firstPrice = [priceArr objectAtIndex:0];
        _secondPrice =[priceArr objectAtIndex:1];
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
