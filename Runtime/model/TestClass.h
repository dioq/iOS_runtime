//
//  TestClass.h
//  Runtime
//
//  Created by zd on 20/1/2024.
//  Copyright © 2024 Dio. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface TestClass : NSObject

-(NSString *)func1Param1:(NSString *)param1 param2:(NSString *)param2;
+(NSString *)func2Param1:(NSString *)param1 param2:(NSString *)param2;

@end

NS_ASSUME_NONNULL_END
