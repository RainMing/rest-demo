//
//  ViewController.m
//  图片压缩
//
//  Created by Mr Wei on 15/10/15.
//  Copyright (c) 2015年 main.m. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    
    /// 原图
    UIImage *valueImage = [UIImage imageNamed:@"54fafdd459a1b.jpg"];
//    UIImage *valueImage = [UIImage imageNamed:@"cea1d831d508f6d2a0bf9c6b96268246"];
    CGSize mySize ;
    mySize.width = valueImage.size.width *0.5;
    mySize.height = valueImage.size.height *0.1;
    
    UIImage *neewImage =  [self compressImage:valueImage];
    UIImageView *myImageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, neewImage.size.width, neewImage.size.height)];
    myImageView.image =neewImage;
    
    
//    UIImage *changeImage = [self scaleImage:valueImage toScale:0.02];
    UIImage *newImage = [self reSizeImage:valueImage toSize:mySize];
//    UIImage *nnImage = [self captureView:myImageView];
//    UIImageView *newView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, nnImage.size.width, nnImage.size.height)];
//    
    /// 压缩像素
    NSData *imageData = UIImageJPEGRepresentation(newImage, 0.5f);
//        NSData *imageData = UIImagePNGRepresentation(newImage);
    newImage = [UIImage imageWithData:imageData];
    
    [self.view addSubview:myImageView];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

///2、生成指定大小图片

- (UIImage *)compressImage:(UIImage *)imgSrc
{
    CGSize size = {320, 480};
    UIGraphicsBeginImageContext(size);
    CGRect rect = {{0,0}, size};
    [imgSrc drawInRect:rect];
    UIImage *compressedImg = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return compressedImg;
}

/**
 * 1、等比缩放
 */
-(UIImage *) scaleImage:(UIImage *)image toScale:(float)scaleSize {
    
    UIGraphicsBeginImageContext(CGSizeMake(image.size.width * scaleSize, image.size.height * scaleSize));
    
    [image drawInRect:CGRectMake(0, 0, image.size.width * scaleSize, image.size.height * scaleSize)];
    UIImage *scaledImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
   
    return scaledImage;
}

/**
 * 2、自定义大小
 */
- (UIImage *) reSizeImage:(UIImage *)image toSize:(CGSize)reSize {
    
    UIGraphicsBeginImageContext(CGSizeMake(reSize.width, reSize.height));
    [image drawInRect:CGRectMake(0, 0, reSize.width, reSize.height)];
    UIImage *reSizeImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
   
    return reSizeImage;
}

/**
 * 3、处理某个特定的view
 * 只要是继承UIView的object 都可以处理, 必须先import QuzrtzCore.framework
 */
-(UIImage*) captureView:(UIView *)theView {
    
//    CGRect rect = theView.frame;
    CGRect rect = CGRectMake(0, 0, 100, 100);
    
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    [theView.layer renderInContext:context];
    UIImage *img = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return img;
}

@end
