//
//  Person.m
//  Runtime
//
//  Created by hello on 2019/10/1.
//  Copyright © 2019 Dio. All rights reserved.
//

#import "Person.h"

@implementation Person

- (NSString *)coding {
    return @"coding";
}

- (NSString *)eating {
    return @"eating";
}

- (void)run:(NSInteger)num {
    NSLog(@"num:%ld", num);
}

-(NSString *)func3:(NSString *)param {
    return [NSString stringWithFormat:@"%@ -- from Person", param];
}

- (NSString *)changeMethod {
    return @"方法已被拦截并替换";
}

-(NSString *)funcForRuntimeCall {
    return @"你成功用 runtime 调用了这个方法";
}

@end
