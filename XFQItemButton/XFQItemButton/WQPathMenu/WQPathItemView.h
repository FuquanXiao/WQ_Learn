//
//  WQPathItemView.h
//  XFQItemButton
//
//  Created by apple on 2019/3/1.
//  Copyright © 2019年 apple. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface WQPathItemView : UIView
@property (nonatomic) CGPoint startPoint;
@property (nonatomic) CGPoint endPoint;
@property (nonatomic) CGPoint nearPoint;
@property (nonatomic) CGPoint farPoint;

@property (nonatomic,strong)UIImageView *contentImageView;
@property (nonatomic,strong)UILabel *contLabel;
@end
