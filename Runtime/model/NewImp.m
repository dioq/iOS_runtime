//
//  ImpObject.m
//  Runtime
//
//  Created by Dio Brand on 2023/3/9.
//  Copyright © 2023 Dio. All rights reserved.
//

#import "NewImp.h"

@implementation NewImp

- (NSString *)eating {
    return @"eating";
}

//添加方法
-(void)addNewMethod {
    NSLog(@"%s",__FUNCTION__);
}

// 替换方法
-(void)replaceM {
    NSLog(@"%s",__FUNCTION__);
}
-(void)normalMethod {
    NSLog(@"%s",__FUNCTION__);
}

@end
