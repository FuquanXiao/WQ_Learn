//
//  MineCenterEditViewModel.m
//  JBApp
//
//  Created by apple on 2018/12/1.
//  Copyright © 2018年 apple. All rights reserved.
//

#import "MineCenterEditViewModel.h"
#import "UserModel.h"
#import "LoginClassificationModel.h"
#import "JBSkillTagModel.h"
@implementation MineCenterEditViewModel
+ (NSArray *)getTitleName{
    
    NSArray *titleArray = @[@[@"昵称",@"照片墙"],@[@"生日",@"城市",@"个人介绍"],@[@"教学内容"],@[@"身份及行业"]];
    return titleArray;
}
+ (NSArray *)getTitlePlaceHolder{
    NSArray *titleArray = @[@[@"请输入您的昵称",@"设置照片墙"],@[@"请选择生日",@"填写您的故乡，让更多的人认识你",@"介绍一下自己吧"],@[@"选择"],@[@"选择"]];
    return titleArray;
}

+ (void)loadMineInfoCompletoion:(void (^)(UserModel *userModel,NSString *des))userInfoBlock{
    
    NSDictionary *params = @{
                             
                             };
    NSString *urlString = [NSString stringWithFormat:@"%@%@",API_BASE_URL_STRING,@"/usersInfo/getUserInfo4Update"];
    
    [HGHttpManager PostUrl:urlString params:params successBlock:^(NSDictionary *responseDict) {
        
        HttpModel *model = [HttpModel mj_objectWithKeyValues:responseDict];
        if ([model.result integerValue] == 200) {
            NSDictionary *dict = (NSDictionary *)model.data;
            if ([NSObject isEmptyObj:dict]) {
                return ;
            }
            else{
                
                UserModel *user = [UserModel mj_objectWithKeyValues:dict];

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

                userInfoBlock(user,nil);
            }
        }
        else{
            userInfoBlock(nil,SafeValue(model.desc));
        }
    } failureBlock:^(NSError *error) {
        userInfoBlock(nil,error.localizedDescription);
    }];
}

+ (void)loadEditMineInfoWithNickName:(NSString *)nickName
                            birthday:(NSString *)birthday
                               email:(NSString *)email
                            province:(NSString *)province
                                city:(NSString *)city
                         description:(NSString *)description
                         industryLab:(NSString *)industryLab
                            teachLab:(NSString *)teachLab
                         completoion:(void (^)(UserModel *userModel,NSString *des))userInfoBlock{
    
    
    NSDictionary *params = @{
                             @"nickName":nickName,
                             @"birthday":birthday,
                             @"email":SafeValue(email),
                             @"province":@"",
                             @"city":city,
                             @"description":description,
                             @"industryLab":industryLab,
                             @"teachLab":teachLab,
                             };
    NSString *urlString = [NSString stringWithFormat:@"%@%@",API_BASE_URL_STRING,@"/usersInfo/editUserInfo"];
    
    [HGHttpManager PostUrl:urlString params:params successBlock:^(NSDictionary *responseDict) {
        
        HttpModel *model = [HttpModel mj_objectWithKeyValues:responseDict];
        if ([model.result integerValue] == 200) {
            NSDictionary *dict = (NSDictionary *)model.data;
            if ([NSObject isEmptyObj:dict]) {
                return ;
            }
            UserModel *user = [UserModel mj_objectWithKeyValues:dict];
            userInfoBlock(user,nil);
        }
        else{
            userInfoBlock(nil,SafeValue(model.desc));
        }
    } failureBlock:^(NSError *error) {
        userInfoBlock(nil,error.localizedDescription);
    }];
    
}

+ (void)loadEditMineHeaderInfoWithImgUrl:(NSString *)imgUrl
                       completoion:(void (^)(UserModel *userModel,NSString *des))userInfoBlock;{
    NSDictionary *params = @{
                             @"imgUrl":imgUrl,
                             
                             };
    NSString *urlString = [NSString stringWithFormat:@"%@%@",API_BASE_URL_STRING,@"/usersInfo/updateHeadPic"];
    
    [HGHttpManager PostUrl:urlString params:params successBlock:^(NSDictionary *responseDict) {
        
        HttpModel *model = [HttpModel mj_objectWithKeyValues:responseDict];
        if ([model.result integerValue] == 200) {
            NSDictionary *dict = (NSDictionary *)model.data;
            if ([NSObject isEmptyObj:dict]) {
                return ;
            }
            UserModel *user = [UserModel mj_objectWithKeyValues:dict];
            userInfoBlock(user,nil);
        }
        else{
            userInfoBlock(nil,SafeValue(model.desc));
        }
    } failureBlock:^(NSError *error) {
        userInfoBlock(nil,error.localizedDescription);
    }];
    
}

@end
