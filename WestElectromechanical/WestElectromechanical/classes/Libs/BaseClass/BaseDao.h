

#import <Foundation/Foundation.h>

#import "BaseModel.h"

#import "RTDatabaseHelper.h"


@protocol IDatabaseDelegate <NSObject>
/**
 *  打开数据库
 *
 *  @return YES 成功
 */
- (BOOL)open;

/**
 *  关闭数据库
 *
 *  @return YES 成功
 */
- (BOOL)close;

/**
 *  开始事务
 *
 *  @return YES 成功
 */
- (BOOL)beginTransaction;

/**
 *  提交事务
 *
 *  @return YES 成功
 */
- (BOOL)commit;

@end


@protocol ICreateORUpdate<NSObject>

-(void)createTable;

- (void)createIndex;

- (BOOL)UpdateColumn;

- (Class)getClassModel;

@end


@protocol IDBTableDelegate <NSObject>

/**
 *  检查表是否从在
 *
 *  @return YES 有 NO 无
 */
- (BOOL)isEmptyTable;


/**
 *  创建数据库
 *
 *  @param string 要创建的字段
 */
//创建表
-(BOOL)createTable:(NSString *)string;

/**
 *   创建索引
 *
 *  @param indexName 索引名称
 *  @param field     索引的字段
 */
- (void)createIndex:(NSString *)indexName fields:(NSArray *)field;

/**
 *  获取表中的数据项总数
 *
 *  @return 返回表中的条数
 */
- (NSInteger)getModelCount;

/**
 *   在数据库表中添加字段
 *
 *  @param columnName 字段
 *  @param type     字段属性
 */
- (BOOL)addColumn:(NSString *)columnName  type:(NSString *)type;

/**
 *  删除表
 *
 *  @return YES 成功
 */
- (BOOL)deleteTable;

@end


@protocol IDBDataDelegate <NSObject>


/**
 *  插入一个数据
 *
 *  @param newEntity 数据model
 *
 *  @return YES 为真
 */
- (BOOL)insertFromModel:(id<IEntity>)newEntity;


/**
 *  插入或更新Model对象
 *
 *  @param model 数据对象
 *
 *  @return YES 成功  NO 失败
 */
- (BOOL)insertOrReplaceFromModel:(id<IEntity>)newEntity;


- (BOOL )executeInsert:(Class) entityType ArrData:(NSArray *)modelArr;
- (BOOL )executeInsertOrReplace:(Class) entityType ArrData:(NSArray *)modelArr;


/**
 *  删除指定的对象
 *
 *  @param where 删除的条件  "字段 ＝ '值' [and 字段 ＝ '值' ]"
 *
 *  @return YES 成功  NO 失败
 */
- (BOOL)deleteInfo:(NSString *)where;

/**
 *  删除指定的对象
 *
 *  @param field_t where 字段
 *  @param value_t where 值
 *  @param isAnd   yes 为 and, no 为 or
 *
 *  @return 返回是否执行成功
 */
- (BOOL)deleteFields:(NSArray *)field_t value:(NSArray *)value_t isand:(BOOL)isAnd;

/**
 *  删除整个表中的数据
 *
 *  @return 返回是否执行成功
 */
- (BOOL)deleteInfo;



/**
 *  更新数据
 *
 *  @param field 要更新的字段
 *  @param value 要更新的数据
 *  @param where 更新的条件   "字段 ＝ '值' [and 字段 ＝ '值' ]"
 *
 *  @return YES 成功  NO 失败
 */
- (BOOL)UpdateWhithFields:(NSArray *)field values:(NSArray *)value where:(NSString *)where;


/**
 *  更新Model对象
 *
 *  @param model 数据对象
 *
 *  @return YES 成功  NO 失败
 */
- (BOOL) UpdateFromModel:(id<IEntity>)model;

/**
 *  用纯sql语句进行复杂的更新
 *
 *  @param sql UPDATE TABLE SET 后面部分
 *
 *  @return <#return value description#>
 */
- (BOOL)updateWithSqlContent:(NSString *)sql;


/**
 *  查询表所有数据
 *
 *  @return 返回所有model的对象
 */
- (NSArray *)fetchAll;

- (NSArray *)executeQuery:(Class) entityType;

- (NSArray *)executeQuery:(Class) entityType withArgumentsInArray:(NSArray *)value_t sqlWhere:(NSString *)sql;
- (NSArray *)executeQuery:(Class) entityType  fields:(NSArray *)field_t value:(NSArray *)value_t isand:(BOOL)isAnd;

- (NSArray *)executeQueryOnlyWithSQL:(Class) entityType withArgumentsInArray:(NSArray *)value_t sqlContent:(NSString *)sql;

@end



@interface BaseDao:NSObject<IDatabaseDelegate,IDBTableDelegate,IDBDataDelegate,ICreateORUpdate>
@property(nonatomic,copy) NSString *tableName;
@property(nonatomic,copy) NSString *dbFile;
@property(nonatomic,retain)FMDatabase * db;
@property(nonatomic,assign) BOOL handleSet;//是否手动open、close、beginTransaction、commit操作;调用FMDatabaseQueue需要设定为YES,屏蔽open、close、beginTransaction、commit操作

@end
