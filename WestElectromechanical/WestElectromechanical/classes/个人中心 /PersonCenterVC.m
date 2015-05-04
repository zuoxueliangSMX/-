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

#import "MyRegisterVC.h"
#import "MeVC.h"


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

}
@end

@implementation PersonCenterVC


- (void)viewWillAppear:(BOOL)animated{

    [super viewWillAppear:animated];
    if ([AccountHanler loginState]==1) {
        
     
        loginBtn.hidden = YES;
        registBtn.hidden = YES;
        labbb.hidden = NO;
        if ([AccountHanler  mobilePhone].length==0) {
            
            labbb.text =[AccountHanler nickname];
            
        }else{
        
            labbb.text =[AccountHanler  mobilePhone];}
        
        
    }else{
        
        loginBtn.hidden = NO;
        registBtn.hidden = NO;
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
    
    
  walert =[[UIAlertView alloc] initWithTitle:@"提示" message:@"登陆成功" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil] ;
    
    [self addUI];
}

- (void)loginClick{

    MeVC *me = [[MeVC alloc]init];
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
        
        
        UIActionSheet *act = [[UIActionSheet alloc] initWithTitle:@"咨询建议" delegate:self cancelButtonTitle:nil destructiveButtonTitle:@"取消" otherButtonTitles:@"0851-86889691",@"zjh@kxmy.com", nil];
        [act showInView:self.view];
        
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
    
    UILabel *textLa = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(imgv.frame)+5,  (head.frame.size.height-60)/2-42, 190, 50)];
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

//    
//    TabbarVC *fvc = [[TabbarVC alloc] init];
//    
//    AppDelegate *app = (AppDelegate*)[UIApplication sharedApplication].delegate;
//    app.window.rootViewController = fvc;
//    
//    
//    [[SendIFAppDefault shareAppDefault] setLoginState:@"0"];
//    [[SendIFAppDefault shareAppDefault] setCurrentUserId:nil];
//    [[SendIFAppDefault shareAppDefault] setMobilePhone:nil];
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (indexPath.row == 0 && indexPath.section ==0) {
        
        return _updateTable?160:44;
    }
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


//            if ([SendIFAppDefault shareAppDefault].currentUserId.length==0) {
//            
//                ALERT_WARN(@"请先登录");
//                return;
//                
//            }
//            
//            SegmentOrderVC *sgvc = [[SegmentOrderVC alloc] init];
//            [self.navigationController pushViewController:sgvc animated:YES];
            
        }else if (indexPath.row == 1){

            
        }else if (indexPath.row == 2){
            
//            if ([SendIFAppDefault shareAppDefault].currentUserId.length==0) {
//                
//                ALERT_WARN(@"请先登录");
//                return;
            
//            }
//        [self.navigationController pushViewController:[ChangePassVC new] animated:YES];
        
        }else if (indexPath.row == 3){
//            
//            [self.navigationController pushViewController:[AboutVC new] animated:YES];
        }
        
    }else if (indexPath.section == 1){
        
        if (indexPath.row == 2) { //审核进禁用此功能
//
//            [ProgressHUD show:@"检查版本中"];
//            AFHTTPClient *cli = [[AFHTTPClient alloc] initWithBaseURL:[NSURL URLWithString:@"https://itunes.apple.com/cn"]];
//            [cli getPath:@"lookup" parameters:@{@"id":@"877948693"} success:^(AFHTTPRequestOperation *operation, id responseObject) {
//                
//                NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingAllowFragments error:nil];
//                
//                DLog(@"version DIC %@",dic);
//                
//                NSDictionary *resultD = [[dic objectForKey:@"results"] firstObject];
//                NSString *version = [resultD objectForKey:@"version"];
//                
//                NSString *nowVersion = [[NSBundle mainBundle] objectForInfoDictionaryKey:@"CFBundleShortVersionString"];
//                if ([version isEqualToString:nowVersion]) {
//                    
//                    [ProgressHUD showSuccess:@"已经是最新版本"];
//                    
//                }else if ([version floatValue] > [nowVersion floatValue]){
//                    
//                    [ProgressHUD dismiss];
//                    [[[UIAlertView alloc] initWithTitle:@"提示" message:@"有新的版本需要更新" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil] show];
//                }else if ([version floatValue] < [nowVersion floatValue]){
//                
//                    [ProgressHUD showSuccess:@"暂无更新"];
//                
//                }
//                
//                
//            } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
//                
//            }];
//            [cli operationQueue];
//

            
        }else if (indexPath.row ==0){
        

//            [self.navigationController pushViewController:[FunctionIntroVC new] animated:YES];
//            
            
        }else if (indexPath.row ==1){
            
            
            
//            [[NSFileManager defaultManager] removeItemAtPath:[NSHomeDirectory() stringByAppendingPathComponent:@"Documents/voices/"] error:nil];
//            
//            [[NSFileManager defaultManager] removeItemAtPath:[NSHomeDirectory() stringByAppendingPathComponent:@"Documents/huanggsDB.sqlite"] error:nil];
//            NSString *pathOne = [[NSBundle mainBundle] pathForResource:@"iphone" ofType:@"sqlite"];
//            NSString *pathTwo = [NSHomeDirectory() stringByAppendingPathComponent:@"Documents/huanggsDB.sqlite"];
//            
//            [[NSFileManager defaultManager] copyItemAtPath:pathOne toPath:pathTwo error:nil];
//            
//            
//            [[SDImageCache sharedImageCache] clearDisk];
//            [[SDImageCache sharedImageCache] clearMemory];
//            [[SDImageCache sharedImageCache] cleanDisk];
//            [[SendIFAppDefault shareAppDefault] setIsFirstLanuch:@"0"];
//            
//            [[[UIAlertView alloc] initWithTitle:@"提示" message:@"缓存已经清除,如需重新拉取数据，请在首页下拉更新最新数据" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil] show];
//            

            
        }else if (indexPath.row ==3){
            

        }
        
    
    }else if (indexPath.section == 2){
    
        if (indexPath.row == 0) {
            
//            
//            ShowWordsVC *svc = [[ShowWordsVC alloc] init];
//            svc.titlee = @"联系我们";
//            svc.contents = @"电话:0851-86889691\n\n邮箱:zjh@kxmy.com";
//            [self.navigationController pushViewController:svc animated:YES];
            
        }else if (indexPath.row == 1){
//        
//            ShowWordsVC *svc = [[ShowWordsVC alloc] init];
//            svc.titlee = @"常见问题";
//            svc.contents = @"Q:全范围的酒店太多，我该如何缩小范围找到合适的酒店？\n A:您可以在酒店页面点击上面的筛选条件进行精确的搜索。\n\nQ:收藏景区，景点时，会收藏不了？\nA:你可以先登录，再次尝试。\n\nQ:为什么分享时候，没有显示新浪微博，或者腾讯微博?\nA:你需要在手机系统设置里，绑定相关的账号（不需要下载第三方的app就可以进行绑定），再次分享的时候，就会显示。\n\nQ:首页的相机拍照为什么不能分享？\nA:拍完照后，相片默认保存在系统相册里，从相册里进行分享。\n\nQ:为什么距离一直显示的是未定位？\nA:手机的定位功能没有开启，具体是在手机系统设置里，隐私->定位服务->打开。\n\nQ:怎么切换到其他的城市浏览产品？\nA:在每个模块的主页的左上角有个城市出发的按钮，点击打开侧滑菜单，然后就可以选择城市，并且切换到该城市下。\n\nQ:为什么数据没有更新下来？ \nA:如果数据没有更新下来，在首页下拉更新数据，如果任然没有更新下来请直接在个人中心里清除缓存后，再下拉刷新";
//            [self.navigationController pushViewController:svc animated:YES];
//            
        }else if (indexPath.row == 2){
        
//            ShowWordsVC *svc = [[ShowWordsVC alloc] init];
//            svc.titlee = @"隐私说明";
//            svc.contents = @"黄果树手机版隐私政策说明\n\n第一条 黄果树手机版根据用户指令为用户提供旅游景区、传播的信息网络存储空间，宗旨是创建手机用户旅游交流,及购买门票的平台。第二条 任何登陆、使用本应用的用户，无论以何种方式使用，包括但不限于浏览、上传、下载等，均视为接受本政策的规定。第三条 本应用十分重视知识产权的保护，充分尊重作者依据《中华人民共和国著作权法》、《信息网络传播权保护条例》及中华人民共和国批准加入的国际公约，如《伯尔尼公约》、《世界版权公约》、《与贸易有关的知识产权协议》等，所享有的人身权利和财产权利。用户应用时亦应遵守上述法律、法规及公约的相关规定。第四条 所展示的图片、音频、文字等均为版权所有者授权发布。";
//            [self.navigationController pushViewController:svc animated:YES];
//            
        }
    
    }
}
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    
    
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"https://itunes.apple.com/cn/app/id877948693?mt=8"]];
    
}





@end
