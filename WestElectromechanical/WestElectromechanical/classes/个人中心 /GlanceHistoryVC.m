//
//  GlanceHistoryVC.m
//  WestElectromechanical
//
//  Created by 夏亚峰 on 15/5/7.
//  Copyright (c) 2015年 zuo. All rights reserved.
//

#import "GlanceHistoryVC.h"
#import "GlanceCell.h"

@interface GlanceHistoryVC ()<UITableViewDelegate,UITableViewDataSource>
{
    
    
    UITableView *_table;
    NSArray *Arr;
    
}


@end

@implementation GlanceHistoryVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    self.navigationItem.rightBarButtonItem =   [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemDone target:self action:@selector(clearAllClick)];
    self.navigationItem.rightBarButtonItem.tintColor =[UIColor whiteColor];

    
    _table = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height) style:UITableViewStylePlain];
    
    
    
  
//    NSMutableArray *images = [[NSMutableArray alloc] initWithCapacity:0];
    _table.delegate =self;
    _table.dataSource =self;
    [self.view addSubview:_table];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return 110;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return 10;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
    static NSString * cellidentifer = @"cell";
    GlanceCell * cell = [tableView dequeueReusableCellWithIdentifier:cellidentifer];
    if (cell ==nil) {
        
        
        cell = [[[NSBundle mainBundle] loadNibNamed:@"GlanceCell" owner:self options:nil]objectAtIndex:0];
        cell.selectionStyle = UITableViewCellSelectionStyleGray;
        
    }
    
//    ZyxM *zm = [zyxArr objectAtIndex:indexPath.row];
//    
//    
//    NSString *path1 = [NSString stringWithFormat:@"%@%@",SendIFServer,zm.picture];
//    [cell.bigImgView sd_setImageWithURL:[NSURL URLWithString:path1] placeholderImage:[UIImage imageNamed:@"about_1"] completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
//        [[SDImageCache sharedImageCache] storeImage:image forKey:zm.picture];
//    }];
//
    
    cell.imgV.image = [UIImage imageNamed:@"Product_Placeholder"];
    cell.titleLa.text=@"CPU芯片";
    cell.orderNum.text =@"090807";
    cell.styleBrand.text =@"89-2型 联发科品牌";
    cell.priceLa.text =@"999元";
    cell.memberPrice.text =@"9.9元";
//    cell.cartBtn.image= [UIImage imageNamed:@"Product_AddCart"];
    
    [cell.cartBtn setBackgroundImage:[UIImage imageNamed:@"Product_AddCart"] forState:UIControlStateNormal];
    
//    cell.titleLa.text = zm.zyxName;
//    cell.introduceLa.text =[NSString stringFromHtml:zm.introduce];
//    cell.priceLa.text =zm.price ;
//    cell.accesoryImgv.image =[UIImage imageNamed:@"ico16"];
    return cell;
    
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
//    FreeLineDetailVC *free =[[FreeLineDetailVC alloc]init];
//    
//    
//    ZyxM*zm = [zyxArr objectAtIndex:indexPath.row];
//    free.zm =zm;
//    
//    
//    [self.navigationController pushViewController:free animated:YES];
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    
}

-(void)clearAllClick
{



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
