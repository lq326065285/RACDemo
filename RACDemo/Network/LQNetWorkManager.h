//
//  LQNetWorkManager.h
//  RACDemo
//
//  Created by 生意汇 on 2017/12/29.
//  Copyright © 2017年 ~~浅笑. All rights reserved.
//

#import <AFNetworking/AFNetworking.h>
#import <ReactiveObjC/ReactiveObjC.h>
typedef NS_ENUM(NSUInteger,RequestMethod){
    GET = 1,
    POST
};

@interface LQNetWorkManager : AFHTTPSessionManager


/**
 网络请求
 @param url 请求url
 @param params 参数
 @param method GET/POST
 @param isShowAlert YES=显示弹框 NO=不显示弹框
 */
+(RACSignal *)requestManagerWithUrl:(NSString *)url params:(NSDictionary *)params method:(RequestMethod)method isShowAlert:(BOOL)isShowAlert;


@end
