//
//  MBMassageLabel.h
//  Mbattler
//
//  Created by Yoshiyuki Sakamoto on 2013/11/07.
//  Copyright (c) 2013年 Mbattler. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UIOutlineLabel.h"

@interface MBMassageLabel : UILabel{
    // UILabel *inner_label;
    NSMutableArray *text_array;
    int maxnum_of_lines;
    UIOutlineLabel *next_label;
}

@property(readwrite) UILabel *innerLabel;

- (void)setText:(NSString *)text;
- (void)addText:(NSString *)text;
- (void)clearText;
- (void)showNextButton;
- (void)removeNextButton;
- (void)setInnerBackgroundColor:(UIColor *)color;

@end
