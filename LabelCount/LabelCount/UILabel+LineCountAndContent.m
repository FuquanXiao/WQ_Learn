//
//  UILabel+LineCountAndContent.m
//  LabelCount
//
//  Created by apple on 2019/4/1.
//  Copyright © 2019 apple. All rights reserved.
//

#import "UILabel+LineCountAndContent.h"
#import <CoreText/CoreText.h>
@implementation UILabel (LineCountAndContent)
- (NSArray *)getLinesArrayOfStringInLabel:(UILabel *)label{
    NSString *text = [label text];
    UIFont *font = [label font];
    CGRect rect = [label frame];
    
    CTFontRef myFont = CTFontCreateWithName(( CFStringRef)([font fontName]), [font pointSize], NULL);
    NSMutableAttributedString *attStr = [[NSMutableAttributedString alloc] initWithString:text];
    [attStr addAttribute:(NSString *)kCTFontAttributeName value:(__bridge  id)myFont range:NSMakeRange(0, attStr.length)];
    CFRelease(myFont);
    CTFramesetterRef frameSetter = CTFramesetterCreateWithAttributedString(( CFAttributedStringRef)attStr);
    CGMutablePathRef path = CGPathCreateMutable();
    CGPathAddRect(path, NULL, CGRectMake(0,0,rect.size.width,100000));
    CTFrameRef frame = CTFramesetterCreateFrame(frameSetter, CFRangeMake(0, 0), path, NULL);
    NSArray *lines = ( NSArray *)CTFrameGetLines(frame);
    NSMutableArray *linesArray = [[NSMutableArray alloc]init];
    for (id line in lines) {
        CTLineRef lineRef = (__bridge  CTLineRef )line;
        CFRange lineRange = CTLineGetStringRange(lineRef);
        NSRange range = NSMakeRange(lineRange.location, lineRange.length);
        NSString *lineString = [text substringWithRange:range];
        CFAttributedStringSetAttribute((CFMutableAttributedStringRef)attStr, lineRange, kCTKernAttributeName, (CFTypeRef)([NSNumber numberWithFloat:0.0]));
        CFAttributedStringSetAttribute((CFMutableAttributedStringRef)attStr, lineRange, kCTKernAttributeName, (CFTypeRef)([NSNumber numberWithInt:0.0]));
        NSLog(@"''''''''''''''''''%@",lineString);
        [linesArray addObject:lineString];
    }
    
    CGPathRelease(path);
    CFRelease( frame );
    CFRelease(frameSetter);
    return (NSArray *)linesArray;
}
+ (NSDictionary *)setTextLineSpaceWithString:(NSString *)string
                           withLineBreakMode:(NSLineBreakMode)lineBreakMode
                               withAlignment:(NSTextAlignment)alignment
                                    withFont:(UIFont *)font
                               withLineSpace:(CGFloat)lineSpace
                         withTextlengthSpace:(NSNumber *)textlengthSpace
                        andParagraphSpaceing:(CGFloat)paragraphSpacing {
    
    // 1. 创建样式对象
    NSMutableParagraphStyle *style = [[NSMutableParagraphStyle alloc] init];
    // 2. 每行容纳字符的宽度
//    style.lineBreakMode = lineBreakMode;
//    // 3. 对齐方式
//    style.alignment = alignment;
    // 4. 设置行间距
    style.lineSpacing = lineSpace;
    // 5. 连字符号链接
//    style.hyphenationFactor = 0.0f;
//    // 6. 首行缩进
//    style.firstLineHeadIndent = 0.f;
//    // 7. 段间距
//    style.paragraphSpacing = paragraphSpacing;
    // 8. 段前间距
//    style.paragraphSpacingBefore = 0.0f;
//    // 9. //头部缩进，相当于左padding 
//    style.headIndent = 0.0f;
//    // 10. 每行容纳字符的宽度
//    style.tailIndent = 0.0f;
    NSDictionary *dict = @{NSFontAttributeName : font,
                           NSParagraphStyleAttributeName : style,
                           NSKernAttributeName : textlengthSpace,
                           };
    return dict;
}
+ (NSArray *)getLinesArrayOfStringAtributeInLabel:(UILabel *)label{
    
    NSString *text = [label text];
    UIFont *font = [label font];
    CGRect rect = [label frame];
    
    CTFontRef myFont = CTFontCreateWithName(( CFStringRef)([font fontName]), [font pointSize], NULL);
    CGFloat  kContentFontSize  = 14.f;
    CGFloat  kContentLineSpace = 8.0f;
    CGFloat  kContentTextLengthSpage = 2.0f;
    NSDictionary *contentDict = [self setTextLineSpaceWithString:text withLineBreakMode:(NSLineBreakByCharWrapping) withAlignment:(NSTextAlignmentLeft) withFont:[UIFont systemFontOfSize:kContentFontSize] withLineSpace:kContentLineSpace  withTextlengthSpace:[NSNumber numberWithFloat:kContentTextLengthSpage] andParagraphSpaceing:0];
    NSMutableAttributedString *attStr = [[NSMutableAttributedString alloc] initWithString:text attributes:contentDict];
    [attStr addAttribute:(NSString *)kCTFontAttributeName value:(__bridge  id)myFont range:NSMakeRange(0, attStr.length)];
    CFRelease(myFont);
    
    CTFramesetterRef frameSetter = CTFramesetterCreateWithAttributedString(( CFAttributedStringRef)attStr);
    CGMutablePathRef path = CGPathCreateMutable();
    CGPathAddRect(path, NULL, CGRectMake(0,0,rect.size.width,100000));
    CTFrameRef frame = CTFramesetterCreateFrame(frameSetter, CFRangeMake(0, 0), path, NULL);
    NSArray *lines = ( NSArray *)CTFrameGetLines(frame);
    NSMutableArray *linesArray = [[NSMutableArray alloc]init];
    
    for (id line in lines) {
        
        CTLineRef lineRef = (__bridge  CTLineRef )line;
        CFRange lineRange = CTLineGetStringRange(lineRef);
        NSRange range = NSMakeRange(lineRange.location, lineRange.length);
        NSString *lineString = [text substringWithRange:range];
        CFAttributedStringSetAttribute((CFMutableAttributedStringRef)attStr, lineRange, kCTKernAttributeName, (CFTypeRef)([NSNumber numberWithFloat:0.0]));
        CFAttributedStringSetAttribute((CFMutableAttributedStringRef)attStr, lineRange, kCTKernAttributeName, (CFTypeRef)([NSNumber numberWithInt:0.0]));
        NSLog(@"''''''''''''''''''%@",lineString);

        [linesArray addObject:lineString];
    }
    
    CGPathRelease(path);
    CFRelease( frame );
    CFRelease(frameSetter);
    return (NSArray *)linesArray;
}

@end
