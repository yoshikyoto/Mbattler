//
//  MBItemButton.m
//  Mbattler
//
//  Created by Yoshiyuki Sakamoto on 2013/11/09.
//  Copyright (c) 2013年 Mbattler. All rights reserved.
//

#import "MBItemButton.h"

@implementation MBItemButton

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void)setItem:(int)itemID{
    self.tag = itemID;
    
    // 画像
    NSString *image_string;
    switch (itemID) {
        case 0:
            image_string = @"stamina.png";
            break;
        case 1:
            image_string = @"yakusou.png";
            break;
        case 2:
            image_string = @"ringo.png";
            break;
    }
    [self setBackgroundImage:[UIImage imageNamed:image_string] forState:UIControlStateNormal];
    
    NSUserDefaults *ud = [NSUserDefaults standardUserDefaults];
    NSString *key = [NSString stringWithFormat:@"ITEM_%d", itemID];
    _label = [[UIOutlineLabel alloc] init];
    [_label setTitle:[NSString stringWithFormat:@"x%d",[ud integerForKey:key]]];
    _label.frame = CGRectMake(0, 30, 44, 14);
    _label.textAlignment = NSTextAlignmentRight;
    //_label.font = [UIFont fontWithName:@"azukifontL" size:14];
    _label.font = [UIFont systemFontOfSize:14];

    [self addSubview:_label];                                                                                           
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
