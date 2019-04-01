//
//  UILabel+LineCountAndContent.h
//  LabelCount
//
//  Created by apple on 2019/4/1.
//  Copyright © 2019 apple. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UILabel (LineCountAndContent)
/**
 返回每一行的内容数组
 */
- (NSArray *)getLinesArrayOfStringInLabel:(UILabel *)label;
+ (NSDictionary *)setTextLineSpaceWithString:(NSString *)string
                           withLineBreakMode:(NSLineBreakMode)lineBreakMode
                               withAlignment:(NSTextAlignment)alignment
                                    withFont:(UIFont *)font
                               withLineSpace:(CGFloat)lineSpace
                         withTextlengthSpace:(NSNumber *)textlengthSpace
                        andParagraphSpaceing:(CGFloat)paragraphSpacing;
+ (NSArray *)getLinesArrayOfStringAtributeInLabel:(UILabel *)label;
@end

NS_ASSUME_NONNULL_END
