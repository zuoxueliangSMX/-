//
//  DBHelper.m
//  ZLYDoc
//  
//  Created by Ryan on 14-4-14.
//  Copyright (c) 2014年 ZLY. All rights reserved.
//

#import "RTDatabaseHelper.h"

@implementation RTDatabaseHelper

- (id)init
{
    if (self = [super init]) {
        
		_database = [FMDatabase databaseWithPath:[[self class] sharedDBPath]];
        [_database setTraceExecution:keySqlTraceExecution];
        _databaseQueue = [FMDatabaseQueue databaseQueueWithPath:[[self class] sharedDBPath]];
    }
    return self;
}

+ (NSString *)sharedDBPath{
    NSString* docsdir = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
    NSString *dbpath = [docsdir stringByAppendingPathComponent:@"zlycare.sqlite"];
    DLog(@"Database path :%@",dbpath);
    return dbpath;
}

+ (RTDatabaseHelper *)sharedInstance
{
    static RTDatabaseHelper *instance = nil;
    static dispatch_once_t predicate;
    dispatch_once(&predicate, ^{
        instance = [[self alloc] init];
    });
    return instance;
}

- (FMDatabase *)openDatabase
{
    if ([_database open]) {
        
        return _database;
    }
    return nil;
}

//
//        /**
//         *  创建或者更新表
//         */
//        NSMutableArray  *listArrary = [NSMutableArray new];
//        [listArrary addObject:[FriendInfoDao class]];
//        for (Class entityType in listArrary) {
//
//            NSObject<ICreateORUpdate> *newEntity = [[entityType alloc] init];
//
//            [newEntity createTable];
//            [newEntity createIndex];
//            [newEntity UpdateColumn];
//        }


- (void)closeDB
{
    dispatch_async(dispatch_get_main_queue(), ^{
        if([_database close]) {
            _database = nil;
        }
    });
}


- (BOOL)isTableExists:(NSString *)tableName
{
    NSString *existsSql = [NSString stringWithFormat:@"select count(name) as countNum from sqlite_master where type = 'table' and name = '%@'", tableName];
    
    FMResultSet *rs = [[self openDatabase] executeQuery:existsSql];

	if ([rs next]) {
		NSInteger count = [rs intForColumn:@"countNum"];
		if (count == 1) {
			DLog(@"%@ is existed.",tableName);
			return YES;
		}
        DLog(@"%@ is not exist.",tableName);
	}
	[rs close];
    
    return NO;
}



- (BOOL)deleteDatabase
{
    NSFileManager *fileManager = [NSFileManager defaultManager];
    return [fileManager removeItemAtPath:[[self class] sharedDBPath] error:nil];
}



@end
