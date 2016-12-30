//
//  TRAFNetworkingTool.h
//  露露微博
//
//  Created by lushuishasha on 15/10/13.
//  Copyright (c) 2015年 Pass_Value. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TRAFNetworkingTool : NSObject
+ (void)get:(NSString *)url params: (NSDictionary *)params success:(void (^)(id json))success failure:(void (^)(NSError *error))failure;
+ (void)post:(NSString *)url params: (NSDictionary *)params success:(void (^)(id json))success failure:(void (^)(NSError *error))failure;
@end
