//
//  MonochromeFilter.m
//  Mbattler
//
//  Created by Yoshiyuki Sakamoto on 2013/08/13.
//  Copyright (c) 2013年 Mbattler. All rights reserved.
//

#import "MonochromeFilter.h"

@implementation MonochromeFilter

- (CGImageRef)doFilter:(CGImageRef)image
{
    // 1.CGImageからIplImageを作成
    IplImage *srcImage       = [self newIplImageFromCGImage:image];
    IplImage *grayScaleImage = cvCreateImage(cvGetSize(srcImage), IPL_DEPTH_8U, 1);
    IplImage *dstImage       = cvCreateImage(cvGetSize(srcImage), IPL_DEPTH_8U, 3);
    
    // 2.グレースケール画像に変換
    cvCvtColor(srcImage, grayScaleImage, CV_BGR2GRAY);
    
    // 3.グレースケール画像を1画素ずつ走査して2値化する
    for(int y = 0; y < grayScaleImage->height; y++) {
        for(int x = 0; x < grayScaleImage->width; x++) {
            int a = grayScaleImage->widthStep * y + x;
            uchar p = grayScaleImage->imageData[a];
            
            if (p < 80) {
                // 黒
                grayScaleImage->imageData[a] = 0;
            } else {
                // それ以上の場合、白
                grayScaleImage->imageData[a] = 255;
            }
        }
    }
    
    // 4.CGImage用にBGRに変換
    cvCvtColor(grayScaleImage, dstImage, CV_GRAY2BGR);
    
    // 5.IplImageからCGImageを作成
    CGImageRef effectedImage = [self newCGImageFromIplImage:dstImage];
    
    cvReleaseImage(&srcImage);
    cvReleaseImage(&grayScaleImage);
    cvReleaseImage(&dstImage);
    
    // 6.灰色の部分を透過する
    // const float colorMasking[6] = {100, 100, 100, 100, 100, 100};
    // effectedImage = CGImageCreateWithMaskingColors(effectedImage, colorMasking);
    
    return effectedImage;
}

- (CGImageRef)do2ValueFilter:(CGImageRef)image
{
    // 1.CGImageからIplImageを作成
    IplImage *srcImage       = [self newIplImageFromCGImage:image];
    IplImage *grayScaleImage = cvCreateImage(cvGetSize(srcImage), IPL_DEPTH_8U, 1);
    IplImage *dstImage       = cvCreateImage(cvGetSize(srcImage), IPL_DEPTH_8U, 3);
    
    // 2.グレースケール画像に変換
    cvCvtColor(srcImage, grayScaleImage, CV_BGR2GRAY);
    
    // 3.グレースケール画像を1画素ずつ走査して2値化する
    // ちょっと平均値でもとってみる
    int num = 0;
    int sum = 0;
    for(int y = 0; y < grayScaleImage->height; y++) {
        for(int x = 0; x < grayScaleImage->width; x++) {
            int a = grayScaleImage->widthStep * y + x;
            uchar p = grayScaleImage->imageData[a];
            
            // ここで統計とる。
            num++;
            sum += p;
            
            if (p < 120) {
                // 黒
                grayScaleImage->imageData[a] = 0;
            } else {
                // それ以上の場合、白
                grayScaleImage->imageData[a] = 255;
            }
        }
    }
    
    NSLog(@"p平均 %d", sum/num);
    
    // 4.CGImage用にBGRに変換
    cvCvtColor(grayScaleImage, dstImage, CV_GRAY2BGR);
    
    // 5.IplImageからCGImageを作成
    CGImageRef effectedImage = [self newCGImageFromIplImage:dstImage];
    
    cvReleaseImage(&srcImage);
    cvReleaseImage(&grayScaleImage);
    cvReleaseImage(&dstImage);
    
    // 6.灰色の部分を透過する
    // const float colorMasking[6] = {100, 100, 100, 100, 100, 100};
    // effectedImage = CGImageCreateWithMaskingColors(effectedImage, colorMasking);
    
    return effectedImage;
}

- (CGImageRef)doGrayScaleFilter:(CGImageRef)image
{
    // 1.CGImageからIplImageを作成
    IplImage *srcImage       = [self newIplImageFromCGImage:image];
    IplImage *grayScaleImage = cvCreateImage(cvGetSize(srcImage), IPL_DEPTH_8U, 1);
    IplImage *dstImage       = cvCreateImage(cvGetSize(srcImage), IPL_DEPTH_8U, 3);
    
    // 2.グレースケール画像に変換
    cvCvtColor(srcImage, grayScaleImage, CV_BGR2GRAY);
    
    // 3.グレースケール画像を1画素ずつ走査して2値化する
    /*
    for(int y = 0; y < grayScaleImage->height; y++) {
        for(int x = 0; x < grayScaleImage->width; x++) {
            int a = grayScaleImage->widthStep * y + x;
            uchar p = grayScaleImage->imageData[a];
            
            if (p < 100) {
                // 黒
                grayScaleImage->imageData[a] = 0;
            } else {
                // それ以上の場合、白
                grayScaleImage->imageData[a] = 255;
            }
        }
    }
     */
    
    // 4.CGImage用にBGRに変換
    cvCvtColor(grayScaleImage, dstImage, CV_GRAY2BGR);
    
    // 5.IplImageからCGImageを作成
    CGImageRef effectedImage = [self newCGImageFromIplImage:dstImage];
    
    cvReleaseImage(&srcImage);
    cvReleaseImage(&grayScaleImage);
    cvReleaseImage(&dstImage);
    
    // 6.灰色の部分を透過する
    const float colorMasking[6] = {100, 100, 100, 100, 100, 100};
    effectedImage = CGImageCreateWithMaskingColors(effectedImage, colorMasking);
    
    return effectedImage;
}

@end