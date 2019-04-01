//
//  JBWLEvaluateLabModel.h
//  JBApp
//
//  Created by apple on 2019/3/27.
//  Copyright © 2019 apple. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface JBWLEvaluateLabModel : NSObject
////接口文档上面没有写这个是什么意思
//@property (nonatomic,strong)NSString *id;
////被评价的用户id
@property (nonatomic,strong)NSString *userId;
@property (nonatomic,strong)NSString *courseId;
@property (nonatomic,strong)NSString *evaluateId;
@property (nonatomic,strong)NSString *labId;
@property (nonatomic,strong)NSString *labName;
@property (nonatomic,strong)NSString *labNum;
@end

NS_ASSUME_NONNULL_END
