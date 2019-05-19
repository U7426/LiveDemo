//
//  NumberLabel.h
//  LiveDemo
//
//  Created by 冯龙飞 on 2019/5/8.
//  Copyright © 2019 冯龙飞. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface NumberLabel : UILabel
- (instancetype)initWithFrame:(CGRect)frame seconds:(CGFloat)seconds coins:(NSInteger)coins;
- (void)start;
@end

NS_ASSUME_NONNULL_END
