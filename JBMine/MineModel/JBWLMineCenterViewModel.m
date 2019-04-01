//
//  JBWLMineCenterViewModel.m
//  JBApp
//
//  Created by apple on 2019/3/27.
//  Copyright © 2019 apple. All rights reserved.
//


#import "JBWLMineCenterViewModel.h"

#import "PhotoWalllViewModel.h"
#import "PhotoWallModel.h"

#import "LoginClassificationModel.h"
#import "JBSkillTagModel.h"
#import "JBWLUserViewModel.h"


#import "JBWLUserCourseModel.h"

#import "JBWLTeachScheduleModel.h"
#import "JBWLEvaluateLabModel.h"

@implementation JBWLMineCenterViewModel
/**
 照片墙
 接口地址：usersInfo/getPhotoWall
 请求方式：POST
 */
- (void)loadPhotoWallWith:(NSString *)userId completion:(JBCompletionArrayCallBack)callBack{
    
    NSDictionary *params = @{
                             @"userId":userId
                             };
    
    NSString *urlString = [NSString stringWithFormat:@"%@%@",API_BASE_URL_STRING,@"/usersInfo/getPhotoWall"];
    
    [HGHttpManager PostUrl:urlString params:params successBlock:^(NSDictionary *responseDict) {
        
        NSMutableArray *dataPhotoArray = [[NSMutableArray alloc] init];
        HttpModel *model = [HttpModel mj_objectWithKeyValues:responseDict];
        ///初始化照片墙
        _cycleImageArray = [[NSMutableArray alloc] init];
        
        if ([model.result integerValue] == 200) {
            NSArray *photoArray = (NSArray *)model.data;
            if (![NSObject isEmptyObj:photoArray]) {
                for (NSDictionary *modelDict in photoArray) {
                    
                    PhotoWallModel *wallmodel = [PhotoWallModel mj_objectWithKeyValues:modelDict];
                    
                    PhotoWalllViewModel *wallVieModel = [[PhotoWalllViewModel alloc] initWithPhotoWallModel:wallmodel];
                    
                    [_cycleImageArray addObject:SafeValue(wallmodel.mediaUrl)];
                    
                    [dataPhotoArray addObject:wallVieModel];
                    
                }
            }
            callBack([dataPhotoArray copy],nil);
        }
        else{
            callBack(nil,SafeValue(model.desc));
        }
    } failureBlock:^(NSError *error) {
        callBack(nil,error.localizedDescription);
    }];
}

- (void)loadUserIntroWithUserId:(NSString *)userId andSourceType:(NSString *)sourceType andComletion:(JBCompletionModelCallBack)callBack{
    
    NSDictionary *params = @{
                             @"userId":userId
                             };
    NSString *urlString = [NSString stringWithFormat:@"%@%@",API_BASE_URL_STRING,@"/usersInfo/getUserInfo4Update"];
    
    [HGHttpManager PostUrl:urlString params:params successBlock:^(NSDictionary *responseDict) {
        
        HttpModel *model = [HttpModel mj_objectWithKeyValues:responseDict];
        JBWLUserViewModel *userViewModel = [[JBWLUserViewModel alloc] init];
        if ([model.result integerValue] == 200) {
            NSDictionary *dict = (NSDictionary *)model.data;
            
            if (![NSObject isEmptyObj:dict]) {
                 NSDictionary *userInfoDict = dict;
                UserModel * user = nil;
                if (![NSObject isEmptyObj:userInfoDict]) {
                  user = [UserModel mj_objectWithKeyValues:userInfoDict];
                  userViewModel.userModel = user;
                }
                NSArray *industryLabArray = dict[@"industryLabList"];
                NSMutableArray *indArray = [[NSMutableArray alloc] init];
                if (![NSObject isEmptyObj:industryLabArray]) {
                    for (NSDictionary * indDict in industryLabArray) {
                        LoginClassificationModel *classificationModel = [LoginClassificationModel mj_objectWithKeyValues:indDict];
                        classificationModel.isSelected = YES;
                        [indArray addObject:classificationModel];
                    }
                }
                
                NSArray *teachLabArray = dict[@"teachLabList"];
                
                NSMutableArray *teachArray = [[NSMutableArray alloc] init];
                if (![NSObject isEmptyObj:teachLabArray]) {
                    for (NSDictionary * indDict in teachLabArray) {
                        JBSkillTagModel *classificationModel = [JBSkillTagModel mj_objectWithKeyValues:indDict];
                        classificationModel.hasSelected = YES;
                        [teachArray addObject:classificationModel];
                    }
                }
                user.teachLabListArray = [teachArray mutableCopy];
                user.industryLabListArray =  [indArray mutableCopy];
            }
            callBack(userViewModel,nil);
        }
        else{
            callBack(nil,SafeValue(model.desc));
        }
    } failureBlock:^(NSError *error) {
        callBack(nil,error.localizedDescription);
    }];
}

- (void)loadQualityCourseCountWithUserId:(NSString *)userId andComletion:(JBCompletionModelCallBack)callBack{
    NSDictionary *params = @{
                             @"userId":userId
                             };
    
    NSString *urlString = [NSString stringWithFormat:@"%@%@",API_BASE_URL_STRING,@"/usersInfo/countProgramByUserId"];
    
    [HGHttpManager PostUrl:urlString params:params successBlock:^(NSDictionary *responseDict) {
        
        HttpModel *model = [HttpModel mj_objectWithKeyValues:responseDict];
        
        if ([model.result integerValue] == 200) {
            
            callBack(SafeValue(model.data),nil);
        }
        else{
            callBack(nil,SafeValue(model.desc));
        }
    } failureBlock:^(NSError *error) {
        callBack(nil,error.localizedDescription);
    }];
}

/**
 个人课程列表
 接口地址：usersCourse/getUsersCourseByUserId
 请求方式：POST
 */
- (void)loadCourseListWithUserId:(NSString *)userId andComletion:(JBCompletionModelCallBack)callBack{
    
    NSDictionary *params = @{
                             @"userId":userId
                             };
    
    NSString *urlString = [NSString stringWithFormat:@"%@%@",API_BASE_URL_STRING,@"/usersCourse/getUsersCourseByUserId"];
    
    [HGHttpManager PostUrl:urlString params:params successBlock:^(NSDictionary *responseDict) {
        
        HttpModel *model = [HttpModel mj_objectWithKeyValues:responseDict];
        
        NSMutableArray *dataSourceArray = [[NSMutableArray alloc] init];
        
        if ([model.result integerValue] == 200) {
            
            NSArray *dataArray = (NSArray *)model.data;
            
            if (![NSObject isEmptyObj:dataArray]) {
                
                for (NSDictionary *courseDict in dataArray) {
                    
                    JBWLUserCourseModel *courseModel = [JBWLUserCourseModel mj_objectWithKeyValues:courseDict];
                    [dataSourceArray addObject:courseModel];
                    
                    NSArray *industryLabArray = courseDict[@"courseLab"];
                    NSMutableArray *indArray = [[NSMutableArray alloc] init];
                    if (![NSObject isEmptyObj:industryLabArray]) {
                        for (NSDictionary * indDict in industryLabArray) {
                            JBSkillTagModel *classificationModel = [JBSkillTagModel mj_objectWithKeyValues:indDict];
                            classificationModel.hasSelected = YES;
                            [indArray addObject:classificationModel];
                        }
                        courseModel.courseLabList = [indArray copy];
                    }
                    
                }
            }
            callBack(dataSourceArray,nil);
        }
        else{
            callBack(nil,SafeValue(model.desc));
        }
    } failureBlock:^(NSError *error) {
        callBack(nil,error.localizedDescription);
    }];
}
/**
 个人主页课程时间表
 
 接口地址：usersCourse/getTeacherSchdule
 请求方式：post
 */
- (void)loadTeacherSchduleWithUserId:(NSString *)userId andComletion:(JBCompletionModelCallBack)callBack{
    NSDictionary *params = @{
                             @"userId":userId
                             };
    NSString *urlString = [NSString stringWithFormat:@"%@%@",API_BASE_URL_STRING,@"/usersCourse/getTeacherSchdule"];
    
    [HGHttpManager PostUrl:urlString params:params successBlock:^(NSDictionary *responseDict) {
        
        HttpModel *model = [HttpModel mj_objectWithKeyValues:responseDict];
        
        NSMutableArray *dataSourceArray = [[NSMutableArray alloc] init];
        
        if ([model.result integerValue] == 200) {
            
            NSArray *dataArray = (NSArray *)model.data;
            
            if (![NSObject isEmptyObj:dataArray]) {
                
                for (NSDictionary *courseDict in dataArray) {
                    
                    JBWLTeachScheduleModel *courseModel = [JBWLTeachScheduleModel mj_objectWithKeyValues:courseDict];
                    [dataSourceArray addObject:courseModel];
                }
            }
            callBack(dataSourceArray,nil);
        }
        else{
            callBack(nil,SafeValue(model.desc));
        }
    } failureBlock:^(NSError *error) {
        callBack(nil,error.localizedDescription);
    }];
}

/**
 获取评价标签
 
 接口地址：usersCourse/getEvaluateLab
 请求方式：post
 */
- (void)loadEvaluateLabWithUserId:(NSString *)userId andCourseId:(NSString *)courseId andComletion:(JBCompletionModelCallBack)callBack{
    NSDictionary *params = @{
                             @"userId":userId,
                             @"courseId":courseId
                             };
    
    NSString *urlString = [NSString stringWithFormat:@"%@%@",API_BASE_URL_STRING,@"/usersCourse/getEvaluateLab"];
    
    [HGHttpManager PostUrl:urlString params:params successBlock:^(NSDictionary *responseDict) {
        
        HttpModel *model = [HttpModel mj_objectWithKeyValues:responseDict];
        
        NSMutableArray *dataSourceArray = [[NSMutableArray alloc] init];
        
        if ([model.result integerValue] == 200) {
            
            NSArray *dataArray = (NSArray *)model.data;
            
            if (![NSObject isEmptyObj:dataArray]) {
                
                for (NSDictionary *courseDict in dataArray) {
                    
                    JBWLEvaluateLabModel *courseModel = [JBWLEvaluateLabModel mj_objectWithKeyValues:courseDict];
                    [dataSourceArray addObject:courseModel];
                }
            }
            callBack(dataSourceArray,nil);
        }
        else{
            callBack(nil,SafeValue(model.desc));
        }
    } failureBlock:^(NSError *error) {
        callBack(nil,error.localizedDescription);
    }];
}

@end
