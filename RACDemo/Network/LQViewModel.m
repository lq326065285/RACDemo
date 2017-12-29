//
//  LQViewModel.m
//  RACDemo
//
//  Created by 生意汇 on 2017/12/29.
//  Copyright © 2017年 ~~浅笑. All rights reserved.
//

#import "LQViewModel.h"

@implementation LQViewModel

-(RACCommand *)requestCommand{
    if (!_requestCommand) {
        _requestCommand = [[RACCommand alloc] initWithSignalBlock:^RACSignal * _Nonnull(id  _Nullable input) {
            return [RACSignal createSignal:^RACDisposable * _Nullable(id<RACSubscriber>  _Nonnull subscriber) {
                //网络请求
                [[LQNetWorkManager requestManagerWithUrl:@"" params:@{} method:GET isShowAlert:YES] subscribeNext:^(id  _Nullable x) {
                    /*正常请求在这里面处理
                     *这里处理一些网络返回值 json-->model
                     *处理数据后subscriber返回
                     */
                    [subscriber sendNext:x];
                    [subscriber sendCompleted];
                } error:^(NSError * _Nullable error) {
                    [subscriber sendError:error];
                }];
                return nil;
            }];
        }];
    }
    return _requestCommand;
}

/*
 //不知道为什么，这里用catch和flattenMap转换之后，vc里面调用的就收不到了
 //我的想法是catch处理错误信息
 //flattenMap处理正确信息
-(RACCommand *)requestCommand{
    if (!_requestCommand) {
        _requestCommand = [[RACCommand alloc] initWithSignalBlock:^RACSignal * _Nonnull(id  _Nullable input) {
            return [[[LQNetWorkManager requestManagerWithUrl:@"" params:@{@"key":@""}] catch:^RACSignal * _Nonnull(NSError * _Nonnull error) {
                return [RACSignal createSignal:^RACDisposable * _Nullable(id<RACSubscriber>  _Nonnull subscriber) {
                    [subscriber sendNext:error];
                    //如果发生错误，在这里处理
                    return nil;
                }];
            }]flattenMap:^__kindof RACSignal * _Nullable(id  _Nullable value) {
                return [RACSignal createSignal:^RACDisposable * _Nullable(id<RACSubscriber>  _Nonnull subscriber) {
                    //正常请求在这里面处理
                     //这里处理一些网络返回值 json-->model
                     //处理数据后subscriber返回
                    [subscriber sendNext:value];
                    [subscriber sendCompleted];
                    //                    [subscriber sendError:nil];
                    return nil;
                }];
            }];
        }];
    }
    return _requestCommand;
}
 */

@end
