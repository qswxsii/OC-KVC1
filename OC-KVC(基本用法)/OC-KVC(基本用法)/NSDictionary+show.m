    //
//  NSDictionary+show.m
//  OC-KVC(基本用法)
//
//  Created by qingyun on 16/4/11.
//  Copyright © 2016年 QingYun. All rights reserved.
//

#import "NSDictionary+show.h"

@implementation NSDictionary (show)
-(NSString *)description//针对对象或者字符串
{
    return @"hello";
}
//当%@打印集合的时候，就会重走这个方法
-(NSString *)descriptionWithLocale:(id)locale
{
    NSMutableString * mulString=[NSMutableString string];//初始化一个可变字符串
    //拼接
    [mulString appendString:@"{\n"];
    //遍历传过来的字典
    for (id key in self)
    {
        //self指的是当前字典
        [mulString appendFormat:@"\t%@ = %@;\n",key,[self objectForKey:key]];//self[key]
    }
    [mulString appendString:@"}"];
    return mulString;
}
@end
