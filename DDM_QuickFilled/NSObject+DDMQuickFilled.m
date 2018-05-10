//
//  NSObject+DDMQuickFilled.m
//  DDM_QuickFilled
//
//  Created by cailianqing on 2018/4/23.
//  Copyright © 2018年 cailianqing. All rights reserved.
//

#import "NSObject+DDMQuickFilled.h"
#import "NSObject+DDMRuntimeAPI.h"
#import "NSObject+DDMJudgeAPI.h"

@implementation NSObject (DDMQuickFilled)

#pragma mark -
#pragma mark - API
+ (instancetype)qf_assignmentFromInstance:(NSObject *)fillInstance
{
    id newInstance = [[[self class] alloc] init];
    [newInstance qf_assignmentFromInstance:fillInstance];
    return newInstance;
}

/**
 实例赋值另一实例
 规则：同名属性直接赋值，如果有继承关系存在，赋值包括父类的属性值
 
 @param fillInstance 源实例
 */
- (void)qf_assignmentFromInstance:(NSObject *)fillInstance
{
    [self assignmentFromInstance:fillInstance];
}

#pragma mark -
#pragma mark - 中介
- (void)assignmentFromInstance:(NSObject *)fillInstance
{
    if ([self isKindOfClass:[NSArray class]]) return;
    if ([self isKindOfClass:[NSDictionary class]]) return;
    
    @autoreleasepool {
        // 获取填充实例所有property
        NSArray *fillClassPropertys = [NSObject qf_getAllPropertiesAndVaulesToRootClass:[fillInstance class] andPropers:nil];
        NSArray *waitFillPropertys = [NSObject qf_getAllPropertiesAndVaulesToRootClass:[self class] andPropers:nil];
        
        // 避免KVC引起的奔溃，再遍历赋值前重写本类的setValue: forUndefinedKey:
        SEL originSEL = @selector(setValue:forUndefinedKey:);
        Method originMethod = class_getInstanceMethod([self class], originSEL);
        SEL newSEL = @selector(qf_setValue:forUndefinedKey:);
        Method newMethod = class_getInstanceMethod([self class], newSEL);
        
        [self qf_methodSwizzlingOriginSEL:originSEL originMethod:originMethod newSEL:newSEL newMethod:newMethod];
        
        // 遍历赋值
        [fillClassPropertys enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            if ([fillInstance valueForKey:obj] != nil && [waitFillPropertys containsObject:obj]) {
                
                if ([self qf_mutableCopyJudge:[fillInstance valueForKey:obj]]) {
                    [self setValue:[[fillInstance valueForKey:obj] mutableCopy] forKey:obj];
                }
                else if ([self qf_copyJudge:[fillInstance valueForKey:obj]])
                {
                    [self setValue:[[fillInstance valueForKey:obj] copy] forKey:obj];
                }
                else{
                    [self setValue:[fillInstance valueForKey:obj] forKey:obj];
                }
            }
        }];
    }
}

#pragma mark -
#pragma mark - 解决KVC冲突
- (void)qf_setValue:(id)value forUndefinedKey:(NSString *)key
{
    NSString *ssertString = [NSString stringWithFormat:@"KVC是出现了找不到的KEY的情况：%@",key];
    NSAssert(key != nil,ssertString);
}
@end
