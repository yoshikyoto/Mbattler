//
//  MBCharacterView.m
//  Mbattler
//
//  Created by Yoshiyuki Sakamoto on 2013/08/10.
//  Copyright (c) 2013年 Mbattler. All rights reserved.
//

#import "MBCharacterView.h"
#import "Player.h"
#import "MBStatusView.h"

@implementation MBCharacterView

- (id)initWithPlayer:(Player *)p
{
    self = [super initWithPlayer:p];
    if (self) {
        // Initialization code
        // タイトル
        title.text = @"キャラクター";
        [self addSubview:title];
        
        // スクロールビューを作成
        UIScrollView *characterScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 40, 320, height - 40)];
        characterScrollView.backgroundColor = [UIColor clearColor]; // 背景透明
        // スクロールビュー内部のサイズ 縦はキャラ数に依存させる感じになる
        int h = 58*ceil([player getNumOfMeishi] / 5.0) + 10;
        characterScrollView.contentSize = CGSizeMake(320, h);
        [self addSubview:characterScrollView];
        //[self setTitle];
        // NSLog(@"%d", h);
        
        // パディングを指定
        int padding = 20;
        
        // キャラクターのボタン作成
        UIButton *button;
        for(int i = 0; i < [player getNumOfMeishi]; i++){
            // ボタンの配置場所は i 依存になる
            button = [UIButton buttonWithType:UIButtonTypeCustom];
            // ボタンのサイズを指定。もうちょっと小さくしてもいいかも。
            button.frame = CGRectMake(padding+58*(i%5), padding+58*(i/5), 48, 48);
            //CGRectMake(5+59*(i%5), 5+59*(i/5), 54, 54);
            // ボタンの tag としてキャラ番号を保持させる
            button.tag = i;
            // ボタンに画像をセット
            [button setBackgroundImage:[[player getMeishi:i] getIcon] forState:UIControlStateNormal];
            [button addTarget:self action:@selector(viewStatus:)forControlEvents:UIControlEventTouchUpInside];
            // ボタンを画面に表示
            [characterScrollView addSubview:button];
        }

    }
    return self;
}

// キャラが押された時 ------------------------------------------------------------
- (void)viewStatus:(id)sender{
    NSLog(@"キャラが選択されました");
    // Sender となったボタンを取得
    UIButton *button = (UIButton *)sender;
    
    // ステータス表示
    MBStatusView *view = [[MBStatusView alloc] initWithMeishi:[player getMeishi:button.tag]];
    [self addSubview:view];
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
