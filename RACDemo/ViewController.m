//
//  ViewController.m
//  RACDemo
//
//  Created by 生意汇 on 2017/12/29.
//  Copyright © 2017年 ~~浅笑. All rights reserved.
//

#import "ViewController.h"
#import "LQViewModel.h"
@interface ViewController ()

@property (nonatomic,strong) LQViewModel * viewModel;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
  
    [self.viewModel.requestCommand.executionSignals.switchToLatest subscribeNext:^(id  _Nullable x) {
        //网络请求完成
        NSLog(@"%@",x);
    }];
    
    [self.viewModel.requestCommand.errors subscribeNext:^(id  _Nullable x) {
        //网络请求出错处理
        NSLog(@"信号错误");
    }];
    
    [self.viewModel.requestCommand execute:@""];//发送网络请求
}


#pragma mark - getter setter

-(LQViewModel *)viewModel{
    if (!_viewModel) {
        _viewModel = [[LQViewModel alloc] init];
    }
    return _viewModel;
}


@end
