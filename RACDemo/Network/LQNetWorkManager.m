//
//  LQNetWorkManager.m
//  RACDemo
//
//  Created by 生意汇 on 2017/12/29.
//  Copyright © 2017年 ~~浅笑. All rights reserved.
//

#import "LQNetWorkManager.h"

@interface LQNetWorkManager()
/** 如果这里不是单例的属性会造成内存泄漏，因为NSURLSession的delegate是retain */
@property (nonatomic,strong) AFHTTPSessionManager * manager;
@end

@implementation LQNetWorkManager
+ (instancetype) sharedInstance{
    static id object;
    static dispatch_once_t  once_token;
    dispatch_once(&once_token, ^{
        object = [[self alloc] init];
    });
    return object;
}

+(RACSignal *)requestManagerWithUrl:(NSString *)url params:(NSDictionary *)params method:(RequestMethod)method isShowAlert:(BOOL)isShowAlert{
    return [self requestManagerWithUrl:url params:params method:method isShowAlert:YES];
}

-(RACSignal *)requestManagerWithUrl:(NSString *)url params:(NSDictionary *)params method:(RequestMethod)method isShowAlert:(BOOL)isShowAlert{
    switch (method) {
        case GET:
            return [RACSignal createSignal:^RACDisposable * _Nullable(id<RACSubscriber>  _Nonnull subscriber) {
                [self.manager GET:url parameters:params progress:nil success:^(NSURLSessionDataTask * _Nonnull task, NSDictionary *  _Nullable responseObject) {
                    if ([responseObject[@"code"] isEqualToString:@"0"]) {//网络请求成功，我们需要的状态
                        [subscriber sendNext:responseObject[@"data"]];
                    }else{
                        if (isShowAlert) {
                           NSLog(@"这里可以做些弹出框的");
                        }
                    }
                    [subscriber sendCompleted];
                } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                    [subscriber sendNext:error];
                }];
                return nil;
            }];
            break;
        case POST:
            return [RACSignal createSignal:^RACDisposable * _Nullable(id<RACSubscriber>  _Nonnull subscriber) {
                [self.manager POST:url parameters:params progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
                    if ([responseObject[@"code"] isEqualToString:@"0"]) {//网络请求成功，我们需要的状态
                        [subscriber sendNext:responseObject[@"data"]];
                    }else{
                        if (isShowAlert) {
                            NSLog(@"这里可以做些弹出框的");
                        }
                    }
                } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                    [subscriber sendNext:error];
                }];
                return nil;
            }];
            break;
        default:
            break;
    }
    return [RACSignal empty];
}

-(AFHTTPSessionManager *)manager{
    if (_manager) {
        _manager = [AFHTTPSessionManager manager];
        //这里设置一些UserAgent  请求头  超时时间
    }
    return _manager;
}

@end
