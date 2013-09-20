//
//  Dungeon.h
//  Mbattler
//
//  Created by Yoshiyuki Sakamoto on 2013/05/26.
//  Copyright (c) 2013年 Mbattler. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Enemy.h"

@interface Dungeon : NSMutableArray{
    int nowgroupnum;
    NSMutableArray *arr;
    NSMutableArray *nowgroup;
    int length; // 敵の長さ
    int num_of_enemy; // 今のグループに含まれる敵の数
    int exp;    // 取得できる経験値
    int stamina;    // 消費されるスタミナ
    UIImageView *bgImageView;   // 背景
    NSArray *names;  // すべてのダンジョンの名前
    NSString *name; // 今入っているダンジョンの名前
}

// セッター
// 指定された番号のダンジョンを選択
- (void)setDungeon:(int)i;

// 背景画像を設定
- (void)setBackgroundInt:(int)image_num;

// ゲッター
// ダンジョンの名前一覧を取得
- (NSArray *)getNames;

// ダンジョンの名前を取得
- (NSString *)getName;

// ダンジョンの消費スタミナを取得
- (int)getStamina;

// ダンジョンの背景を取得
- (UIImageView *)getBackground;

// 敵の長さを取得
- (int)getLength;

// グループの敵の数を取得
- (int)getNumOfEnemy;

// ダンジョンクリアの経験値を取得
- (int)getExp;

// 次の敵グループをロード
- (NSMutableArray *)next;

// 敵グループが全滅したかどうかを判定
- (Boolean)isDead;

- (int)removeEnemy:(Enemy *)e;


// データベースメソッド
- (void)reset;


- (void)dungeon1;
@end
