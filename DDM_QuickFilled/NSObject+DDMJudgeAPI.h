//
//  NSObject+DDMJudgeAPI.h
//  DDM_QuickFilled
//
//  Created by cailianqing on 2018/4/23.
//  Copyright © 2018年 cailianqing. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSObject (DDMJudgeAPI)
/**
 判断是否集合类
 
 @param obj 实例
 @return 可变返回YES
 */
- (BOOL)qf_mutableCopyJudge:(NSObject *)obj;

/**
 判断是否block类
 
 @param obj 实例
 @return 可变返回YES
 */
- (BOOL)qf_copyJudge:(NSObject *)obj;
@end
