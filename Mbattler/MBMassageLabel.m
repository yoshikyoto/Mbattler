//
//  MBMassageLabel.m
//  Mbattler
//
//  Created by Yoshiyuki Sakamoto on 2013/11/07.
//  Copyright (c) 2013年 Mbattler. All rights reserved.
//

#import "MBMassageLabel.h"
#import <QuartzCore/QuartzCore.h>

@implementation MBMassageLabel

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // 外枠をつけます
        self.layer.borderColor = [UIColor blackColor].CGColor;
        self.layer.borderWidth = 0.5;
        
        // 角を丸くします。
        [self.layer setCornerRadius:2.0];
        
        // 色は白にします。
        self.backgroundColor = [UIColor whiteColor];
        
        // 内部を作ります
        inner_label = [[UILabel alloc] init];
        inner_label.frame = CGRectMake(2, 2, frame.size.width - 4, frame.size.height - 4);
        inner_label.backgroundColor = [UIColor colorWithRed:1.0 green:0.95 blue:0.8 alpha:0.9];
        inner_label.numberOfLines = 0;
        inner_label.font = [UIFont fontWithName:@"uzura_font" size:20];
        // テキストの描写範囲
        [inner_label drawTextInRect:CGRectMake(5, 5, 310, 60)];
        [self addSubview:inner_label];
        
        inner_label.text = @"テキストのテスト\nてくすとのてすと";
    }
    return self;
}



/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
