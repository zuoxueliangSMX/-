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


@interface CommitOrderVC ()<UITableViewDataSource,UITableViewDelegate,UIAlertViewDelegate>
{
    
    WEHTTPHandler *we;
    NSArray *imgArr;
    NSArray *titleArr;
    UITableView *_table;

    
}


@end

@implementation CommitOrderVC


-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];

    [_table reloadData];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.title =@"提交订单";
    
    we= [[WEHTTPHandler alloc]init];
    
    _table = [[UITableView alloc] initWithFrame:CGRectMake(0, 0,SCREEN_WIDTH,SCREEN_HEIGHT-64) style:UITableViewStylePlain];
    _table.backgroundColor =SET_COLOR(234.0, 234.0, 234.0);
    
    self.view.backgroundColor =SET_COLOR(234.0, 234.0, 234.0);
    
    _table.delegate =self;
    _table.dataSource =self;
    [self.view addSubview:_table];
    [self addFoot];

   

}

-(void)addFoot
{
    
   
    UIView *footView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, VIEW_WIDETH, 150)];
    GlanceCell *footCell = [[[NSBundle mainBundle] loadNibNamed:@"GlanceCell" owner:self options:nil]objectAtIndex:4];
    footCell.frame = CGRectMake(0, 10, SCREEN_WIDTH, 140);
    [footCell.layer setCornerRadius:4];
    footCell.backgroundColor = [UIColor whiteColor];
    footCell.backgroundColor = [UIColor whiteColor];
    footCell.goodsPriceLa.text = @"商品总额“¥ :800.00";
    footCell.freightageLa.text = @"共计运费: ¥ 8";
    footCell.subtractFeeLa.text =@"减免运费: 30";
    
    
    UIImageView *lineimgv2 = [[UIImageView alloc]initWithFrame:CGRectMake(20, CGRectGetMaxY(footCell.subtractFeeLa.frame)+6,  footCell.frame.size.width-40, 1)];
    lineimgv2.backgroundColor =[UIColor appLineColor];
    [footCell addSubview:lineimgv2];
    
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
            return 105;
        }
        case 3:
        {
            return 105;
        }
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
                UILabel *nameLa = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 250, 25)];
                nameLa.textColor =[UIColor blackColor];
                nameLa.font = [UIFont systemFontOfSize:12];
                nameLa.textColor = [UIColor  lightGrayColor];
                nameLa.tag =100;
                [view addSubview:nameLa];
            
            }
                break;
            case 1:
            {
                UIImageView *imgv =[[UIImageView alloc]initWithFrame:CGRectMake(10, 5, 55, 55)];
                imgv.tag =101;
                imgv.backgroundColor =[UIColor   blueColor];
                UIImageView *imgv2 =[[UIImageView alloc]initWithFrame:CGRectMake(CGRectGetMaxX(imgv.frame)+5, 5, 55, 55)];
                imgv2.backgroundColor =[UIColor   blueColor];
                imgv2.tag =102;
                
                [view addSubview:imgv];
                [view addSubview:imgv2];
                

                
            }
                break;
            case 2:
            {
                UILabel *titleLa = [[UILabel alloc]initWithFrame:CGRectMake(10, 5, 150, 20)];
                titleLa.text =@"收货地址";
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
                titleLa.text =@"索要发票";
                titleLa.tag =107;
                titleLa.font= [UIFont systemFontOfSize:14];
                
                UILabel *invoiceLa = [[UILabel alloc]initWithFrame:CGRectMake(10, CGRectGetMaxY(titleLa.frame)+3, 150, 20)];
                invoiceLa.font =[UIFont systemFontOfSize:14];
                
                invoiceLa.textColor =[UIColor lightGrayColor];
                UILabel *invoiceHeadLa = [[UILabel alloc]initWithFrame:CGRectMake(10, CGRectGetMaxY(invoiceLa.frame)+3, 150, 20)];
                invoiceHeadLa.textColor =[UIColor lightGrayColor];
                
                invoiceHeadLa.font =[UIFont systemFontOfSize:14];
                UILabel *addresLa = [[UILabel alloc]initWithFrame:CGRectMake(10, CGRectGetMaxY(invoiceHeadLa.frame)+3,150, 20 )];
                addresLa.textColor =[UIColor lightGrayColor];
                
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
            UILabel *nameLa= (UILabel*)[view viewWithTag:100];
            view.frame =CGRectMake(0, 0, SCREEN_WIDTH, 34);
            nameLa.text =@"订单号：11211221212  2015-－14 17：17";
          
        }
            break;
        case 1:
        { view.frame =CGRectMake(0, 0, SCREEN_WIDTH, 65);
            
            
            UIImageView *imgv = (UIImageView*)[view viewWithTag:101];
             UIImageView *imgv2 = (UIImageView*)[view viewWithTag:102];
            imgv.image = [UIImage imageNamed:@"Product_Placeholder"];
            imgv2.image = [UIImage imageNamed:@"Product_Placeholder"];
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

            
            //            NSString *lininfo = [NSString stringWithFormat:@"%@",[[SendIFAPPDefault shareAppDefault]contactStr]];
            
            
            
            
            //            wenbenLa.text =lininfo;
            //            if ([[SendIFAPPDefault shareAppDefault]contactStr].length==0) {
            //                cell.textLabel.text = @"请选择联系人:";
            //                wenbenLa.text =@"";
            //            }
   
            
        }
            break;
        case 3:
        {
              view.frame =CGRectMake(0, 0, SCREEN_WIDTH, 100);
//            //            NSString *lininfo = [NSString stringWithFormat:@"%@",[[SendIFAPPDefault shareAppDefault]contactStr]];
//            UILabel*wenbenLa = (UILabel*)[cell  viewWithTag:100];
//            wenbenLa.numberOfLines = 3;
//            //            wenbenLa.text =lininfo;
//            wenbenLa.font= [UIFont systemFontOfSize:15];
            
            
            
         
            
            
//            cell.textLabel.font = [UIFont systemFontOfSize:15];
//            cell.textLabel.text = @"联系人:";
//                        if ([[SendIFAPPDefault shareAppDefault]contactStr].length==0) {
//                            cell.textLabel.text = @"请选择联系人:";
//                            wenbenLa.text =@"";
//                        }

            
           
            
        }
            break;
        case 4:
        {
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

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
