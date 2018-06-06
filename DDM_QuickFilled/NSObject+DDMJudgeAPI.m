//
//  NSObject+DDMJudgeAPI.m
//  DDM_QuickFilled
//
//  Created by cailianqing on 2018/4/23.
//  Copyright © 2018年 cailianqing. All rights reserved.
//

#import "NSObject+DDMJudgeAPI.h"
#import <objc/runtime.h>

@implementation NSObject (DDMJudgeAPI)
/**
 模型可变类型判断mutableCopy
 
 @param obj 实例
 @return 可变返回YES
 */
- (BOOL)qf_mutableCopyJudge:(NSObject *)obj
{
    NSString *isaString = [NSString stringWithUTF8String:class_getName(objc_getMetaClass(object_getClassName(obj)))];
    BOOL mutableArray = [isaString isEqualToString:@"__NSArrayM"];
    BOOL mutableDict = [isaString isEqualToString:@"__NSDictionaryM"];
    BOOL mutableSet = [isaString isEqualToString:@"__NSSetM"];
    return mutableArray || mutableDict || mutableSet;
}

/**
 模型可变类型判断copy
 
 @param obj 实例
 @return 可变返回YES
 */
- (BOOL)qf_copyJudge:(NSObject *)obj
{
    NSString *isaString = [NSString stringWithUTF8String:class_getName(objc_getMetaClass(object_getClassName(obj)))];
    BOOL mutableGlobalBlock = [isaString isEqualToString:@"__NSGlobalBlock__"];
    BOOL mutableStackBlock = [isaString isEqualToString:@"__NSStackBlock__"];
    BOOL mutableMallocBlock = [isaString isEqualToString:@"__NSMallocBlock__"];

    return mutableGlobalBlock || mutableStackBlock || mutableMallocBlock ;
}
@end
