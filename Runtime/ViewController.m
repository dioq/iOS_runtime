//
//  ViewController.m
//  Runtime
//
//  Created by hello on 2019/9/30.
//  Copyright © 2019 Dio. All rights reserved.
//

#import "ViewController.h"
#import <objc/runtime.h>
#import "Person.h"

@interface ViewController ()

@property(nonatomic, strong)Person *person;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    //    [self test1];
    [self addMethod];
}
/*
 // 遍历某个类所有的成员变量
 class_copyIvarList
 
 // 遍历某个类所有的方法
 class_copyMethodList
 
 // 获取指定名称的成员变量
 class_getInstanceVariable
 
 // 获取成员变量名
 ivar_getName
 
 // 获取成员变量类型编码
 ivar_getTypeEncoding
 
 // 获取某个对象成员变量的值
 object_getIvar
 
 // 设置某个对象成员变量的值
 object_setIvar
 
 // 给对象发送消息
 objc_msgSend
 **/

//成员变量
-(void)test1{
    self.person = [[Person alloc]init];
    self.person.name = @"old name";
    self.person.sex = [NSNumber numberWithInt:1];
    NSLog(@"first ====  name:%@  sex:%@", self.person.name, self.person.sex);
    
    unsigned int count = 0;//用来存储属性列表的长度
    // 动态获取类中的属性列表(包括私有)
    Ivar *ivar = class_copyIvarList(self.person.class, &count);
    // 遍历属性
    for (int i = 0; i < count; i++) {
        Ivar tempIvar = ivar[i];//获取第i个属性
        
        const char *varChar = ivar_getName(tempIvar);//获取成员变量的名字
        NSString *varString = [NSString stringWithUTF8String:varChar];//转化成NSString类型
        
        const char *type = ivar_getTypeEncoding(tempIvar);//获取成员变量类型编码
        NSString *typeString = [NSString stringWithUTF8String:type];
        
        id value = object_getIvar(self.person, tempIvar);//获取某个对象成员变量的值
        
        NSLog(@"第%d个成员变量 名字:%@, 类型:%@, 值:%@", i, varString, typeString, value);
        
        if ([varString isEqualToString:@"_name"]) {
            //修改属性name对应的value
            object_setIvar(self.person, tempIvar, @"new name");
        }
    }
    NSLog(@"last ====  name:%@  sex:%@", self.person.name, self.person.sex);
    
    //添加成员变量
    objc_setAssociatedObject(self.person, @"age", @1, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    //获取成员变量
    NSString *name = objc_getAssociatedObject(self.person, @"name");//这个获取不到
    id newPro = objc_getAssociatedObject(self.person, @"age");
    NSLog(@"属性 name:%@, age:%@", name, newPro);
}

//添加方法
-(void)addMethod{
    self.person = [[Person alloc]init];
    /*
     动态添加 coding 方法
     (IMP)codingOC 意思是 codingOC 的地址指针;
     "v@:" 意思是，v 代表无返回值 void，如果是 i 则代表 int；@代表 id sel; : 代表 SEL _cmd;
     “v@:@@” 意思是，两个参数的没有返回值。
     */
    class_addMethod([self.person class], @selector(coding), (IMP)codingOC, "v@:");
    // 调用 coding 方法响应事件
    if ([self.person respondsToSelector:@selector(coding)]) {
        [self.person performSelector:@selector(coding)];
    } else {
        NSLog(@"添加方法失败");
    }
}
// 编写 codingOC 的实现
void codingOC(id self,SEL _cmd) {
    NSLog(@"添加方法成功");
}

@end
