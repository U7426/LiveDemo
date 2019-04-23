//
//  SwitchLiveView.h
//  Remark_QYLive
//
//  Created by 冯龙飞 on 2018/11/9.
//  Copyright © 2018年 孟博. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LiveInfo.h"
@interface SwitchLiveView : UIScrollView

/**
 初始化

 @param views 贴在此视图上的子视图数组（addsubview 顺序跟 元素顺序相同）
 @param lives 直播列表
 @param info 当前直播信息
 @param block 切换回调⚠️block内需要弱引用（oldinifo,newinfo 与KVO类似，切换成功后的旧值和新值）
 @return self
 */
- (instancetype)initWithMainView:(NSArray<UIView *>*)views
                           Lives:(NSArray *)lives
                        liveInfo:(LiveInfo *)info
               liveInfoDidChange:(void(^)(LiveInfo *oldInfo,LiveInfo *newInfo))block;
@end
