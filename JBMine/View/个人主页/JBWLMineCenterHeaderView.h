//
//  JBWLMineCenterHeaderView.h
//  JBApp
//
//  Created by apple on 2019/3/18.
//  Copyright © 2019 apple. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "SDCycleScrollView.h"
#import "JBWLUserViewModel.h"

NS_ASSUME_NONNULL_BEGIN



@interface JBWLMineCenterHeaderView : UIView


@property (nonatomic,strong)YYLabel *contentLabel;
///展示全部简介
@property (nonatomic,copy)void (^showAllText)(void);
@property (nonatomic,strong)SDCycleScrollView *cycleScrollview;
@property (nonatomic,strong)UIImageView *userInfoImageView;

@property (nonatomic,strong)JBWLUserViewModel *userViewModel;

///隐藏全部简介
@property (nonatomic,copy)void (^hideAllText)(void);

- (CGFloat)reInitLabelFrameWithHeight:(CGFloat)height;
- (CGFloat)setContentLabelTextWithContent:(NSString *)contetString;
@end

NS_ASSUME_NONNULL_END
