//
//  JBWLMineCenterHeaderView.m
//  JBApp
//
//  Created by apple on 2019/3/18.
//  Copyright © 2019 apple. All rights reserved.
//

#import "JBWLMineCenterHeaderView.h"
#import "JBWLMineCenterHeaderUserInfoView.h"

@interface JBWLMineCenterHeaderView()
@property (nonatomic,strong)UIImageView *packUpImageview;
@property (nonatomic,strong)JBWLMineCenterHeaderUserInfoView *userInfoView;
@end


@implementation JBWLMineCenterHeaderView

- (instancetype) initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame: frame]) {
        self.backgroundColor = colorF3F3F3;
        [self _creteUI];
       
    }
    return self;
}


- (void)setUserViewModel:(JBWLUserViewModel *)userViewModel{
    _userViewModel = userViewModel;
    ///头像
    [self.userInfoView.iconImageView sd_setImageWithURL:[NSURL URLWithString:[NSString getSuitableImageWith:SafeValue(userViewModel.userModel.headPic) showImageType:ShowImageTypeSmall]] placeholderImage:[UIImage imageWithColor:colorE7E7E7]];
    ///昵称
    self.userInfoView.nameLabel.text = SafeValue(userViewModel.userModel.nickName);

    self.userInfoView.nameIconImageView.image = [UIImage imageNamed:@"MineCenter_名片"];
    self.userInfoView.nameIconImageView.hidden = ([SafeValue(_userViewModel.userModel.userLevel) integerValue] < 2);
    
    self.userInfoView.sexIconImageView.image = [UIImage imageNamed:SafeValue(_userViewModel.userIdentifyImageName)];
    self.userInfoView.tagViewLabel.text = [NSString stringWithFormat:@"活跃值:%@",SafeValue(_userViewModel.userModel.activeValue)];
    
    self.userInfoView.activeLabel.text = [NSString stringWithFormat:@"满意度%@%@",@"100",@"%"];
    if (SafeValue(_userViewModel.userModel.csi).length > 0) {
        self.userInfoView.activeLabel.text = [NSString stringWithFormat:@"满意度%@%@",SafeValue(_userViewModel.userModel.csi),@"%"];
    }
    
    switch (_userViewModel.friendShipType) {
        case UserFriendShipSelf:
        {
          [self.userInfoView.modifyButton setTitle:@"修改资料" forState:UIControlStateNormal];
        }
            break;
        case UserFriendShipAddFriend:
        {
            [self.userInfoView.modifyButton setTitle:@"快速联系" forState:UIControlStateNormal];
        }
            break;
        case UserFriendShipWating:
        {
            self.userInfoView.modifyButton.hidden = YES;
        }
            break;
        case UserFriendShipChatAtNow:
        {
           [self.userInfoView.modifyButton setTitle:@"添加好友" forState:UIControlStateNormal];
        }
            break;
        default:
            break;
    }
    
    
}


- (void)_creteUI{
    [self _createBanner];
    [self _createUserInfo];
    [self _createLabel];
    [self _createHideView];
}


- (void)_createHideView{
    
    UIImageView *packUpImageview = [[UIImageView alloc] init];
    packUpImageview.userInteractionEnabled = YES;
    [self addSubview:packUpImageview];
    self.packUpImageview = packUpImageview;
    packUpImageview.hidden = YES;
    
    [packUpImageview mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.mas_equalTo(self);
        make.centerX.mas_equalTo(self);
        make.height.mas_equalTo(kSpaceH(24));
        make.width.mas_equalTo(kScreenWidth - 60);
    }];
    packUpImageview.image = [UIImage imageNamed:@"JBWL_MineCenter_showAllUp"];
    packUpImageview.contentMode = UIViewContentModeCenter;
    UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithActionBlock:^(id  _Nonnull sender) {
        if (self.hideAllText) {
            self.hideAllText();
        }
        packUpImageview.hidden = YES;
    }];
    [packUpImageview addGestureRecognizer:tapGesture];
    
}

#pragma mark
#pragma mark-------老师介绍文本 -------
- (void)_createLabel{
    YYLabel *label = [YYLabel new];
    label.backgroundColor = [UIColor whiteColor];
    label.userInteractionEnabled = YES;
    self.contentLabel = label;
    label.textColor = color666666;
    [self.userInfoImageView addSubview:self.contentLabel];
}

#pragma mark
#pragma mark-------老师基本信息 -------
- (void)_createUserInfo{
    
    UIImageView *userInfoImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, kSpaceH(185), kScreenWidth, kSpaceH(107))];
    userInfoImageView.backgroundColor = [UIColor whiteColor];
    [self addSubview:userInfoImageView];
    self.userInfoImageView = userInfoImageView;
    userInfoImageView.layer.cornerRadius = kSpaceH(20);
    userInfoImageView.clipsToBounds = YES;
    userInfoImageView.userInteractionEnabled = YES;
    
    
    JBWLMineCenterHeaderUserInfoView *userInfoView = [[JBWLMineCenterHeaderUserInfoView alloc] init];
    userInfoView.backgroundColor = [UIColor whiteColor];
    [userInfoImageView addSubview:userInfoView];
    self.userInfoView = userInfoView;
    [userInfoView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(userInfoImageView).mas_offset(kSpaceH(25));
        make.height.mas_equalTo(kSpaceH(60));
        make.left.and.width.mas_equalTo(self);
    }];
    
}

#pragma mark
#pragma mark-------bannner -------
- (void)_createBanner{
    SDCycleScrollView *cycleScrollview = [SDCycleScrollView cycleScrollViewWithFrame:CGRectMake(0, 0, kScreenWidth, kSpaceH(225)) imageNamesGroup:nil];
    self.cycleScrollview = cycleScrollview;
    self.cycleScrollview.bannerImageViewContentMode = UIViewContentModeScaleAspectFill;
    self.cycleScrollview.localizationImageNamesGroup = @[[UIImage imageNamed:@"MineCenter_PhotoWall_默认"]];
    [self addSubview:cycleScrollview];
    
}



- (CGFloat)setContentLabelTextWithContent:(NSString *)contetString{
    
    NSMutableAttributedString *att = [[NSMutableAttributedString alloc] initWithString:contetString];
    
    NSMutableParagraphStyle *paragraph = [[NSMutableParagraphStyle alloc] init];
    paragraph.lineSpacing = kSpaceH(10);
    [att addAttributes:@{NSParagraphStyleAttributeName:paragraph,NSFontAttributeName:font12,NSForegroundColorAttributeName:color666666} range:NSMakeRange(0, contetString.length)];
    

    UIImage *image = [UIImage imageNamed:@"JBWL_MineCenter_showAllDown"];
    NSString *moreString = @"   全部展开";
    
    NSMutableAttributedString *expandText = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"...  %@", moreString]];
    NSRange xpandRange = [expandText.string rangeOfString:moreString];

    [expandText addAttributes:@{NSFontAttributeName:font11,NSForegroundColorAttributeName:color00CCBB} range:xpandRange];
    

    
    YYTextHighlight *textHeight = [YYTextHighlight  new];
    
    [expandText setTextHighlight:textHeight range:xpandRange];
    
    textHeight.tapAction = ^(UIView * _Nonnull containerView, NSAttributedString * _Nonnull text, NSRange range, CGRect rect) {
         self.contentLabel.numberOfLines = 0;
        [self.contentLabel sizeToFit];
        self.packUpImageview.hidden = NO;
        if (self.showAllText) {
            self.showAllText();
        }
    };
    
    
    NSAttributedString *imageAttri = [NSAttributedString attachmentStringWithContent:image contentMode:UIViewContentModeCenter attachmentSize:CGSizeMake(20, 10) alignToFont:font11 alignment:YYTextVerticalAlignmentCenter];
    [expandText appendAttributedString:imageAttri];
    
    
    YYLabel *seeMore = [YYLabel new];
    seeMore.attributedText = expandText;
    [seeMore sizeToFit];
    
    UIFont *alignFont = font11;
     NSAttributedString *truncationToken = [NSAttributedString attachmentStringWithContent:seeMore contentMode:UIViewContentModeCenter attachmentSize:seeMore.frame.size alignToFont:alignFont alignment:YYTextVerticalAlignmentCenter];
    

    self.contentLabel.truncationToken = truncationToken;
    self.contentLabel.attributedText = att;

    
    YYTextLayout *layout = [YYTextLayout layoutWithContainerSize:CGSizeMake(kSpaceH(275), MAXFLOAT) text:att];
    return layout.textBoundingSize.height;
    
}


- (CGFloat)reInitLabelFrameWithHeight:(CGFloat)height{
    if (height>kSpaceH(64)) {
         self.contentLabel.frame = CGRectMake(kSpaceH(84), kSpaceH(107), kSpaceH(275), kSpaceH(64));
        
        self.contentLabel.numberOfLines = 3;
        [self.contentLabel sizeToFit];
        
        return kSpaceH(64);
    }
    else{
        self.contentLabel.frame = CGRectMake(kSpaceH(84), kSpaceH(107), kSpaceH(275), height);
        return height;
    }
}






@end
