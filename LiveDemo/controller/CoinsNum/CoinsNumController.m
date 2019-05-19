//
//  CoinsNumController.m
//  LiveDemo
//
//  Created by 冯龙飞 on 2019/5/8.
//  Copyright © 2019 冯龙飞. All rights reserved.
//

#import "CoinsNumController.h"
#import "NumberLabel.h"
@interface CoinsNumController ()

@end

@implementation CoinsNumController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    [self initUI];
}
- (void)initUI{
    NumberLabel *label = [[NumberLabel alloc]initWithFrame:CGRectZero seconds:9.0 coins:123456789];
    [self.view addSubview:label];
    [label mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.mas_equalTo(self.view);
        make.width.mas_equalTo(200);
        make.height.mas_equalTo(30);
    }];
    [label start];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end


