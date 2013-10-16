//
//  MBScrollView.m
//  Mbattler
//
//  Created by Yoshiyuki Sakamoto on 2013/08/10.
//  Copyright (c) 2013年 Mbattler. All rights reserved.
//

#import "MBScrollView.h"

@implementation MBScrollView

- (id)initWithPlayer:(Player *)p
{
    self = [super init];
    if (self) {
        // Initialization code
        
        self.backgroundColor = [UIColor whiteColor]; // とりあえず白
        player = p;
        
        // 色初期化
        title_back_color = [UIColor colorWithRed:0.6 green:0.3 blue:0.05 alpha:1.0];
        subtitle_back_color = [UIColor colorWithRed:0.6 green:0.3 blue:0.05 alpha:0.5];
        back_color = [UIColor colorWithRed:0.6 green:0.3 blue:0.05 alpha:0.2];
        
        // 画面の縦横を取得
        CGRect screen_rect = [UIScreen mainScreen].applicationFrame;
        width = screen_rect.size.width;
        int h = screen_rect.size.height;
        height = h - 56 - 54;
        self.frame = CGRectMake(0, 56, width, height);
        
        // タイトル部分の背景
        /*
        titleImage = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"blueTape.png"]];
        titleImage.frame = CGRectMake(0, 3, 320, 50);
        [self addSubview:titleImage];
         */
        
        // タイトル初期化
        title = [[UILabel alloc] init];
        title.font = [UIFont fontWithName:@"mikachan_o" size:20];//[UIFont systemFontOfSize:20];
        //[title setBackgroundColor:[UIColor whiteColor]];
        title.backgroundColor = [UIColor colorWithRed:0.6 green:0.3 blue:0.05 alpha:1.0];
        title.textColor = [UIColor whiteColor];
        title.frame = CGRectMake(-5, 4, 310, 40);
        title.textAlignment = NSTextAlignmentCenter;
        // title.textColor = [UIColor whiteColor];
        [self addSubview:title];
        self.backgroundColor = [UIColor clearColor];
        
        title.layer.masksToBounds = NO;
        title.layer.shadowOffset = CGSizeMake(1.0f, 1.0f);  //影の方向
        title.layer.shadowOpacity = 0.7f; // 影の透明度
        title.layer.shadowColor = [UIColor blackColor].CGColor;   // 影の色
        title.layer.shadowRadius = 1.0f;  // ぼかし
        

        // 背景の設定
        UIImage *backgroundImage = [UIImage imageNamed:@"bg.png"];
        self.backgroundColor = [UIColor colorWithPatternImage:backgroundImage];
    }
    return self;
}

- (void)setTitle:(NSString *)t{
    title.text = t;
}

- (void)setTitle{
    [self addSubview:titleImage];
    [self addSubview:title];
}

// 戻るボタン設置
- (void)setBackButton{
    UIButton *backbutton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    backbutton.frame = CGRectMake(20, 5, 50, 32);
    [backbutton setTitle:@"戻る" forState:UIControlStateNormal];
    [backbutton addTarget:self action:@selector(close:)forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:backbutton];
}

- (void)close:(id)sender{
    [self removeFromSuperview];
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
