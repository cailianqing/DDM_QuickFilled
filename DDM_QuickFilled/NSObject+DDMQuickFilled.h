//
//  NSObject+DDMQuickFilled.h
//  DDM_QuickFilled
//
//  Created by cailianqing on 2018/4/23.
//  Copyright © 2018年 cailianqing. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSObject (DDMQuickFilled)
/**
 创建实例并赋值
 @param fillInstance 源实例
 */
+ (instancetype)qf_assignmentFromInstance:(NSObject *)fillInstance;

/**
 实例赋值另一实例
 规则：同名属性直接赋值，如果有继承关系存在，赋值包括父类的属性值
 
 @param fillInstance 源实例
 */
- (void)qf_assignmentFromInstance:(NSObject *)fillInstance;

@end
