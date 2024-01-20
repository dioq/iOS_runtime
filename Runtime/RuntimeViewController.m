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

@implementation RuntimeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"objc/runtime";
}

- (IBAction)property_action:(UIButton *)sender {
    Person *person = [Person new];
    person.name = @"Little Dio";
    person.sex = [NSNumber numberWithInt:1];
    NSLog(@"%d: name:%@  sex:%@", __LINE__, person.name, person.sex);
    
    Class clz = objc_getClass("Person");
    unsigned int count = 0;//用来存储属性列表的长度
    // 动态获取类中的属性列表(包括私有)
    Ivar *ivar = class_copyIvarList(clz, &count);
    // 遍历属性
    for (unsigned int i = 0; i < count; i++) {
        Ivar tempIvar = ivar[i];//获取第i个属性
        
        const char *var_name = ivar_getName(tempIvar);//获取成员变量的名字
        
        const char *var_type = ivar_getTypeEncoding(tempIvar);//获取成员变量类型编码
        
        id value = object_getIvar(person, tempIvar);//获取对象成员变量的值
        
        NSLog(@"第%d个成员变量 名字:%s 类型:%s 值:%@", i, var_name, var_type, value);
        
        if (strcmp(var_name, "_name")) {
            // 修改属性name 对应的value
            object_setIvar(person, tempIvar, @"Big Dio");
        }
    }
    NSLog(@"%d: name:%@  sex:%@", __LINE__, person.name, person.sex);
    
    //添加成员变量
    objc_setAssociatedObject(person, @"_age", @18, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    
    //获取成员变量
    Ivar name_Ivar = class_getInstanceVariable(clz, "_name");
    id name = object_getIvar(person, name_Ivar);//获取对象成员变量的值
    
    id age_add = objc_getAssociatedObject(person, @"_age");
    NSLog(@"属性 name:%@, age:%@", name, age_add);
    
    free(ivar);
}

// 获取 类 中的所有方法
- (IBAction)method_action:(UIButton *)sender {
    Class clz = objc_getClass("NewImp");
    unsigned int count = 0;
    Method *methods = class_copyMethodList(clz,&count);
    for (int i = 0; i < count; i++) {
        Method tmp_method = methods[i];
        //        const char *method_name = sel_getName(method_getName(tmp_method));
        //        printf("name:%s\n", method_name);
        
        struct objc_method_description *method_des = method_getDescription(tmp_method);
        printf("name:%s\n",sel_getName(method_des->name));
        printf("type:%s\n",method_des->types);
    }
    free(methods);
}

- (IBAction)addMethod:(UIButton *)sender {
    /*
     v 是 void 简写(无返回值)
     i 是 int  简写
     @ 代表 id sel
     : 代表 SEL _cmd
     
     OC 动态添加方法
     "v@:"      无返回值,无参数
     "v@:@@"    无返回值,两个参数
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
    [newImpObject replaceM];
}

@end
