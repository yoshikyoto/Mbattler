//
//  Enemy.h
//  Mbattler
//
//  Created by Yoshiyuki Sakamoto on 2013/05/19.
//  Copyright (c) 2013年 Mbattler. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MBCharacter.h"

@class Meishi;

@interface Enemy : MBCharacter{
    // 敵が持つパラメータ
    
    // 画像関係
    int imagenum;
    UIImageView *leftimg;
}

// 画像関係のメソッド
- (UIImageView *)getLeftImage;
- (void)removeLeftImage;

// 初期化と同時に各種ステータスをセットする
- (id)initWithName:(NSString *)n H:(int)h A:(int)a B:(int)b C:(int)c D:(int)d S:(int)s ImageString:(NSString *)imageString;

// 戦闘関係
// ダメージを受ける関数
- (int)damage:(int)damage;
// 攻撃する関数
- (int)attack:(Meishi *)target;
@end
