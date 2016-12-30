//
//  TRAFNetworkingTool.m
//  露露微博
//
//  Created by lushuishasha on 15/10/13.
//  Copyright (c) 2015年 Pass_Value. All rights reserved.
// 因为授权控制器，首页控制器，发微博控制器等很多地方用到了NFN,为了避免AFN等第三方库升级造成的很多地方的改变，可以用此工具类作为衔接，第三方库升级只用改变这个工具类即可

#import "TRAFNetworkingTool.h"
#import "AFNetworking.h"

@implementation TRAFNetworkingTool

+ (void)get:(NSString *)url params: (NSDictionary *)params success:(void (^)(id json))success failure:(void (^)(NSError *error))failure{
   //创建请求管理者
    AFHTTPRequestOperationManager *mgr = [AFHTTPRequestOperationManager manager];
    
    //发送请求
    [mgr GET:url parameters:params success:^(AFHTTPRequestOperation *operation, id responseObject) {
        if (success) {
            success(responseObject);
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        if (failure) {
            failure(error);
        }
  
    }];
}


+ (void)post:(NSString *)url params: (NSDictionary *)params success:(void (^)(id json))success failure:(void (^)(NSError *error))failure{
    //创建请求管理者
    AFHTTPRequestOperationManager *mgr = [AFHTTPRequestOperationManager manager];
    
    //发送请求
   [mgr POST:url parameters:params success:^(AFHTTPRequestOperation *operation, id responseObject) {
       if (success) {
           success(responseObject);
       }
       
   } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
       if (failure) {
           failure(error);
       }
       
   }];
    
}
@end
