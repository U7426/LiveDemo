//
//  GiftNumView.m
//  LiveUp
//
//  Created by EagleLive on 2017/10/19.
//  Copyright © 2017年 pajia. All rights reserved.
//

#import "GiftNumView.h"
#import "ItemScrollNumView.h"
@interface GiftNumView ()
@property (nonatomic, strong) UIImageView *X;
@property (nonatomic, strong) UILabel *numL;
@property (nonatomic, strong) ScrollNumView *numView;
@end
@implementation GiftNumView
- (instancetype)init{
    self = [super init];
    if (self) {
        self.clipsToBounds = NO;
        self.X = ({
            UIImageView *X = [[UIImageView alloc]init];
            X.image = [UIImage imageNamed:@"Ani-x"];
            [self addSubview:X];
            [X mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.mas_equalTo(self.mas_left);
                make.centerY.mas_equalTo(self);
            }];
            X;
        });
        self.numL = ({
            UILabel *numL = [[UILabel alloc]init];
            [self addSubview:numL];
            [numL mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.mas_equalTo(self.X.mas_right).mas_offset(-10);
                make.centerY.mas_equalTo(self);
            }];
            numL;
        });
        self.numView = ({
            ScrollNumView *numView = [[ScrollNumView alloc]init];
            [self addSubview:numView];
            [numView mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.mas_equalTo(self.X.mas_right).mas_offset(-10);
                make.centerY.mas_equalTo(self);
            }];
            numView;
        });
    }
    return self;
}
- (void)setGiftNum:(NSString *)num{
    [self.numL setGiftNum:num];
}
- (void)setupOldNum:(NSInteger)oldNum newNum:(NSInteger)newNum completed:(void(^)(void))completed{
    if (oldNum == 0) {
        oldNum = 1;
    }
    [self.layer removeAllAnimations];
    [self.numL.layer removeAllAnimations];
    [self.numView.layer removeAllAnimations];
    BOOL bigNumShow = newNum - oldNum >= 9;
    [self setupBigNumShow:NO];
    [self.numL setGiftNum:[NSString stringWithFormat:@"%ld",bigNumShow ? (oldNum ==  0 ? 1 : oldNum) : newNum]];
    if (bigNumShow){//设置滚动
        [self setupBigNumShow:YES];
        [self.numView setUpFromNum:oldNum toNum:newNum animationCompletion:completed];
    }
    else{//设置跳动
        self.numL.transform = CGAffineTransformMakeScale(2, 2);
        [UIView animateWithDuration:0.7 delay:0.0 usingSpringWithDamping:0.3 initialSpringVelocity:0.3 options:0 animations:^{
            self.numL.transform = CGAffineTransformIdentity;
        } completion:^(BOOL finished) {
            if (completed) {
                completed();
            }
        }];
    }

}
- (void)setupBigNumShow:(BOOL)bigNumShow{
    self.numL.hidden  = bigNumShow;
    self.numView.hidden = !bigNumShow;
}
@end
@interface ScrollNumView()
@property (nonatomic,assign) NSInteger fromNum;
@property (nonatomic,assign) NSInteger toNum;
////单个滚动视图的个数（用来判读是否还需要创建）
@property (nonatomic,assign) NSInteger itemViewNum;
@end
@implementation ScrollNumView

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        self.itemViewNum = 0;
        [self setClipsToBounds:YES];
    }
    return self;
}
- (void)setUpFromNum:(NSInteger)fromNum toNum:(NSInteger)toNum animationCompletion:(void (^)(void))completion{
    self.fromNum = fromNum;
    self.toNum = toNum;
    NSInteger toNumLength = [NSString stringWithFormat:@"%ld",(long)self.toNum].length;

    [self mas_updateConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo(40.0 * toNumLength - (toNumLength - 1) * kGiftNumPadding);
        make.height.mas_equalTo(40.0);
    }];
    self.height = 40.0;
    NSInteger nowNum = self.itemViewNum;
    //超过复用 个数，创建所需要的个数，并设置约束
    if (toNumLength > self.itemViewNum) {
        for (NSInteger i = nowNum; i < toNumLength; i++) {
            ItemScrollNumView *itemView = [[ItemScrollNumView alloc]initWithFrame:CGRectMake(0, 0, 40, 40) image:@"Ani-"];
            [self addSubview:itemView];
            itemView.tag = 100 + self.itemViewNum;
            UIView *view;
            if (self.itemViewNum == 0) {
                [itemView mas_makeConstraints:^(MASConstraintMaker *make) {
                    make.top.equalTo(self.mas_top);
                    make.width.mas_equalTo(40.0);
                    make.right.equalTo(self.mas_right);
                }];
            }
            else {
                view = [self viewWithTag:100 + self.itemViewNum -1];
                [itemView mas_makeConstraints:^(MASConstraintMaker *make) {
                    make.top.equalTo(self.mas_top);
                    make.width.mas_equalTo(40.0);
                    make.right.equalTo(view.mas_left).mas_offset(kGiftNumPadding);
                }];
            }
            self.itemViewNum += 1;
        }
    }
    [self starAnimationcompletion:completion];
}
- (void)starAnimationcompletion:(void (^)(void))completion{
    NSString *toNumString = [NSString stringWithFormat:@"%ld",(long)self.toNum];
    NSInteger toNumLength = toNumString.length;
    NSString *fromString = [NSString stringWithFormat:@"%ld",(long)self.fromNum];
    NSInteger fromLength = fromString.length;
    //防止看到未显示的数字阴影
    if (toNumLength < self.itemViewNum) {
        ItemScrollNumView *view = [self viewWithTag:100 + toNumLength];
        view.hidden = YES;
    }
    //设置滚动
    for (NSInteger i = 0; i < toNumLength; i++) {
        NSInteger fromItemNum;
        if (i < fromLength) {
            fromItemNum = [[fromString substringWithRange:NSMakeRange(fromLength - 1 - i, 1)] integerValue];
        }
        else {
            fromItemNum = -1;
        }
        NSInteger toItemNum = [[toNumString substringWithRange:NSMakeRange(toNumLength - 1 - i, 1)] integerValue];
        ItemScrollNumView *view = [self viewWithTag:100 + i];
        view.hidden = NO;
        [view.layer removeAllAnimations];
        view.transform = CGAffineTransformMakeTranslation(0, -fromItemNum * kView_Hight);
        [UIView animateWithDuration:0.5 animations:^{
            if (toItemNum >= fromItemNum) {
                view.transform = CGAffineTransformMakeTranslation(0, -toItemNum * kView_Hight);
            }
            else {
                view.transform = CGAffineTransformMakeTranslation(0,  -(10 + toItemNum)  * kView_Hight);
            }
        } completion:^(BOOL finished) {
            if (i == toNumLength - 1) {
                if (completion) {
                    completion();
                }
            }
        }];
        
    }
}
@end


