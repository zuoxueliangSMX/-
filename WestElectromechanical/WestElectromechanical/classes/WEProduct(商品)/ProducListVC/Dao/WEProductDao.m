//
//  WEProductDao.m
//  WestElectromechanical
//
//  Created by zuo on 15/5/11.
//  Copyright (c) 2015年 zuo. All rights reserved.
//

#import "WEProductDao.h"
#define kProductTableName @"Products"
@implementation WEProductDao
- (Class)getClassModel
{
    return [WEProductSingleModel class];
}
-(void)createTable
{
    NSString * sql = [NSString stringWithFormat:@"'%@' INTEGER PRIMARY KEY  NOT NULL  UNIQUE",kProductId];
    [super createTable:sql];
}
- (void)createIndex
{
    
}
- (BOOL)UpdateColumn
{
    //只会添加一次
    
    [self addColumn:kProductId type:@"VARCHAR"];
    [self addColumn:kProductImgurl type:@"VARCHAR"];
    [self addColumn:kProductName type:@"VARCHAR"];
    [self addColumn:kProductOrderNum type:@"VARCHAR"];
    [self addColumn:kProductPrice type:@"VARCHAR"];
    [self addColumn:kProductVersions type:@"VARCHAR"];
    [self addColumn:kProductVPrice type:@"VARCHAR"];
    [self addColumn:kProductBrand type:@"VARCHAR"];
    [self addColumn:kProductScanTime type:@"VARCHAR"];
    return NO;
}

/**
 *  创建或者更新表
 */
- (void)CreateAndUpdateTable{
    [self createTable];
    [self createIndex];
    [self UpdateColumn];
}

-(instancetype)init
{
    if(self = [super init]){
        self.tableName = kProductTableName;
        self.db = [[RTDatabaseHelper sharedInstance] openDatabase];
        
        //        [[RTDatabaseHelper sharedInstance] inDatabase:^(FMDatabase *db) {
        //            self.db = db;
        //        }];
        
        [self CreateAndUpdateTable];
    }
    return self;
}

-(instancetype)initWithDataBase:(FMDatabase *)db_
{
    self = [super init];
    if (self) {
        self.tableName = kProductTableName;
        self.db = db_;
        self.handleSet = YES;
        [self CreateAndUpdateTable];
    }
    return self;
}

/*  插入N条数据
 *
 *  @param pks ScheduleSinglePKModel数组
 *
 *  @return
 */
- (BOOL)insertOrReplaceProducts:(NSArray *)products
{
    return [self executeInsertOrReplace:[self getClassModel] ArrData:products];
    
}


- (NSArray *)fetchAll
{
    return [self executeQuery:[self getClassModel]];;
}
//排序查找
- (NSArray *)fetchAllProductsDescSort
{
    NSString *condition = @"order by p_scanTime desc";
    return [self selectSortWithSqlContent:condition selectStart:NO];
}
/**
 *  根据id查询日程PK
 */
//- (GroupModel *)queryGroupById:(NSString *)groupId
//{
//    NSAssert(groupId != nil,@"invId不能为空");
//    NSArray *ret = [self executeQuery:[self getClassModel] fields:@[kGroupId] value:@[groupId] isand:NO];
//    if (ret && [ret count] > 0) {
//        id value = [ret objectAtIndex:0];
//        
//        NSAssert([value isKindOfClass:[self getClassModel]], @"返回类型不一致,请检查代码，谢谢！");
//        
//        return value;
//    }
//    return nil;
//    
//}

@end
