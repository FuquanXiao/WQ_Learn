//
//  JBWLUserViewModel.h
//  JBApp
//
//  Created by apple on 2019/3/27.
//  Copyright © 2019 apple. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "UserModel.h"
NS_ASSUME_NONNULL_BEGIN

typedef NS_ENUM(NSInteger,UserLeavelIdentityType){
   ///普通用户
    UserLeavelIdentityNormal = 1,
    ///老师
    UserLeavelIdentityLaoShi,
    ///名师
    UserLeavelIdentityMingShi,
    ///导师
    UserLeavelIdentityDaoShi,
    ///机构
    UserLeavelIdentityJiGou,
    ///顾问
    UserLeavelIdentityGuWen,
    ///行家
    UserLeavelIdentityHangJia,
};
typedef NS_ENUM(NSInteger,UserFriendShipType){
    ///自己
    UserFriendShipSelf = 0,
    ///立即联系
    UserFriendShipChatAtNow,
    ///等待认证
    UserFriendShipWating,
    ///添加好友
    UserFriendShipAddFriend,
    
};

@interface JBWLUserViewModel : NSObject

@property (nonatomic,strong)UserModel *userModel;
///精品课数量
@property (nonatomic,strong)NSString *qualityCount;

@property (nonatomic,assign)UserLeavelIdentityType identifyType;

@property (nonatomic,strong)NSString *userIdentifyImageName;

@property (nonatomic,assign)UserFriendShipType friendShipType;


@end

NS_ASSUME_NONNULL_END
