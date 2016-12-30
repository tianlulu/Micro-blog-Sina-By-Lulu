//
//  TRStatusPhotosView.m
//  露露微博
//
//  Created by lushuishasha on 15/9/21.
//  Copyright (c) 2015年 Pass_Value. All rights reserved.
//

#import "TRStatusPhotosView.h"
#import "TRPhoto.h"
#import "UIImageView+WebCache.h"
#import "UIView+Extension.h"
#import "TRStatusPhotoView.h"

#define TRStatusPhotoWH   70
#define TRStatusPhotoMargin 10
#define TRStatusPhotoMaxCol(count)  ((count==4)?2:3)

@implementation TRStatusPhotosView
+(CGSize)sizeWithCount:(int)count {
    //最大列数
    int maxCols = 3;
    
    //列数
    int cols = (count >= maxCols)? maxCols : count;
    CGFloat photosW = cols * TRStatusPhotoWH + (cols- 1) * TRStatusPhotoMargin;
    
    //行数
    int rows = (count + maxCols - 1) / maxCols;
    CGFloat photosH = rows * TRStatusPhotoWH + (rows - 1) * TRStatusPhotoMargin;
    return CGSizeMake(photosW, photosH);
}

- (id)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
    }
    return self;
}


//重新set方法,因为self.photootossView.photos = status.pic_urls;
- (void) setPhotos:(NSArray *)photos {
    _photos = photos;
    NSUInteger photosCount = photos.count;
    
    //创建足够数量的图片控件
    while (self.subviews.count < photosCount) {
       TRStatusPhotoView *photoView = [[TRStatusPhotoView alloc]init];
        [self addSubview:photoView];
    }
    
    //便利所有的图片控件，设置图片(创建缺少的imageView)
    for (int i = 0; i < self.subviews.count; i++) {
        TRStatusPhotoView *photoView = self.subviews[i];
        if (i < photosCount) {
            photoView.photo = photos[i];
            photoView.hidden = NO;
            
            //设置图
   //  [photoView sd_setImageWithURL:[NSURL URLWithString:photo.thumbnail_pic] placeholderImage:[UIImage imageNamed:@"timeline_image_placeholder"]];
        }else {
            photoView.hidden = YES;
        }
    }
}


- (void)layoutSubviews {
    [super layoutSubviews];
    //设置图片的尺寸和位置
    NSUInteger photosCount = self.photos.count;
    int maxCol = TRStatusPhotoMaxCol(photosCount);
    
    
    for (int i = 0; i < photosCount; i++) {
        TRStatusPhotoView *photoView = self.subviews[i];
        int col = i % maxCol;
        photoView.x = col * (TRStatusPhotoWH + TRStatusPhotoMargin);
        
        int row = i / maxCol;
        photoView.y = row * (TRStatusPhotoWH + TRStatusPhotoMargin);
        photoView.width = TRStatusPhotoWH;
        photoView.height = TRStatusPhotoWH;
    }
    
    
}


@end
