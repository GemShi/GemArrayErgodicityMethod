//
//  ViewController.m
//  GemArrayErgodicityMethod
//
//  Created by GemShi on 2017/3/4.
//  Copyright © 2017年 GemShi. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@property(nonatomic,strong)NSArray *array;

@end

@implementation ViewController
#pragma mark - lazyLoad
//- (NSMutableArray *)array {
//    if (!_array) {
//        _array = [NSMutableArray array];
//        for (int i = 0; i < 10000000; i ++) {
//            [_array addObject:[[NSObject alloc] init]];
//        }
//     }
//     return _array;
//}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    [self initData];
    
    //枚举正序遍历5.552
//    [self EnumObjects];
    
    //枚举倒序遍历5.287
//    [self EnumReverse];
    
    //创建枚举器5.227
//    [self Enumrator];
    
    //dispatch_apply模拟遍历3.203
//    [self DispatchApply];
    
    //do-while和while 3.626 3.546
//    [self DoWhile];
    
    //for-in 3.016
//    [self ForInCycle];
    
    //for 3.674
    [self ForCycle];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)initData
{
    self.array = @[@"1",@"2",@"3",@"4",@"5",@"6"];
}

#pragma mark - for
-(void)ForCycle
{
    for (int i = 0; i < _array.count; i++) {
        NSLog(@"%d---%@",i,_array[i]);
    }
}

#pragma mark - for-in
-(void)ForInCycle
{
    for (id obj in _array) {
        NSLog(@"%@",obj);
    }
}

#pragma mark - do-while
-(void)DoWhile
{
    int i = 0;
    do {
        NSLog(@"%d---%@",i,[_array objectAtIndex:i]);
        i++;
    } while (i < _array.count);
    
//    while (i < _array.count) {
//        NSLog(@"%d---%@",i,[_array objectAtIndex:i]);
//        i++;
//    }
}

#pragma mark - 通过GCD的API
-(void)DispatchApply
{
    //并行，乱序
    dispatch_apply(_array.count, dispatch_get_global_queue(0, 0), ^(size_t index) {
        NSLog(@"%zu---%@",index,[_array objectAtIndex:index]);
    });
}

#pragma mark - 创建枚举器
-(void)Enumrator
{
    NSEnumerator *enumrator = [_array objectEnumerator];
    id obj;
    int k = 0;
    while (obj = [enumrator nextObject]) {
        NSLog(@"%d---%@",k,obj);
        k++;
    }
}

#pragma mark - 设置倒序遍历
-(void)EnumReverse
{
    //NSEnumerationReverse参数为倒序，NSEnumerationConcurrent参数为乱序
    [_array enumerateObjectsWithOptions:NSEnumerationReverse usingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        NSLog(@"%lu---%@",(unsigned long)idx,[_array objectAtIndex:idx]);
    }];
}

#pragma mark - 枚举正序遍历
-(void)EnumObjects
{
    [_array enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        NSLog(@"%lu---%@",(unsigned long)idx,[_array objectAtIndex:idx]);
    }];
}

@end
