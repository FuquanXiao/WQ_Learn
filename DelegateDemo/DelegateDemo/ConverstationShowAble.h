//
//  ConverstationShowAble.h
//  DelegateDemo
//
//  Created by apple on 2019/7/19.
//  Copyright © 2019 apple. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@protocol ConverstationShowAble <NSObject>
// 显示的高度
- (NSInteger)showHeight;

// 重用identifier
- (NSString *)showReuseIndentifier;
@end

NS_ASSUME_NONNULL_END
