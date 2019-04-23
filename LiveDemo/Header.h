//
//  Header.h
//  LiveDemo
//
//  Created by 冯龙飞 on 2019/4/23.
//  Copyright © 2019 冯龙飞. All rights reserved.
//

#ifndef Header_h
#define Header_h
//第三方库
#import <SDWebImage/UIImageView+WebCache.h>//必须
#import <FDFullscreenPopGesture/UINavigationController+FDFullscreenPopGesture.h>//非必须
#import <Masonry.h>//必须
//自定义头文件
#import "GiftShowManager.h"
#import "UILabel+Common.h"
#import "UIView+Frame.h"
#import "UIFont+Common.h"

//工具
#define kScale = [[UIScreen mainScreen] scale]
#define kScreen_Width [UIScreen mainScreen].bounds.size.width
#define kScreen_Height [UIScreen mainScreen].bounds.size.height
#define kView_Width self.frame.size.width
#define kView_Hight self.frame.size.height
#define kKeyWindow [UIApplication sharedApplication].keyWindow
#define kDefault_User_Image [UIImage imageNamed:@"default_bg_user_avatar"]
#define RGB(rgbValue) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]
#define RGBA(rgbValue,a) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:(a)]
#define kNOTIFITION_GIFT_LUCKYMESSAGE @"kNOTIFITION_GIFT_LUCKYMESSAGE"//自己中奖通知message
#define kNOTIFICATION_GREATER_500Times_Lucky @"kNOTIFICATION_GREATER_500Times_Lucky"//自己中得大奖通知（>=500倍）
//需要在项目中替换的
#define MyUid 1000000//自己的uid
#define kGiftNumPadding 15.0//礼物数字之间的间距
#endif /* Header_h */
