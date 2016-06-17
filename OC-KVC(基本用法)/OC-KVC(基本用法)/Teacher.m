//
//  Teacher.m
//  OC-KVC(基本用法)
//
//  Created by qingyun on 16/4/11.
//  Copyright © 2016年 QingYun. All rights reserved.
//

#import "Teacher.h"

@implementation Teacher
-(NSString *)description
{
    return [NSString stringWithFormat:@"%@,%d",_name,_age];
}
@end
