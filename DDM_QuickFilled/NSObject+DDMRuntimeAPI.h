//
//  NSObject+DDMRuntimeAPI.h
//  DDM_QuickFilled
//
//  Created by cailianqing on 2018/4/23.
//  Copyright © 2018年 cailianqing. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <objc/runtime.h>

@interface NSObject (DDMRuntimeAPI)
/*
 获取对象的所有属性(递归到父类)
 */
+ (NSArray *)qf_getAllPropertiesAndVaulesToRootClass:(Class)obj
                                          andPropers:(NSMutableArray *)propers;

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
                          newMethod:(Method)newMethod;

@end
