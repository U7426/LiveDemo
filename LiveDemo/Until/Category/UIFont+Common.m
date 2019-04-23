//
//  UIFont+Common.m
//  shehui
//
//  Created by EagleLive on 2017/7/17.
//  Copyright © 2017年 happyfirst. All rights reserved.
//

#import "UIFont+Common.h"
/*
'SFUIText-Bold'
'SFUIText-Regular'
'SFUIText-Semibold'
'SFUIText-Medium'
'Condensed'
 */
@implementation UIFont (Common)
+ (UIFont *)fontWith_AmericanCondensedBold_OfSize:(CGFloat)size {
    UIFont *font = [UIFont fontWithName:@"AmericanTypewriter-CondensedBold" size:size];
    if (font == nil){
        font = [UIFont boldSystemFontOfSize:size];
    }
    return font;
}
+ (UIFont *)fontWith_Bold_OfSize:(CGFloat)size {
    UIFont *font = [UIFont fontWithName:@"PingFangSC-Bold" size:size];
    if (font == nil){
        font = [UIFont boldSystemFontOfSize:size];
    }
    return font;
}
+ (UIFont *)fontWith_Regular_OfSize:(CGFloat)size {
    UIFont *font = [UIFont fontWithName:@"PingFangSC-Regular" size:size];
    if (font == nil) {
        font = [UIFont boldSystemFontOfSize:size];
    }
    return font;
}
+ (UIFont *)fontWith_Medium_OfSize:(CGFloat)size {
    UIFont *font = [UIFont fontWithName:@"PingFangSC-Medium" size:size];
    if (font == nil) {
        font = [UIFont boldSystemFontOfSize:size];
    }
    return font;
}
+ (UIFont *)fontWith_Light_OfSize:(CGFloat)size {
    UIFont *font = [UIFont fontWithName:@"PingFangSC-Light" size:size];
    if (font == nil) {
        font = [UIFont boldSystemFontOfSize:size];
    }
    return font;
}
+ (UIFont *)fontWith_Semibold_OfSize:(CGFloat)size {
    UIFont *font = [UIFont fontWithName:@"PingFangSC-Semibold" size:size];
    if (font == nil) {
        font = [UIFont boldSystemFontOfSize:size];
    }
    return font;
}
+ (UIFont *)fontWith_DINAlternate_OfSize:(CGFloat)size{
    UIFont *font = [UIFont fontWithName:@"DINAlternate-Bold" size:size];
    if (font == nil) {
        font = [UIFont boldSystemFontOfSize:size];
    }
    return font;
}
+ (UIFont *)fontWith_DINCond_OfSize:(CGFloat)size{
    UIFont *font = [UIFont fontWithName:@"DINCond-Bold" size:size];
    if (font == nil) {
        font = [UIFont boldSystemFontOfSize:size];
    }
    return font;
}
+ (void)logFont {
    int i = 0;
    for(NSString *fontfamilyname in [UIFont familyNames])
    {
        NSLog(@"family:'%@'",fontfamilyname);
        for(NSString *fontName in [UIFont fontNamesForFamilyName:fontfamilyname])
        {
            NSLog(@"\tfont:'%@'",fontName);
        }
        NSLog(@"-------------%d",i++);
    }
}
@end
