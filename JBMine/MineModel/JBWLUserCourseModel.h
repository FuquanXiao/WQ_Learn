//
//  JBWLUserCourseModel.h
//  JBApp
//
//  Created by apple on 2019/3/27.
//  Copyright © 2019 apple. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface JBWLUserCourseModel : NSObject
@property (nonatomic,strong)NSString *courseId;
@property (nonatomic,strong)NSString *userId;

@property (nonatomic,strong)NSString *title;
@property (nonatomic,strong)NSString *content;
@property (nonatomic,strong)NSString *mediaType;
@property (nonatomic,strong)NSString *mediaUrl;
@property (nonatomic,strong)NSString *videoBg;
@property (nonatomic,strong)NSString *audioLen;
@property (nonatomic,strong)NSString *courseType;
@property (nonatomic,strong)NSString *teachType;
@property (nonatomic,strong)NSString *connectNum;
@property (nonatomic,strong)NSString *addressType;
@property (nonatomic,strong)NSString *address;
@property (nonatomic,strong)NSString *lng;
@property (nonatomic,strong)NSString *lat;
@property (nonatomic,strong)NSString *minNum;
@property (nonatomic,strong)NSString *maxNum;
@property (nonatomic,strong)NSString *price;
@property (nonatomic,strong)NSString *priceYuan;
@property (nonatomic,strong)NSString *createTime;
@property (nonatomic,strong)NSString *commentNum;
@property (nonatomic,strong)NSString *likeNum;
@property (nonatomic,strong)NSString *viewNum;
@property (nonatomic,strong)NSString *recommend;
@property (nonatomic,strong)NSString *status;
@property (nonatomic,strong)NSString *del;
@property (nonatomic,strong)NSString *courseLab;
@property (nonatomic,strong)NSArray *courseLabList;
@property (nonatomic,strong)NSString *learnNum;

@property (nonatomic,assign)BOOL hadSelected;

@end

NS_ASSUME_NONNULL_END
