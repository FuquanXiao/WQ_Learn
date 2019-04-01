//
//  MineCenterEditViewModel.h
//  JBApp
//
//  Created by apple on 2018/12/1.
//  Copyright © 2018年 apple. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MineCenterEditViewModel : NSObject
+ (NSArray *)getTitleName;
+ (NSArray *)getTitlePlaceHolder;
+ (void)loadMineInfoCompletoion:(void (^)(UserModel *userModel,NSString *des))userInfoBlock;


+ (void)loadEditMineInfoWithNickName:(NSString *)nickName
                            birthday:(NSString *)birthday
                               email:(NSString *)email
                            province:(NSString *)province
                                city:(NSString *)city
                         description:(NSString *)description
                         industryLab:(NSString *)industryLab
                            teachLab:(NSString *)teachLab
                         completoion:(void (^)(UserModel *userModel,NSString *des))userInfoBlock;


+ (void)loadEditMineHeaderInfoWithImgUrl:(NSString *)imgUrl
                       completoion:(void (^)(UserModel *userModel,NSString *des))userInfoBlock;
@end
