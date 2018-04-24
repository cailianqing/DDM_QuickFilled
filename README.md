# DDM_QuickFilled

- 模型快速填充（赋值）小轮子

### 1.使用方法
- 指定实例赋值：


```
    Father *firstFather = [[Father alloc]init];
    firstFather.fatherName = @"clq";
    firstFather.toys = [NSMutableArray arrayWithObjects:@"1",@"2",@"3",nil];
    firstFather.age = 10;
    
    Son *firstSon = [Son qf_assignmentFromInstance:firstFather];
```
- 未指定实例赋值：
 
```
    Father *firstFather = [[Father alloc]init];
    firstFather.fatherName = @"clq";
    firstFather.toys = [NSMutableArray arrayWithObjects:@"1",@"2",@"3",nil];
    firstFather.age = 10;
    
    Son *firstSon = [[Son alloc]init];
    [firstSon qf_assignmentFromInstance:firstFather];
```

### 2.使用场景
- 在不同VC跳转的时，不同VC需要的模型不同。这里可以用该轮子来给不同VC装配不同模型

### 3.存在问题
- 内容直接是浅拷贝或者指针赋值。会出现恶意篡改的情况发生（暂已修改）
- 缓存！！！多次对一个类遍历可能效率不好。这里可以参考YYModel大神的思路来考虑一下如何实现。


