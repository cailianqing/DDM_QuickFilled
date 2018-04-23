//
//  Father.h
//  DDM_QuickFilled
//
//  Created by cailianqing on 2018/4/23.
//  Copyright © 2018年 cailianqing. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Mother.h"

typedef void (^testblock)(void);

@interface Father : NSObject
@property(nonatomic,copy)NSString * fatherName;
@property(nonatomic,assign)int age;
@property(nonatomic,strong)NSMutableArray *toys;
@property(nonatomic,copy)testblock block;
@property(nonatomic,strong)Mother *m;
@property(nonatomic,strong)NSMutableDictionary *dict;
@property(nonatomic,strong)NSMutableSet *aset;
@end
