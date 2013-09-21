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
    int nowh;       // 今の体力
    
    MBAnimationView *effect; // 攻撃エフェクト
    
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
- (UIImageView *) getBattleImage;
- (MBAnimationView *)getAEffect;

// 各種セッター
- (void)setName:(NSString *)n;

// 戦闘関係のメソッド
- (Boolean)attackA:(MBCharacter *)subject :(MBCharacter *)object; //使ってない

- (int)damagedA:(MBCharacter *)subject;
- (int)damaged;
- (Boolean)isDead;
- (Boolean)isPlayer;
- (UIImageView *)getHpBar:(int)x :(int)y;
- (void)drawHpBar;
- (void)removeLeftImage;
@end
