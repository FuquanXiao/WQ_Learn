//
//  WQPathItemMenu.h
//  XFQItemButton
//
//  Created by apple on 2019/3/1.
//  Copyright © 2019年 apple. All rights reserved.
//

#import <UIKit/UIKit.h>
#define kWindow [[UIApplication sharedApplication] keyWindow]


@protocol  WQPathItemMenuDelegate<NSObject>
- (void)wq_pathItemMenuSelectedIndex:(NSInteger)index;
@end


@interface WQPathItemMenu : UIView

@property (assign, nonatomic) CGFloat bloomRadius;

@property (nonatomic,assign)NSTimeInterval animationDuration;
@property (nonatomic, assign) CGFloat timeOffset;
@property (nonatomic,weak)id<WQPathItemMenuDelegate> delegate;

- (instancetype)initWithCenterButtonFrame:(CGRect)frame;
- (void)showItemsButtonWithArray:(NSMutableArray *)itemArray;
- (void)expandAnimation;
@end
