//
//  BackButton.m
//  Mbattler
//
//  Created by Yoshiyuki Sakamoto on 2013/05/12.
//  Copyright (c) 2013年 Mbattler. All rights reserved.
//

#import "BackButton.h"

@implementation BackButton

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

-(id)init{
    // とりあえずデフォルトのボタンの形
    self = [BackButton buttonWithType:UIButtonTypeRoundedRect];
    // self = [super initWithFrame:CGRectMake(200, 410, 100, 30)];
    if (self) {
        self.frame = CGRectMake(200, 410, 100, 30);
        [self setTitle:@"戻る" forState:UIControlStateNormal];
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
