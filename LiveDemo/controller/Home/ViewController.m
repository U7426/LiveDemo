//
//  ViewController.m
//  LiveDemo
//
//  Created by 冯龙飞 on 2019/4/23.
//  Copyright © 2019 冯龙飞. All rights reserved.
//

#import "ViewController.h"
#import "SwitchLiveViewController.h"
#import "GiftViewController.h"
#import "CoinsNumController.h"
NSString *switchSting = @"切换视图";
NSString *giftString = @"礼物";
NSString *coinsNumberString = @"金币跳动";
@interface ViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic,strong) NSArray *datas;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationController.view.backgroundColor = [UIColor whiteColor];
    self.datas = @[switchSting,giftString,coinsNumberString];
    // Do any additional setup after loading the view.
}
#pragma mark - delegate && dataScource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.datas.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *identifier = @"cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (!cell) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    }
    cell.textLabel.text = self.datas[indexPath.row];
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    NSString *name = self.datas[indexPath.row];
    if ([name isEqualToString:switchSting]) {
        SwitchLiveViewController *switchVC = [SwitchLiveViewController new];
        switchVC.title = name;
        [self.navigationController pushViewController:switchVC animated:YES];
    }
    else if ([name isEqualToString:giftString]){
        GiftViewController *giftVC = [GiftViewController alloc];
        giftVC.title = name;
        [self.navigationController pushViewController:giftVC animated:YES];
    }
    else if ([name isEqualToString:coinsNumberString]){
        CoinsNumController *coinsVC = [CoinsNumController alloc];
        coinsVC.title = name;
        [self.navigationController pushViewController:coinsVC animated:YES];
    }
}
@end
