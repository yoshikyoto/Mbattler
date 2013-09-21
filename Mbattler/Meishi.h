//
//  Meishi.h
//  Mbattler
//
//  Created by Yoshiyuki Sakamoto on 2013/03/12.
//  Copyright (c) 2013年 Mbattler. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MBCharacter.h"
#import "MBAnimationView.h"
#import "Enemy.h"

// 名刺から生成されたキャラクター
@interface Meishi : MBCharacter{
    // キャラクターが持つパラメータ
    int imagenum;   // イメージ画像
    int lv;         // レベル

    int job;        // 職業値
    float j[6];     // 職業補正
    
    int i[6];       // 名刺読み取りデータindividual(個性)
    int abilityID;    // 特殊能力値
    NSString *ability;
    NSString *ability_desc;
    
    int sex;        // 性別
    NSString *history; // 経歴
    
    NSString *company;  // 会社名
    NSString *mail1;    // メールアドレス @より前
    NSString *mail2;    // メールアドレス @より後
    int zip1;     // 郵便番号ハイフンより前
    int zip2;     // 後

    UIImageView *centerimg; //正面向きのアイコン
    UIImageView *rightimg;  // 右向きのImage
    UIImage *icon;  // アイコン
    
    int past_p[6];  // レベルアップ前のパラメータ
    int uplv;       //
    int exp;        // 今の経験値
    
    /*
     （もらった画像によると）キャラクターには「経歴」を持つので、
     「経歴」に関連するパラメータを追加予定
     */
}

// 名刺に社名とかを入れて、キャラを生成するための関数
- (id)initWithInformation:(NSString *)_name CompanyName:(NSString*)_company Mail1:(NSString *)_mail1 Mail2:(NSString *)_mail2 Zip1:(int)_zip1 Zip2:(int)_zip2 Sex:(int)_sex;

// ゲッター(ゲッターの意味が分からなかったらスルーでおk)
- (int) getLv;
- (NSString *) getLvString;
- (void) getParameter:(int *)param;
- (NSString *) getJobString;
- (NSString *) getAbilityString;
- (int)getExp;
- (int)getNextExp;
- (NSString *)getHistory;
// ステータスゲッター(戻り値NSString)
- (NSString *) getHString;
- (NSString *) getAString;
- (NSString *) getBString;
- (NSString *) getCString;
- (NSString *) getDString;
- (NSString *) getSString;

// 画像オブジェクト関係のゲッターとか
- (UIImageView *) getBattleImage;
- (UIImageView *) getCenterImage;
- (UIImage *) getIcon;
// セッター(セッターの意味が分からなければスルーでおk)
- (void) setLv:(int)_lv;
- (void) setImageNum:(int)num;
- (void) setSex:(int)s;
- (void) setJob:(int)_job;
/* 職業セッター
 * 0:戦士
 * 1:格闘家
 * 2:魔法使い
 * 3:僧侶
 */
- (void) setAbility:(int)abl;
/* 特殊能力セッター
 */

- (void) setIndividual:(int *)_i;
- (void) setNowH:(int)_h;
- (void) setExp:(int)e;

- (int) damage:(int)d;
- (void)reflesh;
// 経験値を与える関数
- (int)exp:(int)e;
/*
 経験値をもらった際に、呼び出されるメソッド
 経験値を入力すると、レベルアップするかどうかを判定し、
 レベルアップした場合はステータスの再計算などを行う。
 */

// 戦闘関係
// target を攻撃して、ダメージを返す関数
- (int)attack:(Enemy *)target;

// HPを回復する関数
- (int)recover:(int)r;
// 復活する関数 死んでないならfalseを返す
- (BOOL)revive;
// 内部メソッド(パラメータを計算してくれる関数)
- (void) calcParameter;
- (int) calcParameter:(int)k;

@end