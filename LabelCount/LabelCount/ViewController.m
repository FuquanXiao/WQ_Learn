//
//  ViewController.m
//  LabelCount
//
//  Created by apple on 2019/4/1.
//  Copyright © 2019 apple. All rights reserved.
//

#import "ViewController.h"
#import <CoreText/CoreText.h>
#import "UILabel+LineCountAndContent.h"
@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UILabel *contentLabel = [[UILabel alloc] initWithFrame:CGRectMake(30, 30, 300, 500)];
    contentLabel.numberOfLines = 0;
    contentLabel.backgroundColor = [UIColor redColor];
    
    NSString *content =  @"本市将继续稳妥推进单校划片和多校划片相结合入学方式，对房产、户口具备1条件且居住达到1一定年限的老居民子女继续实行原有单校划片，不完全符合学校单校划片入学1234的将实施多5划片。由各区根据学位供给情况和户籍、房产、居住年限等因素制定相应办法。本市户籍无房家庭可在租住地1入学今年继3续稳妥1实施本市户籍无房家庭1在租住地入学办法。本市户籍无房家庭，长期在非户籍所在区工作、居住，符合在同一区连续单独承租并实际居住3年以上且在住房37租赁监管平台8登记备案、夫妻3一方在该区合法稳定就业3年以上等条件的，其适3龄子女可在该区接受义务教育。具体办法由各区3政府结合实际情况制定。部门联动审核本市户籍无房家庭、合法稳定就业、实际居住等入学资3格条件。依托3北京市住房租赁监3管平台核验本市3户籍无房家庭住3房租赁登记备案信息，租赁信息核验自5月6日与入学信息采集工作同步启动。入学禁止面试选拔3年市教委要求3年，各区教委和3年学校严格执行市教委统一规定的时间表和工作3年程序。严禁以考试成绩和各类竞赛证书、培训竞赛成绩、考级证明等作为招生依据。严禁以面试、评测等名义选拔学生。";
    
    
    
//    NSString *content =  @"本市将继续稳妥推进单校划片和多校划片相结合入学方式，对房产";
    
    
    contentLabel.text = content;
    [self.view addSubview:contentLabel];
    
    
    CGFloat contentLabelWidth = 300;
    CGFloat kContentFontSize  = 14;
    CGFloat kContentLineSpace = 8.0f;
    CGFloat kContentTextLengthSpage = 2.0f;
 
    
    contentLabel.font = [UIFont systemFontOfSize:kContentFontSize];
    contentLabel.numberOfLines = 0;
    NSDictionary *contentDict = [UILabel setTextLineSpaceWithString:content withLineBreakMode:(NSLineBreakByCharWrapping) withAlignment:(NSTextAlignmentLeft) withFont:[UIFont systemFontOfSize:14] withLineSpace:kContentLineSpace  withTextlengthSpace:[NSNumber numberWithFloat:kContentTextLengthSpage] andParagraphSpaceing:2];
    contentLabel.attributedText = [[NSMutableAttributedString alloc] initWithString:content attributes:contentDict];
    
        NSArray *arr = [UILabel getLinesArrayOfStringAtributeInLabel:contentLabel];

    [contentLabel sizeToFit];
    
    
    
    
    [contentLabel sizeToFit];
    
    CGFloat labelHeight = [contentLabel sizeThatFits:CGSizeMake(contentLabel.frame.size.width, MAXFLOAT)].height;
    
    NSInteger count = (labelHeight) / (contentLabel.font.lineHeight + 8);
   
    
    
    
    
    
    CGFloat fontHe =  contentLabel.font.lineHeight;
   
    //    总文字的高度：
    CGFloat  textH = [contentLabel.text  boundingRectWithSize:CGSizeMake(MAXFLOAT, 20) options:NSStringDrawingUsesLineFragmentOrigin attributes:contentDict context:nil].size.width;
    
    //    每行文字的高度：
    
    CGFloat lineHeight = [contentLabel.text sizeWithAttributes:contentDict].height;
    
//    行数：
    
    NSInteger  lineCount = ceil(textH / 300.0);
    
    
}
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

@end
