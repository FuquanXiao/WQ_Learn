//
//  ViewController.m
//  LabelCount
//
//  Created by apple on 2019/4/1.
//  Copyright © 2019 apple. All rights reserved.
//

#import "ViewController.h"
#import <CoreText/CoreText.h>
@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(30, 30, 300, 500)];
    label.numberOfLines = 0;
    label.text = @"本市将继续稳妥推进单校划片和多校划片相结合入学方式，对房产、户口具备条件且居住达到一定年限的老居民子女继续实行原有单校划片，不完全符合学校单校划片入学的将实施多校划片。由各区根据学位供给情况和户籍、房产、居住年限等因素制定相应办法。本市户籍无房家庭可在租住地入学今年继续稳妥实施本市户籍无房家庭在租住地入学办法。本市户籍无房家庭，长期在非户籍所在区工作、居住，符合在同一区连续单独承租并实际居住3年以上且在住房租赁监管平台登记备案、夫妻一方在该区合法稳定就业3年以上等条件的，其适龄子女可在该区接受义务教育。具体办法由各区政府结合实际情况制定。部门联动审核本市户籍无房家庭、合法稳定就业、实际居住等入学资格条件。依托北京市住房租赁监管平台核验本市户籍无房家庭住房租赁登记备案信息，租赁信息核验自5月6日与入学信息采集工作同步启动。入学禁止面试选拔市教委要求，各区教委和学校严格执行市教委统一规定的时间表和工作程序。严禁以考试成绩和各类竞赛证书、培训竞赛成绩、考级证明等作为招生依据。严禁以面试、评测等名义选拔学生。严禁学校和校外培训机构以培训班、校园开放日、冬夏令营等形式提前招生，选拔生源。严禁初中校违规在小学非毕业年级提前招生。严禁任何学校以实验班、特色班、国际部、国际课程班等名义招生。严禁以寄宿招生方式招收非寄宿学生。义务教育学校实行随机均衡编班，严禁分班前组织考试，严禁以任何名义设立重点班、快慢班、实验班。严禁校外培训机构曲解宣传入学政策，炒作公办学校排名，将培训成绩与入学挂钩。严禁任何学校私自招生。对于出现违规违纪行为的交有关部门依规依纪处理。各区教委要落实责任，加强管理。对存在违规行为的公办学校严肃处理，视情节轻重给予通报批评、追究相关人员责任直至免职。对存在违规行为的民办学校，视情节轻重给予通报批评、减少招生计划、警告、停止招生、吊销办学许可证等处理。对存在违规行为的校外培训机构，视情节轻重给予警告、罚款、停止招生、停止办学、吊销办学许可证等处罚，并纳入黑名单。民办学校招生纳入统一管理 民办学校与公办学校同步招生，纳入属地区教委统一管理。严格执行民办中小学招生简章、广告备案制度，公开公示招生计划、招生范围、招生方式、收费标准等，以招收其审批机关所在区域内学生为主。对于报名人数超过招生人数的民办学校，各区在现有工作基础上，指导学校采取电脑随机派位方式招生。各区要加大民办学校学籍监管力度，不得招收不符合条件的学生在校就读。全市统一规定民办学校招生要在5月25日至6月9日之间组织完成。";
    [self.view addSubview:label];
    NSArray *arr = [self getLinesArrayOfStringInLabel:label];
    
    
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
