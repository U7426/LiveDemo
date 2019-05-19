//
//  NumberLabel.m
//  LiveDemo
//
//  Created by 冯龙飞 on 2019/5/8.
//  Copyright © 2019 冯龙飞. All rights reserved.
//

#import "NumberLabel.h"
@interface NumberLabel()
@property (nonatomic,assign) CGFloat seconds;
@property (nonatomic,assign) NSInteger coins;
@property (nonatomic,strong) NSTimer *timer;
@end

@implementation NumberLabel
- (instancetype)initWithFrame:(CGRect)frame seconds:(CGFloat)seconds coins:(NSInteger)coins{
    self = [super initWithFrame:frame];
    if (self) {
        self.seconds = seconds;
        self.coins = coins;
    }
    return self;
}
- (void)start{
    __block NSInteger currentCount  = self.coins;
    NSTimeInterval timeinterval = 0.1;
    if (self.timer) {
        [self.timer invalidate];
        self.timer = nil;
    }
    self.timer = [NSTimer scheduledTimerWithTimeInterval:0.1 repeats:YES block:^(NSTimer * _Nonnull timer) {
        currentCount -= (self.coins / (self.seconds / timeinterval));
        if (currentCount <= 0) {
            [timer invalidate];
            timer = nil;
            currentCount = 0;
        }
        NSString *text = [NSString stringWithFormat:@"%09ld",currentCount];
        NSString *formarttext = [self changeNumberFormatter:text];
        self.text = [NSString stringWithFormat:@"%@",formarttext];
        [self setLabelSpace:self withValue:self.text withFont:[UIFont fontWithName:@"DINAlternate-Bold" size:25]];
    }];
    [[NSRunLoop mainRunLoop] addTimer:self.timer forMode:NSRunLoopCommonModes];
}
-(NSString*)changeNumberFormatter:(NSString*)str{
    NSString *numString = [NSString stringWithFormat:@"%@",str];
    NSNumberFormatter *formatter = [[NSNumberFormatter alloc]init];
    [formatter setPositiveFormat:@"###,###,###"];
    NSNumber *number = [formatter numberFromString:numString];
    formatter.numberStyle=kCFNumberFormatterNoStyle;
    formatter.minimumIntegerDigits = 9;
    formatter.paddingCharacter = @"0";
    NSString *string = [formatter stringFromNumber:number];
    return string;
}
-(void)setLabelSpace:(UILabel*)label withValue:(NSString*)str withFont:(UIFont*)font {
    NSMutableParagraphStyle *paraStyle = [[NSMutableParagraphStyle alloc] init];
    paraStyle.lineBreakMode = NSLineBreakByCharWrapping;
    paraStyle.alignment = NSTextAlignmentCenter;
    paraStyle.hyphenationFactor = 1.0;
    paraStyle.firstLineHeadIndent = 0.0;
    paraStyle.paragraphSpacingBefore = 0.0;
    paraStyle.headIndent = 0;
    paraStyle.tailIndent = 0;
    //设置字间距 
    NSDictionary *dic = @{NSFontAttributeName:font, NSParagraphStyleAttributeName:paraStyle, NSKernAttributeName:@4.0f
                          };
    NSAttributedString *attributeStr = [[NSAttributedString alloc] initWithString:str attributes:dic];
    label.attributedText = attributeStr;
}
- (void)drawTextInRect:(CGRect)rect{
    CGContextRef c = UIGraphicsGetCurrentContext();
    // 设置描边宽度
    CGContextSetLineWidth(c, 1);
    CGContextSetLineJoin(c, kCGLineJoinRound);
    CGContextSetTextDrawingMode(c, kCGTextStroke);
    // 描边颜色
    self.textColor = RGB(0xEC5614);
    [super drawTextInRect:rect];
    // 文本颜色
    self.textColor = RGB(0xFAEFD7);
    CGContextSetTextDrawingMode(c, kCGTextFill);
    [super drawTextInRect:rect];
}

@end
