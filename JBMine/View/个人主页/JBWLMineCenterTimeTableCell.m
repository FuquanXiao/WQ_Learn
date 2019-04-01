//
//  JBWLMineCenterTimeTableCell.m
//  JBApp
//
//  Created by apple on 2019/3/20.
//  Copyright © 2019 apple. All rights reserved.
//

#import "JBWLMineCenterTimeTableCell.h"

#define itemWidth (kScreenWidth - kSpaceH(10) - kSpaceH(20))/8.0
#define itemHeight  kSpaceH(30)
#define titleHeight kSpaceH(34)

@interface JBWLMineCenterTimeTableCell()
@property (nonatomic,strong)UIImageView *bgImageView;
@end


@implementation JBWLMineCenterTimeTableCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.backgroundColor = [UIColor groupTableViewBackgroundColor];
        [self _createUI];
    }
    return self;
}

- (void)_createUI{
    
    UIImageView *bgImageView = [[UIImageView alloc] initWithFrame:CGRectMake(5, 0, kScreenWidth - 10, kSpaceH(146))];
    [self addSubview:bgImageView];
    self.bgImageView = bgImageView;
    bgImageView.backgroundColor = colorFFFFFF;

    
    UIView *titleLineView = [[UIView alloc] initWithFrame:CGRectMake(kSpaceH(10), 0, kScreenWidth - 10 - 20 , 1)];
    [bgImageView addSubview:titleLineView];
    titleLineView.backgroundColor = colorE7E7E7;
    
    
    NSArray *timeArray = @[@"上午",@"下午",@"晚上"];
    
    for (int i = 0; i < 4; i++) {
        
        UIView *horLineView = [[UIView alloc] initWithFrame:CGRectMake(kSpaceH(10), titleHeight +  kSpaceH(15) + itemHeight * i, kScreenWidth - kSpaceH(10) - kSpaceH(20) , 1)];
        [bgImageView addSubview:horLineView];
        horLineView.backgroundColor = colorE7E7E7;
        
        if (i<3) {
            UILabel * morningAfterLabel = [[UILabel alloc] initWithFrame:CGRectMake(kSpaceH(10), titleHeight +  kSpaceH(15) + itemHeight * i + 1, itemWidth - 2, itemHeight - 2)];
            morningAfterLabel.text = timeArray[i];
            morningAfterLabel.textColor = color666666;
            morningAfterLabel.font = font12;
            morningAfterLabel.textAlignment = NSTextAlignmentCenter;
            [bgImageView addSubview:morningAfterLabel];
        }
    }
    
    for (int i = 1; i < 8; i ++ ) {
        UIView *horLineView = [[UIView alloc] initWithFrame:CGRectMake(kSpaceH(10) + itemWidth * i, kSpaceH(15), 1 , kSpaceH(120))];
        [bgImageView addSubview:horLineView];
        horLineView.backgroundColor = colorE7E7E7;
    }
    
    UIImageView *bottomView = [[UIImageView alloc] initWithFrame:CGRectZero];
    
    [self addSubview:bottomView];
    bottomView.image = [UIImage imageNamed:@"向下的圆角"];
    
    [bottomView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.mas_equalTo(self.mas_bottom).mas_offset(0);
        make.left.mas_equalTo(self.bgImageView);
        make.right.mas_equalTo(self.bgImageView);
        make.height.mas_equalTo(kSpaceH(20));
    }];
    
    [self setDataWithDiction:@{} titleKeyArray:@[]];
}

- (void)setScheduleModelArray:(NSArray *)scheduleModelArray{
    
    _scheduleModelArray = scheduleModelArray;
    NSMutableArray *keysArray = [[NSMutableArray alloc] init];
    NSMutableDictionary *valueDict =  [[NSMutableDictionary alloc] init];
    for (JBWLTeachScheduleModel *model in scheduleModelArray) {
        [keysArray addObject:model.weekdayString];
        [valueDict setObject:@[model.morningString,model.afternoonString,model.eveningString] forKey:model.weekdayString];
    }
    [self setDataWithDiction:valueDict titleKeyArray:keysArray];
}


- (void)setDataWithDiction:(NSDictionary *)tempDict titleKeyArray:(NSArray *)titleKeyArr{
    
    for (int i = 0; i < titleKeyArr.count; i++) {
        
        CGRect titleLabelFrame = CGRectMake(kSpaceH(10) + itemWidth + itemWidth * i + 1,  kSpaceH(15) , itemWidth - 2, titleHeight - 1);
        
        UILabel * titleLabel = [UILabel createLabelWithFrame:titleLabelFrame text:titleKeyArr[i] textColor:color999999 font:font12 textAlignment:NSTextAlignmentCenter];
        [self.bgImageView addSubview:titleLabel];
        titleLabel.backgroundColor = [UIColor clearColor];
        
        
        NSArray *valueArray = [tempDict objectForKey:titleKeyArr[i]];
        for (int j = 0; j < 3; j++) {
            CGRect labelFrame = CGRectMake(kSpaceH(10) + itemWidth + itemWidth * i + 1, titleHeight +  kSpaceH(15) + itemHeight * j + 1, itemWidth - 2, itemHeight - 2);
            
            UILabel * morningAfterLabel = [UILabel createLabelWithFrame:labelFrame text:[NSString stringWithFormat:@"%@",valueArray[j]] textColor:color999999 font:font12 textAlignment:NSTextAlignmentCenter];
            
            if ([valueArray[j] isEqualToString:@"可约"]) {
                morningAfterLabel.textColor = color00CCBB;
            }
            [self.bgImageView addSubview:morningAfterLabel];
            morningAfterLabel.backgroundColor = [UIColor clearColor];
        }
    }
}


@end
