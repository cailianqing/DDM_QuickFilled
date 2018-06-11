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
- // 缓存！！！多次对一个类遍历可能效率不好。这里可以参考YYModel大神的思路来考虑一下如何实现。
- YYMolde讲类的粒度拆分的很细，对类的每一个部分进行了分解。然后对整合之后的类进行了缓存。我这里采用了直接对遍历出来的数组进行缓存
- 这个需要一个标记位来判定什么时候这个缓存需要更新，可能还是需要像YYModel一样精细粒度

### 4.性能测试
- 缓存与为缓存
 - 两个类有缓存执行9999次
 - ![iamge](https://raw.githubusercontent.com/cailianqing/MacDownScreenRepsitory/master/picture_%E4%BB%A3%E7%A0%81%E5%B7%A5%E7%A8%8B%E7%86%9F%E6%82%89/%E6%9C%89%E7%BC%93%E5%AD%98%E4%B8%A4%E4%B8%AA%E7%B1%BB%E5%AF%B9%E6%AF%94.jpg)
 - 两个类无缓存执行9999次
 - ![iamge](https://raw.githubusercontent.com/cailianqing/MacDownScreenRepsitory/master/picture_%E4%BB%A3%E7%A0%81%E5%B7%A5%E7%A8%8B%E7%86%9F%E6%82%89/%E6%97%A0%E7%BC%93%E5%AD%98%E4%B8%A4%E4%B8%AA%E7%B1%BB%E5%AF%B9%E6%AF%94.jpg)
 - 三个类有缓存执行9999次
 - ![iamge](https://raw.githubusercontent.com/cailianqing/MacDownScreenRepsitory/master/picture_%E4%BB%A3%E7%A0%81%E5%B7%A5%E7%A8%8B%E7%86%9F%E6%82%89/%E6%9C%89%E7%BC%93%E5%AD%98%E4%B8%89%E4%B8%AA%E7%B1%BB%E5%AF%B9%E6%AF%94.jpeg)
 - 三个类无缓存执行9999次
 - ![iamge](https://raw.githubusercontent.com/cailianqing/MacDownScreenRepsitory/master/picture_%E4%BB%A3%E7%A0%81%E5%B7%A5%E7%A8%8B%E7%86%9F%E6%82%89/%E6%97%A0%E7%BC%93%E5%AD%98%E4%B8%89%E4%B8%AA%E7%B1%BB%E5%AF%B9%E6%AF%94.jpeg)
- 内存占用