//
//  JBWLUserViewModel.m
//  JBApp
//
//  Created by apple on 2019/3/27.
//  Copyright © 2019 apple. All rights reserved.
//

#import "JBWLUserViewModel.h"

@implementation JBWLUserViewModel


- (UserLeavelIdentityType)identifyType{
    return (UserLeavelIdentityType)[self.userModel.userLevel integerValue];
}

- (NSString *)userIdentifyImageName{
    
    NSString *imageName = @"";
    
    switch ([self.userModel.userLevel integerValue]) {
        case 1:
        {
            imageName = @"TeachDoJo_普通用户";
        }
            break;
        case 2:
        {
            imageName = @"TeachDoJo_普通用户";
        }
            break;
        case 3:
        {
            imageName = @"TeachDoJo_名师";
        }
            break;
        case 4:
        {
            imageName = @"TeachDoJo_导师";
        }
            break;
        case 5:
        {
            imageName = @"TeachDoJo_机构";
        }
            break;
        case 6:
        {
            imageName = @"TeachDoJo_顾问标签";
        }
            break;
        case 7:
        {
            imageName = @"hangjia_hangjia";
        }
            break;
        default:
            break;
    }
    return imageName;
    
}


- (UserFriendShipType)friendShipType{
    
    if ([SafeValue(self.userModel.userId) isEqualToString:UserConfig.userId]){
        return UserFriendShipSelf;
    }
 
    return (UserFriendShipType)[self.userModel.friendType integerValue];

}


@end
