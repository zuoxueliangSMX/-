//
//  PersonCenterVC.m
//  MGK
//
//  Created by sendInfo on 2014-02-13.
//  Copyright (c) 2014年 sendInfo. All rights reserved.
//

#import "PersonCenterVC.h"
#import "AppDelegate.h"
#import "SDImageCache.h"
#import "SendIFAPPDefault.h"
#import "MyRegisterVC.h"
#import "LoginVC.h"
#import "CheckPersonInFoVC.h"
#import "WEHTTPHandler.h"
#import "RDVTabBarController.h"
#import "WEHomeVC.h"
#import "RDVTabBarController.h"
#import "AlwaysUsedAddresVC.h"
#import "AccountHanler.h"
#import "UIBarButtonItem+Extension.h"
#import "SheZhiVC.h"
#import "MyCollectionVC.h"
#import "GlanceHistoryVC.h"
#import "WEMineOrderVC.h"

@interface PersonCenterVC () <UITableViewDataSource,UITableViewDelegate,UIAlertViewDelegate,UIActionSheetDelegate>
{
    NSArray *array1;
    NSArray *array2;
    
    NSArray *icons1;
    NSArray *icons2;
    
    NSArray *array3;
    
    BOOL _updateTable;
    
    UILabel *labbb;
    UIButton *loginBtn,*registBtn;
    UIAlertView *walert;
    
    UILabel * authorizationLa;
   
    UIImageView *imgv;
    
    UIImageView *head;
    
    UILabel *textLa;
    
    WEHTTPHandler *weh;
    
    UIButton *addresBut;
    UIImageView *imgvbg;

}
@end

@implementation PersonCenterVC

#pragma mark -
#pragma mark - pop和push控制器时的操作
- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    [[self rdv_tabBarController] setTabBarHidden:NO animated:YES];
}


- (void)viewWillAppear:(BOOL)animated{

    [super viewWillAppear:animated];
    
    [self addRightItem];
    if ([AccountHanler loginState]==1) {
        
     
        loginBtn.hidden = YES;
        registBtn.hidden = YES;
        imgv.hidden =YES;
        labbb.hidden = NO; addresBut.hidden =NO;
        
        labbb.hidden = NO;
        
        labbb.text =[AccountHanler userName];
        NSString *userID =[AccountHanler userId];
        [weh executeGetPersonCenterInfoWithUserId:userID Success:^(id obj) {
            
            
            if ([AccountHanler loginState]==0) {
                imgv.frame = CGRectMake(SCREEN_WIDTH * 0.5 - 140, (head.frame.size.height-60)/2-30, 30, 30);
                
                textLa.frame =CGRectMake((SCREEN_WIDTH-190+40)/2, CGRectGetMinY(imgv.frame), 190, 30);
            }else{
                imgv.frame = CGRectMake(SCREEN_WIDTH * 0.5 - 120, (head.frame.size.height-60)/2-30, 30, 30);
                textLa.frame =CGRectMake(15,  (head.frame.size.height-60)/2-30, SCREEN_WIDTH-30, 30);
            }
            NSString *str = [NSString stringWithFormat:@"您好：%@先生",[obj objectForKey:@"u_name"]];
//            NSString *is_identification= [obj objectForKey:@"is_identification"];
            textLa.text =str;

        } failed:^(id obj) {
            
        }];
        
        
        
    }else if ([AccountHanler loginState]==0){
        
        loginBtn.hidden = NO;
        registBtn.hidden = NO;
        imgv.hidden =NO;
        labbb.hidden = YES;
        addresBut.hidden =YES;
        textLa.text =@"登陆可以查看会员价哦～";
        
        
    }
   
}
- (void)addRightItem{
    UIBarButtonItem *right =[UIBarButtonItem itemWithImageName:@"Navigation_setup" highImageName:@"Navigation_setup" target:self action:@selector(setBtnClick)];
    /**
     *  width为负数时，相当于btn向右移动width数值个像素，由于按钮本身和边界间距为5pix，所以width设为-15时，间距正好调整
     *  为10；width为正数时，正好相反，相当于往左移动width数值个像素
     */
    UIBarButtonItem *negativeSpacer = [[UIBarButtonItem alloc]
                                       initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace
                                       target:nil action:nil];
    negativeSpacer.width = 5;

    self.navigationItem.rightBarButtonItems = @[negativeSpacer,right];
}


- (void)viewDidLoad
{
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    [self setTitle:@"个人中心"];
    array1 = @[@"查看信息",@"浏览历史",@"我的收藏",@"400-821-8800"];
    weh = [[WEHTTPHandler alloc]init];
    
    walert =[[UIAlertView alloc] initWithTitle:@"提示" message:@"登陆成功" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil] ;
    
    [self addUI];
}

- (void)loginClick{

    LoginVC *loginVC =[[LoginVC alloc]init];
    
    WENavitationController *nav =[[WENavitationController alloc]initWithRootViewController:loginVC];
    [self presentViewController:nav animated:YES completion:^{
        
    }];

}

- (void)registBtnClick{

    MyRegisterVC *sigvc = [[MyRegisterVC alloc] init];
    [self.navigationController pushViewController:sigvc animated:YES];
}

- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex{


    if (buttonIndex == 1) {
        

        CALL_PHONE(@"400-821-8800");
        
    }else if (buttonIndex == 2){
    
        [self launchMailAppOnDevice];
     
        
    }
    
    
}
-(void)launchMailAppOnDevice
{
    NSString *recipients = @"mailto:zjh@kxmy.com";
    //@"mailto:first@example.com?cc=second@example.com,third@example.com&subject=my email!";
    NSString *email = [NSString stringWithFormat:@"%@", recipients];
    email = [email stringByAddingPercentEscapesUsingEncoding: NSUTF8StringEncoding];
    
    [[UIApplication sharedApplication] openURL: [NSURL URLWithString:email]];
}
- (void)headBtnClick:(UIButton*)sender{
//  MyOrderMenuVC *mymenu = [[MyOrderMenuVC alloc]init];
    
    
    if ([AccountHanler userId]) {
        WEMineOrderVC *mymenu =[[WEMineOrderVC alloc]init];
        if (sender.tag == 98970) {
            mymenu.selectedItem =1;
        }else if (sender.tag == 98971){
            mymenu.selectedItem =2;
            
        }else if (sender.tag == 98972){
            
            mymenu.selectedItem =0;
        }else if (sender.tag == 98973){
            
            mymenu.selectedItem =3;
        }
        [self.navigationController pushViewController:mymenu animated:YES];
    }else{
        LoginVC *loginVC =[[LoginVC alloc]init];
        WENavitationController *nav =[[WENavitationController alloc]initWithRootViewController:loginVC];
        [self presentViewController:nav animated:YES completion:^{
            
        }];
 
    }
    
    
    
}

- (void)addUI

{
    
    
    head = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, VIEW_WIDETH, 200)];

    imgvbg = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"Person_header_bg"]];
    imgvbg.frame = head.frame;
    imgvbg.userInteractionEnabled =YES;
    [head addSubview:imgvbg];
    
     textLa = [[UILabel alloc]initWithFrame:CGRectMake(15,  (head.frame.size.height-60)/2-30, SCREEN_WIDTH-30, 30)];
    textLa.textAlignment = NSTextAlignmentCenter;
    imgv = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"Person_smile"]];
    imgv.frame = CGRectMake(SCREEN_WIDTH * 0.5 - 130, (head.frame.size.height-60)/2-30, 30, 30);
    [imgvbg addSubview:imgv];
    if ([AccountHanler loginState]==0) {
        textLa.frame =CGRectMake((SCREEN_WIDTH-190+40)/2, CGRectGetMinY(imgv.frame), 190, 30);
    }
    textLa.text =@"登陆可以查看会员价哦～";
    textLa.textColor =[UIColor whiteColor];
    [imgvbg addSubview:textLa];
    
    
    // 管理地址
     addresBut = [UIButton buttonWithType:UIButtonTypeCustom];
    [addresBut setFrame:CGRectMake((SCREEN_WIDTH-110)/2, CGRectGetMaxY(textLa.frame)+15, 110, 25)];
    [addresBut setTitle:@"管理我的地址 >" forState:UIControlStateNormal];
    [addresBut addTarget:self action:@selector(addressMangerClick) forControlEvents:UIControlEventTouchUpInside];
    addresBut.titleLabel.font =[UIFont systemFontOfSize:15];
    [addresBut setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [addresBut setImage:[UIImage imageNamed:@"Person_address"] forState:UIControlStateNormal];
    addresBut.imageEdgeInsets = UIEdgeInsetsMake(0.0, -20, 0.0, 0.0);
    addresBut.titleEdgeInsets = UIEdgeInsetsMake(0.0, -15.0, 0.0, 0.0);
    [imgvbg addSubview:addresBut];
    

   
//    [head sendSubviewToBack:imgvbg];
    
    UIView *blackv = [[UIView alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(head.frame)-55, VIEW_WIDETH, 55)];
    blackv.userInteractionEnabled =YES;
    blackv.alpha =0.6;
    blackv.backgroundColor = [UIColor blackColor];
    [imgvbg addSubview:blackv];
    
    
    NSArray *tits = @[@"待付款",@"待收货",@"全部订单",@"评价订单"];
    for (int i =0; i<4; i++) {
        
        
        UIButton *lBtn = [[UIButton alloc] initWithFrame:CGRectMake(i*(self.view.frame.size.width/4), 0, self.view.frame.size.width/4, 60)];
        [lBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [lBtn addTarget:self action:@selector(headBtnClick:) forControlEvents:UIControlEventTouchUpInside];
        [blackv addSubview:lBtn];
        lBtn.tag = 98970+i;
        
        UIImageView *img = [[UIImageView alloc] init];
        NSString *imgName = [NSString stringWithFormat:@"Person_headBtn%d",i+1];
        img.image = [UIImage imageNamed:imgName];
        img.contentMode = UIViewContentModeScaleAspectFit;
        [lBtn addSubview:img];
        [img mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.edges.equalTo(lBtn).with.insets(UIEdgeInsetsMake(3, 26, 35, 26));
            
        }];
        UILabel *lab = [[UILabel alloc] init];
        lab.textAlignment = NSTextAlignmentCenter;
        lab.textColor = [UIColor whiteColor];
        lab.text = tits[i];
        lab.font = [UIFont systemFontOfSize:15];
        [lBtn addSubview:lab];
        
        [lab mas_makeConstraints:^(MASConstraintMaker *make) {
            
             make.edges.equalTo(lBtn).with.insets(UIEdgeInsetsMake(30, 5, 5, 5));
        }];
        
    }
    

    
    labbb = [[UILabel alloc] initWithFrame:CGRectMake((head.frame.size.width-200)/2, CGRectGetMaxY(imgv.frame)+20, 200, 17)];
    labbb.textAlignment = NSTextAlignmentCenter;
    labbb.textColor = [UIColor whiteColor];
    [imgvbg addSubview:labbb];
    
    
    loginBtn = [[UIButton alloc] initWithFrame:CGRectMake(55, CGRectGetMaxY(imgv.frame)+10, 85, 30)];
    [loginBtn setTitle:@"登录" forState:UIControlStateNormal];
    [loginBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [loginBtn addTarget:self action:@selector(loginClick) forControlEvents:UIControlEventTouchUpInside];
    [loginBtn setBackgroundImage:[UIImage imageNamed:@"Person_BlackLine"] forState:UIControlStateNormal];
    [imgvbg addSubview:loginBtn];
    
    
    registBtn = [[UIButton alloc] initWithFrame:CGRectMake(SCREEN_WIDTH-85-55, CGRectGetMaxY(imgv.frame)+10, 85, 30)];
    [registBtn setTitle:@"注册" forState:UIControlStateNormal];
    [registBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [registBtn addTarget:self action:@selector(registBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [registBtn setBackgroundImage:[UIImage imageNamed:@"Person_BlackLine"] forState:UIControlStateNormal];
    [imgvbg addSubview:registBtn];
    head.userInteractionEnabled = YES;
    
   
    UITableView *tabelView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStyleGrouped];
    [tabelView setDelegate:self];
    [tabelView setDataSource:self];
    tabelView.tableHeaderView = head;

    [self.view addSubview:tabelView];
    
    [tabelView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.edges.equalTo(self.view).with.insets(UIEdgeInsetsMake(0, 0, 0, 0));
    }];
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
  
    return 44;
    
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView;{

    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section == 0) {
        
        return array1.count;
        
    }
    return 0;
    
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{

    UITableViewCell *cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:nil];
    if (indexPath.section ==0) {
        
        
        if (indexPath.row == 0) {
            
            
            UIImageView *line = [[UIImageView alloc] init];
            line.frame = CGRectMake(10, cell.frame.size.width, 310, 1);
            line.backgroundColor = SET_COLOR(213.f, 212.f, 216.f);
            line.tag = 8998;
            line.hidden = YES;
            [cell.contentView addSubview:line];
            
        }
                cell.accessoryType = UITableViewCellAccessoryDetailButton;
                [cell.textLabel setText:array1[indexPath.row]];
                NSString *img = [NSString stringWithFormat:@"Person_section_new%ld",indexPath.row+1];
                [cell.imageView setImage:[UIImage imageNamed:img]];
            
        
        }
        
        
        
    
    [cell setAccessoryType:UITableViewCellAccessoryDisclosureIndicator];
    return cell;
}
-(void)addressMangerClick
{


    AlwaysUsedAddresVC *addres = [[AlwaysUsedAddresVC alloc]init];
    
    [self.navigationController pushViewController:addres animated:YES];




}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    if (indexPath.section == 0) {
        
        if (indexPath.row == 0) {


            if ([AccountHanler userId]==NULL) {
            
                LoginVC *loginVC =[[LoginVC alloc]init];
                WENavitationController *nav =[[WENavitationController alloc]initWithRootViewController:loginVC];
                [self presentViewController:nav animated:YES completion:^{
                    
                }];

                return;
                
            }
            
            CheckPersonInFoVC *chVC = [[CheckPersonInFoVC alloc]init];
           [self.navigationController pushViewController:chVC animated:YES];
            
        }else if (indexPath.row == 1){
         
//            if ([AccountHanler loginState]==0) {
//                
//                ALERT_WARN(@"请先登录");
//                return;
//                
//            }
//            
            GlanceHistoryVC *gvc = [[GlanceHistoryVC alloc]init];
            
            [self.navigationController pushViewController:gvc animated:YES];

        }else if (indexPath.row == 2){
            
            if ([AccountHanler loginState]==0) {
                
                LoginVC *loginVC =[[LoginVC alloc]init];
                WENavitationController *nav =[[WENavitationController alloc]initWithRootViewController:loginVC];
                [self presentViewController:nav animated:YES completion:^{
                    
                }];

                return;
            
            }
            MyCollectionVC *myfav = [[MyCollectionVC alloc]init];
        
       [self.navigationController pushViewController:myfav animated:YES];
        
        }else if (indexPath.row == 3){

            
            
            CALL_PHONE(@"400-821-8800");
        }
        
    }
    
}
//
//- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
//    
//    
//    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"https://itunes.apple.com/cn/app/id877948693?mt=8"]];
//    
//}


-(void)setBtnClick
{
     
    SheZhiVC *shezhi = [[SheZhiVC alloc]init];
    
    [self.navigationController pushViewController:shezhi animated:YES];


}


@end
