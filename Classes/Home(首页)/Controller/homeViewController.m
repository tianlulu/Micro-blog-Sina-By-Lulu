//
//  homeViewController.m
//  露露微博
//
//  Created by lushuishasha on 15/8/10.
//  Copyright (c) 2015年 Pass_Value. All rights reserved.
//

#import "homeViewController.h"
#import "UIBarButtonItem+Extension.h"
#import "UIView+Extension.h"
#import "TRDropDownMenu.h"
#import "TRTitleMenuVCTableViewController.h"
#import "TRAccountTool.h"
#import "AFNetworking.h"
#import "TRTitleButton.h"
#import "UIImageView+WebCache.h"
#import "TRStatus.h"
#import "TRUser.h"
#import "MJExtension.h"
#import "TRLoadMoreFooter.h"
#import "TRStatusCell.h"
#import "TRStatusFrame.h"
#import "TRStatusFrame.h"
#import "TRAFNetworkingTool.h"

@interface homeViewController ()<TRDropDownMenuDelagate>
@property (nonatomic, strong) NSMutableArray *statusFrames;
@end

@implementation homeViewController
- (NSMutableArray *)statusFrames {
    if (!_statusFrames) {
        _statusFrames = [NSMutableArray array];
    }
    return _statusFrames;
}

- (NSArray *)cellStatusChangeToCellFrames:(NSArray *)statuses{
    NSMutableArray *frames = [NSMutableArray array];
    for (TRStatus *status in statuses) {
        TRStatusFrame *frame = [[TRStatusFrame alloc]init];
        frame.status = status;
        [frames addObject:frame];
    }
    return frames;
}

- (void)viewDidLoad {
    self.tableView.contentInset = UIEdgeInsetsMake(TRStatusCellMargin, 0, 0, 0);
    self.tableView.backgroundColor = TRColor(211, 211, 211);
    [super viewDidLoad];
    
    // 设置导航栏内容
    [self setUpNav];
    
    // 获得用户信息（昵称）
    [self setUpUserInfo];
    
   // 下拉加载
    [self setDownRefresh];
    
    //上拉刷新控件
    [self setUpRefresh];
    
    //获得为读书
   // 当view滚动的时候，timer被强迫停止，因为他占用资源
   // NSTimer *timer = [NSTimer scheduledTimerWithTimeInterval:5 target:self selector:@selector(setupUnreadCount) userInfo:nil repeats:YES];
    
     // 主线程也会抽时间处理一下timer（不管主线程是否正在其他事件）
   // [[NSRunLoop mainRunLoop] addTimer:timer forMode:NSRunLoopCommonModes];
}


//获得未读数
- (void)setupUnreadCount {

    //拼接请求参数
    TRAccount *account = [TRAccountTool returnAccount];
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"access_token"] = account.access_token;
    params[@"uid"] = account.uid;
    
    [TRAFNetworkingTool post:@"https://rm.api.weibo.com/2/remind/unread_count.json" params:params success:^(id json) {
        //微博的未读数(对象转换成int)
        // int status = [responseObject[@"status"] intValue];
        
        //设置提醒数字（转换成字符串）
        //  NSString *number = [NSString stringWithFormat:@"%d",status];
        
        //description就可转换成字符串
        NSString *number = [json[@"status"] description];
        
        if ([number isEqualToString:@"0"]) {
            self.tabBarItem.badgeValue = nil;
            //程序进入后台
            //[UIApplication sharedApplication].applicationIconBadgeNumber = 0;
        } else {
            self.tabBarItem.badgeValue = number;
            //[UIApplication sharedApplication].applicationIconBadgeNumber = number.intValue;
        }
    } failure:^(NSError *error) {
        NSLog(@"请求失败:%@",error);

    }];
}

// 集成上拉刷新控件
- (void) setUpRefresh {
    TRLoadMoreFooter *footer = [TRLoadMoreFooter footer];
    footer.hidden =YES;
    self.tableView.tableFooterView = footer;
    
}

// 集成下拉刷新控件
- (void) setDownRefresh {
    
    UIRefreshControl *control = [[UIRefreshControl alloc] init];
    [control addTarget:self action:@selector(refreshStateChange:) forControlEvents:UIControlEventValueChanged];
    [self.tableView addSubview:control];
    
    [control beginRefreshing];
    
    [self refreshStateChange:control];
    
}



// UIRefreshControl进入刷新状态：加载最新的数据
- (void)refreshStateChange:(UIRefreshControl *)control {
    
//    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
//        NSDictionary *responseObject = [NSDictionary dictionaryWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"fakeStatus" ofType:@"plist"]];
//        // 将 "微博字典"数组 转为 "微博模型"数组
//        NSArray *newStatuses = [TRStatus objectArrayWithKeyValuesArray:responseObject[@"statuses"]];
//        
//        // 将 HWStatus数组 转为 HWStatusFrame数组
//        NSArray *newFrames = [self cellStatusChangeToCellFrames:newStatuses];
//        
//        // 将最新的微博数据，添加到总数组的最前面
//        NSRange range = NSMakeRange(0, newFrames.count);
//        NSIndexSet *set = [NSIndexSet indexSetWithIndexesInRange:range];
//        [self.statusFrames insertObjects:newFrames atIndexes:set];
//        
//        // 刷新表格
//        [self.tableView reloadData];
//        
//        // 结束刷新
//        [control endRefreshing];
//        
//        // 显示最新微博的数量
//        [self showNewStatusCountInHeaderWhenRefersh:newStatuses.count];
//    });
//    
//    return;
    
    AFHTTPRequestOperationManager *mgr = [AFHTTPRequestOperationManager manager];
    TRAccount *account = [TRAccountTool returnAccount];
    
    NSMutableDictionary *parmas = [NSMutableDictionary dictionary];
    TRStatusFrame *firstStatusF =[self.statusFrames firstObject];
    parmas[@"access_token"] = account.access_token;
    
    if (firstStatusF) {
        parmas[@"since_id"] = firstStatusF.status.idstr;
    }
    
    [mgr GET:@"https://api.weibo.com/2/statuses/friends_timeline.json" parameters:parmas success:^(AFHTTPRequestOperation *operation, NSDictionary *responseObject) {
        NSLog(@"%@",responseObject);
        NSArray *newStatus = [TRStatus objectArrayWithKeyValuesArray:responseObject[@"statuses"]];
        
        NSArray *newFrames = [self cellStatusChangeToCellFrames:newStatus];
        
        NSRange range = NSMakeRange(0, newFrames.count);
        NSIndexSet *set = [NSIndexSet indexSetWithIndexesInRange:range];
        [self.statusFrames insertObjects:newFrames atIndexes:set];
        [self.tableView reloadData];
        [control endRefreshing];
        
        [self showNewStatusCountInHeaderWhenRefersh:(int)newStatus.count];
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"请求失败:%@",error);
        [control endRefreshing];
    }];
}



/**
 *  加载更多的微博数据
 */
- (void)loadMoreStatus
{
    // 1.请求管理者
    AFHTTPRequestOperationManager *mgr = [AFHTTPRequestOperationManager manager];
    
    // 2.拼接请求参数
    TRAccount *account = [TRAccountTool returnAccount];
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"access_token"] = account.access_token;
    
    // 取出最后面的微博（最新的微博，ID最大的微博）
    TRStatusFrame *lastStatus = [self.statusFrames lastObject];
    if (lastStatus) {
        // 若指定此参数，则返回ID小于或等于max_id的微博，默认为0。
        // id这种数据一般都是比较大的，一般转成整数的话，最好是long long类型
        long long maxId = lastStatus.status.idstr.longLongValue - 1;
        params[@"max_id"] = @(maxId);
    }
    
    
    
    // 3.发送请求
    [mgr GET:@"https://api.weibo.com/2/statuses/friends_timeline.json" parameters:params success:^(AFHTTPRequestOperation *operation, NSDictionary *responseObject) {
        // 将 "微博字典"数组 转为 "微博模型"数组
        NSArray *newStatuses = [TRStatus objectArrayWithKeyValuesArray:responseObject[@"statuses"]];
        
        NSArray *newFrames = [self cellStatusChangeToCellFrames:newStatuses];
        
        // 将更多的微博数据，添加到总数组的最后面
        [self.statusFrames addObjectsFromArray:newFrames];
        
        // 刷新表格
        [self.tableView reloadData];
        
        // 结束刷新(隐藏footer)
        self.tableView.tableFooterView.hidden = YES;
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"请求失败-%@",error);
        
        // 结束刷新
        self.tableView.tableFooterView.hidden = YES;
    }];
}



/**
 *  显示最新微博的数量
 *
 *  @param count 最新微博的数量(横幅)
 */
- (void)showNewStatusCountInHeaderWhenRefersh:(int)count {
   self.tabBarItem.badgeValue = nil;
   // [UIApplication sharedApplication].applicationIconBadgeNumber = 0;
    UILabel *label = [[UILabel alloc] init];
    label.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"timeline_new_status_background"]];
    label.width = [UIScreen mainScreen].bounds.size.width;
    label.height = 35;
    if (count ==0) {
        label.text = @"没有新的微博数据，稍后再试";
    } else {
        label.text = [NSString stringWithFormat:@"一共有%d条微博数据",count];
    }
    label.textColor = [UIColor whiteColor];
    label.textAlignment = NSTextAlignmentCenter;
    label.font = [UIFont systemFontOfSize:16];
    label.y = 64-label.height;
    [self.navigationController.view insertSubview:label belowSubview:self.navigationController.navigationBar];
    
    //动画
    CGFloat duration = 1.0;
    [UIView animateWithDuration:duration animations:^{
        //label.y += label.height;
        label.transform = CGAffineTransformMakeTranslation(0, label.height);
    } completion:^(BOOL finished) {
        CGFloat delay = 1.0;
        [UIView animateWithDuration:duration delay:delay options:UIViewAnimationOptionCurveLinear animations:^{
            //label.y = 64-label.height;
            label.transform = CGAffineTransformIdentity;
        } completion:^(BOOL finished) {
            [label removeFromSuperview];
           
        }];
   }];
}


////获取最新的公共微博
//- (void) loadNewStatus {
//    AFHTTPRequestOperationManager *mgr = [AFHTTPRequestOperationManager manager];
//    TRAccount *account = [TRAccountTool returnAccount];
//    NSMutableDictionary *parmas = [NSMutableDictionary dictionary];
//    parmas[@"access_token"] = account.access_token;
//    
//    [mgr GET:@"https://api.weibo.com/2/statuses/friends_timeline.json" parameters:parmas success:^(AFHTTPRequestOperation *operation, NSDictionary *responseObject) {
//        NSArray *publicWeiBo = [TRStatus objectArrayWithKeyValuesArray:responseObject[@"statuses"]];
//        [self cellStatusChangeToCellFrames:publicWeiBo];
//        [self.tableView reloadData];
//        
//    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
//        NSLog(@"请求失败:%@",error.userInfo);
//    }];
//    
//}



//获得用户信息（昵称）
- (void) setUpUserInfo {
    
    AFHTTPRequestOperationManager *mgr = [AFHTTPRequestOperationManager manager];
    TRAccount *account = [TRAccountTool returnAccount];
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"access_token"] = account.access_token;
    params[@"uid"] = account.uid;
    
    
    //发送请求
    [mgr GET:@"https://api.weibo.com/2/users/show.json" parameters:params success:^(AFHTTPRequestOperation *operation, id responseObject) {
        //标题按钮
        UIButton *titleButton = (UIButton *)self.navigationItem.titleView;
        //设置名字
        TRUser *user = [TRUser objectWithKeyValues:responseObject];
        [titleButton setTitle:user.name forState:UIControlStateNormal];
        account.name =user.name;
        [TRAccountTool saveAccount:account];
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"请求失败:%@",error);
    }];
}



/**
 *  设置导航栏内容
 */

- (void) setUpNav {
    /* 设置导航栏上面的内容 */
    self.navigationItem.leftBarButtonItem = [UIBarButtonItem itemWithTarget:self Action:@selector(friendSearch) image:@"navigationbar_friendsearch" selectedImage:@"navigationbar_friendsearch_highlighted"];
    
    self.navigationItem.rightBarButtonItem = [UIBarButtonItem itemWithTarget:self Action:@selector(pop) image:@"navigationbar_pop" selectedImage:@"navigationbar_pop_highlighted"];
    
    
    
    /* 中间的标题按钮 */
    TRTitleButton *titleButton = [[TRTitleButton alloc]init];
   // titleButton.backgroundColor = [UIColor greenColor];
    
    TRAccount *account = [TRAccountTool returnAccount];
    //取出存储在沙河中的上一次的name
    NSString *name = account.name;
    [titleButton setTitle:name?:@"首页" forState:UIControlStateNormal];
    
       // 监听标题点击
    [titleButton addTarget:self action:@selector(titleClick:) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.titleView = titleButton;
    
  
}

// 如果图片的某个方向上不规则，比如有突起，那么这个方向就不能拉伸
// 什么情况下建议使用imageEdgeInsets、titleEdgeInsets
// 如果按钮内部的图片、文字固定，用这2个属性来设置间距，会比较简单
// 标题宽度
//    CGFloat titleW = titleButton.titleLabel.width * [UIScreen mainScreen].scale;
////    // 乘上scale系数，保证retina屏幕上的图片宽度是正确的
//    CGFloat imageW = titleButton.imageView.width * [UIScreen mainScreen].scale;
//    CGFloat left = titleW + imageW;
//    titleButton.imageEdgeInsets = UIEdgeInsetsMake(0, left, 0, 0);


- (void) titleClick:(UIButton *)titleButton {
    //创建下拉菜单
    TRDropDownMenu *menu = [TRDropDownMenu menu];
   // menu.content = [UIButton buttonWithType:UIButtonTypeContactAdd];
   // menu.content = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, 500, 300)];
    menu.delegate = self;
    //设置内容
     TRTitleMenuVCTableViewController *vc= [[TRTitleMenuVCTableViewController alloc]init];
    vc.view.height = 44 *3;
    vc.view.width = 150;
    menu.contentController = vc;
    //显示
    [menu showFrom:titleButton];
    

//    UIWindow *window = [[UIApplication sharedApplication]
//                        .windows lastObject];
//    
//    UIView *cover = [[UIView alloc]init];
//    cover.backgroundColor = [UIColor clearColor];
//    cover.frame = window.bounds;
//    [window addSubview:cover];
//    [cover addSubview:dropdownMenu];
}


- (void)friendSearch
{
    NSLog(@"friendSearch");
}



- (void)pop
{
    NSLog(@"pop");
}


- (void)dropDownMenuDidDismiss:(TRDropDownMenu *)menu {
    UIButton *titleButton = (UIButton *)self.navigationItem.titleView;
    //[titleButton setImage:[UIImage imageNamed:@"navigationbar_arrow_down"] forState:UIControlStateNormal];
    titleButton.selected = NO;
}


//下拉菜单显示了
- (void)dropDownMenuShow:(TRDropDownMenu *)menu {
    UIButton *titleButton = (UIButton *)self.navigationItem.titleView;
    //[titleButton setImage:[UIImage imageNamed:@"navigationbar_arrow_up"] forState:UIControlStateNormal];
    titleButton.selected = YES;

}
    


#pragma mark - Table view data source
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {


    return self.statusFrames.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    TRStatusCell *cell = [TRStatusCell cellWithTableView:tableView];
    cell.statusFrame = self.statusFrames[indexPath.row];
    return cell;
}



- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    // scrollView == self.tableView == self.view
    // 如果tableView还没有数据，就直接返回
    if (self.statusFrames.count == 0 || self.tableView.tableFooterView.isHidden == NO) return;
    
    CGFloat offsetY = scrollView.contentOffset.y;
    
    // 当最后一个cell完全显示在眼前时，contentOffset的y值
    CGFloat judgeOffsetY = scrollView.contentSize.height + scrollView.contentInset.bottom - scrollView.height - self.tableView.tableFooterView.height;
    if (offsetY >= judgeOffsetY) { // 最后一个cell完全进入视野范围内
        // 显示footer
        self.tableView.tableFooterView.hidden = NO;
        
        // 加载更多的微博数据
        [self loadMoreStatus];
    }
    
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    TRStatusFrame *frame = self.statusFrames[indexPath.row];
    return frame.cellHeight;
    
}


/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
