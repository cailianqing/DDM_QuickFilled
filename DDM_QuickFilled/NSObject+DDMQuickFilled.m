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
    if ([self isKindOfClass:[NSArray class]]) return [self mutableCopy];
    if ([self isKindOfClass:[NSDictionary class]]) return [self mutableCopy];
    
    id newInstance = [[[self class] alloc] init];
    [newInstance qf_assignmentFromInstance:fillInstance];
    return newInstance;
}

- (void)qf_assignmentFromInstance:(NSObject *)fillInstance
{
    [self assignmentFromInstance:fillInstance];
}

#pragma mark -
#pragma mark - 中介
- (void)assignmentFromInstance:(NSObject *)fillInstance
{
    // 如果是集合类 直接copy赋值
    if ([self isKindOfClass:[NSArray class]])
        {
            [self mutableCopy];
            return;
        }
    if ([self isKindOfClass:[NSDictionary class]])
        {
            [self mutableCopy];
            return;
        }
    
    @autoreleasepool {
        // 获取填充实例所有property
        NSArray *fillClassPropertys = [NSObject propertyCacheWithClass:[fillInstance class]];
        NSArray *waitFillPropertys = [NSObject propertyCacheWithClass:[self class]];

        // 避免KVC引起的奔溃，再遍历赋值前重写本类的setValue: forUndefinedKey:
        SEL originSEL = @selector(setValue:forUndefinedKey:);
        Method originMethod = class_getInstanceMethod([self class], originSEL);
        SEL newSEL = @selector(qf_setValue:forUndefinedKey:);
        Method newMethod = class_getInstanceMethod([self class], newSEL);
        
        [self qf_methodSwizzlingOriginSEL:originSEL originMethod:originMethod newSEL:newSEL newMethod:newMethod];
        
        // 遍历赋值
        [fillClassPropertys enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            id valueOfProperty = [fillInstance valueForKey:obj];
            if (valueOfProperty != nil && [waitFillPropertys containsObject:obj]) {
                
                if ([self qf_mutableCopyJudge:valueOfProperty]) {
                    [self setValue:[valueOfProperty mutableCopy] forKey:obj];
                }
                else if ([self qf_copyJudge:valueOfProperty])
                {
                    [self setValue:[valueOfProperty copy] forKey:obj];
                }
                else{
                    [self setValue:valueOfProperty forKey:obj];
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

#pragma mark -
#pragma mark - 缓存
+ (NSArray *)propertyCacheWithClass:(Class)cls {
    if (!cls) return nil;
    static CFMutableDictionaryRef cache;
    static dispatch_once_t onceToken;
    static dispatch_semaphore_t lock;
    dispatch_once(&onceToken, ^{
        cache = CFDictionaryCreateMutable(CFAllocatorGetDefault(), 0, &kCFTypeDictionaryKeyCallBacks, &kCFTypeDictionaryValueCallBacks);
        lock = dispatch_semaphore_create(1);
    });
    dispatch_semaphore_wait(lock, DISPATCH_TIME_FOREVER);
    NSArray *propertyCache = CFDictionaryGetValue(cache, (__bridge const void *)(cls));
    dispatch_semaphore_signal(lock);
    if (!propertyCache) {
        propertyCache = [NSObject qf_getAllPropertiesAndVaulesToRootClass:cls andPropers:nil];
        if (propertyCache) {
            dispatch_semaphore_wait(lock, DISPATCH_TIME_FOREVER);
            CFDictionarySetValue(cache, (__bridge const void *)(cls), (__bridge const void *)(propertyCache));
            dispatch_semaphore_signal(lock);
        }
    }
    return propertyCache;
}
@end
