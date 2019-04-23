//
//  LuckView.m
//  LiveUp
//
//  Created by EagleLive on 2017/10/26.
//  Copyright © 2017年 pajia. All rights reserved.
//

#import "GiftLuckyView.h"
#import <AVFoundation/AVFoundation.h>
#define normalStayTime 2.0
#define bigStayTime 3.0
#define minStayTime 1.5
#define kBigOffSet 15.0
#define kSmallOffSet 2.0
@interface GiftLuckyView()
@property (nonatomic, strong) UIImageView *congratsV,*rayV,*boxV,*winV,*timesCoinsV,*smallBackV;
@property (nonatomic, strong) UIView *timesBackView;
@property (nonatomic, strong) UILabel *timesL,*smallTimesL;
@property (nonatomic, strong) UIView *smallTimesView;
@property (nonatomic, strong) AVAudioPlayer *player;
@property (nonatomic, strong) GiftShowModel *model;
@property (nonatomic, assign) NSInteger cumulation;
@property (nonatomic, assign) BOOL isShowing;
@end
@implementation GiftLuckyView
- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        self.hidden = YES;
        self.cumulation = 0;
        [self setupUI];
    }
    return self;
}
- (void)setupUI{
    self.congratsV = ({
        UIImageView *congratsV = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"congrats500-frontbg"]];
        [self addSubview:congratsV];
        [congratsV mas_makeConstraints:^(MASConstraintMaker *make) {
            make.center.mas_equalTo(self).mas_offset(kBigOffSet);
        }];
        congratsV;
    });
    self.rayV = ({
        UIImageView *rayV = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"emissive-bg"]];
        [self insertSubview:rayV atIndex:0];
        [rayV mas_makeConstraints:^(MASConstraintMaker *make) {
            make.center.mas_equalTo(self).mas_offset(kBigOffSet);
        }];
        [self ravAddAnimation];
        rayV;
    });
    self.boxV = ({
        UIImageView *boxV = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"second-star"]];
        [self insertSubview:boxV atIndex:0];
        [boxV mas_makeConstraints:^(MASConstraintMaker *make) {
            make.center.mas_equalTo(self).mas_offset(kBigOffSet);
        }];
        boxV;
    });
    self.timesBackView = ({
        UIView *view = [[UIView alloc]init];
        [self.congratsV addSubview:view];
        [view mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.mas_equalTo(self.congratsV);
            make.width.mas_equalTo(self.congratsV.width * 338.0  / 437);
            make.height.mas_equalTo(self.congratsV.height * 49.0  / 257);
            make.bottom.mas_equalTo(self.congratsV.mas_bottom).mas_equalTo(- self.congratsV.height * 90.0  / 315);
        }];
        view;
    });
    self.winV = ({
        UIImageView *winV = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"win"]];
        [self.timesBackView addSubview:winV];
        [winV mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self.timesBackView).mas_offset(5);
            make.centerY.mas_equalTo(self.timesBackView);
        }];
        winV;
    });
    self.timesL = ({
        UILabel *timesL = [[UILabel alloc]init];
        [self.timesBackView addSubview:timesL];
        [timesL mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self.winV.mas_right).mas_offset(2);
            make.centerY.mas_equalTo(self.timesBackView);
        }];
        [timesL setLuckyTimes:@"0"];
        timesL;
    });
    self.timesCoinsV = ({
        UIImageView *timesCoinsV = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"times-coins!"]];
        [self.timesBackView addSubview:timesCoinsV];
        [timesCoinsV mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self.timesL.mas_right).mas_offset(2);
            make.centerY.mas_equalTo(self.timesBackView);
        }];
        timesCoinsV;
    });
    self.smallTimesView = ({
        UIView *smallTimesview = [[UIView alloc]init];
        [self addSubview:smallTimesview];
        [smallTimesview  mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.mas_equalTo(self);
            make.top.mas_equalTo(self.mas_centerY).mas_offset(kSmallOffSet);
        }];
        smallTimesview;
    });
    self.smallBackV = ({
        UIImageView *smallBackV = [[UIImageView alloc]init];
        smallBackV.image = [UIImage imageNamed:@"Congrats-bg10"];
        [self.smallTimesView addSubview:smallBackV];
        [smallBackV mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.mas_equalTo(self.smallTimesView);
            make.top.mas_equalTo(self.smallTimesView);
        }];
        smallBackV;
    });
    self.smallTimesL = ({
        UILabel *smallTimesL = [[UILabel alloc]init];
        smallTimesL.textAlignment = NSTextAlignmentCenter;
        smallTimesL.font = [UIFont fontWith_Medium_OfSize:12.0];
        smallTimesL.textColor = [UIColor whiteColor];
        [self.smallBackV addSubview:smallTimesL];
        [smallTimesL mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self.smallBackV.mas_left).mas_equalTo(self.smallBackV.width * 12 / 324 + 16);//图片有留白
            make.centerY.mas_equalTo(self.smallBackV);
        }];
        smallTimesL;
    });
}
- (void)ravAddAnimation{
    CABasicAnimation *animation =  [CABasicAnimation animationWithKeyPath:@"transform.rotation.z"];
    animation.fromValue = [NSNumber numberWithFloat:0.f];
    animation.toValue =  [NSNumber numberWithFloat: M_PI *2];
    animation.duration  = 3.0;
    animation.autoreverses = NO;
    animation.fillMode =kCAFillModeForwards;
    animation.repeatCount = MAXFLOAT;
    [self.rayV.layer addAnimation:animation forKey:@"rayVAnimation"];
}

- (void)receiveModel:(GiftShowModel *)model{
    self.cumulation += model.newGiftNum;
    NSInteger times = [model getLuckyLum];
    if (!(times > 0)) {
        return;
    }
    self.model =  model;
    if (self.isShowing) {
        return;
    }
    [self showCurTimes];
}
- (void)showCurTimes{
    NSInteger times = [self.model getLuckyLum];
    BOOL senderIsMe = self.model.SenderUid == MyUid;
    NSString *luckyMessage = [NSString stringWithFormat:@"%@送出%ld个%@中得%ld倍大奖",senderIsMe ? @"你" : self.model.SenderName,(long)(self.cumulation > 0 ? self.cumulation : 1),self.model.GiftName,(long)times];
    if (senderIsMe) {
        [[NSNotificationCenter defaultCenter] postNotificationName:kNOTIFITION_GIFT_LUCKYMESSAGE object:luckyMessage];
    }
    self.cumulation = 0;
    [self.model.luckGiftInfos removeAllObjects];
    self.model = nil;
    if (times >= 500) {
        [self AVAudioPlayerPlaySenderIsMe:senderIsMe];
        [self setupBigTimesShow:YES];
        [self bigAnimation];
        [self.timesL setLuckyTimes:[NSString stringWithFormat:@"%ld",(long)times]];
        if (senderIsMe) {
            [[NSNotificationCenter defaultCenter] postNotificationName:kNOTIFICATION_GREATER_500Times_Lucky object:nil];
        }
        [self nextShowWithCurBig:YES];
    }
    else{
        if (times >= 50) {
            self.smallBackV.image = [UIImage imageNamed:@"Congrats-bg50"];
        }
        else{
            self.smallBackV.image = [UIImage imageNamed:@"Congrats-bg10"];
        }
        [self setupBigTimesShow:NO];
        [self smallAnimation];
        [self setSmallLuckyTimes:times];
        [self nextShowWithCurBig:NO];
    }
}
- (void)setSmallLuckyTimes:(NSInteger)num{
    if (!(num > 0)) {
        return;
    }
    NSString *string = [NSString stringWithFormat:@"赢得 %ld 倍金币奖励",(long)num];
    NSMutableAttributedString *strAtt = [[NSMutableAttributedString alloc] initWithString:string];
    NSRange range = [string rangeOfString:[NSString stringWithFormat:@"%ld",(long)num]];
    [strAtt addAttribute:NSFontAttributeName value:[UIFont fontWith_AmericanCondensedBold_OfSize:18.0] range:range];
    [strAtt addAttribute:NSForegroundColorAttributeName value:RGB(0xfff800) range:range];
    self.smallTimesL.attributedText = strAtt;
}
- (void)clearCumulation{
    self.cumulation = 0;
}
- (void)nextShowWithCurBig:(BOOL)isBig{
    __block CGFloat stayTime = 0.0000;
    __block CGFloat duration = 0.1000;
    NSTimer *timer = [NSTimer scheduledTimerWithTimeInterval:duration repeats:YES block:^(NSTimer * _Nonnull timer) {
        stayTime += duration;
        if (stayTime >= minStayTime) {
            if (self.model) {
                [self showCurTimes];
                [timer invalidate];
                timer = nil;
                return ;
            }
            else{
                if (stayTime >= (isBig ? bigStayTime : normalStayTime)) {
                    self.model = nil;
                    [timer invalidate];
                    timer = nil;
                    [self setupHidden];
                    return;
                }
            }
        }
    }];
    [[NSRunLoop mainRunLoop] addTimer:timer forMode:NSRunLoopCommonModes];
}

- (void)AVAudioPlayerPlaySenderIsMe:(BOOL)senderIsMe{
    if (!self.player) {
        NSURL *url = [[NSBundle mainBundle] URLForResource:@"礼物声音.mp3" withExtension:nil];
        NSError *error = nil;
        self.player = [[AVAudioPlayer alloc] initWithContentsOfURL:url error:&error];
    }
     [self.player play];
    if (senderIsMe) {
        AudioServicesPlaySystemSound(kSystemSoundID_Vibrate);//震动
    }
}

- (void)bigAnimation{
    self.transform = CGAffineTransformMakeScale(6.0, 6.0);
    [UIView animateWithDuration:0.7 delay:0 usingSpringWithDamping:0.3 initialSpringVelocity:0.3 options:UIViewAnimationOptionCurveEaseIn animations:^{
        self.transform = CGAffineTransformMakeScale(1.0, 1.0);
    } completion:^(BOOL finished) {
        
    }];
}
- (void)smallAnimation{
    // 先缩小
    self.transform = CGAffineTransformMakeScale(0.7, 0.7);
    // 弹簧动画，参数分别为：时长，延时，弹性（越小弹性越大），初始速度
    [UIView animateWithDuration: 0.7 delay:0 usingSpringWithDamping:0.3 initialSpringVelocity:0.3 options:0 animations:^{
        // 放大
        self.transform = CGAffineTransformMakeScale(1, 1);
    } completion:nil];
}
- (void)setupBigTimesShow:(BOOL)show{
    self.hidden = NO;
    self.isShowing = YES;
    self.boxV.hidden = self.congratsV.hidden = self.rayV.hidden = self.timesBackView.hidden = !show;
    if (show) {
        CABasicAnimation *animation = (CABasicAnimation *)[self.rayV.layer animationForKey:@"rayVAnimation"];
        if (animation == nil) {
            [self ravAddAnimation];
        }
    }
    self.smallTimesView.hidden = show;
}
- (void)setupHidden{
    self.isShowing = NO;
    self.hidden = YES;
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
