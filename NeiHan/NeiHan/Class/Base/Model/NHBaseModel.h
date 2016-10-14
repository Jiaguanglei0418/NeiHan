//
//  NHBaseModel.h
//  NeiHan
//
//  Created by Guangleijia on 16/10/14.
//  Copyright © 2016年 Guangleijia. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NHBaseModel : NSObject

// 缓存
/** 归档 */
- (void)archieve;

/** 减档 */
- (void)unarchieve;

/** 移除 */
- (void)remove;

/** 字典数组 转 模型数组 */
+ (NSMutableArray *)modelArrayWithDictArray:(NSArray *)response;

/** 字典转模型 */
+ (instancetype)modelWithDictionary:(NSDictionary *)dictionary;

/** 模型包含模型数组 */
+ (void)setUpModelClassInArrayWithContainDict:(NSDictionary *)dict;


/**
 字典数组 转 模型数组 (模型包含模型数组)

 @param response response description
 @param dict     模型包含模型数组; key: 字段名称  value - 包含的类名

 @return <#return value description#>
 */
+ (NSMutableArray *)modelArrayWithDictArray:(NSArray *)response containDict:(NSDictionary *)dict;
@end
