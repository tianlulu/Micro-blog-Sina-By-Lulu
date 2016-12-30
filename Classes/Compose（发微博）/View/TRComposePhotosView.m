//
//  TRComposePhotosView.m
//  露露微博
//
//  Created by lushuishasha on 15/9/23.
//  Copyright (c) 2015年 Pass_Value. All rights reserved.
//

#import "TRComposePhotosView.h"
#import "UIView+Extension.h"


@implementation TRComposePhotosView
- (id)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        _photos = [NSMutableArray array];
    }
    return self;
}



- (void)addPhoto:(UIImage *)photo {
    UIImageView *photoView = [[UIImageView alloc]init];
    photoView.image = photo;
    [self addSubview:photoView];
    //存储图片
    [_photos addObject:photo];
}


- (void) layoutSubviews {
    //设置图片的尺寸和位置
    NSUInteger count = self.subviews.count;
    int maxCol = 4;
    CGFloat imageWH = 70;
    CGFloat imageMargin = 10;
    for (int i = 0; i < count; i++) {
        UIImageView *photoView = self.subviews[i];
        int col = i % maxCol;
        photoView.x = col * (imageWH + imageMargin);
        
        int row = i / maxCol;
        photoView.y = row * (imageWH + imageMargin);
        photoView.width = imageWH;
        photoView.height = imageWH;

    }
}

//每掉一次便利一次图片
//- (NSArray *)photos{
////    NSMutableArray *photos = [NSMutableArray array];
////    for (UIImageView *imageView in self.subviews) {
////        [photos addObject:imageView.image];
////    }
////    return photos;
//    return self.addPhptos;
//}
@end
