//
//  PersonCenterVC.m
//  MGK
//
//  Created by sendInfo on 2014-02-13.
//  Copyright (c) 2014年 sendInfo. All rights reserved.
//

#import "PersonCenterVC.h"
//#import "SendIFAppDefault.h"
#import "AccountHanler.h"

//#import "TabbarVC.h"
#import "AppDelegate.h"
//#import "MyOrderListVC.h"
//#import "MyFavVC.h"
//#import "AboutVC.h"
//#import "ProgressHUD.h"
//#import "AFHTTPClient.h"
//#import "ChangePassVC.h"
//#import "HttpManager.h"
//#import "MyRegisterVC.h"
//#import "MyLoginVC.h"
//#import "CardVoucherVC.h"
#import "SDImageCache.h"
//#import "ManagerPushMessVC.h"
//#import "FunctionIntroVC.h"
//#import "ShowWordsVC.h"
//#import "SegmentOrderVC.h"
#import "SendIFAPPDefault.h"

#import "MyRegisterVC.h"
#import "LoginVC.h"
#import "CheckPersonInFoVC.h"
#import "WEHTTPHandler.h"
#import "RDVTabBarController.h"
#import "WEHomeVC.h"



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
    
    UIView *head;
    
    UILabel *textLa;
    
    WEHTTPHandler *weh;

}
@end

@implementation PersonCenterVC


- (void)viewWillAppear:(BOOL)animated{

    [super viewWillAppear:animated];
    if ([AccountHanler loginState]==1) {
        
     
        loginBtn.hidden = YES;
        registBtn.hidden = YES;
        imgv.hidden =YES;
               labbb.hidden = NO;
        
        NSString *userID =[AccountHanler userId];
        [weh executeGetPersonCenterInfoWithUserId:userID Success:^(id obj) {
            NSString *str = [NSString stringWithFormat:@"%@先生",[obj objectForKey:@"u_name"]];
            NSString *is_identification= [obj objectForKey:@"is_identification"];
            textLa.text =str;

        } failed:^(id obj) {
            
        }];
        
        
//        
//        if ([SendIFAPPDefault shareAppDefault].phone.length==0) {
//
//            
//        }else{
//        
//            labbb.text =[SendIFAPPDefault shareAppDefault].phone;}
//        
        
    }else{
        
        loginBtn.hidden = NO;
        registBtn.hidden = NO;
        imgv.hidden =NO;
        labbb.hidden = YES;
    }
   }
- (void)viewWillDisappear:(BOOL)animated{

    [super viewWillDisappear:animated];
//    [HttpManager cancelAllRequestHttpTool];
}


- (void)viewDidLoad
{
    [super viewDidLoad];
    VIEW_BACKGROUND;
    [self setTitle:@"个人中心"];
    array1 = @[@"查看信息",@"浏览历史",@"我的收藏",@"40025558787"];
    weh = [[WEHTTPHandler alloc]init];
    
  walert =[[UIAlertView alloc] initWithTitle:@"提示" message:@"登陆成功" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil] ;
    
    [self addUI];
}

- (void)loginClick{

    LoginVC *me = [[LoginVC alloc]init];
    [self.navigationController pushViewController:me animated:YES];
}

- (void)registBtnClick{

    MyRegisterVC *sigvc = [[MyRegisterVC alloc] init];
    [self.navigationController pushViewController:sigvc animated:YES];
}

- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex{


    if (buttonIndex == 1) {
        

        CALL_PHONE(@"0851-86889691");
        
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

    
    if (sender.tag == 98970) {
        
        
//        UIActionSheet *act = [[UIActionSheet alloc] initWithTitle:@"咨询建议" delegate:self cancelButtonTitle:nil destructiveButtonTitle:@"取消" otherButtonTitles:@"0851-86889691",@"zjh@kxmy.com", nil];
//        [act showInView:self.view];
        
    }else if (sender.tag == 98971){
        
//        ManagerPushMessVC *mvc = [[ManagerPushMessVC alloc] init];
//        [self.navigationController pushViewController:mvc animated:YES];
    
    }else if (sender.tag == 98972){
       
//        if ([SendIFAppDefault shareAppDefault].currentUserId.length==0) {
//            
//            ALERT_WARN(@"请先登录");
//            return;
        
//        }
//        MyFavVC *fav= [[MyFavVC alloc] init];
//        [self.navigationController pushViewController:fav animated:YES];
    
    }else if (sender.tag == 98973){
        
//        ALERT_WARN(@"敬请期待!");
//        return;
//        
//        CardVoucherVC *cavc = [[CardVoucherVC alloc] initWithNibName:nil bundle:nil];
//        [self.navigationController pushViewController:cavc animated:YES];
    }

    
}

- (void)addUI
{
    
    
    head = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 200)];
   
   imgv = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"qw"]];
    imgv.frame = CGRectMake((head.frame.size.width-150)/4, (head.frame.size.height-60)/2-42, 50, 50);
    [head addSubview:imgv];
    
    textLa = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(imgv.frame)+5,  (head.frame.size.height-60)/2-42, 190, 50)];
    textLa.text =@"登陆可以查看会员价哦～";
    textLa.textColor =[UIColor whiteColor];
    [head addSubview:textLa];

    UIImageView *imgvbg = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"qweqwe"]];
    [head addSubview:imgvbg];
    [head setBackgroundColor:[UIColor colorWithPatternImage:[UIImage imageNamed:@"retertret"]]];
    [head sendSubviewToBack:imgvbg];
    [imgvbg mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.edges.equalTo(head).with.insets(UIEdgeInsetsMake(0, 0, 55, 0));
    }];
    
    NSArray *tits = @[@"待付款",@"待收货",@"全部订单",@"评价订单"];
    for (int i =0; i<4; i++) {
        
        
        UIButton *lBtn = [[UIButton alloc] initWithFrame:CGRectMake(i*(self.view.frame.size.width/4), CGRectGetMaxY(head.frame)-60, self.view.frame.size.width/4, 70)];
        [lBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [lBtn addTarget:self action:@selector(headBtnClick:) forControlEvents:UIControlEventTouchUpInside];
        [head addSubview:lBtn];
        lBtn.tag = 98970+i;
        
        UIImageView *img = [[UIImageView alloc] init];
        NSString *imgName = [NSString stringWithFormat:@"headBtn%d",i+1];
        img.image = [UIImage imageNamed:imgName];
        [lBtn addSubview:img];
        [img mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.edges.equalTo(lBtn).with.insets(UIEdgeInsetsMake(10, 26, 35, 26));
            
        }];
        UILabel *lab = [[UILabel alloc] init];
        lab.textAlignment = NSTextAlignmentCenter;
        lab.textColor = [UIColor whiteColor];
        lab.text = tits[i];
        lab.font = [UIFont systemFontOfSize:15];
        [lBtn addSubview:lab];
        
        [lab mas_makeConstraints:^(MASConstraintMaker *make) {
            
             make.edges.equalTo(lBtn).with.insets(UIEdgeInsetsMake(45, 5, 15, 5));
        }];
        
    }
    

    
    labbb = [[UILabel alloc] initWithFrame:CGRectMake((head.frame.size.width-200)/2, CGRectGetMaxY(imgv.frame)+20, 200, 17)];
    labbb.textAlignment = NSTextAlignmentCenter;
    labbb.textColor = [UIColor whiteColor];
    [head addSubview:labbb];
    
    
    loginBtn = [[UIButton alloc] initWithFrame:CGRectMake(55, CGRectGetMaxY(imgv.frame)+10, 85, 30)];
    [loginBtn setTitle:@"登录" forState:UIControlStateNormal];
    [loginBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [loginBtn addTarget:self action:@selector(loginClick) forControlEvents:UIControlEventTouchUpInside];
    [loginBtn setBackgroundImage:[UIImage imageNamed:@"retertret"] forState:UIControlStateNormal];
    [head addSubview:loginBtn];
    
    
    registBtn = [[UIButton alloc] initWithFrame:CGRectMake(CGRectGetMaxX(loginBtn.frame)+40, CGRectGetMaxY(imgv.frame)+10, 85, 30)];
    [registBtn setTitle:@"注册" forState:UIControlStateNormal];
    [registBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [registBtn addTarget:self action:@selector(registBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [registBtn setBackgroundImage:[UIImage imageNamed:@"retertret"] forState:UIControlStateNormal];
    [head addSubview:registBtn];
    
    
   
    
   

    
    
    //footer
    UIView *fooV = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 40)];
    
    UIButton *outBtn = [[UIButton alloc] init];
    [outBtn setTitle:@"安全退出登录" forState:UIControlStateNormal];
    [outBtn setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    outBtn.layer.cornerRadius = 8;
    outBtn.layer.masksToBounds = YES;
    outBtn.layer.borderWidth = 1.0;
    [outBtn addTarget:self action:@selector(outBtnClick) forControlEvents:UIControlEventTouchUpInside];
    outBtn.layer.borderColor = [UIColor redColor].CGColor;
    [fooV addSubview:outBtn];
    [outBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.edges.equalTo(fooV).with.insets(UIEdgeInsetsMake(0, 5, 2, 5));
    }];
    
    UITableView *tabelView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStyleGrouped];
    [tabelView setDelegate:self];
    [tabelView setDataSource:self];
    tabelView.tableHeaderView = head;
    tabelView.tableFooterView = fooV;
    [self.view addSubview:tabelView];
    
    [tabelView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.edges.equalTo(self.view).with.insets(UIEdgeInsetsMake(0, 0, 0, 0));
    }];
}
- (void)outBtnClick{

    
    
    
    AppDelegate *app = (AppDelegate*)[UIApplication sharedApplication].delegate;
    [app initTabControlers];
    
//    [[SendIFAppDefault shareAppDefault] setMobilePhone:nil];
    
    [AccountHanler setLoginState:0];
    
    [AccountHanler saveUserId:nil];
    
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
                NSString *img = [NSString stringWithFormat:@"section_new%d",indexPath.row+1];
                [cell.imageView setImage:[UIImage imageNamed:img]];
            
        
        }
        
        
        
    
    [cell setAccessoryType:UITableViewCellAccessoryDisclosureIndicator];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    if (indexPath.section == 0) {
        
        if (indexPath.row == 0) {


            if ([AccountHanler userId]==NULL) {
            
                ALERT_WARN(@"请先登录");
                return;
                
            }
            
            
            
            
            
            CheckPersonInFoVC *chVC = [[CheckPersonInFoVC alloc]init];
           [self.navigationController pushViewController:chVC animated:YES];
            
        }else if (indexPath.row == 1){

            
        }else if (indexPath.row == 2){
            
//            if ([SendIFAppDefault shareAppDefault].currentUserId.length==0) {
//                
//                ALERT_WARN(@"请先登录");
//                return;
            
//            }
//        [self.navigationController pushViewController:[ChangePassVC new] animated:YES];
        
        }else if (indexPath.row == 3){

            
            
            CALL_PHONE(@"40025558787");
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





@end
