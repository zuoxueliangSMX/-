//
//  WEProductCommentFrame.h
//  WestElectromechanical
//
//  Created by zuo on 15/5/14.
//  Copyright (c) 2015年 zuo. All rights reserved.
//

#import "BaseModel.h"
#import "WEProductCommentModel.h"
#import "CommentImgListView.h"
@interface WEProductCommentFrame : BaseModel
@property (nonatomic ,strong)WEProductCommentModel *commentModel;
//总的高度
@property (nonatomic ,assign)CGFloat commentHeight;

@property (nonatomic ,assign)CGRect commentBgFrame;
@property (nonatomic ,assign)CGRect commentUserNameframe;
@property (nonatomic ,assign)CGRect commentDateFrame;
@property (nonatomic ,assign)CGRect commentLineFrame;
@property (nonatomic ,assign)CGRect commentContentFrame;
@property (nonatomic ,assign)CGRect commentImgsFrame;
@end
