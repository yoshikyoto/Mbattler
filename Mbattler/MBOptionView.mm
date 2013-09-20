//
//  MBOptionView.m
//  Mbattler
//
//  Created by Yoshiyuki Sakamoto on 2013/08/12.
//  Copyright (c) 2013年 Mbattler. All rights reserved.
//

#import "MBOptionView.h"

@implementation MBOptionView

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
        title.text = @"設定・その他";
        [self addSubview:title];
        
        UIButton *ac_button = [UIButton buttonWithType:UIButtonTypeRoundedRect];
        ac_button.frame = CGRectMake(30, 40, 260, 30);
        [ac_button setTitle:@"実績" forState:UIControlStateNormal];
        [ac_button addTarget:self action:@selector(openAchivement:)forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:ac_button];
        
        UILabel *push_label = [[UILabel alloc] initWithFrame:CGRectMake(30, 75, 260, 20)];
        push_label.text = @"プッシュ通知";
        [self addSubview:push_label];
        
        UILabel *push_desc_label = [[UILabel alloc] initWithFrame:CGRectMake(30, 100, 260, 30)];
        push_desc_label.text = @"ONにすると、スタミナが全回復した時に、プッシュ通知で知らせてくれます。";
        push_desc_label.numberOfLines = 2;
        push_desc_label.font = [UIFont systemFontOfSize:12];
        [self addSubview:push_desc_label];
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
