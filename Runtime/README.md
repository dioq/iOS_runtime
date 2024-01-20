# Objective-C 底层实现

## 字符串转换成 SEL
sel_registerName

## SEL 转成字符串
sel_getName

## 根据字符串获取到类
objc_getClass

## OC 消息发送
objc_msgSend

## 遍历类所有的成员变量
class_copyIvarList

## 遍历类所有的方法
class_copyMethodList

## 获取成员变量名
ivar_getName

## 获取成员变量类型编码
ivar_getTypeEncoding

## 获取对象成员变量的值
object_getIvar

## 设置对象成员变量的值
object_setIvar

## 获取类的实例方法
class_getInstanceMethod

## 获取类的变量
class_getInstanceVariable

## 获取类的方法实现
class_getMethodImplementation
