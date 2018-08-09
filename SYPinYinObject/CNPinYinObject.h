//
//  CNPinYinObject.h
//  zhangshaoyu
//
//  Created by zhangshaoyu on 2018/8/9.
//  Copyright © 2018年 zhangshaoyu. All rights reserved.
//

#import <Foundation/Foundation.h>
@class CNPinYinModel;

/// 汉字转拼单音调类型
typedef NS_ENUM(NSInteger, CNPinYinToneType) {
    /// 有音调
    CNPinYinToneTypeDefalut = 0,
    /// 无音调
    CNPinYinToneTypeWithout = 1
};

/// 汉字转拼音大小写类型
typedef NS_ENUM(NSInteger, CNPinYinType)
{
    /// 小写
    CNPinYinTypeDefalut = 0,
    /// 大写
    CNPinYinTypeUpper = 1,
    /// 首字母大写
    CNPinYinTypeCapitalized = 2
};

@interface CNPinYinObject : NSObject

/// 汉语转汉语拼音（字符串转换），只要首拼
+ (CNPinYinModel *)transformCNPinYinText:(NSString *)chinese toneType:(CNPinYinToneType)toneType alphabetType:(CNPinYinType)alphabetType hasPrefix:(BOOL)isTrue;

/// 汉语转汉语拼音（数组字符串转换）
+ (NSArray *)transformCNPinYinArray:(NSArray *)chineseArray toneType:(CNPinYinToneType)toneType alphabetType:(CNPinYinType)alphabetType hasPrefix:(BOOL)isTrue;

/// 汉语转汉语拼音（数据字符串转换-按拼音排序），是否分组（若分组则只有一个首拼）
+ (NSArray *)transformCNPinYinSeparatedArray:(NSArray *)chineseArray alphabetType:(CNPinYinType)type hasPrefix:(BOOL)isTrue group:(BOOL)isGrouping;

/// 按字母排序（汉语转换汉语拼音后的数组）
+ (NSArray *)sortCNPinYin:(NSArray *)array;

/// 按字母分组（汉语转换拼音后且已排序的数组）
+ (NSArray *)groupingCNPinYin:(NSArray *)array;

@end


@interface CNPinYinModel : NSObject

/// 分组时的分组标题
@property (nonatomic, strong) NSString *sortKey;
/// 分组时的分组数组
@property (nonatomic, strong) NSArray *sortArray;

@property (nonatomic, strong) NSString *valueCN;
@property (nonatomic, strong) NSString *valueAlphabet;

@property (nonatomic, assign) BOOL isSelected;

@end
