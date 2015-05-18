//
//  MarkSheetVC.m
//  WestElectromechanical
//
//  Created by 夏亚峰 on 15/5/7.
//  Copyright (c) 2015年 zuo. All rights reserved.
//

#import "MarkSheetVC.h"
#import "GCPlaceholderTextView.h"
#import <QuartzCore/QuartzCore.h>
#import "AccountHanler.h"
#import "RDVTabBarController.h"
@interface MarkSheetVC ()<UITextViewDelegate >
{
    
    NSArray *arr;
    GCPlaceholderTextView *tv;
    UIPickerView *Numpicker;
    UIBarButtonItem *done;
    
}


@end

@implementation MarkSheetVC

-(void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [[self rdv_tabBarController] setTabBarHidden:YES animated:YES];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    [[self rdv_tabBarController] setTabBarHidden:NO animated:YES];
}


- (void)viewDidLoad {
    [super viewDidLoad];
    self.title =@"设置";
    VIEW_BACKGROUND
    tv=[[GCPlaceholderTextView alloc] initWithFrame:CGRectMake(10, 40,SCREEN_WIDTH-20, 160)];
    tv.contentInset = UIEdgeInsetsMake(0, 0, 0, 0);
    tv.delegate = self;
    
    tv.placeholder=@"字数不超过200字";
    
    
    tv.font= [UIFont systemFontOfSize:17];
    tv.layer.borderColor = [UIColor lightGrayColor].CGColor;
    
    tv.layer.borderWidth =0.8;
    
    
    [self.view addSubview:tv];
    
    
    UIButton * commitBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [commitBtn setFrame:CGRectMake(20, CGRectGetMaxY(tv.frame)+25, 80, 35)];
    [commitBtn.layer setMasksToBounds:YES];
    [commitBtn.layer setCornerRadius:5];
    [commitBtn  setTitle:@"提       交" forState:UIControlStateNormal ];
    [commitBtn  setTitle:@"" forState:UIControlStateHighlighted ];
    [commitBtn setBackgroundColor:SET_COLOR(255.0, 99.0, 0.0)];
    [commitBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [commitBtn addTarget:self action:@selector(commit) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:commitBtn];
    
    
    UIButton * markBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [markBtn setFrame:CGRectMake(SCREEN_WIDTH-100, CGRectGetMaxY(tv.frame)+25, 80, 35)];
    [markBtn.layer setMasksToBounds:YES];
    [markBtn.layer setCornerRadius:5];
    [markBtn  setTitle:@"评       分" forState:UIControlStateNormal ];
    [markBtn  setTitle:@"" forState:UIControlStateHighlighted ];
    [markBtn setBackgroundColor:SET_COLOR(255.0, 99.0, 0.0)];
    [markBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [markBtn addTarget:self action:@selector(markBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:markBtn];


}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)textViewDidBeginEditing:(UITextView *)textView {
    
    
    
    self.navigationItem.rightBarButtonItem = done;
    
}

- (void)textViewDidEndEditing:(UITextView *)textView {
    
    self.navigationItem.rightBarButtonItem = nil;
    
}

- (void)Doneit {
    
    [tv resignFirstResponder];
   }
-(void)commit
{
    
    NSString *userID =  [AccountHanler userId];
    if (userID == nil) {
        
        
        WARN_ALERT(@"请登录");
        return;
    }
//    NSMutableString * str =  [[NSMutableString alloc]initWithString:self.starfield.text];
//    
//    [str  deleteCharactersInRange:NSMakeRange(1,1)];
//    
//    NSDictionary *dic = @{@"typeId": self.type,
//                          @"outOrderNo":self.outOrderNo,
//                          @"content":tv.text,
//                          @"accountId":userID,
//                          @"score":str
//                          };
//    
//    
//    [HttpManager userAddComentsWithDataInfo:@{@"comment":dic} subKey:@"comment" result:^(NSArray *result) {
//        
//    }];
    
//    
//    [self.navigationController popViewControllerAnimated:YES];
    
    
}

-(void)markBtnClick
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
