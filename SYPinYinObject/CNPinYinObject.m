//
//  CNPinYinObject.m
//  zhangshaoyu
//
//  Created by zhangshaoyu on 2018/8/9.
//  Copyright © 2018年 zhangshaoyu. All rights reserved.
//

#import "CNPinYinObject.h"

@implementation CNPinYinObject

// 汉语转汉语拼音（字符串转换），只要首拼
+ (CNPinYinModel *)transformCNPinYinText:(NSString *)chinese toneType:(CNPinYinToneType)toneType alphabetType:(CNPinYinType)alphabetType hasPrefix:(BOOL)isTrue
{
    NSMutableString *pinyin = [chinese mutableCopy];
    //
    // 带音标kCFStringTransformMandarinLatin
    CFStringTransform((__bridge CFMutableStringRef)pinyin, NULL, kCFStringTransformMandarinLatin, NO);
    if (toneType == CNPinYinToneTypeWithout) {
        // 无音标kCFStringTransformStripCombiningMarks
        CFStringTransform((__bridge CFMutableStringRef)pinyin, NULL, kCFStringTransformStripCombiningMarks, NO);
    }
    //
    if (alphabetType == CNPinYinTypeDefalut) {
        pinyin = (NSMutableString *)[pinyin lowercaseString];
    } else if (alphabetType == CNPinYinTypeUpper) {
        pinyin = (NSMutableString *)[pinyin uppercaseString];
    } else if (alphabetType == CNPinYinTypeCapitalized) {
        pinyin = (NSMutableString *)[pinyin capitalizedString];
    }
    //
    if (isTrue) {
        if (pinyin.length > 0) {
            pinyin = (NSMutableString *)[pinyin substringWithRange:NSMakeRange(0, 1)];
        }
    }
    CNPinYinModel *model = [CNPinYinModel new];
    model.valueCN = chinese;
    model.valueAlphabet = pinyin;
    return model;
}

// 汉语转汉语拼音（数据字符串转换）
+ (NSArray *)transformCNPinYinArray:(NSArray *)chineseArray toneType:(CNPinYinToneType)toneType alphabetType:(CNPinYinType)alphabetType hasPrefix:(BOOL)isTrue
{
    NSMutableArray *results = [[NSMutableArray alloc] init];
    for (NSString *chinese in chineseArray) {
        CNPinYinModel *model = [self transformCNPinYinText:chinese toneType:toneType alphabetType:alphabetType hasPrefix:isTrue];
        [results addObject:model];
    }
    return results;
}

// 汉语转汉语拼音（数组字符串转换-按拼音排序），是否分组（若分组则只有一个首拼）
+ (NSArray *)transformCNPinYinSeparatedArray:(NSArray *)chineseArray alphabetType:(CNPinYinType)type hasPrefix:(BOOL)isTrue group:(BOOL)isGrouping
{
    BOOL hasPrefix = isTrue;
    if (isGrouping) {
        hasPrefix = YES;
    }
    NSArray *results = [self transformCNPinYinArray:chineseArray toneType:CNPinYinToneTypeWithout alphabetType:type hasPrefix:hasPrefix];
    // ascending:YES 代表升序 如果为NO 代表降序
    results = [self sortCNPinYin:results];
    //
    if (isGrouping) {
        results = [self groupingCNPinYin:results];
    }
    return results;
}

/// 按字母排序（汉语转换汉语拼音后的数组）
+ (NSArray *)sortCNPinYin:(NSArray *)array
{
    NSSortDescriptor *sort = [NSSortDescriptor sortDescriptorWithKey:@"valueAlphabet" ascending:YES];
    NSArray *results = [[array sortedArrayUsingDescriptors:@[sort]] mutableCopy];
    return results;
}

/// 按字母分组（汉语转换拼音后且已排序的数组）
+ (NSArray *)groupingCNPinYin:(NSArray *)array
{
    NSMutableArray *results = [[NSMutableArray alloc] init];
    for (int i = 0; i < array.count; ) {
        NSMutableArray *grounpsTmp = [[NSMutableArray alloc] init];
        CNPinYinModel *model = array[i];
        [grounpsTmp addObject:model];
        int j = i + 1;
        int length = 1;
        while (j < array.count && ([[array[j] valueAlphabet] isEqualToString:model.valueAlphabet])) {
            [grounpsTmp addObject:array[j]];
            j++;
            length++;
        }
        i += length;
        //
        CNPinYinModel *modelSuper = [CNPinYinModel new];
        modelSuper.sortKey = model.valueAlphabet;
        modelSuper.sortArray = grounpsTmp;
        [results addObject:modelSuper];
    }
    return results;
}

@end


@implementation CNPinYinModel

@end



