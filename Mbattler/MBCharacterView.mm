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
#import "UIOutlineLabel.h"

@implementation MBCharacterView

- (id)initWithPlayer:(Player *)p
{
    self = [super initWithPlayer:p];
    if (self) {
        // Initialization code
        // タイトル
        title.text = @"キャラクター";
        [self addSubview:title];
        
        [self drawCharactersScrollView];
        
        // characters_scrollView = [self getCharactersScrollView];
        // [self addSubview:characters_scrollView];
        
        // スクロールビューを作成
        /*
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
         */

    }
    return self;
}

- (void)drawCharactersScrollView{
    if(characterScrollView) [characterScrollView removeFromSuperview];
    // スクロールビューを作成
    characterScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 500, 320, height - 40)];
    characterScrollView.backgroundColor = [UIColor clearColor]; // 背景透明
    // スクロールビュー内部のサイズ 縦はキャラ数に依存させる感じになる
    int h = 58*ceil([player getNumOfMeishi] / 5.0) + 10;
    characterScrollView.contentSize = CGSizeMake(320, h);
    //[self addSubview:characterScrollView];
    //[self setTitle];
    // NSLog(@"%d", h);
    
    // パディングを指定
    int padding = 20;
    
    // キャラクターのボタン作成
    UIButton *button;
    for(int i = 0; i < [player getNumOfMeishi]; i++){
        Meishi *meishi = [player getMeishi:i];
        // ボタンの配置場所は i 依存になる
        button = [UIButton buttonWithType:UIButtonTypeCustom];
        // ボタンのサイズを指定。もうちょっと小さくしてもいいかも。
        button.frame = CGRectMake(padding+58*(i%5), padding+58*(i/5), 48, 48);
        //CGRectMake(5+59*(i%5), 5+59*(i/5), 54, 54);
        // ボタンの tag としてキャラ番号を保持させる
        button.tag = i;
        // ボタンに画像をセット
        [button setBackgroundImage:[meishi getIcon] forState:UIControlStateNormal];
        [button setBackgroundColor:[UIColor colorWithRed:0.9 green:0.75 blue:0.55 alpha:1.0]];
        [button addTarget:self action:@selector(viewStatus:)forControlEvents:UIControlEventTouchUpInside];
        // ボタンを画面に表示
        [characterScrollView addSubview:button];
        
        // キャラの名前を表示
        UIOutlineLabel *name_label = [[UIOutlineLabel alloc] init];
        [name_label setOutlineColor:[UIColor whiteColor]];
        [name_label setOutlineWidth:3];
        name_label.text = [meishi getName];
        name_label.frame = CGRectMake(padding+58*(i%5), padding+58*(i/5)+38, 48, 10);
        name_label.textAlignment = NSTextAlignmentCenter;
        name_label.font = [UIFont systemFontOfSize:10];
        name_label.backgroundColor = [UIColor clearColor];
        [characterScrollView addSubview:name_label];
    }
    [self addSubview:characterScrollView];
}

// キャラが押された時 ------------------------------------------------------------
- (void)viewStatus:(id)sender{
    NSLog(@"キャラが選択されました");
    // Sender となったボタンを取得
    UIButton *button = (UIButton *)sender;
    tag = button.tag;
    
    // ステータス表示
    // 解雇ボタンの処理も書く
    status_view = [[MBStatusView alloc] initWithMeishi:[player getMeishi:tag] Player:player];
    [status_view.fire_button addTarget:self action:@selector(fireAlert:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:status_view];
    [status_view startAnimation];
}

// 解雇
- (void)fireAlert:(id)sender{
    UIAlertView *alert = [[UIAlertView alloc] init];
    if([player getNumOfMeishi] > 1){
        alert.delegate = self;
        alert.title = @"この操作は取り消せません";
        alert.message = @"解雇してもよろしいですか？\n解雇したキャラクターは削除されます";
        [alert addButtonWithTitle:@"削除"];
        [alert addButtonWithTitle:@"やめる"];
    }else{
        alert.title = @"最後の名刺です";
        alert.message = @"キャラクターが一人しか居ない場合は\n解雇できません";
        [alert addButtonWithTitle:@"とじる"];
    }
    [alert show];
}


-(void)alertView:(UIAlertView*)alertView
clickedButtonAtIndex:(NSInteger)buttonIndex {
    if(alertView.tag == 1){
        NSLog(@"%s dismissするよ！", __func__);
        return;
    }else{
        switch (buttonIndex) {
            case 0:
                [player removeMeishiAtIndex:tag];
                if(tag < [player getPartynum]) [player setPartyNum:[player getPartynum] - 1];
                [status_view removeFromSuperview];
                [player save];
                [self drawCharactersScrollView];
                break;
            case 1:
                break;
        }
    }
}

- (void)fire:(id)sender{
}

- (void)startAnimation{
    //アニメーションの対象となるコンテキスト
    CGContextRef context = UIGraphicsGetCurrentContext();
    [UIView beginAnimations:nil context:context];
    //アニメーションを実行する時間
    [UIView setAnimationDuration:0.2];
    //アニメーションイベントを受け取るview
    [UIView setAnimationDelegate:self];
    //アニメーション終了後に実行される
    //[UIView setAnimationDidStopSelector:@selector(endAnimation)];
    
    title.frame = CGRectMake(-5, 4, 310, 40);
    characterScrollView.frame = CGRectMake(0, 40, 320, height - 40);
    
    // アニメーション開始
    [UIView commitAnimations];
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
