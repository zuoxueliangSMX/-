//
//  WEProductHandler.m
//  WestElectromechanical
//
//  Created by zuo on 15/5/11.
//  Copyright (c) 2015年 zuo. All rights reserved.
//

#import "WEProductHandler.h"
#define kProductFetchQueue @"productFetchQueue"
#define kProductInsertQueue @"productInsertQueue"
@implementation WEProductHandler
-(id)init{
    if (self = [super init]) {
        _productFetchQueue = dispatch_queue_create([kProductFetchQueue UTF8String], NULL);
        _productFetchQueueTag = &_productFetchQueue;
        dispatch_queue_set_specific(_productFetchQueue, _productFetchQueueTag, _productFetchQueueTag, NULL);
        
        _productInsertQueue = dispatch_queue_create([kProductInsertQueue UTF8String], NULL);
        _productInsertQueueTag = &_productInsertQueue;
        dispatch_queue_set_specific(_productInsertQueue, _productInsertQueueTag, _productInsertQueueTag, NULL);
    }
    return self;
}

- (void)fetchAllSuccessBlock:(SuccessBlock)success failedBlock:(FailedBlock)failed
{
    dispatch_block_t block = ^{
        FMDatabaseQueue *queue = [[RTDatabaseHelper sharedInstance] databaseQueue];
        [queue inDatabase:^(FMDatabase *db) {
            WEProductDao * dao = [[WEProductDao alloc] initWithDataBase:db];
            DLog(@"call fetchAll ----");
            if (success) {
                success([dao fetchAllProductsDescSort]);
            }
            //[dao close];
        }];
    };
    if (dispatch_get_specific(_productFetchQueueTag)) {
        block();
    }
    else
        dispatch_sync(_productFetchQueue, block);
}


- (void)deleteProductSuccessBlock:(SuccessBlock)success failedBlock:(FailedBlock)failed
{
    FMDatabaseQueue *queue = [[RTDatabaseHelper sharedInstance] databaseQueue];
    [queue inDatabase:^(FMDatabase *db) {
        WEProductDao * dao = [[WEProductDao alloc] initWithDataBase:db];
        DLog(@"call fetchAll ----");
        
        if ([dao deleteTable]) {
            if (success) {
                success([NSNumber numberWithBool:YES]);
            }
        }else{
            if (failed) {
                failed([NSNumber numberWithBool:NO]);
            }
        }
        
    }];
    
    
}
- (void)updateProductModel:(WEProductSingleModel *)singleModel success:(SuccessBlock)success faileBlock:(FailedBlock)failed
{
    FMDatabaseQueue *queue = [[RTDatabaseHelper sharedInstance] databaseQueue];
    [queue inDatabase:^(FMDatabase *db) {
        WEProductDao * dao = [[WEProductDao alloc] initWithDataBase:db];
        DLog(@"call fetchAll ----");
        
        if ([dao UpdateFromModel:singleModel]) {
            if (success) {
                success([NSNumber numberWithBool:YES]);
            }
        }else{
            if (failed) {
                failed([NSNumber numberWithBool:NO]);
            }
        }
    }];
    
}

- (void)addProductSingleModels:(NSArray *)singleModels success:(SuccessBlock)success faileBlock:(FailedBlock)failed
{
    dispatch_block_t block = ^{
        FMDatabaseQueue *queue = [[RTDatabaseHelper sharedInstance] databaseQueue];
        [queue inDatabase:^(FMDatabase *db) {
            WEProductDao * dao = [[WEProductDao alloc] initWithDataBase:db];
            if ([dao insertOrReplaceProducts:singleModels]) {
                if (success) {
                    success([NSNumber numberWithBool:YES]);
                }
            }else{
                if (failed) {
                    failed([NSNumber numberWithBool:NO]);
                }
            }
            
        }];
        
    };
    
    if (dispatch_get_specific(_productInsertQueueTag)) {
        block();
    }
    else
        dispatch_sync(_productInsertQueue, block);
    
}

/**
 *  根据id查询群组信息
 *
 *  @param pkId        <#invId description#>
 *  @param successBlock <#successBlock description#>
 */
- (void)queryProductByProductId:(NSString *)groupId successBlock:(SuccessBlock)successBlock
{
    dispatch_block_t block = ^{
        FMDatabaseQueue *queue = [[RTDatabaseHelper sharedInstance] databaseQueue];
        [queue inDatabase:^(FMDatabase *db) {
            WEProductDao * dao = [[WEProductDao alloc] initWithDataBase:db];
            if (successBlock) {
                successBlock([dao queryProdudctById:groupId]);
            }
            
        }];
    };
    if (dispatch_get_specific(_productFetchQueueTag)) {
        block();
    }
    else
        dispatch_sync(_productFetchQueue, block);
}

@end
