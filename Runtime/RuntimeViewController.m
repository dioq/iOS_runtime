//
//  MainViewController.m
//  Runtime
//
//  Created by Dio Brand on 2022/8/6.
//  Copyright © 2022 Dio. All rights reserved.
//

#import "RuntimeViewController.h"
#import <objc/runtime.h>
#import "Person.h"
#import "NewImp.h"

@interface RuntimeViewController ()

@end

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

@implementation RuntimeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.navigationItem.title = @"objc/runtime";
}

- (IBAction)addMethod:(UIButton *)sender {
    /*
     动态添加
     "v@:"   意思是，v 代表无返回值 void，如果是 i 则代表 int；@ 代表 id sel; : 代表 SEL _cmd;
     "v@:@@" 意思是，两个参数的没有返回值。
     */
    //给Person类动态添加 addM 方法,并在 NewImp 类里添加实现方法addNewMthod
    IMP addImp = class_getMethodImplementation(objc_getClass("NewImp"), sel_registerName("addNewMethod"));
    BOOL successOr = class_addMethod(objc_getClass("Person"), sel_registerName("addM"), addImp, "v@:");
    if (successOr) {
        NSLog(@"添加方法成功");
        Person *person = [[Person alloc] init];
        //runtime动态添加的方法,只能通过performSelector来动态调用
        [person performSelector:@selector(addM)];
    }else{
        NSLog(@"添加方法失败");
    }
}

- (IBAction)changeMethod:(UIButton *)sender {
    Method oriMethod = class_getInstanceMethod(objc_getClass("Person"), sel_registerName("coding"));
    Method newMethod = class_getInstanceMethod(objc_getClass("NewImp"), sel_registerName("eating"));
    method_exchangeImplementations(oriMethod, newMethod);
    
    Person *person = [[Person alloc] init];
    NSString *code_result = [NSString stringWithFormat:@"%@调用 coding : %@",[Person class],[person coding]];
    NSLog(@"%@",code_result);
    NewImp *newImp = [[NewImp alloc] init];
    NSString *eat_result = [NSString stringWithFormat:@"%@调用 eating : %@",[newImp class],[newImp eating]];
    NSLog(@"%@",eat_result);
}

- (IBAction)replaceMethod:(UIButton *)sender {
    Method newM = class_getInstanceMethod(objc_getClass("NewImp"), sel_registerName("replaceM")); // 方法的声明
    IMP newImp = method_getImplementation(newM); // 方法的实现
    class_replaceMethod(objc_getClass("NewImp"), sel_registerName("normalMethod"), newImp, method_getTypeEncoding(newM));
    NewImp *newImpObject = [[NewImp alloc] init];
    [newImpObject normalMethod];
}

- (IBAction)changeProperty:(UIButton *)sender {
    Person *person = [Person new];
    person.name = @"old name";
    person.sex = [NSNumber numberWithInt:1];
    NSLog(@"first ====  name:%@  sex:%@", person.name, person.sex);
    
    unsigned int count = 0;//用来存储属性列表的长度
    // 动态获取类中的属性列表(包括私有)
    Ivar *ivar = class_copyIvarList([person class], &count);
    // 遍历属性
    for (int i = 0; i < count; i++) {
        Ivar tempIvar = ivar[i];//获取第i个属性
        
        const char *varChar = ivar_getName(tempIvar);//获取成员变量的名字
        NSString *varString = [NSString stringWithUTF8String:varChar];//转化成NSString类型
        
        const char *type = ivar_getTypeEncoding(tempIvar);//获取成员变量类型编码
        NSString *typeString = [NSString stringWithUTF8String:type];
        
        id value = object_getIvar(person, tempIvar);//获取某个对象成员变量的值
        
        NSLog(@"第%d个成员变量 名字:%@, 类型:%@, 值:%@", i, varString, typeString, value);
        
        if ([varString isEqualToString:@"_name"]) {
            //修改属性name对应的value
            object_setIvar(person, tempIvar, @"new name");
        }
    }
    NSLog(@"last ====  name:%@  sex:%@", person.name, person.sex);
    
    //添加成员变量
    objc_setAssociatedObject(person, @"age", @1, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    //获取成员变量
    NSString *name = objc_getAssociatedObject(person, @"name");//这个获取不到
    id newPro = objc_getAssociatedObject(person, @"age");
    NSLog(@"属性 name:%@, age:%@", name, newPro);
}

@end
