//
//  Player.h
//  Mbattler
//
//  Created by Yoshiyuki Sakamoto on 2013/04/12.
//  Copyright (c) 2013年 Mbattler. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Meishi.h"

@interface Player : NSObject{
    NSString *name; // プレイヤーネーム
    NSMutableArray *meishis;
    int maxmeishi; // 名刺所持数の最大値(課金により増加)
    int partynum; // パーティに所属している名刺の数
    int stamina; // スタミナ
    UIImageView *stamina_bar;
    UILabel *stamina_label;
    NSTimer *stamina_timer;
    NSDate *stamina_date; // ここからスタミナ回復を計算
    NSMutableArray *party; // パーティそれ自身
    int item[3]; // 各種アイテムの所持数
    //スタミナ回復　HP回復　復活
    
    // 名刺の所持数を表示するラベル
    UILabel *meishi_label;
    
    // セーブ用のuser defaults
    NSUserDefaults *ud;
}

- (id)init;     // initialization
- (id)initWithTestdata;
- (id)initWithName:(NSString *)n; // セーブデータ作成
- (id)initWithLoad;

// データセーブ用のメソッド
- (void)save;
- (void)saveItem;
- (void)saveStamina;

// ゲッター
- (Meishi *)getMeishi:(int)i;   // i番目の名刺を返す
- (int)getPartynum;     // パーティの人数を返す
- (NSMutableArray *)getParty;   // パーティの配列を返す
- (NSString *)getName;
- (NSMutableArray *)getMeishis; 
- (int)getNumOfMeishi;  // 名刺が何人いるか
- (UIImageView *)getStaminaBar:(int)x :(int)y;
- (UILabel *)getStaminaLabel;
- (int)getStamina;

// セッター
- (void)setPartyNum:(int)n;
- (void)setName:(NSString *)n;

- (void)reflesh;
- (Boolean)isDead;
- (void)makeTestdata; // デバッグ用のデータ作成
- (void)addMeishi:(Meishi *)m; // 新名刺キャラクターを追加する

- (Boolean)iskMeishiFull;
/* 名刺がいっぱいかどうか確認する関数。
 * true ならいっぱいである。
 */

- (int)removeFromParty:(int)n;
/* パーティからn番目のキャラを外す。
 * 結果は以下のようになる
 * 0 変更完了
 * 1 パーティが0人になってしまう
 * 2 すでにパーティに入っていない
 */

- (int)addParty:(int)n;
/* パーティにn番目のキャラを加える。
 * 結果は以下のようになる
 * 0 変更完了
 * 1 パーティがいっぱいで追加できない
 * 2 すでにパーティに加わっている
 */

- (int)changeParty:(int)n1 :(int)n2;
/* パーティ入れかえ
 * （実際には名刺の順序を入れ替えるだけ）
 * とりあえず、成功したら0を返す。
 */

- (Boolean)minusStaimna:(int)s;
/* スタミナを消費する関数
 * スタミナが足りない場合はfalseが返される
 */

- (Boolean)recoverStamina:(int)r;
/* スタミナを(全)回復する関数
 * 既にスタミナが全回復している場合は false を返す
 * 0が入力されると全回復する
 */

// アイテム関係
// アイテム n を何個持ってるか確認する関数
- (int)getNumOfItem:(int)n;
// アイテム n を使う関数 残り個数を返す
- (int)useItem:(int)n;
// アイテムnをm個買う関数 アイテムの残数を返す
- (int)buyItem:(int)n :(int)m;


@end
