//
//  XiyuprotocolVC.m
//  WestElectromechanical
//
//  Created by 夏亚峰 on 15/5/20.
//  Copyright (c) 2015年 zuo. All rights reserved.
//

#import "XiyuprotocolVC.h"

@interface XiyuprotocolVC ()

@end

@implementation XiyuprotocolVC

- (void)viewDidLoad {
    [super viewDidLoad];
    UIWebView *web = [[UIWebView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height-40)];
    [self.view addSubview:web];
    
    
    
    
    
    
    
    [web  loadHTMLString:self.text baseURL:nil];

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
