//
//  JBWLMineCenterViewModel.h
//  JBApp
//
//  Created by apple on 2019/3/27.
//  Copyright © 2019 apple. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface JBWLMineCenterViewModel : NSObject

///cycleScrollview 照片墙 的图片
@property (nonatomic,strong)NSMutableArray *cycleImageArray;

/**
 照片墙
 接口地址：usersInfo/getPhotoWall
 请求方式：POST
 */
- (void)loadPhotoWallWith:(NSString *)userId completion:(JBCompletionArrayCallBack)callBack;


- (void)loadUserIntroWithUserId:(NSString *)userId andSourceType:(NSString *)sourceType andComletion:(JBCompletionModelCallBack)callBack;
/**
 接口地址：usersInfo/countProgramByUserId
 请求方式：POST
 */
- (void)loadQualityCourseCountWithUserId:(NSString *)userId andComletion:(JBCompletionModelCallBack)callBack;

/**
 个人课程列表
 接口地址：usersCourse/getUsersCourseByUserId
 请求方式：POST
 */
- (void)loadCourseListWithUserId:(NSString *)userId andComletion:(JBCompletionModelCallBack)callBack;



/**
 个人主页课程时间表
 
 接口地址：usersCourse/getTeacherSchdule
 请求方式：post
 */
- (void)loadTeacherSchduleWithUserId:(NSString *)userId andComletion:(JBCompletionModelCallBack)callBack;


/**
 获取评价标签
 
 接口地址：usersCourse/getEvaluateLab
 请求方式：post
 */
- (void)loadEvaluateLabWithUserId:(NSString *)userId andCourseId:(NSString *)courseId andComletion:(JBCompletionModelCallBack)callBack;
@end

NS_ASSUME_NONNULL_END
