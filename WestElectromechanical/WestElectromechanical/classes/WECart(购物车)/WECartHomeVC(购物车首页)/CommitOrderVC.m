//
//  CommitOrderVC.m
//  WestElectromechanical
//
//  Created by 夏亚峰 on 15/5/14.
//  Copyright (c) 2015年 zuo. All rights reserved.
//

#import "CommitOrderVC.h"
#import "SheZhiVC.h"
#import "WEHTTPHandler.h"
#import "AccountHanler.h"
#import "GlanceCell.h"
#import "AlwaysUsedAddresVC.h"
#import "SendIFAPPDefault.h"
#import "ClaimInvoiceVC.h"
#import "UIButton+Extension.h"
#import "CartOrderDetailVC.h"
#import "MyCartM.h"
#import "UIImageView+WebCacheImg.h"
#import "CartCommitOrderVC.h"

#import "RDVTabBarController.h"
@interface CommitOrderVC ()<UITableViewDataSource,UITableViewDelegate,UIAlertViewDelegate>
{
    
    WEHTTPHandler *we;
    NSArray *imgArr;
    NSArray *titleArr;
    UITableView *_table;

    
}


@end

@implementation CommitOrderVC

#pragma mark -
#pragma mark - pop和push控制器时的操作
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [[self rdv_tabBarController] setTabBarHidden:YES animated:YES];
    [_table reloadData];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    [[self rdv_tabBarController] setTabBarHidden:NO animated:YES];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title =@"提交订单";
    
    we= [[WEHTTPHandler alloc]init];
    
    _table = [[UITableView alloc] initWithFrame:CGRectMake(0, 0,SCREEN_WIDTH,SCREEN_HEIGHT-44) style:UITableViewStylePlain];
    _table.backgroundColor =SET_COLOR(234.0, 234.0, 234.0);
    
    self.view.backgroundColor =SET_COLOR(234.0, 234.0, 234.0);
    
    _table.delegate =self;
    _table.dataSource =self;
    [self.view addSubview:_table];
    [self addFoot];
    [self initBottomView];
   
    
    

}

-(void)addFoot
{
    
   
    UIView *footView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, VIEW_WIDETH, 130)];
    GlanceCell *footCell = [[[NSBundle mainBundle] loadNibNamed:@"GlanceCell" owner:self options:nil]objectAtIndex:4];
    footCell.frame = CGRectMake(0, 0, SCREEN_WIDTH, 130);
    [footCell.layer setCornerRadius:4];
    footCell.backgroundColor = [UIColor whiteColor];
    footCell.backgroundColor = [UIColor whiteColor];
    footCell.goodsPriceLa.text = [NSString stringWithFormat:@"商品总额: ¥%0.2f",self.totalP];
    footCell.freightageLa.text = @"共计运费: ¥ 0";
    footCell.subtractFeeLa.text =@"减免运费: 0";
    
    
    
    [footView addSubview:footCell];
    
        _table.tableFooterView =footView;
}




- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    switch (indexPath.row) {
        case 0:
        {
            return 35;
        }
            break;
        case 1:
        {
            return 70;
        }
            break;
        case 2:
        {
            
            if ([AccountHanler   reciveName].length==0) {
                
                return 55;
                
            }else{

            return 105;
            }
        }
             break;
        case 3:
        {
            if ( [AccountHanler invoiceHead].length==0) {
                return 55;
            }else{
            
                return 105;}
            
           

        }
             break;
        case 4:
        {
            return 35;
        }


            break;
        default:
            break;
    }
    return 0;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return 5;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    NSString * cellidentifer = @"cell";
    UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:cellidentifer];
    if (cell ==nil) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellidentifer];
        UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 0)] ;
        view.backgroundColor = [UIColor whiteColor];
        cell.backgroundColor = SET_COLOR(234.0, 234.0, 234.0);
        
        view.tag =10;
        [cell addSubview:view];
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        
        
        
        switch (indexPath.row) {
            case 0:
            {
                UILabel *nameLa = [[UILabel alloc]initWithFrame:CGRectMake(0, 5, 280, 25)];
                nameLa.textColor =[UIColor blackColor];
                nameLa.font = [UIFont systemFontOfSize:12];
                nameLa.textColor = [UIColor  lightGrayColor];
                nameLa.tag =100;
                cell.accessoryType = UITableViewCellAccessoryNone;

                [view addSubview:nameLa];
            
            }
                break;
            case 1:
            {
                
                for (int i=0; i<self.selectedMu.count; i++) {
                 
                    
                    
                    UIImageView *imgv =[[UIImageView alloc]initWithFrame:CGRectMake(10+i*55, 5, 55, 55)];
                    
                    imgv.tag =101+i;
                   
                    [view addSubview:imgv];
                }
                
                

                
            }
                break;
            case 2:
            {
                UILabel *titleLa = [[UILabel alloc]initWithFrame:CGRectMake(10, 5, 150, 20)];
                titleLa.tag =103;
                UILabel *nameLa = [[UILabel alloc]initWithFrame:CGRectMake(10, CGRectGetMaxY(titleLa.frame), 180, 20)];
                nameLa.font= [UIFont systemFontOfSize:14];
                nameLa.textColor =[UIColor lightGrayColor];
                nameLa.tag =104;
                
                UILabel *addresLa = [[UILabel alloc]initWithFrame:CGRectMake(10, CGRectGetMaxY(nameLa.frame)+3, 180, 20)];
                addresLa.font= [UIFont systemFontOfSize:14];
                addresLa.tag =105;

                addresLa.textColor =[UIColor lightGrayColor];
                
                UILabel *phoneLa = [[UILabel alloc]initWithFrame:CGRectMake(10, CGRectGetMaxY(addresLa.frame)+3,180, 20 )];
                phoneLa.tag =106;
                phoneLa.font= [UIFont systemFontOfSize:14];
                phoneLa.textColor =[UIColor lightGrayColor];
                
                [view  addSubview:titleLa];
                [view  addSubview:nameLa];
                [view  addSubview:addresLa];
                [view  addSubview:phoneLa];

                
            }
                break;
            case 3:
            {
                UILabel *titleLa = [[UILabel alloc]initWithFrame:CGRectMake(10, 5, 150, 20)];
                titleLa.tag =107;
                titleLa.font= [UIFont systemFontOfSize:14];
                
                UILabel *invoiceLa = [[UILabel alloc]initWithFrame:CGRectMake(10, CGRectGetMaxY(titleLa.frame)+3, 150, 20)];
                invoiceLa.tag =108;
                invoiceLa.font =[UIFont systemFontOfSize:14];
                
                invoiceLa.textColor =[UIColor lightGrayColor];
                UILabel *invoiceHeadLa = [[UILabel alloc]initWithFrame:CGRectMake(10, CGRectGetMaxY(invoiceLa.frame)+3, 150, 20)];
                invoiceHeadLa.textColor =[UIColor lightGrayColor];
                invoiceHeadLa.tag =109;
                invoiceHeadLa.font =[UIFont systemFontOfSize:14];
                UILabel *addresLa = [[UILabel alloc]initWithFrame:CGRectMake(10, CGRectGetMaxY(invoiceHeadLa.frame)+3,150, 20 )];
                addresLa.textColor =[UIColor lightGrayColor];
                addresLa.tag=110;
                addresLa.font =[UIFont systemFontOfSize:14];
                
                [view  addSubview:titleLa];
                [view  addSubview:invoiceLa];
                [view  addSubview:invoiceHeadLa];
                [view  addSubview:addresLa];

                
            }
                break;
            case 4:
            {
                
                UILabel *nameLa = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 250, 25)];
                nameLa.tag =111;
                view.frame =CGRectMake(0, 0, SCREEN_WIDTH, 30);
                
             
                [view addSubview:nameLa];

            }
                break;
                
            default:
                break;
        }
        
    }
    UIView *view = (UIView*)[cell viewWithTag:10];
  
    
    switch (indexPath.row) {
        case 0:
        {
            NSDateFormatter *formatter =[[NSDateFormatter alloc] init];
            NSDateFormatter *formatter2 =[[NSDateFormatter alloc] init];
            [formatter setDateFormat:@"yyyy-MM-dd-HHmm-ss"];
            [formatter2 setDateFormat:@"yyyyMMddHHmmss"];
            NSString *currentTime = [formatter stringFromDate:[NSDate date]];
             NSString *currentOrderNum = [formatter2 stringFromDate:[NSDate date]];

            
            
            
            UILabel *nameLa= (UILabel*)[view viewWithTag:100];
            view.frame =CGRectMake(0, 0, SCREEN_WIDTH, 34);
            
            nameLa.text =[NSString stringWithFormat:@"订单号：%@   %@",currentOrderNum,currentTime];
          
          
        }
            break;
        case 1:
        { view.frame =CGRectMake(0, 0, SCREEN_WIDTH, 65);
            
            for (int i=0; i<self.selectedMu.count; i++) {
                
                 UIImageView *imgv = (UIImageView*)[view viewWithTag:101+i];
                
                
                MyCartM *mc =  [self.selectedMu  objectAtIndex:i];
                
                NSString *path = [NSString stringWithFormat:@"%@",mc.p_imgurl];
                [ imgv  setWebImgUrl:path placeHolder:[UIImage imageNamed:@"Product_Placeholder"]];
                if (i ==4) {
                    UIImageView *imgv5=(UIImageView*)[view viewWithTag:105];
                    imgv5.frame=CGRectMake(10+i*55, 28, 55, 55/5);
                    imgv5.image =[UIImage imageNamed:@"apostrophe"];
                }
                DLog(@"输出我们的选中的产品的模型有几个%@",mc.p_imgurl);
                

 
              
            }
           
                           }
            break;
        case 2:
        {
            view.frame =CGRectMake(0, 0, SCREEN_WIDTH, 100);
            
            
            UILabel *titleLa = (UILabel*)[view viewWithTag:103];
            UILabel *nameLa = (UILabel*)[view viewWithTag:104];
            UILabel *addresLa = (UILabel*)[view viewWithTag:105];
            UILabel *phoneLa = (UILabel*)[view viewWithTag:106];
            titleLa.text =@"收货地址";
            
            
              nameLa.text =[AccountHanler reciveName];
              addresLa.text = [AccountHanler addres];
              phoneLa.text = [AccountHanler recivePhone];

            
                       
            
            
            if ([AccountHanler   reciveName].length==0) {
                
                view.frame =CGRectMake(0, 0, SCREEN_WIDTH, 50);
                
            }
   
            
        }
            break;
        case 3:
        {
              view.frame =CGRectMake(0, 0, SCREEN_WIDTH, 100);
            
            
            UILabel *titleLa = (UILabel*)[view viewWithTag:107];
            UILabel *invoiceStyleLa = (UILabel*)[view viewWithTag:108];
            UILabel *invoiceAddresLa = (UILabel*)[view viewWithTag:109];
            UILabel *invoiceHeadLa = (UILabel*)[view viewWithTag:110];
            titleLa.text =@"索要发票";
            
            
            invoiceStyleLa.text =[AccountHanler invoiceStyle];
            invoiceAddresLa.text = [AccountHanler invoiceAdress];
            invoiceHeadLa.text = [AccountHanler invoiceHead];
            

            
            
         
            
            

                        if ([AccountHanler   invoiceHead].length==0) {
                          
                            view.frame =CGRectMake(0, 0, SCREEN_WIDTH, 50);

                        }

            
           
            
        }
            break;
        case 4:
        {    view.frame =CGRectMake(0, 0, SCREEN_WIDTH, 30);
            UILabel *nameLa = (UILabel*)[view viewWithTag:111];

            nameLa.text =@"支付宝";
                 }
            break;
            

        default:
            break;
    }
    
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
            CartOrderDetailVC *caod = [[CartOrderDetailVC alloc]init];
            caod.Mu =self.selectedMu;
            [self.navigationController pushViewController:caod animated:YES];

        }
            break;
        case 2:
        {
            AlwaysUsedAddresVC *al =  [[AlwaysUsedAddresVC alloc]init];
            NSString *identifer =@"identifer";
            al.identiferStr =identifer;
            [self.navigationController pushViewController:al animated:YES];

            
        }
            break;
        case 3:
        {
            ClaimInvoiceVC *ci = [[ClaimInvoiceVC alloc]init];
            [self.navigationController pushViewController:ci animated:YES];
            
        }
            break;
        case 4:
        {
                   }
            break;


        default:
            break;
    }
    
    
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField
{
    
    return YES;
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    
    [textField resignFirstResponder];
    return YES;
    
}

- (void)initBottomView
{
    UIView *view =[[UIView alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(_table.frame), SCREEN_WIDTH, 44)];
    view.backgroundColor = [UIColor whiteColor];
        UILabel *allPriceLa=  [[UILabel alloc]initWithFrame:CGRectMake(10, 10, 120, 20)];
    allPriceLa.font = [UIFont systemFontOfSize:14];
    
     allPriceLa.text = [NSString stringWithFormat:@"总金额:¥:%0.2f",self.totalP];
      allPriceLa.textColor  =[UIColor  lightGrayColor];
    [view addSubview:allPriceLa];
    
    
    
    UIButton *btn =[[UIButton alloc]initTarget:self WithTitle:@"提交订单" withColor:[UIColor whiteColor] action:@selector(payClick:)];
    
    [btn  setBackgroundColor:[UIColor  redColor]];
    
    btn.frame = CGRectMake(SCREEN_WIDTH-btn.size.width, 0, 70, 44);
    [view addSubview:btn];
    [self.view addSubview:view];
    
}
-(void)payClick:(UIButton*)btn
{

  CartCommitOrderVC *cvc = [[CartCommitOrderVC alloc]init];
    
  [self.navigationController  pushViewController:cvc animated:YES];

}
@end
