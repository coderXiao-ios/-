//
//  NSString+Category
//  gs_1210
//
//  Created by musoon on 15/1/2.
//  Copyright (c) 2015年 areo. All rights reserved.
//

#import "NSString+Category.h"

@implementation NSString (Category)




//TODO:没有适配
+(CGRect)contentRectNoAdapterWithString:(NSString *)string labelScreenWith:(CGFloat)screenwith AndStringFont:(int)floatnumber
{
    UIFont *font ;
    CGRect tmpRect = [string boundingRectWithSize:CGSizeMake(screenwith, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:[NSDictionary dictionaryWithObjectsAndKeys:font,NSFontAttributeName, nil] context:nil];
    
    return tmpRect;
    
}


+ (CGSize)stringCGSize:(NSString *)str font:(UIFont *)font width:(CGFloat)width height:(CGFloat)height {
    
    str = [NSString toStr: str];
    
    if (nil == font) {
        font = [UIFont systemFontOfSize: 15];
    }
    //    CGSize size = [str sizeWithFont: font constrainedToSize: CGSizeMake(width, height)];
    
    
    CGRect tmpRect = [str boundingRectWithSize:CGSizeMake(width, height) options:NSStringDrawingUsesLineFragmentOrigin attributes:[NSDictionary dictionaryWithObjectsAndKeys:font,NSFontAttributeName, nil] context:nil];

    
    return tmpRect.size;
}

+(CGFloat)sizeWithString:(NSString *)str font:(UIFont *)font width:(CGFloat)width height:(CGFloat)height {
    
    str = [NSString toStr: str];
    
    CGRect tmpRect = [str boundingRectWithSize:CGSizeMake(width == 0 ? MAXFLOAT : width , height == 0 ? MAXFLOAT : height) options:NSStringDrawingUsesLineFragmentOrigin attributes:[NSDictionary dictionaryWithObjectsAndKeys:font,NSFontAttributeName, nil] context:nil];
    
    
    return width == 0 ? tmpRect.size.width : tmpRect.size.height;
    
}

+ (NSString *)verticalString:(NSString *)string{
    NSMutableString * str = [[NSMutableString alloc] initWithString:string];
    NSInteger count = str.length;
    for (int i = 1; i < count; i ++) {
        [str insertString:@"\n" atIndex:i*2 - 1];
    }
    return str;
}

+ (CGSize)stringCGSize:(NSString *)str font:(UIFont *)font width:(CGFloat)width {
    
    str = [NSString toStr: str];
    
     
    
//    CGSize size = [str sizeWithFont: font constrainedToSize: CGSizeMake(width, MAXFLOAT)];
//    
//    return size;
    
    
    CGRect tmpRect = [str boundingRectWithSize:CGSizeMake(width, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:[NSDictionary dictionaryWithObjectsAndKeys:font,NSFontAttributeName, nil] context:nil];
    
    
    return tmpRect.size;
}

+ (CGSize)stringCGSize:(NSString *)str font:(UIFont *)font height:(CGFloat)height {
    
    str = [NSString toStr: str];
    
    if (nil == font) {
        font = [UIFont systemFontOfSize: 15];
    }
    
//    CGSize size = [str sizeWithFont: font constrainedToSize: CGSizeMake(MAXFLOAT, height)];
//    
//    return size;
    
    CGRect tmpRect = [str boundingRectWithSize:CGSizeMake(MAXFLOAT, height) options:NSStringDrawingUsesLineFragmentOrigin attributes:[NSDictionary dictionaryWithObjectsAndKeys:font,NSFontAttributeName, nil] context:nil];
    
    
    return tmpRect.size;
    
}





+ (BOOL) isBlankString:(NSString *)string {
    
    if ([string isKindOfClass:[NSNumber class]]) {
        
        return NO;
    }
    
    if (string == nil || string == NULL) {
        return YES;
    }
    
    if ([string isKindOfClass:[NSNull class]]) {
        return YES;
    }
    if ([string isKindOfClass: [NSNumber class]]) {
        return NO;
    }
    
    if ([[string stringByTrimmingCharactersInSet: [NSCharacterSet whitespaceCharacterSet]] length]==0) {
        return YES;
    }
    return NO;
}


+ (NSString *)toStr:(id)string {
    if (string == nil || string == NULL) {
        return @"";
    }
    if ([string isKindOfClass:[NSNull class]]) {
        return @"";
    }
    
    if ([string isKindOfClass: [NSNumber class]]) {
        return [NSString stringWithFormat: @"%@", string];
    }
    
    if ([[string stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]] length]==0) {
        return @"";
    }
    return string;
}


/**
 *  去左右空格
 *
 *  @param string 待去空格的字符串
 *
 *  @return 处理完的字符串
 */
+ (NSString *)trim:(NSString *)string {
    NSString *trimString = [string stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
    return trimString;
}


/**
 *  @author YYang, 16-02-08 23:02:52
 *
 *  姓名脱敏
 *
 *  @param name 名字
 *
 *  @return 脱敏名字
 */
+(NSString *)nameMask:(NSString *)name{
    
    NSMutableString *custNameDeal = [NSMutableString stringWithString:[name substringToIndex:1]];
    
    for (int i=0; i<name.length-1; i++) {
        [custNameDeal appendString:@"*"];
    }
    
    return custNameDeal;
}


/**
 *  @author YYang, 16-02-08 23:02:20
 *
 *  身份证号脱敏
 *
 *  @param idNum 身份证脱敏
 *
 *  @return 脱敏身份证号
 */
+(NSString *)idCardNumMask:(NSString *)idNum{
    
    if (idNum.length<7) return idNum;
    
    NSMutableString *idNumDeal = [NSMutableString stringWithString:[idNum substringToIndex:6]];
    
    for (int i=0; i<idNum.length-1; i++) {
        [idNumDeal appendString:@"*"];
    }
    
    return idNumDeal;
}

/*!
 字符串转数字逗号分隔 3位分隔一次
 @param num 输入字符串
 @return 逗号分隔成的3位字符串
 */
+(NSString *)countNumAndChangeformat:(NSString *)num
{
    int count = 0;
    long long int a = num.longLongValue;
    if (a < 100) {
        return [NSString stringWithFormat:@"%lld",a];
    }
    while (a != 0)
    {
        count++;
        a /= 10;
    }
    NSMutableString *string = [NSMutableString stringWithString:num];
    NSMutableString *newstring = [NSMutableString string];
    while (count > 3) {
        count -= 3;
        NSRange rang = NSMakeRange(string.length - 3, 3);
        NSString *str = [string substringWithRange:rang];
        [newstring insertString:str atIndex:0];
        [newstring insertString:@"," atIndex:0];
        [string deleteCharactersInRange:rang];
    }
    [newstring insertString:string atIndex:0];
    return newstring;
}

+(NSString*)dictionaryToJson:(NSDictionary *)dic
{

    if (!dic) return @"";
    
    NSError *parseError = nil;

    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:dic options:NSJSONWritingPrettyPrinted error:&parseError];
    NSString *jsonString = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];


//    NSMutableString *responseString = [NSMutableString stringWithString:jsonString];
//    NSString *character = nil;
//    for (int i = 0; i < responseString.length; i ++) {
//        character = [responseString substringWithRange:NSMakeRange(i, 1)];
//        if ([character isEqualToString:@"\n"]){
//            [responseString deleteCharactersInRange:NSMakeRange(i, 1)];
//        }else if ([character isEqualToString:@"\\"]){
//            [responseString deleteCharactersInRange:NSMakeRange(i, 1)];
//        }
//    }
//
//    NSMutableString *  js = [NSMutableString stringWithString:responseString];
//    for (int i = 0; i < js.length; i ++) {
//        character = [js substringWithRange:NSMakeRange(i, 1)];
//        if ([character isEqualToString:@"\""]){
//            [js deleteCharactersInRange:NSMakeRange(i, 1)];
//        }
//    }



    return jsonString;
    
}
+(NSString*)CantianStringChange:(NSString *)String{

    NSString * substr = @"img.hefantv.com";
    NSString * SubString = String;

    if ([SubString containsString:substr]) {//包含
        NSString * firstr = [NSString stringWithFormat:@"%@%@",String,@"@80w"];
        NSArray * secondArr =  [firstr componentsSeparatedByString:@"@80w"];
        NSString * ThiredStr = [NSString stringWithFormat:@"%@%@",[secondArr firstObject],@"@80w"];

        SubString = ThiredStr;

    }else{// 不存在
        if ([SubString containsString:@"@80w"]) {
            SubString = [[SubString componentsSeparatedByString:@"@80w"] firstObject];
        }


    }


    return SubString;


}
+(NSString *)StringSubTitle:(NSString *)title{
    if (title.length <= 6) {
        return title;
    }else{
        return [title substringToIndex:6];
    }
}
+ (NSString *)StringSubDetail:(NSString *)detail{
    if (detail.length <= 20) {
        return detail;
    }else{
//        return  [NSString stringWithFormat:@"%@...",[detail substringToIndex:20]];
        return [NSString stringWithFormat:@"%@...", [self subStringWith:detail ToIndex:20]];
    }
}
+(NSString *)stringSubString:(NSString *)string isWithLength:(NSInteger)IndexLength{
    if (string.length <= IndexLength) {
        return string;
    }else{
        return [NSString stringWithFormat:@"%@...",[self subStringWith:string ToIndex:IndexLength]];
    }
}
 + (NSString *)subStringWith:(NSString *)string ToIndex:(NSInteger)index{
    
    NSString *result = string;
    if (result.length > index) {
        NSRange rangeIndex = [result rangeOfComposedCharacterSequenceAtIndex:index];
        result = [result substringToIndex:(rangeIndex.location)];
    }
    
    return result;
}

- (NSAttributedString *)attributedWithSubString:(NSString *)subString color:(UIColor *)color {
    
    NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString:self];
    if (!subString || subString.length == 0) {
        return attributedString;
    }
    NSRange range = [self rangeOfString:subString];
    if (range.location != NSNotFound) {
        [attributedString addAttributes:@{NSForegroundColorAttributeName : color} range:range];
    }
    return attributedString;
}



+ (NSString *)getShowDateNoYestodayWithTime:(long long)time{
    /**
     传入时间转NSDate类型
     */
    NSDate *timeDate = [[NSDate alloc]initWithTimeIntervalSince1970:time/1000.0];
    
    /**
     初始化并定义Formatter
     
     :returns: NSDate
     */
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    dateFormatter.dateFormat = @"yyyy-MM-dd HH:mm";
    
    NSDateFormatter *commondateFormatter = [[NSDateFormatter alloc] init];
    commondateFormatter.dateFormat = @"yyyy-MM-dd";
    NSString * returnStr=[commondateFormatter stringFromDate:timeDate];
    
    /**
     *  使用Formatter格式化时间（传入时间和当前时间）为NSString
     */
    NSString *timeStr = [dateFormatter stringFromDate:timeDate];
    NSString *nowDateStr = [dateFormatter stringFromDate:[NSDate date]];
    
    /**
     *  判断前四位是不是本年，不是本年直接返回完整时间
     */
    if ([[timeStr substringWithRange:NSMakeRange(0, 4)] rangeOfString:[nowDateStr substringWithRange:NSMakeRange(0, 4)]].location == NSNotFound) {
        return returnStr;
    }else{
        /**
         *  判断是不是本天，是本天返回HH:mm,不是返回MM-dd HH:mm
         */
        if ([[timeStr substringWithRange:NSMakeRange(5, 5)] rangeOfString:[nowDateStr substringWithRange:NSMakeRange(5, 5)]].location != NSNotFound) {
            return [timeStr substringWithRange:NSMakeRange(11, 5)];
        }else{
            //不是本天，则按照规则进行判断
            NSString * hour=[nowDateStr substringWithRange:NSMakeRange(11,2)];
            NSString * minite=[nowDateStr substringWithRange:NSMakeRange(14,2)];
            //昨天零点时间
            long long nowseconds=[NSDate date].timeIntervalSince1970-hour.longLongValue*60*60-minite.longLongValue*60-(long long)24*3600;
            //一周时间
            long long weekSeconds=[NSDate date].timeIntervalSince1970-hour.longLongValue*60*60-minite.longLongValue*60-(long long)7*24*3600;
            if(time/1000.0>nowseconds){
                //昨天时间
                commondateFormatter.dateFormat = @"HH:mm";
                NSString * timestr=[commondateFormatter stringFromDate:timeDate];
                returnStr = [NSString stringWithFormat:@"昨天%@",timestr];
                return returnStr;
            }else if(time/1000.0>weekSeconds){
                //早于昨天，大于一周，则按照周几显示
                NSArray *weekdays = [NSArray arrayWithObjects: [NSNull null], @"星期日", @"星期一", @"星期二", @"星期三", @"星期四", @"星期五", @"星期六", nil];
                NSCalendar *calendar = [NSCalendar currentCalendar];
                NSDateComponents *theComponents = [calendar components:NSCalendarUnitWeekday fromDate:timeDate];
                
                commondateFormatter.dateFormat = @"HH:mm";
                NSString *timestr=[commondateFormatter stringFromDate:timeDate];
                return [NSString stringWithFormat:@"%@ %@",[weekdays objectAtIndex:theComponents.weekday],timestr];
            }else{
                commondateFormatter.dateFormat = @"HH:mm";
                NSString *timestr=[commondateFormatter stringFromDate:timeDate];
                return  [NSString stringWithFormat:@"%@ %@",returnStr,timestr];
            }
        }
    }
    
    return returnStr;

}


- (BOOL)isNumber{
    NSString * regex = @"^[0-9]*$";
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regex];
    return [predicate evaluateWithObject:self];
}


+ (NSString *)setupToolbarTitleCount:(NSInteger)count defaultTitle:(NSString *)defaultTitle
{
    if (count > 9999) {
        defaultTitle = [NSString stringWithFormat:@"%.1fW",floor((double)count/1000.0)/10.0];
    }else{
        if (count != 0) {
            defaultTitle = [NSString stringWithFormat:@"%ld",(long)count];
        }
    }
    return defaultTitle;
}

+ (NSString *)removeTheDecimalRedundantZero:(NSString *)decimalStr{
    NSNumberFormatter *formatter = [[NSNumberFormatter alloc] init];
    formatter.numberStyle = kCFNumberFormatterDecimalStyle;
    [formatter setRoundingMode:NSNumberFormatterRoundDown];
    [formatter setMaximumFractionDigits:2];
    formatter.groupingSeparator = @"";
    NSString *formatterString = [formatter stringFromNumber:[NSNumber numberWithDouble:[decimalStr doubleValue]]];
    return formatterString;
}

- (BOOL)removeSpacesAndLinesMinWordsNum:(NSUInteger)num
{
    if (!self&&self.length == 0 ) return NO;
    NSString *string = [self stringByReplacingOccurrencesOfString:@" " withString:@""];
    string = [string stringByReplacingOccurrencesOfString:@"\n" withString:@""];
    if (!string && string.length == 0) {
        return NO;
    } else if (string.length >= num) {
        return YES;
    }
    return NO;
}

@end
