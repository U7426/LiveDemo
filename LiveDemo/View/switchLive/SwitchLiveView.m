//
//  SwitchLiveView.m
//  Remark_QYLive
//
//  Created by 冯龙飞 on 2018/11/9.
//  Copyright © 2018年 孟博. All rights reserved.
//

#import "SwitchLiveView.h"
#import <SDWebImage/SDWebImageManager.h>
typedef NS_ENUM(NSInteger,Location){
    Top = 0,
    Middle,
    Bottom
};
@interface SwitchLiveView()<UIScrollViewDelegate>
@property (nonatomic,strong) UIImageView *topCoverView;
@property (nonatomic,strong) UIImageView *middleCoverView;
@property (nonatomic,strong) UIImageView *bottomCoverView;
@property (nonatomic,strong) NSArray *lives;
@property (nonatomic,strong) LiveInfo *liveInfo;
@property (nonatomic,strong) NSMutableArray *coverArray;
@property (nonatomic,copy) void(^didSwitchBlock)(LiveInfo *oldInfo,LiveInfo *info);
@property (nonatomic,strong) LiveInfo *oldInfo;
@end
@implementation SwitchLiveView
- (NSMutableArray *)coverArray {
    if (!_coverArray) {
        _coverArray = [NSMutableArray arrayWithCapacity:0];
    }
    return _coverArray;
}
- (instancetype)initWithMainView:(NSArray<UIView *>*)views
                           Lives:(NSArray *)lives
                        liveInfo:(LiveInfo *)info
               liveInfoDidChange:(void(^)(LiveInfo *oldInfo,LiveInfo *newInfo))block{
    self = [super initWithFrame:CGRectMake(0, 0, kScreen_Width, kScreen_Height)];
    if (self) {
        self.lives = lives;
        self.liveInfo = info;
        //观看列表大于 1，且 不是私密直播间才能滑动
        self.scrollEnabled = self.lives.count > 1;
        self.scrollsToTop = NO;
        self.contentSize = CGSizeMake(kScreen_Width, kScreen_Height * 3);
        [self setContentOffset:CGPointMake(0, kScreen_Height) animated:NO];
        self.showsVerticalScrollIndicator = NO;
        self.pagingEnabled = YES;
        self.bounces = NO;
        self.delegate = self;
        [self initWithThreeCoverView];
        for (UIView *view in views) {
            view.y = kScreen_Height;
            [self addSubview:view];
        }
        [self sortImageAndShowModelDidEndDeceleratingWithLocation:Middle];
        [self setThreeCoverImage];
        self.didSwitchBlock = block;
    }
    return self;
}
#pragma mark - private
- (void)initWithThreeCoverView{
    self.topCoverView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, kScreen_Width, kScreen_Height)];
    self.topCoverView.contentMode = UIViewContentModeScaleAspectFill;
    self.middleCoverView = [[UIImageView alloc]initWithFrame:CGRectMake(0, kScreen_Height , kScreen_Width, kScreen_Height)];
    [self.middleCoverView setUserInteractionEnabled:YES];
    self.middleCoverView.contentMode = UIViewContentModeScaleAspectFill;
    self.bottomCoverView = [[UIImageView alloc]initWithFrame:CGRectMake(0, kScreen_Height * 2 , kScreen_Width, kScreen_Height)];
    self.bottomCoverView.contentMode = UIViewContentModeScaleAspectFill;
    [self addSubview:self.topCoverView];
    [self addSubview:self.middleCoverView];
    [self addSubview:self.bottomCoverView];
}
/**
 排列三张图片在数组中对应位置并重新设置即将展示的直播model
 
 @param location 当前滑动停止的位置
 
 */
- (void)sortImageAndShowModelDidEndDeceleratingWithLocation:(Location)location{
    //先清空原数组，重新加入
    [self.coverArray removeAllObjects];
    //获取准备滑动时直播的 model 下标index
    NSInteger index = [self.lives indexOfObject:self.liveInfo];
    self.oldInfo = self.liveInfo;
    switch (location) {
        case Top:
            //如果当前展示的已经是数组第一个，则取数组的最后一个元素（无限循环滚动）
            if (index == 0) {
                self.liveInfo = [self.lives lastObject];
            }
            else {
                self.liveInfo = self.lives[index - 1];
            }
            index = [self.lives indexOfObject:self.liveInfo];
            [self addImageToArrayWithCurrentIndex:index];
            break;
        case Middle:
            [self addImageToArrayWithCurrentIndex:index];
            break;
        case Bottom:
            if (index == self.lives.count - 1) {
                self.liveInfo = self.lives.firstObject;
            }
            else {
                self.liveInfo = self.lives[index + 1];
            }
            index = [self.lives indexOfObject:self.liveInfo];
            [self addImageToArrayWithCurrentIndex:index];
            break;
        default:
            break;
    }
}
/**
 根据下标按顺序向数组加入图片
 
 @param index 即将展示model的下标
 */
- (void)addImageToArrayWithCurrentIndex:(NSInteger)index{
    if (!self.lives.count) {
        [self.middleCoverView sd_setImageWithURL:[NSURL URLWithString:self.liveInfo.cover] placeholderImage:nil];
        return;
    }
    //操作model容器
    LiveInfo *info = nil;
    //获取上一个model 取到图片
    if (index == 0) {
        info = [self.lives lastObject];
    }
    else {
        info = self.lives[index - 1];
    }
    //加入第一张图
    [self.coverArray addObject:info.cover];
    //加入第二张图
    [self.coverArray addObject:self.liveInfo.cover];
    //如果当前展示的为最后一个，则取数组第一个元素
    if (index == self.lives.count - 1) {
        info = self.lives.firstObject;
    }
    else {
        info = self.lives[index + 1];
    }
    //加入第三张图
    [self.coverArray addObject:info.cover];
}
//设置三张图片
- (void)setThreeCoverImage{
    if (self.coverArray.count != 3) {
        return;
    }
    [self.topCoverView sd_setImageWithURL:[NSURL URLWithString:self.coverArray[0]] placeholderImage:kDefault_User_Image];
    [self.middleCoverView sd_setImageWithURL:[NSURL URLWithString:self.coverArray[1]] placeholderImage:nil];
    [self.bottomCoverView sd_setImageWithURL:[NSURL URLWithString:self.coverArray[2]] placeholderImage:kDefault_User_Image];
}
//获取当前scrollView是在顶部 中间 还是 最底部
- (Location)locationWithScrollView:(UIScrollView *)scrollview{
    CGFloat offset = scrollview.contentOffset.y;
    if (offset <= kScreen_Height / 2.0) {
        return Top;
    }
    if (offset >= kScreen_Height / 2.0 * 3) {
        return Bottom;
    }
    else {
        return Middle;
    }
}

#pragma mark - scrollViewDelegate
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    Location location = [self locationWithScrollView:scrollView];
    switch (location) {
        case Top:
            [self sortImageAndShowModelDidEndDeceleratingWithLocation:Top];
            break;
            
        case Middle:
            
            return;
            break;
            
        case Bottom:
            [self sortImageAndShowModelDidEndDeceleratingWithLocation:Bottom];
            break;
        default:
            break;
    }
    self.middleCoverView.hidden = NO;
    [scrollView setContentOffset:CGPointMake(0, kScreen_Height) animated:NO];
    //对应数组设置三张假图片
    [self setThreeCoverImage];
    if (self.didSwitchBlock) {
        self.didSwitchBlock(self.oldInfo,self.liveInfo);
    }
}
@end
