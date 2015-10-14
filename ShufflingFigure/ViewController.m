//
//  ViewController.m
//  ShufflingFigure
//
//  Created by lanouhn on 15/7/1.
//  Copyright (c) 2015年 main.m. All rights reserved.

//博文作者：GarveyCalvin
//博文出处：http://www.cnblogs.com/GarveyCalvin/

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
   // 1.1）创建之后需要使用start方法，才会执行方法
    /// 创建线程
    NSThread *myThread = [[NSThread alloc]initWithTarget:self selector:@selector(loadMyTHread) object:nil];
    /// 开始执行
    [myThread start];
    
    //1.2）创建并马上执行方法：
    [NSThread detachNewThreadSelector:@selector(threadAlloc:) toTarget:self withObject:nil];
    
   // 2）隐式创建线程：NSObject
    // 我们也可以使用NSObject类的方法直接调用方法
    [self performSelectorInBackground:@selector(threadAlloc:) withObject:nil];
    /**
     * 取消线程的方法：
       实际上并没有真正提供取消线程的API。苹果提供了一个cancel的api，但它不能作用于取消线程，它只能改变线程的运行状态。我们可以使用它来进行条件判断
     */
    [self threadCancel];
    
}
-(void)loadMyTHread
{
    NSLog(@"呵呵");
}

- (void)threadAlloc:(NSThread *)myThread
{
    NSLog(@"爽歪歪");
}

- (void)threadCancel
{
    NSThread *thread = [[NSThread alloc] initWithTarget:self selector:@selector(threadCancelNow) object:nil];
    [thread start];
}

- (void)threadCancelNow
{
    int a = 0;
    while (![[NSThread currentThread] isCancelled]) {
        NSLog(@"a - %d", a);
        a++;
        if (a == 5000) {
            NSLog(@"终止循环");
            [[NSThread currentThread] cancel];
            break;
        }
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
