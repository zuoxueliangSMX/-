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
#import "UIButton+Extension.h"
#import "CommitOrderVC.h"
#import "WECartBottomView.h"
@interface WECartHomeVC ()<UITableViewDelegate,UITableViewDataSource>
{

   int _num;
    UILabel *totalPriceLa;
    UITextField *qnumTF;
    WEHTTPHandler *we;
  __block  NSMutableArray *arr;

    CGFloat _totalPrice;
    NSInteger _totalProduc;
    
    
    BOOL isClick;
}
/**
 *  购物车TableView
 */
@property (nonatomic ,weak)WECartBottomView *bottomView;
@property (nonatomic ,strong)UITableView *cartTable;

@property (nonatomic ,strong)WECartsModel *cartsModel;

@end

@implementation WECartHomeVC


- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    [we executeGetCartListTaskWithUserId:[AccountHanler userId] withPage:@"1" Success:^(id obj) {
    
        DLog(@"输出我的购物车里面的数据%@",obj);
        _cartsModel = (WECartsModel *)obj;
        [self.cartTable reloadData];

        
    } failed:^(id obj) {
        
    }];
    
}
- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor =[UIColor colorFromHexCode:@"f2f2f2"];
    we = [[WEHTTPHandler alloc]init];
    
    arr = [[NSMutableArray alloc] initWithCapacity:0];
    
   
    [self initCartTable];
    [self  initBottomView];
}

- (void)initBottomView
{
    
    WECartBottomView *bottomView =[[WECartBottomView alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(_cartTable.frame), SCREEN_WIDTH, 50)];
    bottomView.backgroundColor = [UIColor whiteColor];
    
    __weak WECartBottomView *weekBottomView = bottomView;
    [bottomView setCartBottomViewAllChooseBlock:^(BOOL isSelected) {
       
        _totalPrice =0.00;
        _totalProduc = 0;
        if (isSelected) {
            for (MyCartM *myCartModel in _cartsModel.products) {
                myCartModel.isChoose = NO;
            }
            [_cartTable reloadData];
        }else{
        
            for (MyCartM *myCartModel in _cartsModel.products) {
                myCartModel.isChoose = YES;
                _totalProduc +=[myCartModel.p_num integerValue];
                _totalPrice += [myCartModel.p_num integerValue]*[myCartModel.p_price floatValue];
            }
            [_cartTable reloadData];
        }
        weekBottomView.totalCountLa.text =[NSString stringWithFormat:@"总计商品：%ld",_totalProduc];
        weekBottomView.allPriceLa.text =[NSString stringWithFormat:@"总金额：￥%.2f",_totalPrice];
        NSMutableAttributedString *totalCountLa = [[NSMutableAttributedString alloc] initWithString:weekBottomView.totalCountLa.text];
        
        NSRange totalCountLaRange = NSMakeRange(5, [totalCountLa length]-5);
        
        [totalCountLa addAttribute:NSForegroundColorAttributeName value:[UIColor orangeColor] range:totalCountLaRange];
        [weekBottomView.totalCountLa setAttributedText:totalCountLa];
        
        NSMutableAttributedString *allPriceLa = [[NSMutableAttributedString alloc] initWithString:weekBottomView.allPriceLa.text];
        
        NSRange allPriceLaRange = NSMakeRange(4, [allPriceLa length]-4);
        
        [allPriceLa addAttribute:NSForegroundColorAttributeName value:[UIColor orangeColor] range:allPriceLaRange];
        
        [weekBottomView.allPriceLa setAttributedText:allPriceLa];

        
    }];
     [bottomView setCartBottomViewClearingBlock:^{
        
    }];
    [self.view addSubview:bottomView];
    _bottomView = bottomView;
       
}

-(void)initCartTable
{   //新加的注释
    _cartTable =[[UITableView alloc]init];
    _cartTable.frame =CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT-49-44);
    _cartTable.delegate =self;
    _cartTable.dataSource =self;
    _cartTable.backgroundColor =[UIColor colorFromHexCode:@"f2f2f2"];
    _cartTable.separatorStyle = UITableViewCellSeparatorStyleNone;
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
    return 185;
}
- (UITableViewCell*)tableView:(UITableView*)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *CellIdentifier = @"Cell";
    WECartHomeCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if(cell == nil) {
        cell = [[WECartHomeCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
        cell.backgroundColor =[UIColor colorFromHexCode:@"f2f2f2"];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    
    MyCartM *mcm = [_cartsModel.products objectAtIndex:indexPath.row];
    cell.myCartModel = mcm;
    
    /**
     *  删除产品购物车
     */
    
    [cell.bgView setCartdeleteBlock:^{
        
        [we executeDeleteCartProductTaskWithUserId:[AccountHanler userId] withProductId:mcm.p_id Success:^(id obj) {
            
            DLog(@"输出删除是否成功的信息%@",obj);
            if ([[obj objectForKey:@"message"] isEqualToString:@"0"]) {
//                WARN_ALERT(@"删除成功");

                
                MyCartM *myCartModel = [_cartsModel.products objectAtIndex:indexPath.row];
                cell.myCartModel = myCartModel;
                
                if (myCartModel.isChoose == YES) {

                    _totalPrice -= [myCartModel.p_price floatValue]*[myCartModel.p_num integerValue];
                    _totalProduc -= [myCartModel.p_num integerValue];
                    _bottomView.totalCountLa.text =[NSString stringWithFormat:@"总计商品：%ld",_totalProduc];
                    _bottomView.allPriceLa.text =[NSString stringWithFormat:@"总金额：￥%.2f",_totalPrice];
                    
                    NSMutableAttributedString *totalCountLa = [[NSMutableAttributedString alloc] initWithString:_bottomView.totalCountLa.text];
                    
                    NSRange totalCountLaRange = NSMakeRange(5, [totalCountLa length]-5);
                    
                    [totalCountLa addAttribute:NSForegroundColorAttributeName value:[UIColor orangeColor] range:totalCountLaRange];
                    [_bottomView.totalCountLa setAttributedText:totalCountLa];
                    
                    NSMutableAttributedString *allPriceLa = [[NSMutableAttributedString alloc] initWithString:_bottomView.allPriceLa.text];
                    
                    NSRange allPriceLaRange = NSMakeRange(4, [allPriceLa length]-4);
                    
                    [allPriceLa addAttribute:NSForegroundColorAttributeName value:[UIColor orangeColor] range:allPriceLaRange];
                    
                    [_bottomView.allPriceLa setAttributedText:allPriceLa];
                    
                }
                
                [_cartsModel.products removeObjectAtIndex:indexPath.row];
                [_cartTable reloadData];

            }
            
        } failed:^(id obj) {
            
            
            
        }];
        
    }];
    
    /**
     *  选中和反选产品
     */
    __weak WECartHomeCell *bCell = cell;
    
   [ cell.bgView.middleview setChosesBlock:^(UIButton *chooseBtn){
     
       NSInteger row2 = [tableView indexPathForCell:((WECartHomeCell*)[[chooseBtn superview]superview])].row;
       
       MyCartM *cm =  [_cartsModel.products objectAtIndex:indexPath.row];
       if (cm.isChoose) {
           cm.isChoose = NO;
           _totalPrice -=([bCell.myCartModel.p_num integerValue]*[cm.p_price floatValue]);
           _totalProduc -=[bCell.myCartModel.p_num integerValue];
       }else{
           cm.isChoose = YES;
           _totalPrice +=([bCell.myCartModel.p_num integerValue]*[cm.p_price floatValue]);
           _totalProduc +=[bCell.myCartModel.p_num integerValue];

       }
       
       _bottomView.totalCountLa.text =[NSString stringWithFormat:@"总计商品：%ld",_totalProduc];
       _bottomView.allPriceLa.text =[NSString stringWithFormat:@"总金额：￥%.2f",_totalPrice];
       
       NSMutableAttributedString *totalCountLa = [[NSMutableAttributedString alloc] initWithString:_bottomView.totalCountLa.text];
       
       NSRange totalCountLaRange = NSMakeRange(5, [totalCountLa length]-5);
       
       [totalCountLa addAttribute:NSForegroundColorAttributeName value:[UIColor orangeColor] range:totalCountLaRange];
       [_bottomView.totalCountLa setAttributedText:totalCountLa];
       
       NSMutableAttributedString *allPriceLa = [[NSMutableAttributedString alloc] initWithString:_bottomView.allPriceLa.text];
       
       NSRange allPriceLaRange = NSMakeRange(4, [allPriceLa length]-4);
       
       [allPriceLa addAttribute:NSForegroundColorAttributeName value:[UIColor orangeColor] range:allPriceLaRange];
       
       [_bottomView.allPriceLa setAttributedText:allPriceLa];
       

       
       bCell.myCartModel = cm;
       
       NSInteger count = 0;
       for (MyCartM * model in _cartsModel.products) {
           if (model.isChoose == YES) {
               count++;
           }
       }
       if (count == _cartsModel.products.count) {
           _bottomView.allButton.selected = YES;
       }else{
           _bottomView.allButton.selected = NO;

       }
       DLog(@"输出数组里面的对象有几个%0.2f",_totalPrice);
       
    }];
    

   
    
    /**
     *  减少产品数量 --
     */
    [cell.bgView.bottomView setCartHomeCellBottomCutBlock:^(NSInteger tfNum,UILabel *numTf,UILabel*jineLa) {
        DLog(@"%ld",(long)tfNum);
        
        tfNum--;
        
        if (tfNum<=0) {
//            tfNum=1;
//            return ;
        }else{
            NSString * strNum = [NSString stringWithFormat:@"%ld",(long)tfNum];
            DLog(@"%@",strNum);
            
            
            [we executeUpdateCartProductCountTaskWithUserId:[AccountHanler userId] withProductId:mcm.p_id withNum:strNum Success:^(id obj) {
                MyCartM *cm =  [_cartsModel.products objectAtIndex:indexPath.row];
                cm.p_num = strNum;
                bCell.myCartModel = cm;
                if (cm.isChoose == YES) {
                    _totalProduc --;
                    _totalPrice -= [cm.p_price floatValue];
                    _bottomView.totalCountLa.text =[NSString stringWithFormat:@"总计商品：%ld",_totalProduc];
                    _bottomView.allPriceLa.text =[NSString stringWithFormat:@"总金额：￥%.2f",_totalPrice];
                    
                    NSMutableAttributedString *totalCountLa = [[NSMutableAttributedString alloc] initWithString:_bottomView.totalCountLa.text];
                    
                    NSRange totalCountLaRange = NSMakeRange(5, [totalCountLa length]-5);
                    
                    [totalCountLa addAttribute:NSForegroundColorAttributeName value:[UIColor orangeColor] range:totalCountLaRange];
                    [_bottomView.totalCountLa setAttributedText:totalCountLa];
                    
                    NSMutableAttributedString *allPriceLa = [[NSMutableAttributedString alloc] initWithString:_bottomView.allPriceLa.text];
                    
                    NSRange allPriceLaRange = NSMakeRange(4, [allPriceLa length]-4);
                    
                    [allPriceLa addAttribute:NSForegroundColorAttributeName value:[UIColor orangeColor] range:allPriceLaRange];
                    
                    [_bottomView.allPriceLa setAttributedText:allPriceLa];

                }
                
                
            } failed:^(id obj) {
                
            }];
 
        }
        
    }];
    
    
    [cell.bgView.bottomView setCartHomeCellBottomPlusBlock:^(NSInteger tfNum,UILabel *numTf,UILabel*jineLa) {
        tfNum++;
        
        if (tfNum<=0) {
            //            tfNum=1;
            //            return ;
        }else{
            NSString * strNum = [NSString stringWithFormat:@"%ld",(long)tfNum];
            DLog(@"%@",strNum);
            [we executeUpdateCartProductCountTaskWithUserId:[AccountHanler userId] withProductId:mcm.p_id withNum:strNum Success:^(id obj) {
                MyCartM *cm =  [_cartsModel.products objectAtIndex:indexPath.row];
                cm.p_num = strNum;
                bCell.myCartModel = cm;
                
                if (cm.isChoose == YES) {
                    _totalProduc++;
                    _totalPrice += [cm.p_price floatValue];
                    _bottomView.totalCountLa.text =[NSString stringWithFormat:@"总计商品：%ld",_totalProduc];
                    _bottomView.allPriceLa.text =[NSString stringWithFormat:@"总金额：￥%.2f",_totalPrice];
                    
                    NSMutableAttributedString *totalCountLa = [[NSMutableAttributedString alloc] initWithString:_bottomView.totalCountLa.text];
                    
                    NSRange totalCountLaRange = NSMakeRange(5, [totalCountLa length]-5);
                    
                    [totalCountLa addAttribute:NSForegroundColorAttributeName value:[UIColor orangeColor] range:totalCountLaRange];
                    [_bottomView.totalCountLa setAttributedText:totalCountLa];
                    
                    NSMutableAttributedString *allPriceLa = [[NSMutableAttributedString alloc] initWithString:_bottomView.allPriceLa.text];
                    
                    NSRange allPriceLaRange = NSMakeRange(4, [allPriceLa length]-4);
                    
                    [allPriceLa addAttribute:NSForegroundColorAttributeName value:[UIColor orangeColor] range:allPriceLaRange];
                    
                    [_bottomView.allPriceLa setAttributedText:allPriceLa];

                }

            } failed:^(id obj) {
                
            }];
            
            

        }
      
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
-(void)instantPayClick:(UIButton*)btn
{

    CommitOrderVC *myorder =[[CommitOrderVC alloc]init];
    
    [self.navigationController pushViewController:myorder animated:YES];
}

-(void)ALLchooseClic :(UIButton*)btn
{
    isClick = !isClick;
    
    if (isClick) {
        
        
        btn.selected =YES;
       
        
        
    }else{
        
        
        btn.selected = NO;
        
        
        
    }


}
@end
