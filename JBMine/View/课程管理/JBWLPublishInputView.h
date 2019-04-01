//
//  JBWLPublishInputView.h
//  JBApp
//
//  Created by apple on 2019/3/25.
//  Copyright © 2019 apple. All rights reserved.
//
typedef NS_ENUM(NSInteger ,JBInputItemViewItemType) {
    JBInputItemViewItemTypeNormal,
    JBInputItemViewItemTypeText,
};

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface JBWLPublishInputView : UIView
@property (nonatomic,strong)NSString *title;
@property (nonatomic,assign)JBInputItemViewItemType type;
@property (nonatomic,strong)NSString *placeHolder;
@property (nonatomic,strong)UITextField * textView;
@property (nonatomic,strong)UIFont *titleFont;
@property (nonatomic,strong)UIFont *textViewFont;
@property (nonatomic,strong)UIColor *textViewColor;
@property (nonatomic,strong)UIColor *titleColor;


@property (nonatomic,strong)UIButton *proButtton;
@property (nonatomic,assign)CGFloat labelWidth;
@property (nonatomic,assign)CGFloat labelInputSpace;
@property (nonatomic,assign)CGFloat textBgViewWidth;
@property (nonatomic,assign)CGFloat textBgViewHeight;

- (instancetype)initWithFrame:(CGRect)frame andTitle:(NSString *)title placeHoler:(NSString *)placeHolder andType:(JBInputItemViewItemType)type;

- (void)showItemView;
@end

NS_ASSUME_NONNULL_END
