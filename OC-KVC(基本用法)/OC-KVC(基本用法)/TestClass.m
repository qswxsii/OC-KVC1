//
//  TestClass.m
//  OC-KVC(基本用法)
//
//  Created by qingyun on 16/4/11.
//  Copyright © 2016年 QingYun. All rights reserved.
//

#import "TestClass.h"

@implementation TestClass
+(void)showInfo:(id)obj
{
    NSLog(@"obj=>%@",obj);
    NSLog(@"name is %@,age is %@",[obj valueForKey:@"name"],[obj valueForKey: @"age"]);
}
@end
