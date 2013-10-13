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
#import "UIOutlineLabel.h"


@implementation MBPartyView

- (id)initWithPlayer:(Player *)p
{
    self = [super initWithPlayer:p];
    if (self) {
        // Initialization code
        
        title.text = @"パーティ編成";
        [self addSubview:title];
        
        // パーティ部分の描写
        [self drawPartyView];
        // パーティじゃない部分の描写
        [self drawReserveView];
        
        // タグの初期化（まだどのキャラむ選択されていないことを示す
        selected_party_tag = -2;
        selected_reserve_tag = -2;
        
        // 確認ウィンドウの初期化
        confirm_window = [[PartyChangeView alloc] initWithFrame:CGRectMake(10, 150, 300, 250)];
        // 決定ボタンの初期化
        confirm_button = [UIButton buttonWithType:UIButtonTypeCustom];
        confirm_button.frame = CGRectMake(151, 220, 74, 30);
        [confirm_button setTitle:@"はい" forState:UIControlStateNormal];
        confirm_button.backgroundColor = [UIColor colorWithRed:0.5 green:0.5 blue:1.0 alpha:1.0];
        [confirm_button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [confirm_button addTarget:self action:@selector(confirmChange:)forControlEvents:UIControlEventTouchUpInside];
        [confirm_window addSubview:confirm_button];
        // キャンセルボタンの初期化
        cancel_button = [UIButton buttonWithType:UIButtonTypeRoundedRect];
        cancel_button.frame = CGRectMake(226, 220, 74, 30);
        [cancel_button setTitle:@"いいえ" forState:UIControlStateNormal];
        cancel_button.backgroundColor = [UIColor colorWithRed:1.0 green:0.5 blue:0.5 alpha:1.0];
        [cancel_button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [cancel_button addTarget:self action:@selector(cancelChange:)forControlEvents:UIControlEventTouchUpInside];
        [confirm_window addSubview:cancel_button];
    }
    return self;
}


// パーティ部分描写 ------------------------------------------------------------------------------------------
- (void)drawPartyView{
    // パーティ部分のビュー
    party_view = [[UIScrollView alloc] initWithFrame:CGRectMake(8, 52, 300, 90)];
    party_view.backgroundColor = [UIColor grayColor];
    [self addSubview:party_view];
    int i;
    for(i = 0; i < [player getPartynum]; i++){
        Meishi *meishi = [player getMeishi:i];
        
        // ボタンのサイズとかを指定
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        button.frame = CGRectMake(12+58*i, 10, 48, 48);
        // ボタンの tag としてキャラ番号を保持させる
        button.tag = i;
        // ボタンに画像をセット
        [button setBackgroundImage:[meishi getIcon] forState:UIControlStateNormal];
        // タップされた時の処理
        [button addTarget:self action:@selector(touchedPartyMember:)forControlEvents:UIControlEventTouchUpInside];
        [party_view addSubview:button];
        
        // キャラの名前の表示
        UIOutlineLabel *name_label = [meishi getNameLabel];
        name_label.frame = CGRectMake(12+58*(i%5), 10+38, 48, 10);
        [party_view addSubview:name_label];
    }
    // パーティ不足の時の追加ボタン
    if(i < 5){
        UIButton *in_button = [UIButton buttonWithType:UIButtonTypeCustom];
        in_button.frame = CGRectMake(10+58*i, 10, 48, 48);
        // アイコンはとりあえず代用
        [in_button setBackgroundImage:[UIImage imageNamed:@"outicon.PNG"] forState:UIControlStateNormal];
        in_button.tag = -1;
        [in_button addTarget:self action:@selector(touchedPartyMember:)forControlEvents:UIControlEventTouchUpInside];
        [party_view addSubview:in_button];
    }
    
    // ここで暗転するやつも初期化しておく
    party_black_mask = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 300, 90)];
    party_black_mask.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.6];
}
// ノンパーティ部分再描写 ------------------------------------------------------------------------------------------
- (void)drawReserveView{
    // キャラクタービューの作成（パーティじゃないキャラクターの描写）
    reserve_view = [[UIScrollView alloc] initWithFrame:CGRectMake(10, 142, 300, height - 142)];
    reserve_view.backgroundColor = [UIColor clearColor]; //sub_bg; // 背景
    
    // 「はずす」ボタンの描写
    UIButton *out_button = [UIButton buttonWithType:UIButtonTypeCustom];
    out_button.frame = CGRectMake(10, 10, 48, 48);
    [out_button setBackgroundImage:[UIImage imageNamed:@"outicon.PNG"] forState:UIControlStateNormal]; //アイコン
    out_button.tag = -1;
    [out_button addTarget:self action:@selector(touchedReserveMember:)forControlEvents:UIControlEventTouchUpInside];
    [reserve_view addSubview:out_button];
    // アイコンの描写
    int partynum = [player getPartynum];
    int nonpartynum = [player getNumOfMeishi] - partynum;
    for(int i = 0; i < nonpartynum; i++){
        
        // ボタンの配置場所は i 依存になる
        int j = i + partynum;
        Meishi *meishi = [player getMeishi:j];
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        // ボタンのサイズを指定。もうちょっと小さくしてもいいかも。
        button.frame = CGRectMake(10+58*((i+1)%5), 10+58*((i+1)/5), 48, 48);
        // ボタンの tag としてキャラ番号を保持させる
        button.tag = j;
        // ボタンに画像をセット
        [button setBackgroundImage:[meishi getIcon] forState:UIControlStateNormal];
        // タップされた時の処理
        [button addTarget:self action:@selector(touchedReserveMember:)forControlEvents:UIControlEventTouchUpInside];
        // ボタンを画面に表示
        [reserve_view addSubview:button];
        
        // キャラの名前を表示
        UIOutlineLabel *name_label = [meishi getNameLabel];
        name_label.frame = CGRectMake(10+58*((i+1)%5), 10+58*((i+1)/5)+38, 48, 10);
        [reserve_view addSubview:name_label];
    }
    // スクロールビュー内部のサイズ 縦はキャラ数に依存させる感じになる
    int h = 58*ceil((nonpartynum+1) / 5.0) + 10;
    NSLog(@"h: %d", h);
    reserve_view.contentSize = CGSizeMake(300, h);
    [self addSubview:reserve_view];
    
    // ここで暗転するやつも初期化しておく
    reserve_black_mask = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 300, h)];
    reserve_black_mask.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.6];
}

// キャラが押された時の処理 ------------------------------------------------------------
// パーティのキャラクターが押された時
- (void)touchedPartyMember:(UIButton *)sender{
    NSLog(@"%s", __func__);
    // そいつが既に選択されていたかどうかで処理が別れる
    if(sender.tag == selected_party_tag){
        // 既に選択されていたものだった場合、選択を解除する処理
        [party_black_mask removeFromSuperview];
        selected_party_tag = -2;
    }else{
        // 「入れる」と「外す」は同時に選択できない
        if((sender.tag == -1)&&(selected_reserve_tag == -1)) return;
        
        // 新たに選択された場合、まずは画面を暗転させる。
        [party_view addSubview:party_black_mask];
        [party_view bringSubviewToFront:sender];
        
        // タグに情報をセット
        selected_party_tag = sender.tag;
        latest_selection_bool = true;
        
        // 選択された物によって分類
        Meishi *meishi = nil;
        if(sender.tag != -1){
            // キャラクターが選択された場合
            meishi = [player getMeishi:sender.tag];
            // 名前も全面に持ってくる
            [party_view bringSubviewToFront:[meishi getNameLabel]];
        }
        [confirm_window setPartyMember:meishi];
        
        // Rserveも選択されている場合
        if(selected_reserve_tag >= -1) [self addSubview:confirm_window];
    }
}

// パーティ外のキャラクターが押された時
- (void)touchedReserveMember:(UIButton *)sender{
    NSLog(@"%s", __func__);
    // そいつが既に選択されていたかどうかで処理が別れる
    if(sender.tag == selected_reserve_tag){
        // 既に選択されていたものだった場合、選択を解除する処理
        [reserve_black_mask removeFromSuperview];
        selected_reserve_tag = -2;
    }else{
        // 「入れる」と「外す」は同時に選択できない
        if((sender.tag == -1)&&(selected_reserve_tag == -1)) return;
        
        // 新たに選択された場合、まずは画面を暗転させる。
        [reserve_view addSubview:reserve_black_mask];
        [reserve_view bringSubviewToFront:sender];
        
        // タグに情報をセット
        selected_reserve_tag = sender.tag;
        latest_selection_bool = false;
        
        // 選択された物によって分類
        Meishi *meishi = nil;
        if(sender.tag != -1){
            // キャラクターが選択された場合
            meishi = [player getMeishi:sender.tag];
            // 名前も全面に持ってくる
            [reserve_view bringSubviewToFront:[meishi getNameLabel]];
        }
        [confirm_window setReserveMember:meishi];
        
        // Partyも選択されている場合、確認メッセージ表示
        if(selected_party_tag >= -1) [self addSubview:confirm_window];;
    }
}
// 変更が確定されたとき ------------------------------------------------------------------------------------------
- (void)confirmChange:(id)sender{
    // こんなことせずに、playerのメソッドとして用意するべきかもしれない
    NSMutableArray *meishis = [player getMeishis];
    if(selected_party_tag == -1){
        // 追加のとき
        NSLog(@"パーティ追加 %d", n_id);
        [player addParty:selected_reserve_tag];
    }else if(selected_reserve_tag == -1){
        // 外すとき
        [player removeFromParty:selected_party_tag];
    }else{
        // 入れ替えのとき
        [meishis exchangeObjectAtIndex:selected_party_tag withObjectAtIndex:selected_reserve_tag];
    }
    // 各種ウインドウ閉じる
    [confirm_window removeFromSuperview];
    [party_black_mask removeFromSuperview];
    [reserve_black_mask removeFromSuperview];
    selected_party_tag = -2;
    selected_reserve_tag = -2;
    // 再描写
    [self reDraw];
}

// キャラ選択が解除されたとき------------------------------------------------------------------------------------
- (void)cancelChange:(id)sender{
    // まず確認メッセージを除去
    [confirm_window removeFromSuperview];
    // 最後に選ばれたのが Party か Reserve か
    if(latest_selection_bool){
        // Party
        [party_black_mask removeFromSuperview];
        selected_party_tag = -2;
    }else{
        // Reserve
        [reserve_black_mask removeFromSuperview];
        selected_reserve_tag = -2;
    }
}

// パーティ入れ替え後とかの再描写
- (void)reDraw{
    // pについてremoveしてからdraw;
    [party_view removeFromSuperview];
    [self drawPartyView];
    // nについて
    [reserve_view removeFromSuperview];
    [self drawReserveView];
}


/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

/*
- (void)characterTouched:(id)sender{
    // それ(target)がパーティかそれ以外かを判断
    UIButton *target = (UIButton *)sender;
    
    if((-1 <= target.tag)&&(target.tag < [player getPartynum])){
        // パーティメンバーだった時の処理
        // 暗転させる
        [party_view addSubview:party_black_mask];
        [party_view bringSubviewToFront:target];
        // 同じキャラがタップされたら外す
        if(party_select_flag&&(p_id == target.tag)){
            [self removeP];
            return;
        }
        // p_id にタグをセット
        p_id = target.tag;
        
        if(target.tag == -1){
            // キャラ追加の時　入れるのは選べない
            if(party_select_flag&&(p_id == -2)) return;
            NSLog(@"はずす");
            // 確認ウィンドウにはnilをセット
            [confirm_window set_p: nil];
        }else{
            // それ以外の時　入れ替えのとき
            NSLog(@"パーティメンバー選択");
            // 押された名刺の情報を確認ウインドウにセット
            [confirm_window set_p: [player getMeishi:p_id]];
            [party_view bringSubviewToFront:[[player getMeishi:p_id] getNameLabel]];
        }
        
        //[[self view] addSubview:p_cancelbutton];    //取り消しボタンを表示
        party_select_flag = true;  //選ばれたことを表す
        latest_view = true; //最後に選ばれたのはパーティメンバーである
        
    }else{
        // パーティメンバーじゃなかったとき
        
        // まず暗転させる
        [reserve_view addSubview:reserve_black_mask];
        // 画像だけ前に出す
        [party_view bringSubviewToFront:target];
        if(reserve_select_flag&&(n_id == target.tag)){
            [self removeN];
            return;
        }
        // 押された名刺の情報をセット
        n_id = target.tag;
        if(target.tag == -2){
            // 外すとき、入れるのは選べない
            if(party_select_flag&&(p_id == -1)) return;
            NSLog(@"%s はずす", __func__);
            [confirm_window set_n:nil];
        }else{
            // 普通にいれかえ
            NSLog(@"パーティメンバー以外選択");
            [confirm_window set_n: [player getMeishi:n_id]];
            [reserve_view bringSubviewToFront:[[player getMeishi:n_id] getNameLabel]];
        }
        
        //[self addSubview:nministatus];   // ステータスを表示
        //[[self view] addSubview:n_cancelbutton];    //取り消しボタンを表示
        reserve_select_flag = true;  //選ばれたことを表す
        latest_view = false;    //最後に選ばれたのはノンパーティメンバーである
    }
    
    if(party_select_flag&&reserve_select_flag){
        NSLog(@"両方選ばれた");
        [self viewConfirmMessege];
    }
}
*/

@end
