//
//  MonochromeFilter.h
//  Mbattler
//
//  Created by Yoshiyuki Sakamoto on 2013/08/13.
//  Copyright (c) 2013年 Mbattler. All rights reserved.
//
// http://dev.classmethod.jp/smartphone/opencv-manga-2/
// の3値化を2値化したもの　その他いろいろ改良

#import "FilterBase.h"

@interface MonochromeFilter : FilterBase

- (CGImageRef)do2ValueFilter:(CGImageRef)image;
- (CGImageRef)doGrayScaleFilter:(CGImageRef)image;

@end