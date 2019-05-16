//
//  CloserBlock.h
//  BlockStudy
//
//  Created by apple on 2019/5/16.
//  Copyright © 2019 xfq. All rights reserved.
//


typedef void (^ClassChatBlock)(void);

typedef void (^ClassBuyBlock)(void);

typedef void (^ClassBuy)(int page);


#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface CloserBlock : NSObject
@property (nonatomic,copy)ClassChatBlock chatBlock;

@property (nonatomic,copy)ClassBuyBlock buyBlock;
- (void)fetchDataWith:(ClassBuy)callBack;
@end

NS_ASSUME_NONNULL_END
