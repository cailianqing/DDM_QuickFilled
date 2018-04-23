//
//  ViewController.m
//  DDM_QuickFilled
//
//  Created by cailianqing on 2018/4/23.
//  Copyright © 2018年 cailianqing. All rights reserved.
//

#import "ViewController.h"
#import "Father.h"
#import "Son.h"
#import "Mother.h"
#import "NSObject+DDMQuickFilled.h"
@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // 父填充子
    Father *firstFather = [[Father alloc]init];
    firstFather.fatherName = @"clq";
    firstFather.toys = [NSMutableArray arrayWithObjects:@"1",@"2",@"3",nil];
    firstFather.age = 10;
    firstFather.block = ^{
        NSLog(@"1");
    };

    Son *firstSon = [Son qf_assignmentFromInstance:firstFather];
    firstSon.sonName = @"test son";
    firstSon.block = ^{
        NSLog(@"2");
    };
    
    firstFather.block();
    firstSon.block();
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}


@end
