//
//  DungeonViewController.h
//  Mbattler
//
//  Created by Yoshiyuki Sakamoto on 2013/04/06.
//  Copyright (c) 2013年 Mbattler. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Player.h"
#import "Dungeon.h"
#import "MBConbatantView.h"
#import "MBScrollView.h"


@interface DungeonViewController : UIViewController{
    UILabel *messege;
    UITextView *messege_window;
    UITapGestureRecognizer *tgr;    // タップレコグナイザー
    NSMutableArray *party;  // 味方
    NSMutableArray *enemy;  // 敵
    NSArray *enemy_const;
    Enemy *target;
    NSMutableArray *combatant; // 戦闘参加者を素早さ順に並び替えた配列
    int enemypositions[5][3];
    int meishipositions[5][3];
    
    // アイテム関係
    UIButton *item1_button;
    UIButton *item2_button;
    int item_flag;
    UILabel *item_desc;
    
    NSMutableArray *eimgs;
    Dungeon *dungeon;
    Player *player;
    int exp;
    
    // タイトル関係
    UIImageView *navImage;
    UILabel *title;
    MBConbatantView *combatant_view;
    // ターン数もここで管理できる
    
    int turn;
    
    // アビリティキュー
    NSMutableArray *ability_meishi_queue;
    
    
    //以下結果画面用 ---------
    MBScrollView *resultView;
}

- (id)initWithPlayer:(Player *)p;
- (void)setPlayer:(Player *)p;
- (void)setDungeon:(Dungeon *)d;

@end

/*
 meeting memo
 
 - 戦闘ダメージに乱数を導入
 - 急所は必要ない
 - 戦闘周辺の実装考える
 - ダンジョンは入る→敵倒す→新たな敵が出てくる…→繰り返して最終的にボス
 - ボス倒した後に経験値処理
 - 自然回復はなし 基本は回復剤を使う形で、それプラス僧侶がいたら回復魔法を使う感じ。
 - 戦闘中に体力回復するアイテムは課金アイテムって感じですかね
 - ダンジョン入るのにスタミナが必要で、それは時間回復 or 課金アイテムによる回復
 
 1. 仮の敵DB作り
 2. 経験値、敵連続出現システム
 3. パーティ編成画面
 4. アイテム関係
 5. データセーブ
 6. インタフェース
 7. 課金システム
 8. 実機での動作確認
 
 http://www.slideshare.net/yomoyamareiji/tesseractocr-in-ios
*/