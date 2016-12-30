//
//  test2ViewController.m
//  露露微博
//
//  Created by lushuishasha on 15/8/10.
//  Copyright (c) 2015年 Pass_Value. All rights reserved.
//

#import "test2ViewController.h"
#import "test3ViewController.h"
@interface test2ViewController ()
@end
@implementation test2ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
}


- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    test3ViewController *test3 = [[test3ViewController alloc]init];
    test3.title = @"test3控制器";
    [self.navigationController pushViewController:test3 animated:YES];
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
