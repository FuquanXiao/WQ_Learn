//
//  JBWLPublishClassInfoView.h
//  JBApp
//
//  Created by apple on 2019/3/24.
//  Copyright © 2019 apple. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "JBSkillTagModel.h"
#import "JBWLUserCourseModel.h"
#import "JBWLPublishInputView.h"

typedef NS_ENUM(NSInteger,PublishClassType) {
    PublishClassOnLine = 1,///线上
    PublishClassOffLine///线上
};

NS_ASSUME_NONNULL_BEGIN

@interface JBWLPublishClassInfoView : UIView
@property (nonatomic,assign)PublishClassType classType;

@property (nonatomic,strong)NSMutableArray *skillTagModelArray;
@property (nonatomic,strong)JBWLUserCourseModel *courseModel;

@property (nonatomic,strong)UIView *lineViewOne;
@property (nonatomic,strong)UIView *lineViewTimeLengthViewBottom;
@property (nonatomic,strong)UIView *lineViewTwo;
@property (nonatomic,strong)UIView *lineViewThree;
@property (nonatomic,strong)UIView *lineViewFourth;
@property (nonatomic,strong)UIView *lineViewFive;
@property (nonatomic,strong)UIView *lineViewSix;
@property (nonatomic,strong)JBWLPublishInputView *addressItemView;

@property (nonatomic,strong)UIView *peopleCountView;
@property (nonatomic,strong)UIView *feeView;
@property (nonatomic,strong)UIView *tagsView;
@property (nonatomic,strong)UIView * addressView;

@property (nonatomic,strong)UIButton *onLineChooseButton;
@property (nonatomic,strong)UIButton *offLineChooseButton;

@property (nonatomic,strong)UILabel *classTypeLabel;

@property (nonatomic,strong)JBWLPublishInputView *feeItemView;
@property (nonatomic,strong)UIButton * gotoHomeButton;
@property (nonatomic,strong)UIButton *  aggreeButton;
@property (nonatomic,strong)UIButton *  regularButton;

@property (nonatomic,strong)UITextField *minTextField;
@property (nonatomic,strong)UITextField *maxTextField;
@property (nonatomic,strong)UILabel *lineLable;
@property (nonatomic,strong)UIButton *onePeopleButton;
@property (nonatomic,strong)UIButton *moreOnePeopleButton;

@property (nonatomic,strong)UIButton *chooseTagButton;

@property (nonatomic,strong)UILabel *showTagLabel;

@property (nonatomic,strong)NSString *tagLabelName;

@property (nonatomic,strong)UIView *classLengthView;

////存放时间长度的按钮 1小时，1.5小时；
@property (nonatomic,strong)NSMutableArray *timeLengthButtonArray;

@property (nonatomic,strong)NSArray *classTimeArray;

@property (nonatomic,strong)NSString *timeLengthString;

//// 存放tag的标签数组
@property (nonatomic,strong)NSMutableArray *tagButtonArray;


- (CGFloat)getViewHeight;
@end

NS_ASSUME_NONNULL_END
