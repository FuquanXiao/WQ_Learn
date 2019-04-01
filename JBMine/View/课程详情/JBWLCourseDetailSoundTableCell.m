//
//  JBWLCourseDetailSoundTableCell.m
//  JBApp
//
//  Created by xfq on 2019/3/30.
//  Copyright © 2019年 apple. All rights reserved.
//

#import "JBWLCourseDetailSoundTableCell.h"

@implementation JBWLCourseDetailSoundTableCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self _creteUI];
    }
    return self;
}

- (void)_creteUI{
    _videoView = [[HomeVideoView alloc] initWithFrame:CGRectMake(kSpaceW(10), 10, 180, 60)];
    [self addSubview:_videoView];
}
@end
