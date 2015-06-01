//
//  WEMineAddComentCell.h
//  WestElectromechanical
//
//  Created by 夏亚峰 on 15/5/18.
//  Copyright (c) 2015年 zuo. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WEMineComentHeadView.h"
#import "GCPlaceholderTextView.h"
@interface WEMineAddComentCell : UITableViewCell
@property(nonatomic,weak)WEMineComentHeadView *header;
@property (nonatomic ,weak)GCPlaceholderTextView *tv;;
@end
