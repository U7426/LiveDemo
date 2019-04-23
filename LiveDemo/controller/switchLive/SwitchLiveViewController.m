//
//  SwitchLiveViewController.m
//  LiveDemo
//
//  Created by 冯龙飞 on 2019/4/23.
//  Copyright © 2019 冯龙飞. All rights reserved.
//

#import "SwitchLiveViewController.h"
#import "SwitchLiveView.h"
@interface SwitchLiveViewController ()
@property (nonatomic,strong) SwitchLiveView *switchLiveView;
@end

@implementation SwitchLiveViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.fd_prefersNavigationBarHidden = YES;
    [self initUI];
}
- (void)initUI{
    NSMutableArray *lives = [NSMutableArray new];
    LiveInfo *info1 = [LiveInfo new];
    info1.cover = @"https://cdn.static.orzzhibo.com/20190414/67ac04f4d448ba56886279f479f3afab.jpeg";
    LiveInfo *info2 = [LiveInfo new];
    info2.cover = @"https://cdn.static.orzzhibo.com/20190414/5c97a1dc43e864c629e2343e737c8595.jpeg";
    LiveInfo *info3 = [LiveInfo new];
    info3.cover = @"https://cdn.static.orzzhibo.com/20190414/97d6b1ab75aec964ff39d858ab3105e9.jpeg";
    lives = @[info1,info2,info3].mutableCopy;
//    __weak typeof(self) weakself = self;
    self.switchLiveView = ({
        SwitchLiveView *switchView = [[SwitchLiveView alloc]initWithMainView:@[[UIView new]] Lives:lives liveInfo:info1 liveInfoDidChange:^(LiveInfo *oldInfo,LiveInfo *liveInfo) {
            if (oldInfo) {
                
            }
        }];
        [self.view insertSubview:switchView atIndex:0];
        switchView;
    });
}

@end
