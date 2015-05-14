//
//  WEProductCommentCell.m
//  WestElectromechanical
//
//  Created by zuo on 15/5/14.
//  Copyright (c) 2015年 zuo. All rights reserved.
//

#import "WEProductCommentCell.h"
@interface WEProductCommentCell()
@property (nonatomic ,weak)UIView  *commentBg;
@property (nonatomic ,weak)UILabel *commentUserName;
@property (nonatomic ,weak)UILabel *commentDate;
@property (nonatomic ,weak)UILabel *commentContent;
@property (nonatomic ,weak)UILabel *line;
@property (nonatomic ,weak)CommentImgListView *imgListView;
@end
@implementation WEProductCommentCell
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self =[super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        UIView *commentBg =[[UIView alloc]init];
        commentBg.backgroundColor =[UIColor whiteColor];
        commentBg.layer.cornerRadius = 5;
        commentBg.layer.borderColor =[UIColor whiteColor].CGColor;
        commentBg.layer.borderWidth = 1;
        [self.contentView addSubview:commentBg];
        _commentBg = commentBg;
        
        UILabel *commentUserName =[[UILabel alloc]init];
        commentUserName.numberOfLines =1;
        commentUserName.font =font(16);
        commentUserName.backgroundColor =[UIColor clearColor];
        [commentBg addSubview:commentUserName];
        _commentUserName = commentUserName;
        
        UILabel *commentDate =[[UILabel alloc]init];
        commentDate.numberOfLines =1;
        commentDate.font =font(16);
        commentDate.backgroundColor =[UIColor clearColor];
        [commentBg addSubview:commentDate];
        _commentDate = commentDate;
        
        UILabel *line =[[UILabel alloc]init];
        line.numberOfLines =1;
        line.font =font(16);
        line.backgroundColor =[UIColor colorFromHexCode:@"f2f2f2"];
        [commentBg addSubview:line];
        _line = line;
        
        UILabel *commentContent =[[UILabel alloc]init];
        commentContent.numberOfLines =0;
        commentContent.font =font(16);
        commentContent.backgroundColor =[UIColor clearColor];
        [commentBg addSubview:commentContent];
        _commentContent = commentContent;
        
        CommentImgListView *imgListView =[[CommentImgListView alloc]init];
        imgListView.backgroundColor =[UIColor clearColor];

        [commentBg addSubview:imgListView];
        _imgListView = imgListView;
        
    }
    
    return self;
}

- (void)setCommentFrame:(WEProductCommentFrame *)commentFrame
{
    _commentFrame = commentFrame;
    _commentBg.frame = commentFrame.commentBgFrame;
    _commentUserName.frame = commentFrame.commentUserNameframe;
    _commentUserName.text =[NSString stringWithFormat:@"用户名:%@",commentFrame.commentModel.u_name];
    _commentDate.frame = commentFrame.commentDateFrame;
    _commentDate.text =commentFrame.commentModel.date;
    _commentContent.frame = commentFrame.commentContentFrame;
    _commentContent.text =commentFrame.commentModel.conmment;
    _imgListView.frame = commentFrame.commentImgsFrame;
    _imgListView.pic_urls =commentFrame.commentModel.pics;
    _line.frame = commentFrame.commentLineFrame;
}

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
