//
//  JBWLMineCenterController.h
//  JBApp
//
//  Created by apple on 2019/3/18.
//  Copyright © 2019 apple. All rights reserved.
//

#import "JBBaseController.h"

NS_ASSUME_NONNULL_BEGIN

@interface JBWLMineCenterController : JBBaseController

///...
@property (nonatomic,strong)NSString *userId;
///后台需要这个统计来源
@property (nonatomic,strong)NSString *sourceType;
@end

NS_ASSUME_NONNULL_END
