//
//  MBButton.m
//  Mbattler
//
//  Created by Yoshiyuki Sakamoto on 2013/10/18.
//  Copyright (c) 2013年 Mbattler. All rights reserved.
//

#import "MBButton.h"

@implementation MBButton

- (id)initWithFrame:(CGRect)frame colorType:(int)type
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        self = [UIButton buttonWithType:UIButtonTypeCustom];
        self.frame = frame;
        // [self setTitle:@"GO!" forState:UIControlStateNormal];
        self.titleLabel.font = [UIFont fontWithName:@"mikachan_o" size:16];
        self.backgroundColor = [UIColor colorWithRed:0.6 green:0.3 blue:0.05 alpha:0.5];
        [self setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [self setColorType:type];
    }
    return self;
}

-(void)setText:(NSString *)text{
    [self setTitle:text forState:UIControlStateNormal];
}

-(void)setColorType:(int)type{
    self.titleLabel.font = [UIFont fontWithName:@"mikachan_o" size:16];
    [self setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    switch (type) {
        case 1:
            self.backgroundColor = [UIColor colorWithRed:0.5 green:0.5 blue:1.0 alpha:0.8];
            break;
            
        case 2:
            self.backgroundColor = [UIColor colorWithRed:1.0 green:0.5 blue:0.5 alpha:0.8];
            break;
            
        default:
            self.backgroundColor = [UIColor colorWithRed:0.6 green:0.3 blue:0.05 alpha:0.5];
            break;
    }
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
