//
//  GiftShowView.m
//  LiveUp
//
//  Created by 杨晓东 on 2017/8/16.
//  Copyright © 2017年 pajia. All rights reserved.
//

#import "GiftShowView.h"
#import "GiftNumView.h"
#import "GiftLuckyView.h"
@interface GiftShowView()
@property (nonatomic,strong) UIImageView* iconV;
@property (nonatomic,strong) UILabel* topL;
@property (nonatomic,strong) UILabel* bottomL;
@property (nonatomic,strong) UIImageView* giftV;
@property (nonatomic,strong) UILabel* numL;
@property (nonatomic, strong) GiftNumView *numView;
@property (nonatomic, strong) GiftLuckyView *luckyView;
@property (nonatomic, strong) NSTimer *hiddenTimer;
@property (nonatomic,strong) UIImageView *backV;
@end
@implementation GiftShowView
- (instancetype)init{
    self = [super init];
    if (self) {
        self.isShowing = NO;
        [self setupUI];
    }
    return self;
}
- (void)setupUI{
    [self setClipsToBounds:NO];
    self.alpha = 0.0;
    CGFloat height = 40;
    CGFloat width = 160;
    [self mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo(width);
        make.height.mas_equalTo(height);
    }];
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tap)];
    [self addGestureRecognizer:tap];
    self.backV = ({
        UIImageView *backV = [UIImageView new];
        backV.image = [UIImage imageNamed:@"room_bg_gift_area"];
        [self addSubview:backV];
        [backV mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.mas_equalTo(self);
        }];
        backV;
    });
    self.iconV = ({
        UIImageView *iconV = [[UIImageView alloc]init];
        [iconV setImage:kDefault_User_Image];
        [self addSubview:iconV];
        [iconV mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self.mas_left).mas_offset(3.0);
            make.top.mas_equalTo(self.mas_top).mas_offset(3.0);
            make.bottom.mas_equalTo(self.mas_bottom).mas_offset(- 3.0);
            make.width.mas_equalTo(iconV.mas_height);
        }];
        iconV.layer.cornerRadius = 17.0;
        iconV.layer.masksToBounds = YES;
        iconV;
    });
    
    
    self.topL = ({
        UILabel *topL = [[UILabel alloc]init];
        topL.textColor = [UIColor whiteColor];
        topL.font = [UIFont fontWith_Medium_OfSize:12.0];
        [self addSubview:topL];
        [topL mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self.iconV.mas_right).offset(6.0);
            make.top.mas_equalTo(self.mas_top).offset(4.0);
            make.right.mas_equalTo(self.mas_right).mas_offset(-height - 2);
            make.height.mas_equalTo(16);
        }];
        [topL sizeToFit];
        topL;
        
    });
    self.bottomL = ({
        UILabel *bottomL = [[UILabel alloc]init];
        bottomL.textColor = [UIColor whiteColor];
        bottomL.font = [UIFont fontWith_Medium_OfSize:12.0];
        [self addSubview:bottomL];
        bottomL.textAlignment =  NSTextAlignmentLeft;
        [bottomL mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self.topL.mas_left);
            make.bottom.mas_equalTo(self.mas_bottom).offset(-4);
            make.right.mas_equalTo(self.topL.mas_right);
            make.height.mas_equalTo(16);
        }];
        [bottomL sizeToFit];
        bottomL;
    });
    self.giftV = ({
        UIImageView *giftV = [[UIImageView alloc]init];
        [giftV setImage:kDefault_User_Image];
        [self addSubview:giftV];
        [giftV mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(self.mas_top);
            make.bottom.mas_equalTo(self.mas_bottom);
            make.right.mas_equalTo(self.mas_right);
            make.height.mas_equalTo(giftV.mas_width);
        }];
        giftV;
    });
    self.numView = ({
        GiftNumView *numView = [[GiftNumView alloc]init];
        [self addSubview:numView];
        [numView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self.mas_right);
            make.centerY.mas_equalTo(self);
        }];
        numView;
    });
    self.luckyView = ({
        GiftLuckyView *luckyView = [[GiftLuckyView alloc]init];
        [self addSubview:luckyView];
        [luckyView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.mas_equalTo(self);
            make.centerY.mas_equalTo(self.mas_bottom);
        }];
        luckyView;
    });
}
- (void)tap{
    if (self.didTouchAvatar) {
        self.didTouchAvatar(self.giftModel.SenderName,self.giftModel.SenderUid);
    }
}
#pragma mark 设置运动
- (void)setupShowWithGiftModel:(GiftShowModel *)giftModel {
    self.giftModel = giftModel;
    self.giftModel.isWillRemove = NO;
    [self.iconV sd_setImageWithURL:[NSURL URLWithString:giftModel.avatarUrl] placeholderImage:kDefault_User_Image];
    self.topL.text = giftModel.SenderName;
    self.bottomL.text = [NSString stringWithFormat:@"送 %@",giftModel.toName];
    [self.giftV sd_setImageWithURL:[NSURL URLWithString:giftModel.giftImageUrl] placeholderImage:kDefault_User_Image];
    if (giftModel.SenderUid == MyUid || giftModel.toUid == MyUid) {
//        self.backgroundColor = RGBA(0xe55cbe, 0.4);
        self.backV.image = [UIImage imageNamed:@"room_bg_gift_area_self"];
    }
    else{
//        self.backgroundColor = [UIColor colorWithWhite:0.0 alpha:0.26];
        self.backV.image = [UIImage imageNamed:@"room_bg_gift_area"];
    }
    [self setupShow];
}
- (void)updateShowView{
    [self reSetNumAndLucky];
}
- (void)setupShow{
    self.isShowing = YES;
    if (self.willShowGiftView) {
        self.willShowGiftView(self.giftModel);
    }
    [self setShowNum:NO];
    [self setGiftViewOrigin];
    [self setupOrgin];
    __weak typeof(self) weakSelf = self;
    [UIView animateWithDuration:0.2 delay:0 options:UIViewAnimationOptionCurveEaseOut animations:^{
        self.transform = CGAffineTransformMakeTranslation(0, self.transform.ty);
    } completion:^(BOOL finished) {
        [self setGiftViewAnimationCompleted:^{
            [weakSelf reSetNumAndLucky];
        }];
    }];
}
- (void)setupHidden {
    self.giftModel.isWillRemove = YES;
    [self stopHiddenTimer];
    [UIView animateWithDuration:0.2 delay:0 options:UIViewAnimationOptionCurveEaseIn animations:^{
        [self setupDestination];
    } completion:^(BOOL finished) {
        [self.luckyView clearCumulation];
        self.isShowing = NO;
        if (self.willRemoveGiftView) {
            self.willRemoveGiftView(self.giftModel);
        }
    }];
}
- (void)reSetNumAndLucky{
    [self stopHiddenTimer];
    [self setShowNum:YES];
    [self.luckyView receiveModel:self.giftModel];
}
- (void)setShowNum:(BOOL)show{
    self.numView.hidden = !show;
    if (show) {
        [self.numView setupOldNum:self.giftModel.lastGiftNum - self.giftModel.newGiftNum newNum:self.giftModel.lastGiftNum completed:^{
            [self startHiddenTimer];
        }];
    }
}
- (void)stopHiddenTimer{
    if (self.hiddenTimer != nil && [self.hiddenTimer isValid]) {
        [self.hiddenTimer invalidate];
        self.hiddenTimer = nil;
    }
}
- (void)startHiddenTimer{
    [self stopHiddenTimer];
    __weak typeof(self) weakSelf = self;
    self.hiddenTimer = [NSTimer scheduledTimerWithTimeInterval:self.giftModel.newGiftNum > 7 ? 4 : 3 repeats:NO block:^(NSTimer * _Nonnull timer) {
        [weakSelf setupHidden];
    }];
}
- (void)setupOrgin{
    self.alpha = 1.0;
    self.transform = CGAffineTransformMakeTranslation(- self.width - 40, self.transform.ty);
}
- (void)setupLift:(BOOL)yesOrNo{
    self.transform = CGAffineTransformMakeTranslation(self.transform.tx, yesOrNo ? - 50 : 0);
}
- (void)setupDestination {
    self.transform = CGAffineTransformMakeTranslation(kScreen_Width / 2, self.transform.ty);
    self.alpha = 0.0;
}
- (void)setGiftViewOrigin{
    self.giftV.transform = CGAffineTransformMakeTranslation(- (self.width - self.giftV.width), 0);
}

- (void)setGiftViewAnimationCompleted:(void (^)(void))completed{
    [UIView animateWithDuration:0.3 delay:0.05 options:UIViewAnimationOptionCurveEaseIn animations:^{
        self.giftV.transform = CGAffineTransformIdentity;
    } completion:^(BOOL finished) {
        completed();
    }];
}
//延迟释放不再提示
- (BOOL)willDealloc {
    return YES;
}
- (void)dealloc{
    [self stopHiddenTimer];
}
@end
