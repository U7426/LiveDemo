//
//  UIFont+Common.h
//  shehui
//
//  Created by EagleLive on 2017/7/17.
//  Copyright © 2017年 happyfirst. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIFont (Common)
/*
 字体: PingFangSC-Bold
 **/
+ (UIFont *)fontWith_Bold_OfSize:(CGFloat)size;
/*
 字体: PingFangSC-Regular
 **/
+ (UIFont *)fontWith_Regular_OfSize:(CGFloat)size;
+ (UIFont *)fontWith_Light_OfSize:(CGFloat)size;
/*
 字体: PingFangSC-Medium
 **/
+ (UIFont *)fontWith_Medium_OfSize:(CGFloat)size;
+ (UIFont *)fontWith_Semibold_OfSize:(CGFloat)size;
+ (UIFont *)fontWith_AmericanCondensedBold_OfSize:(CGFloat)size;

/*
 字体: DINAlternate-Bold
 字体: DINCond-Bold
 **/
+ (UIFont *)fontWith_DINAlternate_OfSize:(CGFloat)size;
+ (UIFont *)fontWith_DINCond_OfSize:(CGFloat)size;


+ (void)logFont;
@end
