//
//  UILabel+Common.m
//  LiveDemo
//
//  Created by 冯龙飞 on 2019/4/23.
//  Copyright © 2019 冯龙飞. All rights reserved.
//

#import "UILabel+Common.h"

@implementation UILabel (Common)
- (void)setGiftNum:(NSString *)num {
    if (!(num.length > 0)) {
        NSAssert(num.length > 0, @"礼物数量不大于0表示 服务器 或者自己 处理礼物数量有问题");
        return;
    }
    NSMutableAttributedString *strAtt = [[NSMutableAttributedString alloc] initWithString:@"" attributes:@{NSFontAttributeName : [UIFont boldSystemFontOfSize:25]}];
    for (int i = 0; i < num.length; i++) {
        UIImage *image = [UIImage imageNamed:[NSString stringWithFormat:@"Ani-%@",[num substringWithRange:NSMakeRange(i, 1)]]];
        NSTextAttachment *attatch = [[NSTextAttachment alloc] initWithData:nil ofType:nil];
        attatch.bounds = CGRectMake(i * - kGiftNumPadding, 0, image.size.width, image.size.height);
        attatch.image = image;
        NSAttributedString *string = [NSAttributedString attributedStringWithAttachment:attatch];
        [strAtt appendAttributedString:string];
    }
    self.attributedText = strAtt;
}
- (void)setLuckyTimes:(NSString *)num{
    if (!(num.length > 0)) {
        NSAssert(num.length > 0, @"礼物数量不大于0表示 服务器 或者自己 处理礼物数量有问题");
        return;
    }
    NSMutableAttributedString *strAtt = [[NSMutableAttributedString alloc] initWithString:@""];
    for (int i = 0; i < num.length; i++) {
        UIImage *image = [UIImage imageNamed:[NSString stringWithFormat:@"%@times",[num substringWithRange:NSMakeRange(i, 1)]]];
        NSTextAttachment *attatch = [[NSTextAttachment alloc] initWithData:nil ofType:nil];
        attatch.bounds = CGRectMake(0, 0, image.size.width, image.size.height);
        attatch.image = image;
        NSAttributedString *string = [NSAttributedString attributedStringWithAttachment:attatch];
        [strAtt appendAttributedString:string];
    }
    self.attributedText = strAtt;
}
@end
