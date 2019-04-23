//
//  GiftShowManager.m
//  shehui
//
//  Created by EagleLive on 2017/6/26.
//  Copyright © 2017年 happyfirst. All rights reserved.
//

#import "GiftShowManager.h"
extern NSInteger extern_maxGiftNum;
@interface GiftShowManager()
///接收到的礼物存放数组
@property (nonatomic, strong) NSMutableArray *giftArray;
@end
@implementation GiftShowManager
#pragma mark - lazy
- (NSMutableArray *)giftArray {
    if (!_giftArray) {
        _giftArray = [NSMutableArray arrayWithCapacity:0];
    }
    return _giftArray;
}
- (NSMutableArray *)showingArray {
    if (!_showingArray) {
        _showingArray = [NSMutableArray arrayWithCapacity:0];
    }
    return _showingArray;
}
#pragma mark - init
- (instancetype)init{
    self = [super init];
    if (self) {

    }
    return self;
}
#pragma mark - 接收到礼物逻辑处理
- (void)didReceiveNewGiftWithModel:(GiftShowModel *)giftModel {
    if (giftModel.isWebp) {
        if (self.webpGiftBlock) {
            self.webpGiftBlock(giftModel);
        }
        return;
    }
    BOOL isCombine = [self isCombine:giftModel];
    if (isCombine) {
        return;
    }
    else {
        if (self.giftArray.count > 0) {
                @synchronized (self) {
            //队列中是否有相同特效
            __block BOOL isSame = NO;
            for (int i = 0; i < self.giftArray.count; i++) {
                GiftShowModel *model = self.giftArray[i];
                BOOL isEqual = model.SenderUid == giftModel.SenderUid && model.toUid == giftModel.toUid && model.giftId == giftModel.giftId;
                if (isEqual) {
                    //队列中同种特效直接合并
                    giftModel =  [self reSetModelWithModel:model receiveModel:giftModel];//修改了增加弹道时没有赋值giftmodel 的bug
                    isSame = YES;
                    break;
                }
                if (i == self.giftArray.count - 1) {
                    isSame = NO;
                }
            }

            if (!isSame) {
                [self reSetModelWithModel:nil receiveModel:giftModel];
                @synchronized (self) {
                    [self giftArrayAddModelWithModel:giftModel];
                }
            }
                }
        }
        else {
            [self reSetModelWithModel:nil receiveModel:giftModel];
            @synchronized (self) {
                [self giftArrayAddModelWithModel:giftModel];
            }
        }
        if (self.showingArray.count < extern_maxGiftNum) {
            [self addShowModel:giftModel];
        }
    }
}
- (void)giftArrayAddModelWithModel:(GiftShowModel *)model{
    if (model.SenderUid == MyUid || model.toUid == MyUid) {
        [self.giftArray insertObject:model atIndex:0];
    }
    else{
        [self.giftArray addObject:model];
    }
}
///重新更新礼物model。正在展示的直接重新赋值中奖数组，如果中奖效果正在展示，礼物视图 会自己管理 中奖数组。 否则 这里就全部合并
- (GiftShowModel *)reSetModelWithModel:(GiftShowModel *)model receiveModel:(GiftShowModel *)receiveModel{
    if (model) {
        model.newGiftNum = receiveModel.newGiftNum;
        model.lastGiftNum = model.lastGiftNum + model.newGiftNum;
        if (model.lastGiftNum <= 0) {
            NSLog(@"");
        }
        if (model.luckGiftInfos.count > 0) {
            [model.luckGiftInfos addObjectsFromArray:receiveModel.luckGiftInfos];
        }
        else{
            model.luckGiftInfos = [receiveModel.luckGiftInfos mutableCopy];
        }
        return model;
    }
    else {
        receiveModel.newGiftNum = receiveModel.newGiftNum;
        receiveModel.lastGiftNum = receiveModel.newGiftNum;
        if (receiveModel.lastGiftNum <= 0) {
            NSLog(@"");
        }
        return receiveModel;
    }
}
///判断加入的model是否能和正在展示的合并,如果可以,合并 并 返回bool
- (BOOL)isCombine:(GiftShowModel *)giftModel {
    if (self.showingArray.count > 0) {
        for (NSInteger i = 0; i < self.showingArray.count; i++) {
            GiftShowModel *showingModel = self.showingArray[i];
            if ([self isSameModelWithModel1:giftModel model2:showingModel]) {
                //合并处理，并通知外部
                [self reSetModelWithModel:showingModel receiveModel:giftModel];
                if (self.updateBlock) {
                    self.updateBlock(showingModel);
                }
                return YES;
            }
        }
    }
    return NO;
}
- (BOOL)isSameModelWithModel1:(GiftShowModel *)model1 model2:(GiftShowModel *)model2{
    if (model1.SenderUid == model2.SenderUid && model1.toUid == model2.toUid && model1.giftId == model2.giftId && !model1.isWillRemove && !model2.isWillRemove) {
        return YES;
    }
    return NO;
}
//弹道在等待 移除通知下一个进入时,插入消息误认为 弹道空闲，如果弹道全部被占用将插入失败，插入消息清除，重新插入
- (void)addFault:(GiftShowModel *)model{
    @synchronized (self) {
        [self.showingArray removeObject:model];
        [self giftArrayAddModelWithModel:model];
    }
}
- (void)addShowModel:(GiftShowModel *)model{
    @synchronized (self) {
        if (self.giftArray.count > 0) {
            [self.showingArray addObject:model];
            [self.giftArray removeObject:model];
            if (model.lastGiftNum <= 0) {
                NSLog(@"");
            }
            if (self.addBlock) {
                self.addBlock(model);
            }
        }
    }
}
//移除
- (void)updateShowingArray:(GiftShowModel *)willRemoveModel {
    if (!willRemoveModel) {
        return ;
    }
    @synchronized (self) {
        [self.showingArray removeObject:willRemoveModel];
        [self addShowGiftView];
    }
}
- (void)clearData {
    @synchronized (self) {
        [self.showingArray removeAllObjects];
        [self.giftArray removeAllObjects];
    }
}
- (void)addShowGiftView{
    if (self.giftArray.count > 0 ) {
        GiftShowModel *model;
        @synchronized (self) {
            model = self.giftArray[0];
            [self.showingArray addObject:model];
            [self.giftArray removeObject:model];
        }
        if (self.addBlock) {
            self.addBlock(model);
        }
    }
}
+ (NSInteger)countWay{
    return 4;
}

@end
