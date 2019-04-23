//
//  GiftNumView.h
//  LiveUp
//
//  Created by EagleLive on 2017/10/19.
//  Copyright © 2017年 pajia. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface GiftNumView : UIView
- (void)setGiftNum:(NSString *)num;
- (void)setupOldNum:(NSInteger)oldNum newNum:(NSInteger)newNum completed:(void(^)(void))completed;
@end
@interface ScrollNumView : UIView

/**
 设置 滚动初始值 和 目标值,来创建需要滚动的view 并设置frame；
 
 @param fromNum 初始值
 @param toNum 目标值
 */
- (void)setUpFromNum:(NSInteger)fromNum toNum:(NSInteger)toNum animationCompletion:(void (^)(void))completion;
@end
