//
//  JCTopic.h
//  PSCollectionViewDemo
//
//  Created by jc on 14-1-7.
//
//

#import <UIKit/UIKit.h>
@protocol JCTopicDelegate<NSObject>
-(void)didClick:(id)data;
-(void)currentPage:(int)page total:(NSUInteger)total;
@end
typedef enum : NSUInteger {
    JCTopicHome,
    JCTopicDetail,
} JCTopicType;
@interface JCTopic : UIScrollView<UIScrollViewDelegate>{
    UIButton * pic;
    bool flag;
    int scrollTopicFlag;
    NSTimer * scrollTimer;
    int currentPage;
    CGSize imageSize;
    UIImage *image;
}
@property(nonatomic,strong)NSArray * pics;
@property (nonatomic ,assign)JCTopicType picType;
@property(nonatomic,retain)id<JCTopicDelegate> JCdelegate;
-(void)releaseTimer;
-(void)upDate;
@end
