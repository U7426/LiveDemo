//
//  GiftShowView.h
//  LiveUp
//
//  Created by 杨晓东 on 2017/8/16.
//  Copyright © 2017年 pajia. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GiftShowModel.h"
@interface GiftShowView : UIView
///点击送礼物头像通知
@property (nonatomic, copy) void (^didTouchAvatar)(NSString *name,NSInteger uid);
///即将展示礼物视图，通知外部，管理类判断是否需要合并处理，如果可以就合并 并更新giftModel
@property (nonatomic, copy) void (^willShowGiftView)(GiftShowModel *giftModel);
///视图移除，通知下一个进入（传出需要移除的model）
@property (nonatomic,copy) void (^willRemoveGiftView)(GiftShowModel *giftModel);
///展示幸运礼物，通知外部撒金币
@property (nonatomic, copy) void (^didShowLuckyView)(void);
@property (nonatomic,strong) GiftShowModel* giftModel;
//视图是否正在展示（外部用此来判断此视图是否空闲）
@property (nonatomic,assign) BOOL isShowing;

- (void)setupShowWithGiftModel:(GiftShowModel *)giftModel;
- (void)updateShowView;
- (void)setupOrgin;
- (void)setupLift:(BOOL)yesOrNo;//设置是否抬升
@end
