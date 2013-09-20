//
//  MBSummonView.m
//  Mbattler
//
//  Created by Yoshiyuki Sakamoto on 2013/08/12.
//  Copyright (c) 2013年 Mbattler. All rights reserved.
//

#import "MBSummonView.h"

@implementation MBSummonView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

- (id)initWithPlayer:(Player *)p{
    self = [super initWithPlayer:p];
    if(self){
        NSLog(@"MBCharacterView: initWithPlayer");
        title.text = @"名刺召喚";
        [self addSubview:title];
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
