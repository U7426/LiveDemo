//
//  NewLiveGiftModel.m
//  shehui
//
//  Created by 徐奥林 on 2017/4/21.
//  Copyright © 2017年 happyfirst. All rights reserved.
//

#import "GiftShowModel.h"
@implementation GiftShowModel
- (id)copyWithZone:(NSZone *)zone{
    GiftShowModel *model = [[[self class] allocWithZone:zone]init];
    model.lastGiftNum = _lastGiftNum;
    model.newGiftNum = _newGiftNum;
    model.giftId = _giftId;
    model.giftImageUrl = [_giftImageUrl copy];
    model.SenderName = [_SenderName copy];
    model.SenderUid = _SenderUid;
    model.GiftName = [_GiftName copy];
    model.luckGiftInfos = [_luckGiftInfos copy];
    model.avatarUrl = [_avatarUrl copy];
    model.toName = [_toName copy];
    model.toUid = _toUid;
    model.gold = _gold;
    model.isWebp = _isWebp;
    model.webpImageUrl = [_webpImageUrl copy];
    return model;
}
- (instancetype)init {
    self = [super init];
    if (self) {

    }
    return self;
}
- (NSInteger)getLuckyLum {
    NSInteger allNum = 0;
    for (GiftLucky *luckGiftInfo in self.luckGiftInfos) {
        allNum  = allNum +  [luckGiftInfo.mutil integerValue];
    }
    return allNum;
}

@end
@implementation GiftLucky

@end
