//
//  JBWLSubscribeBottomView.h
//  JBApp
//
//  Created by apple on 2019/3/20.
//  Copyright © 2019 apple. All rights reserved.
//立即预约view

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger,BottomViewLeftType){
    BottomViewLeftChat,
    BottomViewLeftPriceTime,
};


typedef void (^ClassChatBlock)(void);

typedef void (^ClassBuyBlock)(void);
NS_ASSUME_NONNULL_BEGIN

@interface JBWLSubscribeBottomView : UIView

@property (nonatomic,copy)ClassChatBlock chatBlock;

@property (nonatomic,copy)ClassBuyBlock buyBlock;

@property (nonatomic,assign)BottomViewLeftType bottomLeftType;
@end

NS_ASSUME_NONNULL_END
