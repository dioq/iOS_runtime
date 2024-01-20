//
//  MsgSendViewController.m
//  Runtime
//
//  Created by Dio Brand on 2022/8/7.
//  Copyright © 2022 Dio. All rights reserved.
//

#import "MsgSendViewController.h"
#import <objc/message.h>

@interface MsgSendViewController ()

@end

@implementation MsgSendViewController

/*
 类型转换
 ((void (*)(id, SEL, id))objc_msgSend)(target, sel, value);
 **/

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.navigationItem.title = @"objc/message";
}

// performSelector 调用实例方法
- (IBAction)call_instance_method_act:(UIButton *)sender {
    Class TestClass = objc_getClass("TestClass");
    id test_obj =  ((id (*)(id, SEL))objc_msgSend)(TestClass, sel_registerName("alloc"));
    test_obj = ((id (*)(id, SEL))objc_msgSend)(test_obj,sel_registerName("init"));
    
    NSString *param1 = @"Hello";
    NSString *param2 = @"World";
    id retVal = [test_obj performSelector:@selector(func1Param1:param2:) withObject:param1 withObject:param2];
    NSLog(@"%@",retVal);
}

// performSelector 调用类方法
- (IBAction)call_class_method_act:(UIButton *)sender {
    Class TestClass = objc_getClass("TestClass");
    
    NSString *param1 = @"Hello";
    NSString *param2 = @"World";
    id retVal = [TestClass performSelector:@selector(func2Param1:param2:) withObject:param1 withObject:param2];
    NSLog(@"%@",retVal);
}

// objc_msgSend 调用实例方法
- (IBAction)objc_msgSend_call_instance_method:(UIButton *)sender {
    Class TestClass = objc_getClass("TestClass");
    id test_obj =  ((id (*)(id, SEL))objc_msgSend)(TestClass, sel_registerName("alloc"));
    test_obj = ((id (*)(id, SEL))objc_msgSend)(test_obj,sel_registerName("init"));
    
    NSString *param1 = @"Hello";
    NSString *param2 = @"World";
    NSString *retVal = ((id (*)(id, SEL, NSString *, NSString *))objc_msgSend)(test_obj, sel_registerName("func1Param1:param2:"), param1, param2);
    NSLog(@"%@",retVal);
}

// objc_msgSend 调用类方法
- (IBAction)objc_msgSend_call_class_method:(UIButton *)sender {
    Class TestClass = objc_getClass("TestClass");
    
    NSString *param1 = @"Hello";
    NSString *param2 = @"World";
    NSString *retVal = ((id (*)(id, SEL, NSString *, NSString *))objc_msgSend)(TestClass, sel_registerName("func2Param1:param2:"), param1, param2);
    NSLog(@"%@",retVal);
}

// objc_msgSend 调用系统方法的一个例子
- (IBAction)callSysFunc:(UIButton *)sender {
    NSString *pase = [UIPasteboard generalPasteboard].string;
    NSLog(@"%@",pase);
    
    id objZ = ((id (*)(id, SEL))objc_msgSend)(objc_getClass("UIPasteboard"), sel_registerName("generalPasteboard"));
    
    // 实现读取粘贴板
    id retVal = ((id (*)(id, SEL))objc_msgSend)(objZ, sel_registerName("string"));
    NSLog(@"retVal:%@",retVal);
    
    NSString *tipString = @"This is a test string.";
    ((void (*)(id, SEL, id))objc_msgSend)(objZ, sel_registerName("setString:"),tipString);
    NSLog(@"粘贴板上已经写了数据,可以找个地方粘贴一下数据");
}

@end
