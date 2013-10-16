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
        
        
        UILabel *version_label = [[UILabel alloc] initWithFrame:CGRectMake(30, 55, 260, 20)];
        version_label.text = @"バージョン";
        version_label.font = [UIFont fontWithName:@"mikachan_o" size:16];
        [self addSubview:version_label];
        
        UILabel *version_desc_label = [[UILabel alloc] initWithFrame:CGRectMake(30, 80, 260, 15)];
        version_desc_label.text = @"名刺バトラー beta  ver0.1";
        //version_desc_label.numberOfLines = 2;
        version_desc_label.font = [UIFont systemFontOfSize:12];
        version_desc_label.textColor = [UIColor darkGrayColor];
        [self addSubview:version_desc_label];
        
        UILabel *credit_label = [[UILabel alloc] initWithFrame:CGRectMake(30, 115, 260, 20)];
        credit_label.text = @"クレジット";
        credit_label.font = [UIFont fontWithName:@"mikachan_o" size:16];
        [self addSubview:credit_label];
        
        UILabel *credit_label1 = [[UILabel alloc] initWithFrame:CGRectMake(30, 140, 260, 30)];
        credit_label1.text = @"ぴぽや倉庫\nhttp://piposozai.wiki.fc2.com/";
        credit_label1.numberOfLines = 2;
        credit_label1.font = [UIFont systemFontOfSize:12];
        credit_label1.textColor = [UIColor darkGrayColor];
        [self addSubview:credit_label1];
        
        UILabel *credit_label2 = [[UILabel alloc] initWithFrame:CGRectMake(30, 180, 260, 30)];
        credit_label2.text = @"アンデッドとか好きだからーーーッ！\nhttp://lud.sakura.ne.jp/";
        credit_label2.numberOfLines = 2;
        credit_label2.font = [UIFont systemFontOfSize:12];
        credit_label2.textColor = [UIColor darkGrayColor];
        [self addSubview:credit_label2];
        
        UILabel *credit_label3 = [[UILabel alloc] initWithFrame:CGRectMake(30, 220, 260, 30)];
        credit_label3.text = @"フリー素材 * ヒバナ\nhttp://hibana.rgr.jp/";
        credit_label3.numberOfLines = 2;
        credit_label3.font = [UIFont systemFontOfSize:12];
        credit_label3.textColor = [UIColor darkGrayColor];
        [self addSubview:credit_label3];
        
        
        /*
        UIButton *ac_button = [UIButton buttonWithType:UIButtonTypeRoundedRect];
        ac_button.frame = CGRectMake(30, 40, 260, 30);
        [ac_button setTitle:@"実績" forState:UIControlStateNormal];
        [ac_button addTarget:self action:@selector(openAchivement:)forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:ac_button];
         */
        
        /*
        UILabel *push_label = [[UILabel alloc] initWithFrame:CGRectMake(30, 75, 260, 20)];
        push_label.text = @"プッシュ通知";
        [self addSubview:push_label];
        
        UILabel *push_desc_label = [[UILabel alloc] initWithFrame:CGRectMake(30, 100, 260, 30)];
        push_desc_label.text = @"ONにすると、スタミナが全回復した時に、プッシュ通知で知らせてくれます。";
        push_desc_label.numberOfLines = 2;
        push_desc_label.font = [UIFont systemFontOfSize:12];
        [self addSubview:push_desc_label];
         */
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
