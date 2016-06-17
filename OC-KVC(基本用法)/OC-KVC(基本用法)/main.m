//
//  main.m
//  OC-KVC(基本用法)
//
//  Created by qingyun on 16/4/11.
//  Copyright © 2016年 QingYun. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Student.h"
#import "TestClass.h"
#import "Teacher.h"
#define NAME @"name"

int main(int argc, const char * argv[]) {
    @autoreleasepool {
        // KVC--->基础语法
        NSDictionary *dic=[NSDictionary dictionaryWithObjectsAndKeys:@"xiaoming",@"name",@(21),@"age", nil];
        //要想添加新的键值对，必须字典可变！
        NSMutableDictionary *mulDic1=[NSMutableDictionary dictionaryWithDictionary:dic];
        [mulDic1 setObject:@"男" forKey:@"sex"];
        //KVC用法-设置键值对
        [mulDic1 setValue:@"高新区" forKey:@"address"];
        NSLog(@"mulDic1=,%p,%@",mulDic1,mulDic1);
        //读取键值对
        NSLog(@"%@,%@",[mulDic1 objectForKey:@"name"],[mulDic1 valueForKey:@"age"]);
        
        Student *s1=[Student new];
        //以前的写法
        s1.name=@"小明";
        [s1 setAge:21];
        NSLog(@"s1=%@",s1);
        //KVC去写  编译不报错
        [s1 setValue:@"小红" forKey:@"name"];// 注意：关键字必须是属性！，否则崩溃！
        NSLog(@"s1=%@",s1);
        NSLog(@"age=%@",[s1 valueForKey:@"age"]);//取值
        
        //字典转化为模型
        //1.对应的键值为对应的各个属性赋值
        s1.name=mulDic1[@"name"];
        s1.age=[mulDic1[@"age"] intValue];
        //快速赋值
        for (id key in mulDic1)
        {
            [s1 setValue:mulDic1[key] forKey:key];
        }
        NSLog(@"s1=%@",s1);
        
        //KVC的NB地方
        //1.快速转为模型对象
        [s1 setValuesForKeysWithDictionary:mulDic1];
        NSLog(@"s1=>%@",s1);
        //2.可以自动拆箱数值
        [s1 setValue:@(18) forKey:@"age"];
        NSLog(@"%d",s1.age);
        //3.可以设置和访问私有属性和私有成员变量
        [s1 setValue:@"1603101" forKey:@"stuID"];
        NSLog(@"%@",[s1 valueForKey:@"stuID"]);
        [s1 setValue:@(98.5) forKey:@"score"];
        NSLog(@"%@",[s1 valueForKey:@"score"]);
        //4.可以为只读属性赋值
        [s1 setValue:@"8821908" forKey:@"telephone"];
        NSLog(@"s1=>%@",[s1 valueForKey:@"telephone"]);
        //5.可以不用确定对象的具体类型
        [TestClass showInfo:s1];
        Teacher *t1=[Teacher new];
        [t1 setValue:@"teacher-wang" forKey:@"name"];
        [t1 setValue:@(26) forKey:@"age"];
        [TestClass showInfo:t1];
        
        //键值路径 setValue: forKeyPath:
//        BOOK *b1=[BOOK new];
////        [s1 setBook:b1];
        s1.book.bookName=@"三国演义";
        NSLog(@"%@",s1.book.bookName);
        [s1 setValue:@"罗贯中" forKeyPath:@"name"];//等同于setValue:forKey:
        [s1 setValue:@(99.9) forKeyPath:@"book.bookPrice"];
        NSLog(@"%@,%@,%@",[s1 valueForKeyPath:@"name"],[s1.book valueForKeyPath:@"bookName"],[s1 valueForKeyPath:@"book.bookPrice"]);
        
        //KVC陷阱 ⚠️⚠️⚠️⚠️⚠️⚠️
        //1.对于发杂字典使用键值路径操作的时候，一定要保证所操作的字典是可变的！
//        NSMutableDictionary *dic2=[NSMutableDictionary dictionaryWithDictionary:@{@"info":mulDic1,@"school":@"青云学院"}];
        NSDictionary *dic2=@{@"info":mulDic1,@"school":@"青云学院"};
        [dic2 setValue:@"qingyun" forKeyPath:@"info.name"];
        NSLog(@"%@",[dic2 valueForKeyPath:@"info.name"]);
        //过多的键值路径操作会违背低耦合程序设计原理，所以说，一定要尽量避免复杂层级的操作,程序效率低
        //2.为了避免写错这关键字，可以使用宏定义
        [s1 setValue:@"gaoli" forKeyPath: NAME];
        NSLog(@"%@",[s1 valueForKeyPath:NAME]);
        //3.设置未被定义的键容易出错！
//        [s1 setValue:@"河工大" forKeyPath:@"school"];
        //必须避免这种写法
        [s1 setValue:@"河工大" forKey:@"school"];//使用之前必须重写
        NSLog(@"%@",[s1 valueForKey:@"school"]);
        //4. 如果设置的键所对应的值为空
        [s1 setValue:0 forKey:@"age"];//value必须是OC中的任意类型的对象！
        
        //********批处理*****
        //1.可以从对象中取出某些属性对应的键值对作为新的字典
        NSDictionary *myDic=[s1 dictionaryWithValuesForKeys:@[@"name",@"age",@"sex"]];
        NSLog(@"myDic=%@",myDic);
//        //valuesForKeys已经被弃用了
//        NSLog(@"%@,%@",[myDic allValues],[s1 valuesForKeys:@[@"name",@"age",@"sex"]]);
        //2.字典快速给模型赋值
        [s1 setValuesForKeysWithDictionary:mulDic1];
        NSLog(@"%@",s1);
        
        // 整体操作
        Student *s2=[[Student alloc] initWithName:@"xialning"];
        Student *s3=[[Student alloc] initWithName:@"hongming"];
        Student *s4=[[Student alloc] initWithName:@"zhanghong"];
//        s1.names=[NSMutableArray arrayWithObjects:s1,s2,s3,s4, nil];
        [s1.names addObjectsFromArray:@[s1,s2,s3,s4]];
        NSLog(@"%ld",s1.names.count);
        // 求名字数组的总个数
        NSLog(@"%@,%@",[s1 valueForKeyPath:@"names.@count"],[s1.names valueForKeyPath:@"@count"]);
    }
    return 0;
}
