//
//  MsgSendViewController.m
//  Runtime
//
//  Created by Dio Brand on 2022/8/7.
//  Copyright © 2022 Dio. All rights reserved.
//

#import "MsgSendViewController.h"
#import <objc/message.h>
#import "Person.h"

@interface MsgSendViewController ()

@end

@implementation MsgSendViewController

/*
 通过类型强制转换
 ((void (*)(id, SEL, id))objc_msgSend)(target, sel, value);
 需要传的参数个数自行定义
 **/

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.navigationItem.title = @"objc/message";
}

- (IBAction)callMyFunc:(UIButton *)sender {
    //    Person *person = [[Person alloc]init];
    id p1 =  ((id (*)(id, SEL))objc_msgSend)(objc_getClass("Person"), sel_registerName("alloc"));
    id person = ((id (*)(id, SEL))objc_msgSend)(p1,sel_registerName("init"));
    
    // 调用run有参数方法@selector(run:)后依奖填写要传入的参数
    NSInteger param = 20;
    ((void (*)(id, SEL, id))objc_msgSend)(person, @selector(run:), @(param));
    
    
    // 调用类方法的方式：两种
    // 第一种通过类名调用
    // 第二种通过类对象调用
    //    [[Person class] eating];
    
    // 用类名调用类方法，底层会自动把类名转换成类对象调用
    // 本质：让类对象发送消息
    NSString *func3Param = @"MSGP";
    id func3ret = ((id (*)(id, SEL, id))objc_msgSend)(person, @selector(func3:), func3Param);
    NSLog(@"func3ret:%@",func3ret);
}

- (IBAction)callSysFunc:(UIButton *)sender {
    NSString *pase = [UIPasteboard generalPasteboard].string;
    NSLog(@"%@",pase);
    
    id obj1 = ((id (*)(id, SEL))objc_msgSend)(objc_getClass("UIPasteboard"), sel_registerName("generalPasteboard"));
    id obj2 = ((id (*)(id, SEL))objc_msgSend)(obj1, sel_registerName("string"));
    NSLog(@"obj2:\n%@",obj2);
}

@end
