//
//  GiftShowManager.h
//  shehui
//
//  Created by EagleLive on 2017/6/26.
//  Copyright © 2017年 happyfirst. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "GiftShowModel.h"
@interface GiftShowManager : NSObject


//通知外部更新（可以合并）
@property (nonatomic, copy) void(^updateBlock)(GiftShowModel *model);
//通知外部添加展示
@property (nonatomic, copy) void(^addBlock)(GiftShowModel *model);
//收到动画礼物(和小礼物独立)
@property (nonatomic, copy) void(^webpGiftBlock)(GiftShowModel *model);
///正在展示的giftModel数组
@property (nonatomic, strong) NSMutableArray *showingArray;

/**
 接收到新礼物
 
 @param giftModel 收到的礼物model
 */
- (void)didReceiveNewGiftWithModel:(GiftShowModel *)giftModel;

/**
 即将移除，判断是否移除。view只需处理移除与否，展示逻辑函数内部完成

 @param willRemoveModel 移除的model
 */
- (void)updateShowingArray:(GiftShowModel *)willRemoveModel;
//添加失败，重新添加
- (void)addFault:(GiftShowModel *)model;
/**
 滑屏清空数据
 */
- (void)clearData;

+ (NSInteger)countWay;
@end
