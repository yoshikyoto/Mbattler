//
//  MBConbatantView.m
//  Mbattler
//
//  Created by Yoshiyuki Sakamoto on 2013/10/05.
//  Copyright (c) 2013年 Mbattler. All rights reserved.
//

#import "MBConbatantView.h"

@implementation MBConbatantView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        self.backgroundColor = [UIColor darkGrayColor];
        
        // ラベル初期化
        turn_label = [[UILabel alloc] initWithFrame:CGRectMake(20, 7, 200, 30)];
        turn_label.textColor = [UIColor whiteColor];
        [self addSubview:turn_label];
        [self setTurn:0];
    }
    return self;
}

- (void)setTurn:(int)t{
    turn = t;
    turn_label.text = [NSString stringWithFormat:@"turn %d", turn];
}

- (int)nextTurn{
    int t = turn + 1;
    [self setTurn:t];
    return t;
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
