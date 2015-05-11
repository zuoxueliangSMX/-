//
//  BaseDao.m
//  ZLYDoc
//
//  Created by Ryan on 14-4-15.
//  Copyright (c) 2014年 ZLY. All rights reserved.
//

#import "BaseDao.h"

#import "FMDatabaseAdditions.h"



static NSLock *lock = nil;

@implementation BaseDao

- (id)init
{
    if (self = [super init]) {
        self.handleSet = NO;
        [[self class] initLock];
    }
    return self;
}

+ (void) initLock
{
    if (lock  == nil) {
        lock = [[NSLock alloc] init];
    }
}


#pragma mark - ICreateORUpdate
- (Class)getClassModel
{
    return nil;
}

-(void)createTable
{
    
}

- (void)createIndex
{
    
}
//更新版本字段
- (BOOL)UpdateColumn
{
    return NO;
}



#pragma mark - IDatabaseDelegate
- (BOOL)open
{
    if (self.handleSet) {
        return YES;
    }
    [lock lock];
    BOOL ret = [self.db open];
    if (!ret) {
        [lock unlock];
    }
    return ret;
}

- (BOOL)close
{
    if (self.handleSet) {
        return YES;
    }
    //    debug_NSLog_Line();
    
    BOOL ret = [self.db close];
    
    [lock unlock];
    
    return ret;
}

- (BOOL)beginTransaction
{
    if (self.handleSet) {
        return YES;
    }
    //    debug_NSLog_Line();
    return [self.db beginTransaction];
}

- (BOOL)commit
{
    if (self.handleSet) {
        return YES;
    }
    //    debug_NSLog_Line();
    return [self.db commit];
}

#pragma mark - 表操作

-(BOOL)createTable:(NSString *)string
{

    BOOL  success = NO;
    
    NSString *sql = [NSString stringWithFormat:@"CREATE TABLE IF NOT EXISTS '%@' (%@)", self.tableName, string];
    
    if ([self open]) {
        
        success = [self.db executeUpdate:sql];
        
        if (success) {
            
        }
        
        [self close];
    }
    
    return success;
}

/**
 *  检查表是否从在
 *
 *  @return YES 有 NO 无
 */
- (BOOL)isEmptyTable
{
    BOOL ret = NO;
    
    
    if ([self open]) {
        
        FMResultSet *resultSet = [self.db executeQuery:@"SELECT count(*) as 'count' FROM sqlite_master WHERE type='table' AND name= ?",self.tableName];
        
        
        if ([resultSet next])
        {
            int count = [resultSet intForColumn:@"count"];
            
            [resultSet close];
            
            if (count > 0)
            {
                ret = YES;
            }
        }
        
        [self close];
    }
    
    return ret;
}

/**
 *   创建索引
 *
 *  @param indexName 索引名称
 *  @param field     索引的字段
 */
- (void)createIndex:(NSString *)indexName fields:(NSArray *)field
{
    NSString *indexStr = [field componentsJoinedByString:@","];
    NSString *sql = [NSString stringWithFormat:@"CREATE INDEX if not exists '%@' on '%@' (%@)", indexName, self.tableName, indexStr];
    
    if ([self open])
    {
        BOOL  success = [self.db executeUpdate:sql];
        
        if (success) {
        }
        
        [self close];
    }
}

/**
 *   在数据库表中添加字段
 *
 *  @param columnName 字段
 *  @param type     字段属性
 */
- (BOOL)addColumn:(NSString *)columnName  type:(NSString *)type
{
    if ([self open])
    {
        if (![self.db columnExists:columnName inTableWithName:self.tableName]) {
            NSString *sql = [NSString stringWithFormat:@"ALTER TABLE '%@' ADD '%@' %@", self.tableName, columnName, type];
            BOOL update =  [self.db executeUpdate:sql];
            [self close];
            return update;
        }
        else
            [self close];
    }
    return NO;
    
}

/**
 *  获取表中的数据项总数
 *
 *  @return 返回表中的条数
 */
- (NSInteger)getModelCount
{
    NSString *sql = [NSString stringWithFormat:@"SELECT count(*) as 'count' FROM %@",self.tableName];
    
    NSInteger count = 0;
    
    if ([self open]) {
        
        FMResultSet *resultSet = [self.db executeQuery:sql];
        
        
        if ([resultSet next])
        {
            count = [resultSet intForColumn:@"count"];
            
            [resultSet close];
        }
        
        [self close];
    }
    
    return count;
}

/**
 *  删除表
 *
 *  @return YES 成功
 */
- (BOOL)deleteTable
{
    BOOL  success = NO;
    if ([self open]) {
        NSString *sqlstr = [NSString stringWithFormat:@"DROP TABLE '%@'", self.tableName];
        success = [self.db executeUpdate:sqlstr];
        
        if (success) {
            
        }
        
        [self close];
    }
    
    return success;
}
#pragma mark - 数据查询
/**
 *  查询表所有数据
 *
 *  @return 返回所有model的对象
 */
- (NSArray *)fetchAll
{
    Class entityType = [self getClassModel];
    if (entityType != nil) {
        return [self executeQuery:entityType];
    }
    
    
    return nil;
}

- (NSArray *)executeQuery:(Class) entityType
{
    return [self executeQuery:entityType withArgumentsInArray:nil sqlWhere:nil];
}

- (NSArray *)executeQuery:(Class) entityType  fields:(NSArray *)field_t value:(NSArray *)value_t isand:(BOOL)isAnd
{
    
    NSMutableString *sql_str = [NSMutableString stringWithCapacity:10];
    
    for (int i = 0; i < [field_t count]; i++) {
        NSString *key = [field_t objectAtIndex:i];
        
        if (i > 0)
        {
            if (isAnd)
            {
                [sql_str appendString:@" and "];
            }
            else {
                [sql_str appendString:@" or "];
            }
            
        }
        
        [sql_str appendFormat:@" %@ = ? ",key];
    }
    return [self executeQuery:entityType withArgumentsInArray:value_t sqlWhere:sql_str];
}

- (NSArray *)executeQuery:(Class) entityType withArgumentsInArray:(NSArray *)value_t sqlWhere:(NSString *)sql
{
    BOOL isWhere = NO;
    NSString *sql_line = nil;
    
    if (sql == nil)
    {
        sql_line = [NSString stringWithFormat:@"SELECT * FROM '%@'",self.tableName];
    }
    else
    {
        sql_line = [NSString stringWithFormat:@"SELECT * FROM '%@' WHERE %@",self.tableName, sql];
        
        if ([value_t count] > 0)
        {
            
            isWhere = YES;
        }
        
    }
    
    
    NSMutableArray *entities = [[NSMutableArray alloc] init];
    
    if ([self open]) {
        
        FMResultSet *result = nil;
        
        if (isWhere) {
            result = [self.db executeQuery:sql_line withArgumentsInArray:value_t];
        }
        else {
            result = [self.db executeQuery:sql_line];
        }
        
        while(result.next) {
            NSObject<IEntity> *newEntity = [[entityType alloc] init];
            
            NSArray * fields = [entityType getAllFields];
            
            for (id fieldName in fields) {
                NSObject * val = [result objectForColumnName:fieldName];
                if (![val isKindOfClass:[NSNull class]]) {
                    //DLog(@"%@---%@",fieldName,val);
                    [newEntity setFieldValue:fieldName value:val];
                }
                
            }
            
            [entities addObject:newEntity];
        }
        [result close];
        [self close];
    }
    return entities;
}


- (NSArray *)selectWithSqlContent:(NSString *)sql selectStart:(BOOL)selectStart{
    NSString * sqlStr = nil;
    Class entityType = [self getClassModel];
    
    if (selectStart) {
        sqlStr = sql;
        entityType = [SelectModel class];
    }
    else{
        sqlStr = [NSString stringWithFormat:@"SELECT * FROM '%@' WHERE %@",self.tableName, sql];
        
    }
    return [self executeQueryOnlyWithSQL:entityType withArgumentsInArray:nil sqlContent:sqlStr];
   
}

- (NSArray *)selectSortWithSqlContent:(NSString *)sql selectStart:(BOOL)selectStart{
    NSString * sqlStr = [NSString stringWithFormat:@"SELECT * FROM '%@' %@",self.tableName, sql];
    
    if (selectStart) {
        sqlStr = sql;
    }
    
    return [self executeQueryOnlyWithSQL:[self getClassModel] withArgumentsInArray:nil sqlContent:sqlStr];
}


- (NSArray *)executeQueryOnlyWithSQL:(Class) entityType withArgumentsInArray:(NSArray *)value_t sqlContent:(NSString *)sql
{
    BOOL isWhere = NO;
    NSString *sql_line = nil;
    
    //参数判断
    if(sql == nil || [sql length] == 0)
    {
        return nil;
    }
    
    sql_line = sql;
    
    if ([value_t count] > 0)
    {
        isWhere = YES;
    }
    
    
    NSMutableArray *entities = [[NSMutableArray alloc] init];
    
    if ([self open]) {
        
        FMResultSet *result = nil;
        
        if (isWhere) {
            result = [self.db executeQuery:sql_line withArgumentsInArray:value_t];
        }
        else {
            result = [self.db executeQuery:sql_line];
        }
        
        while(result.next) {
            NSObject<IEntity> *newEntity = [[entityType alloc] init];
            
            NSArray * fields = [entityType getAllFields];
            
            for (id fieldName in fields) {
                NSObject * val = [result objectForColumnName:fieldName];
                if (![val isKindOfClass:[NSNull class]]) {
                    [newEntity setFieldValue:fieldName value:val];
                }
                
            }
            
            [entities addObject:newEntity];
        }
        [result close];
        [self close];
    }
    
    return entities;
}



#pragma mark - 数据插入

- (BOOL)executeInsert:(Class)entityType ArrData:(NSArray *)modelArr
{
    BOOL success = NO;
    if ([self open])
    {
        [self beginTransaction];
        
        //        NSObject<IEntity> *newEntity = [[entityType alloc] init];
        
        NSArray * fields = [entityType getAllFields];
        
        NSString* sqlString = [fields componentsJoinedByString:@","];
        NSMutableArray * para  = [[NSMutableArray alloc] init];
        for (int i = 0; i<[fields count];i++) {
            [para addObject:@"?"];
        }
        
        NSString * sqlPara = [para componentsJoinedByString:@","];
        
        NSString *sqlStr = [NSString stringWithFormat:@"insert into '%@' (%@) VALUES (%@)",self.tableName,sqlString,sqlPara];
        
        for (NSObject<IEntity> *  fnew in modelArr)
        {
            NSMutableArray * arr = [[NSMutableArray alloc] init];
            
            for (id fieldName in fields) {
                
                id V = [fnew getFromFieldValue:fieldName];
                [arr addObject:V ? V:[NSNull null]];
            }
            
            success = [self.db executeUpdate:sqlStr withArgumentsInArray:arr];
        }
        
        
        if (success && [self.db changes] > 0) {
            //NSLogEx(@"Insert success");
        }
        
        [self commit];
        [self close];
    }
    return success;
}

- (BOOL)executeInsertOrReplace:(Class)entityType ArrData:(NSArray *)modelArr
{
    BOOL success = NO;
    if ([self open])
    {
        [self beginTransaction];
        
        //        NSObject<IEntity> *newEntity = [[entityType alloc] init];
        
        NSArray * fields = [entityType getAllFields];
        
        NSString* sqlString = [fields componentsJoinedByString:@","];
        NSMutableArray * para  = [[NSMutableArray alloc] init];
        for (int i = 0; i<[fields count];i++) {
            [para addObject:@"?"];
        }
        
        NSString * sqlPara = [para componentsJoinedByString:@","];
        
        NSString *sqlStr = [NSString stringWithFormat:@"INSERT OR REPLACE into '%@' (%@) VALUES (%@)",self.tableName,sqlString,sqlPara];
        
        for (NSObject<IEntity> *  fnew in modelArr)
        {
            NSMutableArray * arr = [[NSMutableArray alloc] init];
            
            for (id fieldName in fields) {
                
                id V = [fnew getFromFieldValue:fieldName];
                [arr addObject:V ? V:[NSNull null]];
            }
            
            success = [self.db executeUpdate:sqlStr withArgumentsInArray:arr];
        }
        
        
        if (success && [self.db changes] > 0) {
            //NSLogEx(@"Insert success");
        }
        
        [self commit];
        [self close];
    }
    return success;
}

/**
 *  插入一个数据
 *
 *  @param newEntity 数据model
 *
 *  @return YES 为真
 */
- (BOOL)insertFromModel:(id<IEntity>)model
{
    Class entityType = [self getClassModel];
    if (entityType) {
        return [self insertdata:entityType model:model];
    }
    else {
        return [self insertdata:[(NSObject *)model class] model:model];
    }
}


- (BOOL)insertdata:(Class)entityType model:(id<IEntity>)newEntity
{
    BOOL success = NO;
    
    if ([self open]) {
        [self beginTransaction];
        
        NSArray * fields = [entityType getAllFields];
        
        NSMutableString *sqlString = [NSMutableString stringWithCapacity:10];
        NSMutableString *paraString = [NSMutableString stringWithCapacity:10];
        NSMutableArray  *value = [NSMutableArray arrayWithCapacity:10];
        
        BOOL isconnt = NO;
        for (int i = 0; i<[fields count];i++) {
            
            
            NSString *field = [fields objectAtIndex:i];
            if ([newEntity getFromFieldValue:field]) {
                
                if (isconnt) {
                    [sqlString appendString:@", "];
                    [paraString appendString:@", "];
                }
                
                [sqlString appendFormat:@"'%@'",field];
                [paraString appendString:@"?"];
                [value addObject:[newEntity getFromFieldValue:field]];
                isconnt = YES;
            }
            
        }
        
        NSString *sqlStr = [NSString stringWithFormat:@"INSERT  into '%@' (%@) VALUES (%@)",self.tableName,sqlString,paraString];
        
        success = [self.db executeUpdate:sqlStr withArgumentsInArray:value];
        
        if (success && [self.db changes] > 0) {
            //NSLogEx(@"Insert success");
        }
        
        [self commit];
        [self close];
        
    }
    
    return success;
}

- (BOOL)insertOrReplaceFromModel:(id<IEntity>)model
{
    Class entityType = [self getClassModel];
    if (entityType) {
        return [self insertOrReplace:entityType model:model];
    }
    else {
        return [self insertOrReplace:[(NSObject *)model class] model:model];
    }
}

- (BOOL)insertOrReplace:(Class)entityType model:(id<IEntity>)newEntity
{
    BOOL success = NO;
    
    if ([self open]) {
        [self beginTransaction];
        
        NSArray * fields = [entityType getAllFields];
        
        NSMutableString *sqlString = [NSMutableString stringWithCapacity:10];
        NSMutableString *paraString = [NSMutableString stringWithCapacity:10];
        NSMutableArray  *value = [NSMutableArray arrayWithCapacity:10];
        
        BOOL isconnt = NO;
        for (int i = 0; i<[fields count];i++) {
            NSString *field = [fields objectAtIndex:i];
            if ([newEntity getFromFieldValue:field]) {
                if (isconnt) {
                    [sqlString appendString:@", "];
                    [paraString appendString:@", "];
                }
                
                [sqlString appendFormat:@"'%@'",field];
                [paraString appendString:@"?"];
                [value addObject:[newEntity getFromFieldValue:field]];
                isconnt = YES;
            }
            
        }
        
        NSString *sqlStr = [NSString stringWithFormat:@"INSERT OR REPLACE into '%@' (%@) VALUES (%@)",self.tableName,sqlString,paraString];
        
        success = [self.db executeUpdate:sqlStr withArgumentsInArray:value];
        
        if (success && [self.db changes] > 0) {
            //NSLogEx(@"Insert success");
        }
        [self commit];
        [self close];
        
    }
    
    return success;
}

#pragma mark - 数据更新

/**
 *  更新Model对象
 *
 *  @param model 数据对象
 *
 *  @return YES 成功  NO 失败
 */
- (BOOL) UpdateFromModel:(id<IEntity>)model
{
    Class entityType = [self getClassModel];
    if (entityType) {
        return [self Update:entityType model:model];
    }
    else {
        return [self Update:[(NSObject *)model class] model:model];
    }
}

- (BOOL)updateWithSqlContent:(NSString *)sql{
    BOOL success = NO;
    
    if ([self open]) {
        
        [self beginTransaction];
        
        NSString *sqlStr = [NSString stringWithFormat:@"UPDATE '%@' SET %@ ",self.tableName,sql];
        success = [self.db executeUpdate:sqlStr];
        
        if (success && [self.db changes] > 0) {
            
        }
        
        [self commit];
        [self close];
        
    }
    return success;
}

- (BOOL) Update:(Class)entityType model:(id<IEntity>)model
{
    
    BOOL success = NO;
    
    if ([self open]) {
        
        [self beginTransaction];
        
        NSMutableArray *value = [NSMutableArray arrayWithCapacity:5];
        NSArray *field = [entityType  getAllFields];
        
        NSMutableString * sqlString = [NSMutableString stringWithCapacity:10];
        for (int i = 1; i < [field count]; i++) {
            if (i > 1) {
                [sqlString appendString:@" , "];
            }
            NSString *key = [field objectAtIndex:i];
            id V = [model getFromFieldValue:key];
            [value addObject:V ? V : [NSNull null]];
            [sqlString appendFormat:@"%@ = ?", key];
        }
        
        NSString *fire_str = [field objectAtIndex:0];
        
        [value addObject:[model getFromFieldValue:fire_str]];
        
        NSString *where = [NSString stringWithFormat:@"%@ = ?", fire_str];
        
        NSString *sqlStr = [NSString stringWithFormat:@"UPDATE '%@' SET %@ WHERE %@",self.tableName,sqlString,where];
        
        success = [self.db executeUpdate:sqlStr withArgumentsInArray:value];
        
        
        if (success && [self.db changes] > 0) {
            //NSLogEx(@"update success");
        }
        
        [self commit];
        [self close];
        
    }
    
    return success;
}


/**
 *  更新数据
 *
 *  @param field 要更新的表字段
 *  @param value 要更新的数据值
 *  @param where 更新的条件   "字段 ＝ '值' [and 字段 ＝ '值' ]"
 *
 *  @return YES 成功  NO 失败
 */
- (BOOL)UpdateWhithFields:(NSArray *)field values:(NSArray *)value where:(NSString *)where
{
    BOOL success = NO;
    if ([self open]) {
        [self beginTransaction];
        
        
        NSMutableString * sqlString = [NSMutableString stringWithCapacity:10];
        for (int i = 0; i < [field count]; i++) {
            if (i > 0) {
                [sqlString appendString:@" , "];
            }
            [sqlString appendFormat:@"'%@' = ?",[field objectAtIndex:i]];
        }
        
        NSString *sqlStr = nil;
        if (where) {
            sqlStr = [NSString stringWithFormat:@"UPDATE '%@' SET %@ WHERE %@",self.tableName,sqlString,where];
        }
        else {
            sqlStr = [NSString stringWithFormat:@"UPDATE '%@' SET %@ ",self.tableName,sqlString];
        }
        
        
        success = [self.db executeUpdate:sqlStr withArgumentsInArray:value];
        
        
        if (success && [self.db changes] > 0) {
            //NSLogEx(@"update success");
        }
        
        [self commit];
        [self close];
        
    }
    
    return success;
}

#pragma mark - 删除处理
/**
 *  删除指定的对象
 *
 *  @param where 删除的条件  "字段 ＝ '值' [and 字段 ＝ '值' ]"
 *
 *  @return YES 成功  NO 失败
 */
- (BOOL)deleteInfo:(NSString *)where
{
    
    NSAssert(where != nil, @"删除的条件不能为空，否则将会删除掉所有的数据");
    
    BOOL success = NO;
    
    if ([self open]) {
        
        success = [self.db executeUpdate:[NSString stringWithFormat:@"DELETE  from '%@' WHERE %@", self.tableName, where]];
        
        if (success && [self.db changes] > 0) {
            //NSLogEx(@"delete success");
        }
        
        [self close];
        
    }
    
    
    return success;
    
}

/**
 *  删除特定条件
 *
 *  @param field_t 表字段
 *  @param value_t 字段值
 *  @param isAnd   是否有“and”条件判断
 *
 *  @return <#return value description#>
 */

- (BOOL)deleteFields:(NSArray *)field_t value:(NSArray *)value_t isand:(BOOL)isAnd
{
    NSAssert((field_t && [field_t count] > 0) && (value_t && [value_t count] > 0), @"删除的条件不能为空，否则将会删除掉所有的数据");
    
    BOOL success = NO;
    
    NSMutableString *sql_str = [NSMutableString stringWithCapacity:10];
    
    for (int i = 0; i < [field_t count]; i++) {
        NSString *key = [field_t objectAtIndex:i];
        
        if (i > 0) {
            if (isAnd) {
                [sql_str appendString:@" and "];
            }
            else {
                [sql_str appendString:@" or "];
            }
            
        }
        
        [sql_str  appendString:key];
        [sql_str appendString:@" = ? "];
    }
    
    if ([self open]) {
        
        success = [self.db executeUpdate:[NSString stringWithFormat:@"DELETE  from '%@' WHERE %@", self.tableName, sql_str] withArgumentsInArray:value_t];
        
        if (success) {
            //NSLogEx(@"delete success");
        }
        
        [self close];
        
    }
    
    
    return success;
    
}

/**
 *  删除表中所有数据
 *
 *  @return YES
 */

- (BOOL)deleteInfo
{
    
    BOOL success = NO;
    
    if ([self open]) {
        
        success = [self.db executeUpdate:[NSString stringWithFormat:@"DELETE  from '%@' ", self.tableName]];
        
        [self close];
        
    }
    return success;
}

@end
