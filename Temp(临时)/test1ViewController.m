//
//  test1ViewController.m
//  露露微博
//
//  Created by lushuishasha on 15/8/10.
//  Copyright (c) 2015年 Pass_Value. All rights reserved.
//

#import "test1ViewController.h"
#import "test2ViewController.h"

@interface test1ViewController ()

@end

@implementation test1ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
}




- (void) touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    test2ViewController *test2 = [[test2ViewController alloc]init];
    test2.title = @"tese2控制器";
    [self.navigationController pushViewController:test2 animated:YES];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
