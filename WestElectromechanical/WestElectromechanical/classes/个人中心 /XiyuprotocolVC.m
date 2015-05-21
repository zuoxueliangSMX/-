//
//  XiyuprotocolVC.m
//  WestElectromechanical
//
//  Created by 夏亚峰 on 15/5/20.
//  Copyright (c) 2015年 zuo. All rights reserved.
//

#import "XiyuprotocolVC.h"
#import "RDVTabBarController.h"
#import "UIButton+Extension.h"
@interface XiyuprotocolVC ()

@end

@implementation XiyuprotocolVC
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
- (void)setXiyuprotocolVCBlock:(xiyuprotocolVCBlock)block
{
    _block =block;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    self.view.backgroundColor =[UIColor whiteColor];
    UIWebView *web = [[UIWebView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height-40)];
    [self.view addSubview:web];
    
    [web  loadHTMLString:self.text baseURL:nil];
    
    
    UIView *view =[[UIView alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(web.frame), SCREEN_WIDTH, 40)];
    [self.view addSubview:view];
    
    
    NSArray *arr =@[@"不同意",@"同意"];
    for (int i =0; i<2; i++) {
        UIButton * button =[UIButton addTarget:self WithNorTitle:[arr objectAtIndex:i] withNorColor:[UIColor whiteColor] withSelectedTitle:[arr objectAtIndex:i] withSelectedColor:[UIColor whiteColor] withBackgroundColor:[UIColor lightGrayColor] withTileSize:font(18) action:@selector(agree:)];
        if (i==1) {
            button.backgroundColor =[UIColor redColor];
        }
        button.tag=1000+i;
        button.frame = CGRectMake(20+((SCREEN_WIDTH-60)/2+20)*i, 0, (SCREEN_WIDTH-60)/2, 40);
        [view addSubview:button];
    }

}
- (void)agree:(UIButton *)btn
{
    if (_block) {
        _block(btn.tag);
    }

    [self.navigationController popViewControllerAnimated:YES];
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
