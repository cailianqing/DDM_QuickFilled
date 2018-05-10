//
//  NSObject+DDMRuntimeAPI.m
//  DDM_QuickFilled
//
//  Created by cailianqing on 2018/4/23.
//  Copyright © 2018年 cailianqing. All rights reserved.
//

#import "NSObject+DDMRuntimeAPI.h"

@implementation NSObject (DDMRuntimeAPI)
#pragma mark -
#pragma mark - Runtime_Property相关接口
/*
 获取对象的所有属性(递归到父类)
 */
+ (NSArray *)qf_getAllPropertiesAndVaulesToRootClass:(Class)obj andPropers:(NSMutableArray *)propers
{
    if (propers == nil) {
        propers = [NSMutableArray array];
    }
    Class superClassName = [obj superclass];
    if (superClassName==nil || [superClassName isMemberOfClass:[NSObject class]]) {
        return propers;
    }
    else{
        unsigned int outCount;
        objc_property_t *properties = class_copyPropertyList(obj, &outCount);
        for ( int i = 0; i<outCount; i++)
        {
            objc_property_t property = properties[i];
            const char* char_f = property_getName(property);
            NSString *propertyName = [NSString stringWithUTF8String:char_f];
            [propers addObject:propertyName];
        }
        free(properties);
        return [NSObject qf_getAllPropertiesAndVaulesToRootClass:superClassName andPropers:propers];
    }
}
#pragma mark -
#pragma mark - Runtime_Method相关接口
/**
 方法交换
 
 @param originSEL 原选择子
 @param oldMethod 原方法
 @param newSEL 新方法子
 @param newMethod 新方法
 */
- (void)qf_methodSwizzlingOriginSEL:(SEL)originSEL
                       originMethod:(Method)oldMethod
                             newSEL:(SEL)newSEL
                          newMethod:(Method)newMethod
{
    IMP newIMP = method_getImplementation(newMethod);
    BOOL addMethodSuccess = class_addMethod([self class], newSEL, newIMP, method_getTypeEncoding(newMethod));
    if (addMethodSuccess) {
        class_replaceMethod([self class], originSEL, newIMP, method_getTypeEncoding(newMethod));
    }else{
        method_exchangeImplementations(oldMethod, newMethod);
    }
}

@end
