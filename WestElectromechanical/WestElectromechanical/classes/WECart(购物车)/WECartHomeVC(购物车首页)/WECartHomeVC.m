//
//  WECartVC.m
//  WestElectromechanical
//
//  Created by zuo on 15/4/26.
//  Copyright (c) 2015年 zuo. All rights reserved.
//

#import "WECartHomeVC.h"
#import "WECartHomeCell.h"
#import "WEHTTPHandler.h"
#import "JsonToModel.h"
#import "MyCartM.h"
#import "UIImageView+WebCacheImg.h"
#import "AccountHanler.h"
@interface WECartHomeVC ()<UITableViewDelegate,UITableViewDataSource>
{

   int _num;
    UILabel *totalPriceLa;
    UITextField *qnumTF;
       NSString *str;
    WEHTTPHandler *we;
  __block  NSMutableArray *arr;

    CGFloat _totalPrice;
}
/**
 *  购物车TableView
 */
@property (nonatomic ,strong)UITableView *cartTable;
@property (nonatomic ,strong)WECartsModel *cartsModel;

@end

@implementation WECartHomeVC


- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    [we executeGetCartListTaskWithUserId:@"15472" withPage:@"1" Success:^(id obj) {
    
        DLog(@"输出我的购物车里面的数据%@",obj);
        _cartsModel = (WECartsModel *)obj;
        [self.cartTable reloadData];

        
    } failed:^(id obj) {
        
    }];
    
}
- (void)viewDidLoad {
    [super viewDidLoad];
    we = [[WEHTTPHandler alloc]init];
    
    arr = [[NSMutableArray alloc] initWithCapacity:0];
    
   
    [self initCartTable];
}

-(void)initCartTable
{   //新加的注释
    _cartTable =[[UITableView alloc]init];
    _cartTable.frame =CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT-49-44);
    _cartTable.delegate =self;
    _cartTable.dataSource =self;
    _cartTable.backgroundColor =[UIColor clearColor];
    [self.view addSubview:_cartTable];
    _cartTable.tableFooterView =[[UIView alloc]init];
   

}

#pragma mark -
#pragma mark - UITableViewDataSource

- (NSInteger)tableView:(UITableView*)tableView numberOfRowsInSection:(NSInteger)section {
    return _cartsModel.products.count;
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
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    
    MyCartM *mcm = [_cartsModel.products objectAtIndex:indexPath.row];
    cell.wbgv.middleview.priceLabel.text =[NSString stringWithFormat:@"¥ %@",mcm.p_price];

    cell.wbgv.middleview.versionBrandLa.text =[NSString stringWithFormat:@"型号:%@ 品牌:%@",mcm.p_version,mcm.p_brand];

    cell.wbgv.middleview.productLabel.text =mcm.p_name;
    cell.wbgv.middleview.productCartIdLabel.text =[NSString stringWithFormat:@"西域订货号:%@ ",mcm.p_order_num];
    
    
    NSString *path = [NSString stringWithFormat:@"%@%@",kWEImgUrl,mcm.p_imgurl];
    
  [cell.wbgv setCartdeleteBlock:^(BOOL deleteNoOrYes) {
     
      
      [we executeDeleteCartProductTaskWithUserId:@"15472" withProductId:mcm.p_id Success:^(id obj) {
          
          DLog(@"输出删除是否成功的信息%@",obj);
          if ([[obj objectForKey:@"message"] isEqualToString:@"0"]) {
              WARN_ALERT(@"删除成功");
          }
          
          
          dispatch_async(dispatch_get_main_queue(), ^{
              [self viewWillAppear:YES];
              
              
          });
          
          
      } failed:^(id obj) {
          
          
          
      }];
      
      
  } ];
    
   //  选中的的产品  
    __weak WECartHomeCell *bCell = cell;
   [ cell.wbgv.middleview setChosesBlock:^(UIButton *chooseBtn){
     
       int row2 = [tableView indexPathForCell:((WECartHomeCell*)[[chooseBtn superview]superview])].row;
       
       MyCartM *cm =  [_cartsModel.products objectAtIndex:row2];
       if (chooseBtn.selected) {
//           _totalPrice +=[*[cm.p_price intValue ]];
           _totalPrice +=([bCell.wbgv.bottomView.numTF.text  intValue]*[cm.p_price intValue]);
           

       }else{
           
            _totalPrice -=([bCell.wbgv.bottomView.numTF.text  intValue]*[cm.p_price intValue]);
//           [arr removeObject:cm.p_price];
           
       }
       
       DLog(@"输出数组里面的对象有几个%0.2f",_totalPrice);
       
    }];
    
    
    
    
    
    
    
    DLog(@"输出这个路径%@",path);
    [ cell.wbgv.middleview.productImg  setWebImgUrl:path placeHolder:[UIImage imageNamed:@"Product_Placeholder"]];

   
    
    
    [cell.wbgv.bottomView setCartHomeCellBottomCutBlock:^(NSInteger tfNum,UITextField *numTf,UILabel*jineLa) {
        DLog(@"%ld",(long)tfNum);
        
        tfNum--;
        
        if (tfNum<0) {
            tfNum=0;
        }
        str = [NSString stringWithFormat:@"%ld",(long)tfNum];
        DLog(@"%@",str);
        
        numTf.text =str;
        jineLa.text=[NSString stringWithFormat:@"金额:%d",[str  intValue]*[mcm.p_price intValue ]];
        dispatch_async(dispatch_get_main_queue(), ^{
            [_cartTable reloadData];
        });
        
        }];
    
    
    [cell.wbgv.bottomView setCartHomeCellBottomPlusBlock:^(NSInteger tfNum,UITextField *numTf,UILabel*jineLa) {
        DLog(@"%ld",(long)tfNum);
       
        tfNum++;
     

        str = [NSString stringWithFormat:@"%ld",(long)tfNum];
        DLog(@"%@",str);
 
        numTf.text =str;
        jineLa.text=[NSString stringWithFormat:@"金额:%d",[str  intValue]*[mcm.p_price intValue]];

        dispatch_async(dispatch_get_main_queue(), ^{
            [_cartTable reloadData];
            
            
        });
        

    }];

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
@end
