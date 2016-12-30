//
//  TRComposeViewController.m
//  露露微博
//
//  Created by lushuishasha on 15/9/23.
//  Copyright (c) 2015年 Pass_Value. All rights reserved.
//

#import "TRComposeViewController.h"
#import "TRAccountTool.h"
#import "UIView+Extension.h"
#import "TREmotionTextView.h"
#import "AFNetworking.h"
#import "MBProgressHUD+MJ.h"
#import "TRComposeToolbar.h"
#import "TRComposePhotosView.h"
#import "TREmotionKeyboard.h"
#import "TREmotion.h"


@interface TRComposeViewController ()<UITextViewDelegate,TRComposeToolbarDelegate,UINavigationControllerDelegate, UIImagePickerControllerDelegate>
//输入控件
@property (nonatomic, weak) TREmotionTextView *textView;
/** 键盘顶部的工具条 */
@property (nonatomic, weak) TRComposeToolbar *toolBar;

/** 相册（存放拍照或者相册中选择的图片） */
@property (nonatomic, weak) TRComposePhotosView *photosView;
//表情键盘，一定要用strong ，避免销毁
@property (nonatomic, strong)TREmotionKeyboard *emotionKeyboard;
//是否在切换键盘
@property (nonatomic, assign) BOOL switchKeyboard;
@end

@implementation TRComposeViewController
#pragma mark--懒加载
- (TREmotionKeyboard *)emotionKeyboard {
    if (!_emotionKeyboard) {
        self.emotionKeyboard = [[TREmotionKeyboard alloc]init];
        //如果键盘本身就有非0的宽度，那么热系统会强制让键盘的宽度等于屏幕的宽度
        self.emotionKeyboard.width = self.view.width;
        self.emotionKeyboard.height = 256;
    }
    return _emotionKeyboard;
}


#pragma mark---系统方法
- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
    //设置导航内容
    [self setUpNav];
    
    //添加输入控件
    [self setupTextView];
    
    //设置发微博的工具条
    [self setupToolBbar];
    
    [self setUpPhotosView];
}

#pragma mark---初始化方法

- (void)setUpPhotosView {
    TRComposePhotosView *photosView = [[TRComposePhotosView alloc]init];
    [self.textView addSubview:photosView];
    photosView.height = self.view.height;
    photosView.width = self.view.width;
    photosView.y = 100;
   // photosView.backgroundColor = [UIColor redColor];
    self.photosView = photosView;
}



- (void)setupToolBbar {
    TRComposeToolbar *toolBar = [[TRComposeToolbar alloc]init];
    toolBar.width = self.view.width;
    toolBar.height = 44;
    toolBar.y = self.view.height  - toolBar.height;
    // inputView用来设置键盘
    //self.textView.inputAccessoryView = toolBar;
    self.toolBar = toolBar;
    toolBar.delegate = self;
    [self.view addSubview:toolBar];
}


- (void)setUpNav{
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithTitle:@"取消" style:UIBarButtonItemStyleDone target:self action:@selector(cancel)];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithTitle:@"发送" style:UIBarButtonItemStyleDone target:self action:@selector(send)];
    //self.navigationItem.rightBarButtonItem.enabled = NO;
    
    NSString *name = [TRAccountTool returnAccount].name;
    NSString *prefix = @"发微博";
    if (name) {
        UILabel *titleView = [[UILabel alloc]init];
        titleView.width = 200;
        titleView.height = 35;
        titleView.textAlignment = NSTextAlignmentCenter;
        titleView.numberOfLines = 0;
        NSString *str = [NSString stringWithFormat:@"%@\n%@",prefix,name];
        
        //创建一个带有属性的字符串（比如颜色，字体跟文字）
        NSMutableAttributedString *attStr = [[NSMutableAttributedString alloc]initWithString:str];
        
        //添加属性
        [attStr addAttribute:NSFontAttributeName value:[UIFont boldSystemFontOfSize:16] range:[str rangeOfString:prefix]];
        [attStr addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:13] range:[str rangeOfString:name]];
        //带有样式的有属性的字符串
        titleView.attributedText = attStr;
        self.navigationItem.titleView = titleView;
    }else {
        self.textView.text = prefix;
    }
}




- (void) setupTextView {
    TREmotionTextView *textView = [[TREmotionTextView alloc]init];
    textView.frame = self.view.bounds;
    textView.placeholder = @"分享新鲜事";
    
    //textView里面要插入一些带有属性的文字
    //textView.attributedText
    
    
    textView.font = [UIFont systemFontOfSize:15];
    //垂直方向上永远是弹簧效果
    textView.alwaysBounceVertical = YES;
    textView.delegate = self;
    //textView.placeholderColor = [UIColor redColor];
    [self.view addSubview:textView];
    self.textView = textView;
    
    //能输入文本的控件一旦成为第一响应者就会弹出相应的键盘
   // [textView becomeFirstResponder];
    //在这个控制器中，textView的contentInset.top默认会等于64
   /* UITextField:
   1. 文字永远在一行，不能显示多行文字
   2.有placeholder属性设置站位文字
   3.继承自UIControl
    4.监听行为
    1>设置代理
    2>addTarget
    3>通知
    
    
    
    UITextView:
    1.能显示任意行文字
    2.不能设置站位文字
    3.继承自UIScrollView
    4.监听行为
    1》设置代理
    2》通知
    */
    
    //监听通知,控制器监听textView的文字是否发生改变
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(textDidChange) name:UITextViewTextDidChangeNotification object:textView];
    
    
    //键盘通知,键盘到frame发生改变时发出的通知（位置和尺寸）
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(KeyboardWillChangeFram:) name:UIKeyboardWillChangeFrameNotification object:nil];
    
   //选中表情的通知
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(emotionDidSelect:) name:@"TREmotionDidSelectedNotification" object:nil];
    
    //删除文字的通知
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(emotionDidDelete) name:@"TREmotionDidDeleteNotification" object:nil];
}


//为避免键盘每次都弹出来之后又谈下去，所以设置在view显示完之后弹出键盘
- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    [self.textView becomeFirstResponder];
}


#pragma mark---监听方法
- (void)emotionDidDelete {
    [self.textView deleteBackward];
}


//选中表情后，将表情放到textview中
- (void)emotionDidSelect:(NSNotification *)notification {
   TREmotion *emotion = notification.userInfo[@"selectedEmotion"];
    
    NSLog(@"%@表情选中啦",emotion.png);
    [self.textView insertEmotion:emotion];
   }


- (void)KeyboardWillChangeFram:(NSNotification *)notification {
   if (self.switchKeyboard) return;
    //所有的 notification.userInfo都是NSValue对象包含了rect或者结构体
   NSDictionary *userInfo =  notification.userInfo;
   double duration = [userInfo[UIKeyboardAnimationDurationUserInfoKey] doubleValue];
   CGRect keyboardF = [userInfo[UIKeyboardFrameEndUserInfoKey] CGRectValue];
    [UIView animateWithDuration:duration animations:^{
        if (keyboardF.origin.y > self.view.height) {//意味着键盘的y值远远超过了控制器的view
            self.toolBar.y = self.view.height - self.toolBar.height;
        }else {
             self.toolBar.y = keyboardF.origin.y - self.toolBar.height;
        }
    }];
}



- (void)textDidChange {
    self.navigationItem.rightBarButtonItem.enabled = self.textView.hasText;
    
}


- (void)cancel {

    [self dismissViewControllerAnimated:YES completion:nil];
}


- (void)send {
    
    if (self.photosView.photos.count) {
        [self sendWithImage];
    }else {
        [self sendWitoutImage];
    }
}

//从相册中选择的图片
- (void)sendWithImage {
    // 1.请求管理者
    AFHTTPRequestOperationManager *mgr = [AFHTTPRequestOperationManager manager];
    
    // 2.拼接请求参数
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"access_token"] = [TRAccountTool returnAccount].access_token;
    params[@"status"] = self.textView.fullString;
    
    // 3.发送请求
    [mgr POST:@"https://upload.api.weibo.com/2/statuses/upload.json" parameters:params constructingBodyWithBlock:^(id<AFMultipartFormData> formData) {
        // 拼接文件数据
        UIImage *image = [self.photosView.photos firstObject];
        NSData *data = UIImageJPEGRepresentation(image, 1.0);
        [formData appendPartWithFileData:data name:@"pic" fileName:@"test.jpg" mimeType:@"image/jpeg"];
    } success:^(AFHTTPRequestOperation *operation, NSDictionary *responseObject) {
        [MBProgressHUD showSuccess:@"发送成功"];
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        [MBProgressHUD showError:@"发送失败"];
    }];
    
}


- (void)sendWitoutImage {
    // 1.请求管理者
    AFHTTPRequestOperationManager *mgr = [AFHTTPRequestOperationManager manager];
    
    // 2.拼接请求参数
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"access_token"] = [TRAccountTool returnAccount].access_token;
    params[@"status"] = self.textView.fullString;
    
    // 3.发送请求
    [mgr POST:@"https://api.weibo.com/2/statuses/update.json" parameters:params success:^(AFHTTPRequestOperation *operation, NSDictionary *responseObject) {
        [MBProgressHUD showSuccess:@"发送成功"];
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        [MBProgressHUD showError:@"发送失败"];
    }];
}


- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}



//开始拖拽
- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView {
    [self.view endEditing:YES];
}


#pragma mark --TRComposeToolbarDelegate
- (void)composeToolbar:(TRComposeToolbar *)toolbar didClickButton:(TRComposeToolbarButtonType)buttonType {
    switch (buttonType) {
        case TRComposeToolbarButtonTypeCamera: // 拍照
            [self openCamera];
            break;
            
        case TRComposeToolbarButtonTypePicture: // 相册
           [self openAlbum];
            break;
            
        case TRComposeToolbarButtonTypeMention: // @
            NSLog(@"--- @");
            break;
            
        case TRComposeToolbarButtonTypeTrend: // #
            NSLog(@"--- #");
            break;
            
        case TRComposeToolbarButtonTypeEmotion: // 表情\键盘
            NSLog(@"--- 表情");
            [self switchedKeyboard];
            break;
    }
}



#pragma mark--其他方法
- (void)switchedKeyboard {
    if (self.textView.inputView == nil) {
        //显示键盘按钮
        self.toolBar.showEmotionButton = YES;
        self.textView.inputView =self.emotionKeyboard;
    }else {
        //显示表情按钮
        self.toolBar.showEmotionButton = NO;
        self.textView.inputView = nil;
    }
    //开始切换键盘
    self.switchKeyboard = YES;
    
    //退出键盘
    [self.textView endEditing:YES];
    
    //结束切换键盘（拦截旧键盘的作用）
    self.switchKeyboard = NO;
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        //弹出键盘（不拦截新键盘，执行changeFrame的操作）
          [self.textView becomeFirstResponder];
       
    });
}


- (void)openCamera{
    [self openImagePickerController:UIImagePickerControllerSourceTypeCamera];
}


- (void)openAlbum {
    //如果想写一个图片选择控制器
    [self openImagePickerController:UIImagePickerControllerSourceTypePhotoLibrary];
}


- (void)openImagePickerController:(UIImagePickerControllerSourceType)type {
    if (![UIImagePickerController isSourceTypeAvailable:type]) return;
    UIImagePickerController *ipc = [[UIImagePickerController alloc]init];
    ipc.sourceType = type;
    ipc.delegate = self;
    [self presentViewController:ipc animated:YES completion:nil];
}


#pragma mark--UIImagePickerControllerDelegate
//选择完图片后就调用（拍照，选择相册）
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info {
    [picker dismissViewControllerAnimated:YES completion:nil];
    //info中包含了选择的图片
    UIImage *image = info[UIImagePickerControllerOriginalImage];
    //添加图片阿道photosView
    // UIImageView *imageView = [[UIImageView alloc]init];
    // imageView.image = image;
    // [self.photosView addSubview:imageView];
    [self.photosView addPhoto:image];
}
@end
