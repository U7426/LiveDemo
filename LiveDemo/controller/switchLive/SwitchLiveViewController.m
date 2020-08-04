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
    info1.cover = @"https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1594220311562&di=508e4384d2b4ce38627cd9d316b7e4bb&imgtype=0&src=http%3A%2F%2Fwww.08lr.cn%2Fuploads%2Fallimg%2F170412%2F1-1F412152634.jpg";
    LiveInfo *info2 = [LiveInfo new];
    info2.cover = @"https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1594220311561&di=e3e696174434c825439d127689f4d7bc&imgtype=0&src=http%3A%2F%2Fyouimg1.c-ctrip.com%2Ftarget%2Ftg%2F055%2F224%2F049%2F96cb1a03b8c04627b10fafcb90b0eb9f.jpg";
    LiveInfo *info3 = [LiveInfo new];
    info3.cover = @"https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1594220311560&di=9b4b5350197919abab3474c04f193c02&imgtype=0&src=http%3A%2F%2F5b0988e595225.cdn.sohucs.com%2Fimages%2F20180605%2F7d976e643aec4e0a920ad561e124d80d.jpeg";
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
