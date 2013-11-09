//
//  MBSubScrollView.m
//  Mbattler
//
//  Created by Yoshiyuki Sakamoto on 2013/11/09.
//  Copyright (c) 2013年 Mbattler. All rights reserved.
//

#import "MBSubScrollView.h"

@implementation MBSubScrollView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        self.backgroundColor = [UIColor colorWithRed:0.6 green:0.3 blue:0.05 alpha:0.2];
        
        _titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 120, 26)];
        _titleLabel.backgroundColor = [UIColor colorWithRed:0.6 green:0.3 blue:0.05 alpha:0.5];
        [_titleLabel setTextColor:[UIColor whiteColor]];
        _titleLabel.textAlignment = NSTextAlignmentCenter;
        _titleLabel.font = [UIFont fontWithName:@"uzura_font" size:16];
    }
    return self;
}

- (void)setTitle:(NSString *)title{
    _titleLabel.text = title;
    [self addSubview:_titleLabel];
}

- (void)setTitleLabel{
    [self addSubview:_titleLabel];
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
