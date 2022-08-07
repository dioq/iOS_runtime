//
//  Person.h
//  Runtime
//
//  Created by hello on 2019/10/1.
//  Copyright © 2019 Dio. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface Person : NSObject

/** 姓名 **/
@property (nonatomic, copy) NSString *name;
/** 性别 **/
@property (nonatomic, assign) NSNumber *sex;

- (NSString *)coding;
- (NSString *)eating;
- (void)run:(NSInteger)num;
- (NSString *)func3:(NSString *)param;
- (NSString *)changeMethod;

- (NSString *)funcForRuntimeCall;

@end

NS_ASSUME_NONNULL_END
