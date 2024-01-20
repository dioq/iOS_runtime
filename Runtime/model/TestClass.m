//
//  TestClass.m
//  Runtime
//
//  Created by zd on 20/1/2024.
//  Copyright © 2024 Dio. All rights reserved.
//

#import "TestClass.h"

@implementation TestClass

-(NSString *)func1Param1:(NSString *)param1 param2:(NSString *)param2 {
    NSString *new_str = [NSString stringWithFormat:@"%s:  %@--%@",__FUNCTION__,param1,param2];
    return new_str;
}

+ (NSString *)func2Param1:(NSString *)param1 param2:(NSString *)param2 {
    NSString *new_str = [NSString stringWithFormat:@"%s:  %@--%@",__FUNCTION__,param1,param2];
    return new_str;
}

@end
