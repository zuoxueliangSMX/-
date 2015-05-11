//
//  WEProductHandler.h
//  WestElectromechanical
//
//  Created by zuo on 15/5/11.
//  Copyright (c) 2015年 zuo. All rights reserved.
//

#import "BaseHandler.h"
#import "WEProductDao.h"
@interface WEProductHandler : BaseHandler
@property (readonly) dispatch_queue_t productFetchQueue;
@property (readonly) void *productFetchQueueTag;
@property (readonly) dispatch_queue_t productInsertQueue;
@property (readonly) void *productInsertQueueTag;

//
- (void)fetchAllSuccessBlock:(SuccessBlock)success failedBlock:(FailedBlock)failed;

- (void)deleteProductSuccessBlock:(SuccessBlock)success failedBlock:(FailedBlock)failed
;
- (void)updateProductModel:(WEProductSingleModel *)singleModel success:(SuccessBlock)success faileBlock:(FailedBlock)failed;

- (void)addProductSingleModels:(NSArray *)singleModels success:(SuccessBlock)success faileBlock:(FailedBlock)failed;

/**
 *  根据id查询日程PK
 *
 *  @param pkId        <#invId description#>
 *  @param successBlock <#successBlock description#>
 */
- (void)queryProductByProductId:(NSString *)groupId successBlock:(SuccessBlock)successBlock;


@end
