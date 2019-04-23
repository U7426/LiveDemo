//
//  NewLiveGiftModel.h
//  shehui
//
//  Created by 徐奥林 on 2017/4/21.
//  Copyright © 2017年 happyfirst. All rights reserved.
//

#import <Foundation/Foundation.h>
@class LuckyManager;
@interface GiftShowModel : NSObject<NSCopying>
//最后礼物数量
@property (nonatomic, assign)  NSInteger lastGiftNum;
//新加礼物数量
@property (nonatomic, assign)  NSInteger newGiftNum;
//礼物id
@property (nonatomic, assign)  NSInteger giftId;
//礼物图片
@property (nonatomic, strong)  NSString *giftImageUrl;
//用户昵称
@property (nonatomic, strong)  NSString *SenderName;
//发送者id
@property (nonatomic, assign)  NSInteger  SenderUid;
//发送的礼物名称
@property (nonatomic, strong) NSString *GiftName;
//幸运礼物数组
@property (nonatomic, strong)  NSMutableArray  *luckGiftInfos;
//发送者头像
@property (nonatomic, strong)  NSString *avatarUrl;
//接收人昵称
@property (nonatomic, strong)  NSString *toName;
//接收人ID
@property (nonatomic, assign)  NSInteger  toUid;
//礼物金额
@property (nonatomic, assign)  NSInteger gold;
//webp
@property (nonatomic, assign) BOOL isWebp;
@property (nonatomic, strong) NSString *webpImageUrl;

//是否即将移除(被标记说明该model 正要执行滑动移除动画不能再进行 合并)
@property (nonatomic,assign) BOOL isWillRemove;
- (NSInteger)getLuckyLum;
@end

@interface GiftLucky : NSObject
@property (nonatomic,strong) NSString *medals;
@property (nonatomic,strong) NSString *mutil;
@property (nonatomic,strong) NSString *remainCoins;
@property (nonatomic,strong) NSString *showMsg;
@end
