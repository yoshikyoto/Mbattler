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
        inner_label.font = [UIFont fontWithName:@"azukifontL" size:16];
        // テキストの描写範囲
        //[inner_label drawTextInRect:CGRectMake(5, 5, frame.size.width - 10, frame.size.height - 10)];
        [self addSubview:inner_label];
        
        // 次へボタンの初期化
        next_label = [[UIOutlineLabel alloc] init];
        [next_label setTitle:@"tap▼"];
        CGRect frame = self.frame;
        next_label.frame = CGRectMake(frame.size.width - 50, frame.size.height - 14, 50, 14);
        next_label.textAlignment = NSTextAlignmentRight;
        next_label.font = [UIFont fontWithName:@"uzura_font" size:14];
        
        text_array = [[NSMutableArray alloc] init];
    }
    return self;
}

- (void)setNumberOfLines:(int)numberOfLines{
    inner_label.numberOfLines = numberOfLines;
    maxnum_of_lines = numberOfLines;
}

- (void)drawText{
    NSString *labeltext = [text_array objectAtIndex:0];
    for(int i = 1; i < maxnum_of_lines; i++){
        if(i < [text_array count]){
            labeltext = [NSString stringWithFormat:@"%@\n%@", labeltext, [text_array objectAtIndex:i]];
        }else{
            labeltext = [NSString stringWithFormat:@"%@\n", labeltext];
        }
    }
    inner_label.text = labeltext;
}

- (void)setText:(NSString *)text{
    text_array = [[NSMutableArray alloc] init];
    [text_array addObject:text];
    [self drawText];
}

- (void)addText:(NSString *)text{
    if([text_array count] >= 3) [text_array removeObjectAtIndex:0];
    [text_array addObject:text];
    [self drawText];
}

- (void)showNextButton{
    [self addSubview:next_label];
}

- (void)removeNextButton{
    [next_label removeFromSuperview];
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
