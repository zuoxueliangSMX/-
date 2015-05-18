//
//  WEMineAddComentCell.m
//  WestElectromechanical
//
//  Created by 夏亚峰 on 15/5/18.
//  Copyright (c) 2015年 zuo. All rights reserved.
//

#import "WEMineAddComentCell.h"
#import "WEMineComentHeadView.h"
#import "GCPlaceholderTextView.h"
@interface WEMineAddComentCell()<UITextViewDelegate >
{
    GCPlaceholderTextView *tv;


}
@end
@implementation WEMineAddComentCell
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self =[super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        
     WEMineComentHeadView *header = [[WEMineComentHeadView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 60)];
        
       header.backgroundColor =[UIColor whiteColor];
      [self.contentView addSubview:header];
       
        
        tv=[[GCPlaceholderTextView alloc] initWithFrame:CGRectMake(10, CGRectGetMaxY(header.frame)+10,SCREEN_WIDTH-20, 60)];
        tv.contentInset = UIEdgeInsetsMake(0, 0, 0, 0);
        tv.delegate = self;
        
        tv.placeholder=@"亲，写点什么吧，您的意见对我们有很大帮助";
        
        
        tv.font= [UIFont systemFontOfSize:13];
        tv.layer.borderColor = [UIColor lightGrayColor].CGColor;
        tv.layer.cornerRadius =4.0;
        tv.backgroundColor = SET_COLOR(244.0, 244.0, 244.0);

        tv.layer.borderWidth =0.8;
        
        
        [self addSubview:tv];
 
        
        
    }
    
    return self;
}
-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    
    
    
    [self endEditing:YES];
    
    
    
}
- (void)textViewDidBeginEditing:(UITextView *)textView {
    
    
    
    
}

- (void)textViewDidEndEditing:(UITextView *)textView {
    
    
}




@end
