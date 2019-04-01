//
//  JBWLMineCenterSectionView.h
//  JBApp
//
//  Created by apple on 2019/3/19.
//  Copyright © 2019 apple. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface JBWLMineCenterSectionView : UIView
@property (nonatomic,strong)UILabel *sectionTitleLabel;
@property (nonatomic,strong)UIButton *nextButton;
- (instancetype)initWithFrame:(CGRect)frame showTopCornor:(BOOL)showCornor;
@end

NS_ASSUME_NONNULL_END
