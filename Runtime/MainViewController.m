//
//  MainViewController.m
//  Runtime
//
//  Created by Dio Brand on 2022/8/6.
//  Copyright © 2022 Dio. All rights reserved.
//

#import "MainViewController.h"
#import <objc/runtime.h>
#import "Person.h"

@interface MainViewController ()

@property (weak, nonatomic) IBOutlet UILabel *show;
@property(nonatomic, strong)Person *person;

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

@implementation MainViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.navigationItem.title = @"Runtime";
    self.person = [[Person alloc]init];
}

//添加方法
-(void)find {
    NSLog(@"printPerson 方法的实现, 在ViewController里实现,实现方法是find");
}

- (IBAction)addMethod:(UIButton *)sender {
    /*
     动态添加
     "v@:" 意思是，v 代表无返回值 void，如果是 i 则代表 int；@代表 id sel; : 代表 SEL _cmd;
     “v@:@@” 意思是，两个参数的没有返回值。
     */
    //给Person类动态添加 printPerson方法,并在ViewController类里添加实现方法find
    BOOL successOr = class_addMethod([Person class], @selector(printPerson), class_getMethodImplementation([MainViewController class], @selector(find)), "v@:");
    if (successOr) {
        NSLog(@"添加方法成功");
        [self.show setText:@"添加方法成功"];
    }else{
        NSLog(@"添加方法失败");
        [self.show setText:@"添加方法失败"];
    }
}
- (IBAction)callAddMethod:(UIButton *)sender {
    [self.show setText:@""];
    //runtime动态添加的方法,只能通过performSelector来动态调用
    [self.person performSelector:@selector(printPerson)];
}

- (IBAction)changeMethod:(UIButton *)sender {
    [self.show setText:@""];
    Method oriMethod = class_getInstanceMethod(_person.class, @selector(coding));
    Method curMethod = class_getInstanceMethod(_person.class, @selector(eating));
    method_exchangeImplementations(oriMethod, curMethod);
    [self.show setText:@"交换方法执行"];
}

- (IBAction)callMethod:(UIButton *)sender {
    [self.show setText:@""];
    NSMutableString *code_result = [NSMutableString stringWithFormat:@"调用 coding : %@",[self.person coding]];
    NSLog(@"%@",code_result);
    NSMutableString *eat_result = [NSMutableString stringWithFormat:@"调用 eating : %@",[self.person eating]];
    NSLog(@"%@",eat_result);
    NSMutableString *resutl = [NSMutableString string];
    [resutl appendString:code_result];
    [resutl appendString:@"\n"];
    [resutl appendString:eat_result];
    [self.show setText:resutl];
}

- (IBAction)changeProperty:(UIButton *)sender {
//    self.person = [[Person alloc]init];
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

@end
