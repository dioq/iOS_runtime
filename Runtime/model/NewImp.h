//
//  ImpObject.h
//  Runtime
//
//  Created by Dio Brand on 2023/3/9.
//  Copyright © 2023 Dio. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NewImp : NSObject

- (NSString *)eating;

// 方法的实现
-(void)addNewMethod;

// 替换方法
-(void)replaceM;
-(void)normalMethod;

@end

NS_ASSUME_NONNULL_END
