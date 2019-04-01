//
//  PhotoWalllViewModel.h
//  JBApp
//
//  Created by apple on 2019/3/27.
//  Copyright © 2019 apple. All rights reserved.
////照片墙viewModel

#import <Foundation/Foundation.h>
#import "PhotoWallModel.h"
NS_ASSUME_NONNULL_BEGIN

@interface PhotoWalllViewModel : NSObject

@property (nonatomic,strong)PhotoWallModel *photoWallModel;


- (instancetype)initWithPhotoWallModel:(PhotoWallModel *)photoWallModel;


@end

NS_ASSUME_NONNULL_END
