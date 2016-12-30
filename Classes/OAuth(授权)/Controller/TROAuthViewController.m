//
//  TROAuthViewController.m
//  露露微博
//
//  Created by lushuishasha on 15/8/13.
//  Copyright (c) 2015年 Pass_Value. All rights reserved.
//

#import "TROAuthViewController.h"
//#import "AFNetworking.h"
#import "TRAccount.h"
#import "FirstScrollView.h"
#import "mainTabBarViewController.h"
#import "MBProgressHUD+MJ.h"
#import "TRAccountTool.h"
#import "UIWindow+Extension.h"
#import "TRConst.h"
#import "TRAFNetworkingTool.h"
#import "MBProgressHUD.h"


@interface TROAuthViewController ()<UIWebViewDelegate>

@end

@implementation TROAuthViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    //创建一个WebView
    UIWebView *webView = [[UIWebView alloc] init];
    webView.frame = self.view.bounds;
    webView.delegate = self;
    [self.view addSubview:webView];
    
    NSURL *url = [NSURL URLWithString:@"https://api.weibo.com/oauth2/authorize?client_id=2007001679&redirect_uri=http://www.baidu.com"];
    NSURLRequest *request = [NSURLRequest  requestWithURL:url];
    [webView loadRequest:request];
}


- (void)webViewDidFinishLoad:(UIWebView *)webView {
    [MBProgressHUD hideHUD];
}

- (void)webViewDidStartLoad:(UIWebView *)webView {
    [MBProgressHUD showSuccess:@"正在加载"];
}

- (BOOL) webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType {
   
    NSString *url = request.URL.absoluteString;
    NSLog(@"url:%@",url);
    NSLog(@"url2:%@",request.URL);
    
    NSRange range = [url rangeOfString:@"code="];
    if (range.length != 0) {
        NSUInteger fromIndex = range.location + range.length;
        NSString *code = [url substringFromIndex:fromIndex];
        //利用code换取一个accessToken
        [self accessTokenWithCode:code];
        return NO;
    }
    return YES;
}



- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error
{
    [MBProgressHUD hideHUD];
}

- (void)accessTokenWithCode:(NSString *)code {
    /*
     URL：https://api.weibo.com/oauth2/access_token
     
     请求参数：
     client_id：申请应用时分配的AppKey
     client_secret：申请应用时分配的AppSecret
     grant_type：使用authorization_code
     redirect_uri：授权成功后的回调地址
     code：授权成功后返回的code
     */
    
    //网络请求1 AFHTTPRequestOperationManager *mgr = [AFHTTPRequestOperationManager manager];
    //mgr.responseSerializer = [AFJSONResponseSerializer serializer];
    
    //1.请求参数
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"client_id"] = TRAPPKey ;
    params[@"client_secret"] = TRAPPSecrect;
    params[@"grant_type"] = @"authorization_code";
    params[@"redirect_uri"] = TRRedirectURI;
    params[@"code"] = code;
    
    
    //2，发送请求
    [TRAFNetworkingTool post:@"https://api.weibo.com/oauth2/access_token" params:params success:^(id json) {
        [MBProgressHUD hideHUD];
        //将返回的数据字典转为---模型存到沙盒
        TRAccount *account = [TRAccount accountWithDict:json];
        //存储账号信息
        [TRAccountTool saveAccount:account];
        //切换窗口的跟控制器
        UIWindow *window = [UIApplication sharedApplication].keyWindow;
        [window changeRootViewController];
        
    } failure:^(NSError *error) {
        NSLog(@"请求失败:%@",error);
    }];
}
@end
