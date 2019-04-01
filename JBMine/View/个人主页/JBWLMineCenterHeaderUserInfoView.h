//
//  JBWLMineCenterHeaderUserInfoView.h
//  JBApp
//
//  Created by apple on 2019/3/19.
//  Copyright © 2019 apple. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface JBWLMineCenterHeaderUserInfoView : UIView
@property (nonatomic,strong)UIImageView * iconImageView;
@property (nonatomic,strong)UILabel *nameLabel;
@property (nonatomic,strong)UIImageView *nameIconImageView;
@property (nonatomic,strong)UIImageView *sexIconImageView;
@property (nonatomic,strong)UILabel *activeLabel;
@property (nonatomic,strong)UIView *lineView;
@property (nonatomic,strong)UILabel *tagViewLabel;
@property (nonatomic,strong)UIButton *modifyButton;
@end

NS_ASSUME_NONNULL_END
