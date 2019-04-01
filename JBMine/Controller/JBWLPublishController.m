//
//  JBWLPublishController.m
//  JBApp
//
//  Created by apple on 2019/3/22.
//  Copyright © 2019 apple. All rights reserved.
//添加课程

#import "JBWLPublishController.h"
#import "XFQNavigationView.h"
#import "JBTeachingPostToobarView.h"
#import "WQDisplayView.h"
#import "HomeVideoView.h"
#import "JBRecordView.h"
#import "JBWLPublishClassInfoView.h"
#import "IQKeyboardManager.h"
#import "WQVoicePalyer.h"

#import "ZLPhotoActionSheet.h"
#import "ZLDefine.h"
#import <Photos/Photos.h>
#import "ZLPhotoModel.h"
#import "ZLPhotoManager.h"
#import "ZLProgressHUD.h"
#import "ZLPhotoConfiguration.h"


#import "JBWLUserCourseModel.h"


@interface JBWLPublishController ()<UITextViewDelegate,JBTeachingPostToobarViewDelegate,WQDisplayViewDelegate,HomeVideoViewDelegate,JBRecordViewDelegate,YYTextViewDelegate>
@property (nonatomic,strong)UIScrollView *bgScrollview;

@property (nonatomic,strong)WQTextView *titleTextView;

@property (nonatomic,strong)YYTextView *contentTextView;

@property (nonatomic,strong)UIImageView *contentImageView;
@property (nonatomic,strong)JBTeachingPostToobarView *toobarView;

///当前选择的是音频 语音 图片中的哪一个
@property (nonatomic,assign)NSInteger videoPicSelectedIndex;
///展示语音 图片 音频的背景
@property (nonatomic,strong)UIView *variousBgView;
///展示图片的控件
@property (nonatomic,strong)WQDisplayView *picListView;
///展示音频的控件；
@property (nonatomic,strong)UIImageView *medaiView;
///展示语音的控件；
@property (nonatomic,strong)HomeVideoView *voiceView;
/// 语音，音频 图片的删除按钮；
@property (nonatomic,strong)UIButton *deleteButton;
///展示图片的数组
@property (nonatomic,strong)NSMutableArray *picArray;
@property (nonatomic,strong)NSMutableArray *picKeysArray;
///录音界面是否正在展示；
@property (nonatomic,assign)BOOL recordViewIsShowing;
///本地录音文件
@property (nonatomic,strong)NSString *localMp3Path;
///本地视频文件
@property (nonatomic,strong)NSString *videoPath;
///本地录音mp3文件
@property (nonatomic,strong)NSString *mp3Path;
///视频文件的背景图片path路径
@property (nonatomic,strong)NSString *videoBackImagePath ;

@property (nonatomic,strong)UIView *contentTextViewBottomLine;
///音频录音键盘
@property (nonatomic,strong)JBRecordView *recordView;

//上传视频文件
@property (nonatomic,strong)PHAsset *myAsset ;
@property (nonatomic,strong)UIImage *myAssetImage ;

@property (nonatomic,strong)ZLPhotoActionSheet *actionSheet;

/// 判断是不是在录音
@property (nonatomic,assign)BOOL isRecoding;
@property (nonatomic,strong)NSString *voiceTime;

///记录录音是不是正在播放
@property (nonatomic,assign)BOOL recordIsPlaying;

@property (nonatomic,strong)JBWLUserCourseModel *courseModel;

@property (nonatomic,strong)JBWLPublishClassInfoView * classInfoView;
@end

@implementation JBWLPublishController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self _setNav];
    [self _createUI];
    _courseModel = [[JBWLUserCourseModel alloc] init];
}

- (void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    [self.view addSubview:self.recordView];
    [self.recordView bringSubviewToFront:_bgScrollview];
}
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [IQKeyboardManager sharedManager].enableAutoToolbar = NO;
}

- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    [IQKeyboardManager sharedManager].enableAutoToolbar = YES;
}

- (void)gotoBack{
    
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark
#pragma mark-------确认发布 -------
- (void)nextButtonAction:(UIButton *)btn{
    
    _courseModel.title = self.titleTextView.text;
    _courseModel.content = self.contentTextView.text;
    
    if (self.videoPicSelectedIndex == -1) {
        _courseModel.mediaType = @"1";
        _courseModel.mediaUrl = @"";
    }
    if (self.videoPicSelectedIndex == 0) {
        _courseModel.mediaType = @"2";
        _courseModel.mediaUrl = [self.picKeysArray componentsJoinedByString:@","];
    }
    if (self.videoPicSelectedIndex == 1) {
        _courseModel.mediaType = @"3";
        _courseModel.mediaUrl = self.videoPath;
        _courseModel.videoBg = self.videoBackImagePath;
        _courseModel.audioLen = self.voiceTime;
    }
    if (self.videoPicSelectedIndex == 2) {
        _courseModel.mediaType = @"4";
        _courseModel.mediaUrl = self.mp3Path;

    }
    ///授课类型（在线辅导）：1微信 2电话
    _courseModel.teachType = @"";
    ///联系号码
    _courseModel.connectNum = @"";
    
    _courseModel.address = self.classInfoView.addressItemView.textView.text;
    _courseModel.priceYuan = self.classInfoView.feeItemView.textView.text;
    _courseModel.minNum = self.classInfoView.minTextField.text;
    _courseModel.maxNum = self.classInfoView.maxTextField.text;
    
}

#pragma mark
#pragma mark-------textview -------

- (BOOL)textViewShouldBeginEditing:(UITextView *)textView{
    if (self.recordViewIsShowing) {
        self.recordViewIsShowing = NO;
    }
    return YES;
}

- (void)textViewDidChange:(UITextView *)textView{
    
    if (textView == self.titleTextView) {
        if (textView.text.length > 30) {
            UITextRange *markedRange = [textView markedTextRange];
            if (markedRange) {
                return;
            }
            NSRange range = [textView.text rangeOfComposedCharacterSequenceAtIndex:30];
            textView.text = [textView.text substringToIndex:range.location];
            
            [self showHudMessage:@"标题最多三十个字" hidenAfterDelay:1];
            
        }
    }
}


#pragma mark
#pragma mark------- 上传视频 -------

- (void)uploadMedia{
    [XFQ_QNUpload uploadMediaWithPHAsset:_myAsset success:^(QNResponseInfo *info, NSString *key) {
        if (info.statusCode == 200) {
            self.videoPath = [NSString stringWithFormat:@"%@%@",@"https://img.jbwl66.com/",key];
            
            [XFQ_QNUpload uploadImage:_myAssetImage progress:^(NSString *key, float percent) {} success:^(QNResponseInfo *info, NSString *key) {
               
                dispatch_async(dispatch_get_main_queue(), ^{
                    self.videoBackImagePath = [NSString stringWithFormat:@"%@%@",@"https://img.jbwl66.com/",key];
                    [self _reSetVariousUIFrame];
                });
            } failure:^(NSString *error) {
                dispatch_async(dispatch_get_main_queue(), ^{
                    [self showHudMessage:@"视频上传失败" hidenAfterDelay:1];
                });
               
            }];
        }
    } failure:^(NSString *error) {
        dispatch_async(dispatch_get_main_queue(), ^{
            [self showHudMessage:@"视频上传失败" hidenAfterDelay:1];
        });
    }];
}

#pragma mark
#pragma mark------- 上传图片 -------

- (void)uploadImageToQiNiuYunWithImageIndex:(NSInteger)index{
    
    if (index == self.picArray.count) {
        [self _reSetVariousUIFrame];
        [self.picArray removeAllObjects];
        return;
    }

    UIImage *willUploadImage = self.picArray[index];
    NSData *imageData  = UIImagePNGRepresentation(willUploadImage);
    [XFQ_QNUpload uploadImageToQNImageData:imageData index:index imageSize:willUploadImage.size success:^(QNResponseInfo *info, NSString *key) {
        if (info.statusCode == 200) {
            [self.picKeysArray addObject:[NSString stringWithFormat:@"%@%@",@"https://img.jbwl66.com/",key]];
        }
        [self uploadImageToQiNiuYunWithImageIndex:(index +1)];
        
    } failure:^(NSString *error) {
        [self uploadImageToQiNiuYunWithImageIndex:(index +1)];
    }];
}

- (void)uploadImageToQiNiu{
    
    [self uploadImageToQiNiuYunWithImageIndex:0];
    
    dispatch_async(dispatch_get_main_queue(), ^{
        
        
    });
}


#pragma mark
#pragma mark-------选择多媒体 -------

- (void)gotoAlbumToSelectedImageView{
    if ([self.picArray containsObject:self.picListView.placeHolerimage]) {
        [self.picArray removeObject:self.picListView.placeHolerimage];
    }
    if (self.picArray.count == 3) {
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:nil message:@"最多只能选三张，您已经选择三张图片" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
        [alertView show];
    }
    else{
        [self gotoAlbumWithMaxCount:(3 - self.picArray.count)];
    }
}


- (void)gotoAlbumWithMaxCount:(NSInteger)count{
    
    self.actionSheet.sender = self;
    
    if (self.videoPicSelectedIndex == 0) {
        //    是否允许选择图片
        self.actionSheet.configuration.allowSelectImage = YES;
        /// 设置最大选择数
        self.actionSheet.configuration.maxSelectCount = count;
        self.actionSheet.configuration.allowSelectVideo = NO;//
        
    }
    if (self.videoPicSelectedIndex == 2) {
        /// 是否选择视频
        self.actionSheet.configuration.allowSelectVideo = YES;//
        self.actionSheet.configuration.allowRecordVideo = YES;
        self.actionSheet.configuration.maxRecordDuration = 15;
        self.actionSheet.configuration.maxVideoDuration = 5*60;
        self.actionSheet.configuration.maxVideoXfqSize = 40;
        
        self.actionSheet.configuration.allowSelectImage = NO;
        self.actionSheet.configuration.maxSelectCount = count;
    }
    
    [self.actionSheet showPhotoLibrary];
    __weak typeof(self) weakSelf = self;
    [self.actionSheet setSelectImageBlock:^(NSArray<UIImage *> * _Nonnull images, NSArray<PHAsset *> * _Nonnull assets, BOOL isOriginal) {
        
        if (weakSelf.videoPicSelectedIndex == 0) {
            for (UIImage *image in images) {
                [weakSelf.picArray addObject:image];
            }
            [weakSelf uploadImageToQiNiu];
            
        }
        if (weakSelf.videoPicSelectedIndex == 2) {
            for (PHAsset *assetbbbb in assets) {
                PHVideoRequestOptions *options = [[PHVideoRequestOptions alloc] init];
                options.version = PHVideoRequestOptionsVersionOriginal;
                
                [[PHImageManager defaultManager] requestAVAssetForVideo:assetbbbb options:options resultHandler:^(AVAsset * _Nullable asset, AVAudioMix * _Nullable audioMix, NSDictionary * _Nullable info) {
                    AVURLAsset *urlAsset = (AVURLAsset *)asset;
                    NSURL *url = urlAsset.URL;
                    weakSelf.myAsset = assetbbbb;
                    weakSelf.videoPath = url.absoluteString;
                    weakSelf.myAssetImage = [images firstObject];
                     [weakSelf uploadMedia];
                    
                }];
            }
        }
    }];
    self.actionSheet.cancleBlock = ^{
        weakSelf.toobarView.videoButton.selected = NO;
        weakSelf.toobarView.vioceButton.selected = NO;
        weakSelf.toobarView.picButton.selected = NO;
    };
}


#pragma mark
#pragma mark------- 删除录音  视频-------
- (void)deleteVoiceAction:(UIButton *)btn{
    [self.voiceView removeFromSuperview];
    [self.deleteButton removeFromSuperview];
    self.mp3Path = @"";
    self.voiceTime = @"";
    self.toobarView.vioceButton.selected =
    self.toobarView.videoButton.selected =
    self.toobarView.picButton.selected = NO;
    self.videoPicSelectedIndex = -1;
    [[WQVoicePalyer sharedVoicePlayer ] releasePlayer];
    self.recordIsPlaying = NO;
}


- (void)deleteMediaAction:(UIButton *)btn{
    [self.medaiView removeFromSuperview];
    self.videoPath = @"";
    self.videoBackImagePath = @"";
    self.videoPicSelectedIndex = -1;
    self.toobarView.vioceButton.selected =
    self.toobarView.videoButton.selected =
    self.toobarView.picButton.selected = NO;
}


#pragma mark
#pragma mark-------音频文件播放点击事件 -------
- (void)mediaBackGroundTapHandle:(UITapGestureRecognizer *)gesture{
    
}




///开始录音
- (void)jb_recordViewStartRecord{
    self.isRecoding = YES;
}
///删除录音
- (void)jb_recordViewCancleRecordWithFilePath:(NSString *)filePath{
    //    删除弹窗
    self.isRecoding = NO;
    self.recordViewIsShowing = NO;
    self.toobarView.vioceButton.selected = NO;
}



- (void)jb_recordView:(JBRecordView *)view confirmWithMediaPath:(NSString *)path filePath:(NSString *)filePath time:(NSString *)timeString{
    
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    [XFQ_QNUpload uploadMediaoToQNFilePaht:path success:^(QNResponseInfo *info, NSString *key) {
        hud.hidden = YES;
        if (info.statusCode == 200) {
            self.mp3Path = key;
            self.isRecoding = NO;
            self.recordViewIsShowing = NO;
            self.localMp3Path = path;
            self.voiceTime = timeString;
            [self _reSetVariousUIFrame];
            [self showHudMessage:@"音频上传成功" hidenAfterDelay:1];
        }
        else{
            [self showHudMessage:@"音频上传失败" hidenAfterDelay:1];
        }
    } failure:^(NSString *error) {
        hud.hidden = YES;
        [self showHudMessage:@"音频上传失败" hidenAfterDelay:1];
    }];
}

- (void)setIsRecoding:(BOOL)isRecoding{
    _isRecoding = isRecoding;
    self.toobarView.videoButton.userInteractionEnabled =
    self.toobarView.vioceButton.userInteractionEnabled =
    self.toobarView.picButton.userInteractionEnabled =
    self.titleTextView.userInteractionEnabled =
    self.contentTextView.userInteractionEnabled =
    self.bgScrollview.userInteractionEnabled = !_isRecoding;
}

#pragma mark
#pragma mark-------JBTeachingPostToobarDelegate 视频 图片 录音按钮 -------
- (void)wq_JBTeachingPostToobarView:(JBTeachingPostToobarView *)view selectedIndex:(NSInteger)index{
    if (self.mp3Path.length > 0 || self.videoPath.length > 0 ||self.picArray.count >= 3){
        return;
    }
    self.videoPicSelectedIndex = index;
    
    [self.titleTextView resignFirstResponder];
    [self.contentTextView resignFirstResponder];
    
    /// 图片
    if ( index == 0) {
        self.recordViewIsShowing = NO;
        if (self.mp3Path.length > 0 || self.videoPath.length > 0) {
            UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:nil message:@"该功能仅支持视频、图片、语音其中任意一种格式" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
            [alertView show];
            return;
        }
        self.toobarView.videoButton.selected = NO;
        self.toobarView.vioceButton.selected = NO;
        self.toobarView.picButton.selected = YES;
        [self gotoAlbumToSelectedImageView];
    }
    /// 录音
    if (index == 1) {
        
        if (self.picKeysArray.count > 0 || self.videoPath.length > 0) {
            UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:nil message:@"该功能仅支持视频、图片、语音其中任意一种格式" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
            [alertView show];
            return;
        }
        
        if (self.mp3Path.length>0) {
            UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:nil message:@"只能上传一个音频文件" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
            [alertView show];
            return;
        }
        self.recordViewIsShowing = !self.recordViewIsShowing;
        self.toobarView.videoButton.selected = NO;
        self.toobarView.vioceButton.selected = self.recordViewIsShowing;
        self.toobarView.picButton.selected = NO;
    }
    /// 视频
    if (index == 2) {
        self.recordViewIsShowing = NO;
        if (self.picArray.count > 0 || self.mp3Path.length > 0) {
            UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:nil message:@"该功能仅支持视频、图片、语音其中任意一种格式" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
            [alertView show];
            return;
        }
        
        if (self.videoPath && self.videoPath.length > 1) {
            UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:nil message:@"您最多只能选择一个视频" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
            [alertView show];
            return;
        }
        else{
            self.toobarView.videoButton.selected = YES;
            self.toobarView.vioceButton.selected = NO;
            self.toobarView.picButton.selected = NO;
            [self gotoAlbumWithMaxCount:1];
        }
    }
}


- (void)_reSetVariousUIFrame{
    
    self.variousBgView.backgroundColor = [UIColor magentaColor];
    if (self.videoPicSelectedIndex == 0) {
        [self.variousBgView addSubview:self.picListView];
        self.picListView.picArray = self.picKeysArray ;
    }
    
    if (self.videoPicSelectedIndex == 2) {
        [self.variousBgView addSubview:self.medaiView];
        [self.medaiView sd_setImageWithURL:[NSURL URLWithString:self.videoBackImagePath]];
    }
    
    if (self.videoPicSelectedIndex == 1) {
        [self.variousBgView addSubview:self.voiceView];
        [self.variousBgView addSubview:self.deleteButton];
        self.voiceView.frame = CGRectMake(10,10, kSpaceW(160),kSpaceH(35));
        self.deleteButton.frame = CGRectMake(kSpaceW(180), 10 + (kSpaceH(35) - 18)/2.0, 18, 18);
    }
}
- (void)setRecordViewIsShowing:(BOOL)recordViewIsShowing{
    _recordViewIsShowing = recordViewIsShowing;
    
    if (_recordViewIsShowing) {
        [UIView animateWithDuration:0.25 animations:^{
            self.recordView.frame = CGRectMake(0, kScreenHeight - WQ_TabbarSafeBottomMargin - 216, kScreenWidth, 216);
        } completion:^(BOOL finished) {
        }];
    }
    else{
        [UIView animateWithDuration:0.25 animations:^{
            self.recordView.frame = CGRectMake(0, kScreenHeight, kScreenWidth, 216);
        } completion:^(BOOL finished) {
        }];
    }
}




- (void)changeTitleTextViewFrameWithTextView:(WQTextView *)textView andTextHeight:(CGFloat)textHeight{
    
    if ([textView isEqual:self.titleTextView]) {
        CGRect frame = self.titleTextView.frame;
        frame.size.height = MAX(35, textHeight);
        self.titleTextView.frame = frame;
        CGRect contentFrame =  self.contentImageView.frame;
        contentFrame.origin.y = 15 + MAX(35, textHeight);
        self.contentImageView.frame = contentFrame;
    }
    
}



- (void)_setNav{
    
    self.view.backgroundColor = [UIColor whiteColor];
    self.fd_prefersNavigationBarHidden = YES;
    XFQNavigationView  *nav =  [[XFQNavigationView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, WQ_StatusBarAndNavigationBarHeight) leftImageName:@"JbAPP_Back" leftTitle:nil title:@"添加课程" target:self action:@selector(gotoBack) showBottomLine:YES];
    [self.view addSubview:nav];
}





- (void)_createUI{
    
    UIScrollView *bgScrollview = [[UIScrollView alloc] initWithFrame:CGRectMake(0, WQ_StatusBarAndNavigationBarHeight, kScreenWidth, kScreenHeight - WQ_StatusBarAndNavigationBarHeight - WQ_TabbarSafeBottomMargin - 49)];
    
    UITapGestureRecognizer *bigScrollviewTap = [[UITapGestureRecognizer alloc] initWithActionBlock:^(id  _Nonnull sender) {
        [self.titleTextView resignFirstResponder];
        [self.contentTextView resignFirstResponder];
        self.recordViewIsShowing = NO;
    }];
    
    
    if (@available(iOS 11.0, *)) {
        bgScrollview.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
    } else {
        self.edgesForExtendedLayout = UIRectEdgeNone;
    }

    
    [bgScrollview addGestureRecognizer:bigScrollviewTap];
    bgScrollview.backgroundColor = kUIColorFromRGB(0xF4F4F4);
    [self.view addSubview:bgScrollview];
    self.bgScrollview = bgScrollview;
    
    
    
    [bgScrollview addSubview:self.contentImageView];
    [bgScrollview addSubview:self.titleTextView];
    
    
    
    UIView *lineView = [[UIView alloc] initWithFrame:CGRectMake(0, CGRectGetHeight(self.contentImageView.frame) - 1 - kSpaceH(45), kScreenWidth , 1)];
    lineView.backgroundColor = [UIColor redColor];

    [self.contentImageView addSubview:lineView];
    
    self.contentTextViewBottomLine  = lineView;
    
#pragma mark
#pragma mark-------添加tabbar -------
    [self.contentImageView addSubview:self.toobarView];

    UILabel *tishiLabel = [[UILabel alloc] initWithFrame:CGRectZero];
    tishiLabel.text = @"已添加 图片文件";
    tishiLabel.font = font12;
    tishiLabel.textColor = color999999;
    [self.toobarView addSubview:tishiLabel];
    [tishiLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(self.toobarView);
        make.left.mas_equalTo(10);
    }];
    
    [self.toobarView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.mas_equalTo(self.contentImageView);
        make.right.left.mas_equalTo(self.contentImageView);
        make.height.mas_equalTo(kSpaceH(45));
    }];
    
#pragma mark
#pragma mark-------添加课程信息 -------
    JBWLPublishClassInfoView * classInfoView = [[JBWLPublishClassInfoView alloc] initWithFrame:CGRectMake(kSpaceW(5), CGRectGetMaxY(self.contentImageView.frame) + kSpaceH(10), kScreenWidth - kSpaceW(10), kSpaceW(180))];
    self.classInfoView = classInfoView;
    classInfoView.backgroundColor = [UIColor whiteColor];
    [bgScrollview addSubview:classInfoView];
    
    [classInfoView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.contentImageView.mas_bottom).mas_offset(kSpaceH(10));
        make.left.mas_equalTo(kSpaceH(5));
        make.width.mas_equalTo(kScreenWidth - kSpaceH(10));
        make.height.mas_equalTo([classInfoView getViewHeight]);
    }];
    
    
    bgScrollview.contentSize = CGSizeMake(kScreenWidth, [classInfoView getViewHeight] + CGRectGetMaxY(self.contentImageView.frame) + 10);
    
    
    UIView *lineViewSix = [[UIView alloc] init];
    lineViewSix.backgroundColor = [UIColor orangeColor];
    lineViewSix.frame = CGRectMake(0, CGRectGetMaxY(bgScrollview.frame), kScreenWidth, 1);
    [self.view  addSubview:lineViewSix];
    
    
#pragma mark
#pragma mark-------确 认 发 布 -------
    
    UIButton *nextbutton = [[UIButton alloc] initWithFrame:CGRectMake(20, 4.5, 150 , 40)];
    [nextbutton addTarget:self action:@selector(nextButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    
    [nextbutton setTitle:@"确 认 发 布" forState:UIControlStateNormal];
    nextbutton.backgroundColor = color00CCBB;
    nextbutton.titleLabel.font = font16;
    [nextbutton setTitleColor:colorFFFFFF forState:UIControlStateNormal];
    nextbutton.layer.cornerRadius = 20;
    nextbutton.clipsToBounds = YES;
    [self.view addSubview:nextbutton];
    nextbutton.adjustsImageWhenHighlighted = NO;
    [nextbutton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(lineViewSix.mas_bottom).mas_offset(4);
        make.centerX.mas_equalTo(self.view.mas_centerX);
        make.height.mas_equalTo(40);
        make.width.mas_equalTo(150);
    }];
    
}

- (UIImageView *)medaiView{
    if (!_medaiView) {
        _medaiView = [[UIImageView alloc] initWithFrame:CGRectMake(0,0, kSpaceW(80),kSpaceH(60))];
        _medaiView.userInteractionEnabled = YES;
        UIButton *deleteButton = [[UIButton alloc] initWithFrame:CGRectMake(kSpaceW(80) - 20, 0, 20, 20)];
        [_medaiView addSubview:deleteButton];
        [deleteButton addTarget:self action:@selector(deleteMediaAction:) forControlEvents:UIControlEventTouchUpInside];
        _medaiView.contentMode = UIViewContentModeScaleAspectFill;
        _medaiView.clipsToBounds = YES;
        UITapGestureRecognizer *imageTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(mediaBackGroundTapHandle:)];
        [_medaiView addGestureRecognizer:imageTap];
        
        [deleteButton setImage:[UIImage imageNamed:@"JB_Post_ImageView_删除"] forState:UIControlStateNormal];
        
    }
    return _medaiView;
}

- (JBRecordView *)recordView{
    if (!_recordView) {
        _recordView = [[JBRecordView alloc] initWithFrame:CGRectMake(0, kScreenHeight, kScreenWidth, 216)];
        _recordView.delegate = self;
    }
    return _recordView;
}

- (WQDisplayView *)picListView{
    if (!_picListView) {
        _picListView = [[WQDisplayView alloc] initWithFrame:CGRectMake(5, 0, kScreenWidth - 20, kSpaceH(60))];
        _picListView.perWidth = kSpaceH(60);
        _picListView.delegate = self;
    }
    return _picListView;
}
- (HomeVideoView *)voiceView{
    if (!_voiceView) {
        
        _voiceView = [[HomeVideoView alloc] initWithFrame:CGRectZero type:1];
        [_voiceView animationStop];
        _voiceView.delegate = self;
    }
    return _voiceView;
}


- (UIView *)variousBgView{
    if (!_variousBgView) {
        _variousBgView = [[UIView alloc] initWithFrame:CGRectMake(0, kSpaceH(100) + 5 + kSpaceH(10), kScreenWidth - 10, kSpaceH(60))];
        _variousBgView.backgroundColor = [UIColor cyanColor];
        
        UITapGestureRecognizer *contentTextViewTap = [[UITapGestureRecognizer alloc] initWithActionBlock:^(id  _Nonnull sender) {
            [self.titleTextView resignFirstResponder];
            [self.contentTextView resignFirstResponder];
            self.recordViewIsShowing = NO;
        }];
        [_variousBgView addGestureRecognizer:contentTextViewTap];
    }
    return _variousBgView;
}

- (WQTextView *)titleTextView{
    if (!_titleTextView) {
        _titleTextView = [[WQTextView alloc] initWithFrame:CGRectMake(5, 5, kScreenWidth - 10, 35)];
        self.titleTextView = _titleTextView;
        [_titleTextView textValueDidChanged:^(CGFloat textHeight) {
            [self changeTitleTextViewFrameWithTextView:_titleTextView andTextHeight:textHeight];
        }];
        _titleTextView.delegate = self;
        _titleTextView.placeholderFont = font14;
        _titleTextView.font = font14;
        _titleTextView.textColor = color333333;
        _titleTextView.maxNumberOfLines = 2;
        _titleTextView.placeholder = @"请输入教学内容标题";
        _titleTextView.layer.cornerRadius = 15;
        _titleTextView.clipsToBounds = YES;
    }
    return _titleTextView;
}


- (UIButton *)deleteButton{
    if (!_deleteButton) {
        _deleteButton =[[UIButton alloc] initWithFrame:CGRectMake(kSpaceW(140), 0, 20, 20)];
        [_deleteButton addTarget:self action:@selector(deleteVoiceAction:) forControlEvents:UIControlEventTouchUpInside];
        [_deleteButton setBackgroundImage:[UIImage imageNamed:@"发布录音删除"] forState:UIControlStateNormal];
    }
    return _deleteButton;
}


- (JBTeachingPostToobarView *)toobarView{
    if (!_toobarView) {
        _toobarView = [[JBTeachingPostToobarView alloc] initWithFrame:CGRectMake(0, kSpaceH(240) - kSpaceH(50), kScreenWidth - 10, kSpaceH(45))];
        _toobarView.delegate = self;
        _toobarView.backgroundColor = [UIColor whiteColor];
    }
    return _toobarView;
}

- (UIImageView *)contentImageView{
    if (!_contentImageView) {
        
        _contentImageView = [[UIImageView alloc] initWithFrame:CGRectMake(5, 50, kScreenWidth - 10, kSpaceH(145) + kSpaceH(20) + 5 + kSpaceH(60))];
        _contentImageView.layer.cornerRadius = 10;
        _contentImageView.userInteractionEnabled = YES;
        _contentImageView.clipsToBounds = YES;
        _contentImageView.backgroundColor = [UIColor whiteColor];
        self.contentImageView = _contentImageView;
        YYTextView *_contentTextView = [[YYTextView alloc] initWithFrame:CGRectMake(0, 5, kScreenWidth - 10, kSpaceH(100))];
        self.contentTextView = _contentTextView;
        UIView *ba = [[UIView alloc] initWithFrame:CGRectMake(0, 4, kScreenWidth - 10, 5)];
        [_contentImageView addSubview:ba];
        ba.backgroundColor = [UIColor whiteColor];
        
        
        _contentTextView.delegate = self;
        _contentTextView.font = font14;
        _contentTextView.placeholderFont = font14;
        _contentTextView.textColor = color666666;
        _contentTextView.backgroundColor = [UIColor whiteColor];
        _contentTextView.placeholderText = @"请对您的教学内容进行具体的描述";
        [_contentImageView addSubview:_contentTextView];
        UITapGestureRecognizer *contentTextViewTap = [[UITapGestureRecognizer alloc] initWithActionBlock:^(id  _Nonnull sender) {
            [self.contentTextView becomeFirstResponder];
            self.recordViewIsShowing = NO;
        }];
        [_contentImageView addGestureRecognizer:contentTextViewTap];
        [_contentImageView addSubview:self.variousBgView];

    }
    return  _contentImageView;
}

- (NSMutableArray *)picArray{
    if (!_picArray) {
        _picArray = [[NSMutableArray alloc] init];
    }
    return _picArray;
}
- (NSString *)videoPath{
    if (!_videoPath) {
        _videoPath = @"";
        _videoBackImagePath = @"";
    }
    return _videoPath;
}
- (NSString *)localMp3Path{
    if (!_localMp3Path) {
        _localMp3Path = @"";
    }
    return _localMp3Path;
}
- (NSString *)mp3Path{
    if (!_mp3Path) {
        _mp3Path = @"";
    }
    return _mp3Path;
}
- (NSMutableArray *)picKeysArray{
    if (!_picKeysArray) {
        _picKeysArray = [[NSMutableArray alloc] init];
    }
    return _picKeysArray;
}

- (ZLPhotoActionSheet *)actionSheet{
    
    if (!_actionSheet) {
        _actionSheet = [[ZLPhotoActionSheet alloc] init];
    }
    return _actionSheet;
    
}

@end
