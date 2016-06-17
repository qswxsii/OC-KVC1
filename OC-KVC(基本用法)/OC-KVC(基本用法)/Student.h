//
//  Student.h
//  OC-KVC(基本用法)
//
//  Created by qingyun on 16/4/11.
//  Copyright © 2016年 QingYun. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BOOK.h"

@interface Student : NSObject
@property(copy,nonatomic)NSString *name;
@property(assign,nonatomic)int age;
@property(copy,nonatomic)NSString *sex;
@property(copy,nonatomic)NSString *address;
@property(strong,nonatomic)BOOK *book;
@property(strong,nonatomic)NSMutableArray *names;
-(instancetype)initWithName:(NSString *)name;
@end
