//
//  Student.m
//  OC-KVC(基本用法)
//
//  Created by qingyun on 16/4/11.
//  Copyright © 2016年 QingYun. All rights reserved.
//

#import "Student.h"

@interface Student()//声明一个类扩展
{
    double _score;//成绩
}
@property(copy,nonatomic)NSString *stuID;//学号
@property(readonly,nonatomic,copy)NSString *telephone;//只读属性
@end
@implementation Student
-(NSString *)description
{
    return [NSString stringWithFormat:@"%@,%d,%@,%@",_name,_age,_sex,_address];
}
//懒加载  当外界调用setter方法的时候自动调用此方法！
-(BOOK *)book
{
    if (!_book)//没有内存
    {
        _book=[BOOK new];
    }
    return _book;
}
//重写
-(void)setValue:(id)value forUndefinedKey:(NSString *)key
{
    NSLog(@"未被定义的键...");
//    if ([key isEqualToString:@"school"])
//    {
//        [self setValue:value forKey:key];
//    }
}
-(id)valueForUndefinedKey:(NSString *)key
{
    if ([key isEqualToString:@"school"])
    {
        NSLog(@"没该关键字对应的学生...");
    }
    return nil;
}
//如果设置的键对应的值为空
-(void)setNilValueForKey:(NSString *)key
{
    NSLog(@"值为空，下次请细心...");
}
-(instancetype)initWithName:(NSString *)name
{
    if (self=[super init])
    {
        _name=name;
    }
    return self;
}
//懒加载
-(NSMutableArray *)names
{
    if (_names==nil)
    {
        _names=[NSMutableArray array];
    }
    return _names;
}
@end
