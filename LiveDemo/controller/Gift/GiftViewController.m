//
//  GiftViewController.m
//  LiveDemo
//
//  Created by 冯龙飞 on 2019/4/23.
//  Copyright © 2019 冯龙飞. All rights reserved.
//

#import "GiftViewController.h"
#import "GiftShowView.h"
#define kGiftViewTagBegin 200
NSInteger extern_maxGiftNum;
@interface GiftViewController ()
@property (nonatomic,strong) NSMutableArray *giftViewArray;
@property (nonatomic,strong) GiftShowManager *giftManager;
@property (nonatomic,strong) NSTimer *timer;
@end

@implementation GiftViewController
- (NSMutableArray *)giftViewArray{
    if (!_giftViewArray) {
        _giftViewArray = [NSMutableArray arrayWithCapacity:0];
    }
    return _giftViewArray;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    #warning 需要设置隐藏边界
    self.view.layer.masksToBounds = YES;
    self.view.backgroundColor = [UIColor whiteColor];
    #warning extern_maxGiftNum 想要展示的弹道数量，必须声明
    extern_maxGiftNum = [GiftShowManager countWay];//[GiftShowManager countWay] 这里设置的4，可以自己设置
    [self initUI];//可从该demo直接复制
    [self setupGiftManager];//可从该demo直接复制（布局自己调整）
    [self nofitication];//自己中奖通知
    [self initData];//模拟收到礼物
    [self initSendBt];//模拟送礼按钮
    [self changeCountWay];//动态改变弹道数量（选择使用）
}
- (void)initData{
    NSString *path = [[NSBundle mainBundle] pathForResource:@"gift" ofType:@"json"];
    NSArray *array = [NSArray arrayWithContentsOfFile:path];
    __weak typeof(self) weakSelf = self;
    self.timer = [NSTimer scheduledTimerWithTimeInterval:0.2 repeats:YES block:^(NSTimer * _Nonnull timer) {
        NSDictionary *dic = array[arc4random() % array.count];//假数据随机取一条
        GiftShowModel *model = [[GiftShowModel alloc]init];
        //基础信息
        model.newGiftNum = arc4random()%100 + 1;//收到新礼物数量
        model.giftId = [dic[@"id"] integerValue];//礼物id
        model.giftImageUrl = dic[@"img"];//礼物图片
        model.GiftName = dic[@"grab_name"];//礼物名称
        model.gold = [dic[@"grab_price"] integerValue];//礼物金额
        //中奖信息
        GiftLucky *lucky = [GiftLucky new];
        NSArray *luckyNums = @[@"0",@"10",@"20",@"500"];//这里模拟中奖倍数
        lucky.mutil = luckyNums[arc4random()%luckyNums.count];
        model.luckGiftInfos = lucky.mutil.integerValue > 0 ? @[lucky].mutableCopy : nil;
        //大礼物信息（SVGA，WEBP）
        model.isWebp = [dic[@"cid"] integerValue] == 2;//是否为大礼物
        model.webpImageUrl = dic[@"svga"];//大礼物url
        //发送方和接收方信息
        NSArray *avatars = @[@"https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1594220538169&di=dd875399642305d7033ef1c2dfa92b52&imgtype=0&src=http%3A%2F%2Ft7.baidu.com%2Fit%2Fu%3D3646975693%2C3978456039%26fm%3D193",
                            @"https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1594220538169&di=52da5166ca278f9dc1c5c6064b30bb3c&imgtype=0&src=http%3A%2F%2Ft9.baidu.com%2Fit%2Fu%3D3183183007%2C2073289373%26fm%3D193",
                            @"https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1594220538168&di=47af89ec67309ffbf68b32513202c45b&imgtype=0&src=http%3A%2F%2Ft8.baidu.com%2Fit%2Fu%3D595885617%2C884179174%26fm%3D193",
        @"https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1594220538167&di=d577fb75f972e2a13201067dd3df4a5f&imgtype=0&src=http%3A%2F%2Ft9.baidu.com%2Fit%2Fu%3D2246033344%2C164411552%26fm%3D193",
        @"https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1594220739623&di=65f44aacf857df3490944d8568f324e6&imgtype=0&src=http%3A%2F%2Fimage.namedq.com%2Fuploads%2F20200116%2F03%2F1579118224-bWXzQjqrvF.jpg",
        @"https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1594220748424&di=0925e8075ac3c546f3197a869ed8ede2&imgtype=0&src=http%3A%2F%2Fwww.scxxg.net%2Fpublic%2Fuploads%2Fimages%2F20180731%2F1_201807311725395f81f.jpeg",
        @"https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1594220777092&di=91e9fe78948a0599d77dd7f370af8ab2&imgtype=0&src=http%3A%2F%2Fimg1.imgtn.bdimg.com%2Fit%2Fu%3D297778481%2C2089397163%26fm%3D214%26gp%3D0.jpg",
        @"https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1594220739622&di=69fb45303e528d6945987de44b35bbc5&imgtype=0&src=http%3A%2F%2Fimage.namedq.com%2Fuploads%2F20190215%2F21%2F1550239006-CiQOglKPSt.jpg"];
        model.avatarUrl = avatars[arc4random()%avatars.count];//送礼这头像
        model.SenderName = @"sender";//昵称
        model.SenderUid = arc4random()%2;//uid
        model.toName = @"receiver";//礼物送给谁（昵称）
        model.toUid = arc4random()%2;//礼物送给谁（uid）
        [weakSelf.giftManager didReceiveNewGiftWithModel:model];
    }];
}
- (void)initUI{
    GiftShowView *lastGiftView = nil;
    for (int i = 0;  i < [GiftShowManager countWay]; i++) {
        GiftShowView *giftShowView = [[GiftShowView alloc]init];
        giftShowView.tag = kGiftViewTagBegin + i;
        if (i == 0)[self.view addSubview:giftShowView];
        else [self.view insertSubview:giftShowView belowSubview:lastGiftView];
        [giftShowView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self.view.mas_left).offset(15);
            make.bottom.mas_equalTo(lastGiftView ? lastGiftView.mas_top :self.view.mas_centerY).offset (lastGiftView ? - 50 : 50);
        }];
        lastGiftView = giftShowView;
        //约束后设置运动开始位置
        [giftShowView layoutIfNeeded];
        [giftShowView setupOrgin];
        giftShowView.alpha = 0.0;
        [self.giftViewArray addObject:giftShowView];
        __weak typeof(self) weakSelf = self;
        giftShowView.willRemoveGiftView = ^(GiftShowModel *giftModel) {
            [weakSelf.giftManager updateShowingArray:giftModel];
        };
        //点击头像回调
        giftShowView.didTouchAvatar = ^(NSString *name,NSInteger uid) {
            #warning 点击头像回调
        };
    }
}

- (void)setupGiftManager {
    __weak typeof(self) weakSelf = self;
    self.giftManager = [[GiftShowManager alloc]init];
    self.giftManager.updateBlock = ^(GiftShowModel *model) {
        for (GiftShowView *giftView in weakSelf.giftViewArray) {
            if (giftView.giftModel == model) {
                [giftView updateShowView];
                break;
            }
        }
    };
    self.giftManager.addBlock = ^(GiftShowModel *model) {
        for (NSInteger i = 0; i < extern_maxGiftNum; i++) {
            GiftShowView *giftShowView = weakSelf.giftViewArray[i];
            if (!giftShowView.isShowing) {
                [giftShowView setupShowWithGiftModel:model];
                break;
            }
            if (i == extern_maxGiftNum - 1) {
                [weakSelf.giftManager addFault:model];
                //                NSAssert(NO, @"礼物逻辑错误，没有找到空闲的视图");
            }
        }
    };
    self.giftManager.webpGiftBlock = ^(GiftShowModel *model) {
#warning 收到大礼物处理
        
    };
}
#pragma mark - 中奖通知
- (void)nofitication{
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(lucky:) name:kNOTIFITION_GIFT_LUCKYMESSAGE object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(lucky500Times:) name:kNOTIFICATION_GREATER_500Times_Lucky object:nil];
}
- (void)lucky:(NSNotification*)notificaton{
    NSLog(@"%@",notificaton.object);
}
- (void)lucky500Times:(NSNotification *)notification{
    NSLog(@"中的500倍及以上大奖");
}
#pragma mark - 模拟送礼
- (void)initSendBt{
    UIButton *sendBt = [UIButton buttonWithType:UIButtonTypeCustom];
    sendBt.tag = 101;
    sendBt.frame = CGRectMake(kScreen_Width / 2 - 100 / 2, kScreen_Height - 150 - 50, 100, 50);
    sendBt.backgroundColor = [UIColor blackColor];
    [sendBt setTitle:@"赠送" forState:UIControlStateNormal];
    [self.view addSubview:sendBt];
    [sendBt addTarget:self action:@selector(senderAction:) forControlEvents:UIControlEventTouchUpInside];
}
- (void)senderAction:(UIButton *)sender{
    NSString *path = [[NSBundle mainBundle] pathForResource:@"gift" ofType:@"json"];
    NSArray *array = [NSArray arrayWithContentsOfFile:path];
    NSDictionary *dic = array[0];//假数据随机取一条
    GiftShowModel *model = [[GiftShowModel alloc]init];
    //基础信息
    model.newGiftNum = 99;//收到新礼物数量
    model.giftId = [dic[@"id"] integerValue];//礼物id
    model.giftImageUrl = dic[@"img"];//礼物图片
    model.GiftName = dic[@"grab_name"];//礼物名称
    model.gold = [dic[@"grab_price"] integerValue];//礼物金额
    //中奖信息
    GiftLucky *lucky = [GiftLucky new];
    NSArray *luckyNums = @[@"0",@"10",@"20",@"500"];//这里模拟中奖倍数
    lucky.mutil = luckyNums[arc4random()%luckyNums.count];
    model.luckGiftInfos = lucky.mutil.integerValue > 0 ? @[lucky].mutableCopy : nil;
    //大礼物信息（SVGA，WEBP）
    model.isWebp = [dic[@"cid"] integerValue] == 2;//是否为大礼物
    model.webpImageUrl = dic[@"svga"];//大礼物url
    //发送方和接收方信息
    model.avatarUrl = @"https://cdn.static.orzzhibo.com/20190414/5c97a1dc43e864c629e2343e737c8595.jpeg";//送礼这头像
    model.SenderName = @"mySelf";//昵称
    model.SenderUid = MyUid;//uid
    model.toName = @"receiver";//礼物送给谁（昵称）
    model.toUid = 100;//礼物送给谁（uid）
    [self.giftManager didReceiveNewGiftWithModel:model];
}
- (void)changeCountWay{
    CGFloat spacing = 20;
    CGFloat width = 30;
    CGFloat height = 30;
    UIView *senderView = [self.view viewWithTag:101];
    UILabel *tipL = [[UILabel alloc]initWithFrame:CGRectMake(0, CGRectGetMinY(senderView.frame) - 150, kScreen_Width, 30)];
    tipL.text = @"改变弹道数量";
    tipL.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:tipL];
    UIButton *add = [UIButton buttonWithType:UIButtonTypeCustom];
    add.frame = CGRectMake(kScreen_Width / 2 - width - spacing, CGRectGetMaxY(tipL.frame) + spacing, width, height);
    add.backgroundColor = [UIColor blackColor];
    [add setTitle:@"+" forState:UIControlStateNormal];
    [self.view addSubview:add];
    [add addTarget:self action:@selector(add) forControlEvents:UIControlEventTouchUpInside];
    UIButton *minus = [UIButton buttonWithType:UIButtonTypeCustom];
    minus.frame = CGRectMake(kScreen_Width / 2 + spacing, CGRectGetMaxY(tipL.frame) + spacing, width, height);
    minus.backgroundColor = [UIColor blackColor];
    [minus setTitle:@"-" forState:UIControlStateNormal];
    [self.view addSubview:minus];
    [minus addTarget:self action:@selector(minus) forControlEvents:UIControlEventTouchUpInside];
}
- (void)add{
    if (extern_maxGiftNum < [GiftShowManager countWay]) {
        extern_maxGiftNum += 1;
    }
}
- (void)minus{
    if (extern_maxGiftNum > 1) {
        extern_maxGiftNum -= 1;
    }
}
- (void)dealloc{
    NSLog(@"释放");
    extern_maxGiftNum = [GiftShowManager countWay];
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    [self.timer invalidate];
    self.timer = nil;
}
@end
