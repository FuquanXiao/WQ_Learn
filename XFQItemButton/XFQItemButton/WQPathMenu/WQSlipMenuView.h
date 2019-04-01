//
//  WQSlipMenuView.h
//  XFQItemButton
//
//  Created by apple on 2019/3/3.
//  Copyright © 2019年 apple. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface WQSlipMenuView : UIScrollView

@property (nonatomic,strong)NSArray *titleArray;

@property (nonatomic,strong)UIFont *normalFont;
@property (nonatomic,strong)UIFont *selectedFont;
@property (nonatomic,strong)UIColor *normalColor;
@property (nonatomic,strong)UIColor *selectedColor;


@end
