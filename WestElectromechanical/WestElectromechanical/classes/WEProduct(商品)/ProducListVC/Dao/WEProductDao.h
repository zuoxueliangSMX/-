//
//  WEProductDao.h
//  WestElectromechanical
//
//  Created by zuo on 15/5/11.
//  Copyright (c) 2015年 zuo. All rights reserved.
//

#import "BaseDao.h"
#import "WEProductSingleModel.h"
@interface WEProductDao : BaseDao
/**
 *  创建或者更新表需要实现的协议
 */
- (Class)getClassModel;
-(void)createTable;
- (void)createIndex;
- (BOOL)UpdateColumn;


/**
 *  初始化使用默认数据库的FriendInfoDAO
 *
 */

-(instancetype)init;


- (instancetype)initWithDataBase:(FMDatabase *)db_;

/*  插入N条数据
 *
 *  @param groups GroupModel数组
 *
 *  @return
 */
- (BOOL)insertOrReplaceProducts:(NSArray *)products;
- (NSArray *)fetchAll;
//排序查找
- (NSArray *)fetchAllProductsDescSort;
/**
 *  根据id查询日程PK
 */
- (WEProductSingleModel *)queryProdudctById:(NSString *)productId;

@end
