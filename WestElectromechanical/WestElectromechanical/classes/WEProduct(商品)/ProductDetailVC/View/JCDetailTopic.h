//
//  JCTopic.h
//  PSCollectionViewDemo
//
//  Created by jc on 14-1-7.
//
//

#import <UIKit/UIKit.h>
@protocol JCDetailTopicDelegate<NSObject>
-(void)didClick:(id)data;
-(void)currentPage:(int)page total:(NSUInteger)total;
@end
typedef enum : NSUInteger {
    JCDetailTopicHome,
    JCDetailTopicDetail,
} JCDetailTopicType;
@interface JCDetailTopic : UIScrollView<UIScrollViewDelegate>{
    UIButton * pic;
    bool flag;
    int scrollTopicFlag;
    NSTimer * scrollTimer;
    int currentPage;
    CGSize imageSize;
    UIImage *image;
}
@property(nonatomic,strong)NSArray * pics;
@property (nonatomic ,assign)JCDetailTopicType picType;
@property(nonatomic,retain)id<JCDetailTopicDelegate> JCDetaildelegate;
-(void)releaseTimer;
-(void)upDate;
@end
