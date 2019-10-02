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
    NSLog(@"go to Person coding");
    return @"coding";
}

- (NSString *)eating {
    NSLog(@"go to Person eating");
    return @"eating";
}

- (NSString *)changeMethod {
    NSLog(@"go to Person eating");
    return @"方法已被拦截并替换";
}

@end
