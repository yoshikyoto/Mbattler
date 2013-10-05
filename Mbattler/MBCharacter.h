//
//  MBCharacter.h
//  Mbattler
//
//  Created by Yoshiyuki Sakamoto on 2013/06/02.
//  Copyright (c) 2013年 Mbattler. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MBAnimationView.h"

@interface MBCharacter : NSObject{
    // 敵と見方、両方持つパラメータ
    NSString *name; // 名前
    int p[6];       // パラメータ
    float p_mult[6];  // パラメータ補正値
    int nowh;       // 今の体力
    
    MBAnimationView *effect; // 攻撃エフェクト
    MBAnimationView *downView;  // 能力下がった時のエフェクト
    MBAnimationView *upView;    // 能力上がった時のエフェクト
    
    UIImageView *hpbar;
}

// 各種ゲッター
- (NSString *) getName;
- (int) getH;
- (int) getA;
- (int) getB;
- (int) getC;
- (int) getD;
- (int) getS;
- (int) getNowH;
- (int) getHMult;
- (int) getAMult;
- (int) getBMult;
- (int) getCMult;
- (int) getDMult;
- (int) getSMult;
- (UIImageView *) getBattleImage;

// 各種セッター
- (void)setName:(NSString *)n;

// 戦闘関係のメソッド
// いろいろリセットするやつ
// ダメージを受ける関数
- (int)damage:(int)damage;
// 画像を除去する関数
- (void)removeBattleImage;
//能力up関数
- (void)multParameter:(int)position :(float)mult;

- (Boolean)isDead;
- (Boolean)isPlayer;
- (UIImageView *)getHpBar:(int)x :(int)y;
- (void)drawHpBar;
- (void)removeLeftImage;

// ダメージに乱数を入れるメソッド
- (int)damageRand:(int)damage;
@end
