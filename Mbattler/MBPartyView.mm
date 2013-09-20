//
//  MBPartyView.m
//  Mbattler
//
//  Created by Yoshiyuki Sakamoto on 2013/08/10.
//  Copyright (c) 2013年 Mbattler. All rights reserved.
//

#import "MBPartyView.h"
#import "Player.h"
#import "Meishi.h"
#import "MiniStatusView.h"
#import <QuartzCore/QuartzCore.h>
#import "PartyChangeView.h"


@implementation MBPartyView

- (id)initWithPlayer:(Player *)p
{
    self = [super initWithPlayer:p];
    if (self) {
        // Initialization code
        
        title.text = @"パーティ編成";
        [self addSubview:title];
        
        // パーティ部分の描写
        [self drawParty];
        
        // パーティじゃない部分の描写
        [self drawNParty];
        
        // 確認ウィンドウの初期化
        [self initConfirmWindow];
        
        // 決定ボタンの初期化
        confirm = [UIButton buttonWithType:UIButtonTypeRoundedRect];
        confirm.frame = CGRectMake(90, 285, 50, 30);
        [confirm setTitle:@"はい" forState:UIControlStateNormal];
        [confirm addTarget:self action:@selector(doChange:)forControlEvents:UIControlEventTouchUpInside];
        // キャンセルボタンの初期化
        cancel = [UIButton buttonWithType:UIButtonTypeRoundedRect];
        cancel.frame = CGRectMake(160, 285, 50, 30);
        [cancel setTitle:@"いいえ" forState:UIControlStateNormal];
        [cancel addTarget:self action:@selector(cancelChange:)forControlEvents:UIControlEventTouchUpInside];
    }
    return self;
}

// 確認ウインドウ初期化
- (void)initConfirmWindow{
    confirm_window = [[PartyChangeView alloc] init];
    confirm_window.frame = CGRectMake(10, 96, 300, 300);
    confirm_window.backgroundColor = [title_bg colorWithAlphaComponent:0.8]; // 少し透けさせる
    // 影をつける
    confirm_window.layer.masksToBounds = NO;
    confirm_window.layer.shadowOffset = CGSizeMake(3.0f, 3.0f);  //影の方向
    confirm_window.layer.shadowOpacity = 0.7f; // 影の透明度
    confirm_window.layer.shadowColor = [UIColor blackColor].CGColor;   // 影の色
    confirm_window.layer.shadowRadius = 2.0f;  // ぼかし
}

// パーティ部分描写 ------------------------------------------------------------------------------------------
- (void)drawParty{
    // パーティ表示部分の背景
    UIImageView *partyImage = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"c_tape2.png"]];
    partyImage.frame = CGRectMake(0, 50, 315, 100);
    [self addSubview:partyImage];
    // パーティ部分のビュー
    p_view = [[UIScrollView alloc] initWithFrame:CGRectMake(8, 52, 300, 90)];
    p_view.backgroundColor = [UIColor clearColor];
    [self addSubview:p_view];
    int i;
    for(i = 0; i < [player getPartynum]; i++){
        // ボタンのサイズとかを指定
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        button.frame = CGRectMake(12+58*i, 10, 48, 48);
        // ボタンの tag としてキャラ番号を保持させる
        button.tag = i;
        // ボタンに画像をセット
        [button setBackgroundImage:[[player getMeishi:i] getIcon] forState:UIControlStateNormal];
        // タップされた時の処理
        [button addTarget:self action:@selector(characterTouched:)forControlEvents:UIControlEventTouchUpInside];
        [p_view addSubview:button];
        
        // 前後入れ替えボタン
        UIButton *zengo = [UIButton buttonWithType:UIButtonTypeRoundedRect];
        zengo.frame = CGRectMake(5+59*i, 64, 54, 25);
        [zengo setTitle:@"前後" forState:UIControlStateNormal];
        [p_view addSubview:zengo];
    }
    // パーティ不足の時の追加ボタン
    if(i < 5){
        UIButton *in_button = [UIButton buttonWithType:UIButtonTypeCustom];
        in_button.frame = CGRectMake(10+58*i, 10, 48, 48);
        // アイコンはとりあえず代用
        [in_button setBackgroundImage:[UIImage imageNamed:@"outicon.PNG"] forState:UIControlStateNormal];
        in_button.tag = -1;
        [in_button addTarget:self action:@selector(characterTouched:)forControlEvents:UIControlEventTouchUpInside];
        [p_view addSubview:in_button];
    }
    // ここで暗転するやつも初期化しておく
    p_black = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 300, 90)];
    p_black.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.6];
}
// ノンパーティ部分再描写 ------------------------------------------------------------------------------------------
- (void)drawNParty{
    // キャラクタービューの作成（パーティじゃないキャラクターの描写）
    n_view = [[UIScrollView alloc] initWithFrame:CGRectMake(10, 142, 300, height - 142)];
    n_view.backgroundColor = [UIColor clearColor]; //sub_bg; // 背景
    
    // 「はずす」ボタンの描写
    UIButton *out_button = [UIButton buttonWithType:UIButtonTypeCustom];
    out_button.frame = CGRectMake(10, 10, 48, 48);
    [out_button setBackgroundImage:[UIImage imageNamed:@"outicon.PNG"] forState:UIControlStateNormal]; //アイコン
    out_button.tag = -2;
    [out_button addTarget:self action:@selector(characterTouched:)forControlEvents:UIControlEventTouchUpInside];
    [n_view addSubview:out_button];
    // アイコンの描写
    int partynum = [player getPartynum];
    int nonpartynum = [player getNumOfMeishi] - partynum;
    for(int i = 0; i < nonpartynum; i++){
        // ボタンの配置場所は i 依存になる
        int j = i + partynum;
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        // ボタンのサイズを指定。もうちょっと小さくしてもいいかも。
        button.frame = CGRectMake(10+58*((i+1)%5), 10+58*((i+1)/5), 48, 48);
        // ボタンの tag としてキャラ番号を保持させる
        button.tag = j;
        // ボタンに画像をセット
        [button setBackgroundImage:[[player getMeishi:j] getIcon] forState:UIControlStateNormal];
        // タップされた時の処理
        [button addTarget:self action:@selector(characterTouched:)forControlEvents:UIControlEventTouchUpInside];
        // ボタンを画面に表示
        [n_view addSubview:button];
    }
    // スクロールビュー内部のサイズ 縦はキャラ数に依存させる感じになる
    int h = 58*ceil((nonpartynum+1) / 5.0) + 10;
    NSLog(@"h: %d", h);
    n_view.contentSize = CGSizeMake(300, h);
    [self addSubview:n_view];
    // ここで暗転するやつも初期化しておく
    n_black = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 300, h)];
    n_black.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.6];
}

// キャラが押された時の処理 ------------------------------------------------------------
- (void)characterTouched:(id)sender{
    // それ(target)がパーティかそれ以外かを判断
    UIButton *target = (UIButton *)sender;
    
    if((-1 <= target.tag)&&(target.tag < [player getPartynum])){
        // パーティメンバーだった時の処理
        if(p_selected&&(p_id == target.tag)){
            [self removeP];
            return;
        }
        // p_id にタグをセット
        p_id = target.tag;
        
        if(target.tag == -1){
            // キャラ追加の時　入れるのは選べない
            if(p_selected&&(p_id == -2)) return;
            NSLog(@"はずす");
            // 確認ウィンドウにはnilをセット
            [confirm_window set_p: nil];
        }else{
            // それ以外の時　入れ替えのとき
            NSLog(@"パーティメンバー選択");
            // 押された名刺の情報を確認ウインドウにセット
            [confirm_window set_p: [player getMeishi:p_id]];
        }
        // 暗転させる
        [p_view addSubview:p_black];
        [p_view addSubview:target];
        //[[self view] addSubview:p_cancelbutton];    //取り消しボタンを表示
        p_selected = true;  //選ばれたことを表す
        latest_view = true; //最後に選ばれたのはパーティメンバーである
        
    }else{
        // パーティメンバーじゃなかったとき
        if(n_selected&&(n_id == target.tag)){
            [self removeN];
            return;
        }
        // 押された名刺の情報をセット
        n_id = target.tag;
        if(target.tag == -2){
            // 外すとき、入れるのは選べない
            if(p_selected&&(p_id == -1)) return;
            NSLog(@"はずす");
            [confirm_window set_n:nil];
        }else{
            // 普通にいれかえ
            NSLog(@"パーティメンバー以外選択");
            [confirm_window set_n: [player getMeishi:n_id]];
        }
        // 暗転させる
        [n_view addSubview:n_black];
        [n_view addSubview:target];
        [self addSubview:nministatus];   // ステータスを表示
        //[[self view] addSubview:n_cancelbutton];    //取り消しボタンを表示
        n_selected = true;  //選ばれたことを表す
        latest_view = false;    //最後に選ばれたのはノンパーティメンバーである
    }
    
    if(p_selected&&n_selected){
        NSLog(@"両方選ばれた");
        [self viewConfirmMessege];
    }
}

// pの方をremoveする ------------------------------------------------------------
- (void)removeP{
    // まずは確認ウインドウを除去
    [self removeConfirmMessage];
    // miniviewとボタンを除去
    [pministatus removeFromSuperview];
    [p_cancelbutton removeFromSuperview];
    [p_black removeFromSuperview];
    // selectedをfalseに
    p_selected = false;
}
// nの方を除去する
- (void)removeN{
    // まずは確認ウインドウを除去
    [self removeConfirmMessage];
    // miniviewとボタンを除去
    [nministatus removeFromSuperview];
    [n_cancelbutton removeFromSuperview];
    [n_black removeFromSuperview];
    // selectedをfalseに
    n_selected = false;
}
// 確認メッセージを表示する関数
- (void)viewConfirmMessege{
    [self addSubview:confirm_window];
    for(int i = 330; i >= 9; i -= (i*0.1)){
        [[NSRunLoop currentRunLoop] runUntilDate:[NSDate dateWithTimeIntervalSinceNow:0.01]];
        confirm_window.frame = CGRectMake(i, 40, 300, 300);
    }
    
    confirm_window.frame = CGRectMake(10, 40, 300, 300);
    [self addSubview:confirm];
    [self addSubview:cancel];
}
// 確認メッセージを除去する関数
- (void)removeConfirmMessage{
    // 両方選択されてないと確認メッセージは出ない筈なので
    if(p_selected&&n_selected){
        [confirm_window removeFromSuperview];
        [confirm removeFromSuperview];
        [cancel removeFromSuperview];
    }
}
// キャラ選択が解除されたとき------------------------------------------------------------------------------------
- (void)cancelChange:(id)sender{
    // まず確認メッセージを除去
    [confirm_window removeFromSuperview];
    [confirm removeFromSuperview];
    [cancel removeFromSuperview];
    // 対応したminiviewを除去------------------------------------!!!ここ修正
    if(latest_view){
        [self removeP];
    }else{
        [self removeN];
    }
}
// 確定されたとき ------------------------------------------------------------------------------------------
- (void)doChange:(id)sender{
    NSMutableArray *meishis = [player getMeishis];
    if(p_id == -1){
        // 追加のとき
        NSLog(@"パーティ追加 %d", n_id);
        [player addParty:n_id];
    }else if(n_id == -2){
        // 外すとき
        [player removeFromParty:p_id];
    }else{
        // 入れ替えのとき
        [meishis exchangeObjectAtIndex:p_id withObjectAtIndex:n_id];
    }
    // 各種ウインドウ閉じる
    [self removeConfirmMessage];
    [self removeP];
    [self removeN];
    // 再描写
    [self reDraw];
}

// パーティ入れ替え後とかの再描写
- (void)reDraw{
    // pについてremoveしてからdraw;
    [p_view removeFromSuperview];
    [self drawParty];
    // nについて
    [n_view removeFromSuperview];
    [self drawNParty];
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
