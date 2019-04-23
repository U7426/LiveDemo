//
//  LuckView.h
//  LiveUp
//
//  Created by EagleLive on 2017/10/26.
//  Copyright © 2017年 pajia. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GiftShowModel.h"
@interface GiftLuckyView : UIView
- (void)receiveModel:(GiftShowModel *)model;
- (void)clearCumulation;
@end
