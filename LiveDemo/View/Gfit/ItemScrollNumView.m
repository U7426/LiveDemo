//
//  ItemScrollNumView.m
//  Remark_QYLive
//
//  Created by 冯龙飞 on 2019/4/15.
//  Copyright © 2019 孟博. All rights reserved.
//

#import "ItemScrollNumView.h"
@interface ItemScrollNumView()
@property (nonatomic,strong) NSString *imagePrefix;
@end
@implementation ItemScrollNumView

- (instancetype)initWithFrame:(CGRect)frame image:(NSString *)imagePrefix{
    self = [super initWithFrame:frame];
    if (self) {
        self.imagePrefix = imagePrefix;
        [self addNumView];
    }
    return self;
}
- (void)addNumView {
    CGFloat width = self.width;
    CGFloat height = self.height;
    for (int i = 0; i < 19; i++) {
        UIImageView *imageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, (i * height), width, height)];
        int num = i;
        if (num > 9) {
            num -= 10;
        }
        imageView.image = [UIImage imageNamed:[NSString stringWithFormat:@"%@%d.png",self.imagePrefix,num]];
        [self addSubview:imageView];
    }
}

@end
