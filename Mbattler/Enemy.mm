//
//  Enemy.m
//  Mbattler
//
//  Created by Yoshiyuki Sakamoto on 2013/05/19.
//  Copyright (c) 2013年 Mbattler. All rights reserved.
//

#import "Enemy.h"
#import "Meishi.h"

@implementation Enemy

- (id)initWithName:(NSString *)n H:(int)h A:(int)a B:(int)b C:(int)c D:(int)d S:(int)s ImageString:(NSString *)imageString{
    self = [super init];
    if(self){
        name = n;
        p[0] = h;
        p[1] = a;
        p[2] = b;
        p[3] = c;
        p[4] = d;
        p[5] = s;
        attackBy = 0;
        nowh = p[0];
        leftimg = [[UIImageView alloc] initWithImage:[UIImage imageNamed:imageString]];
    }
    return self;
}

- (id)initWithName:(NSString *)n H:(int)h A:(int)a B:(int)b C:(int)c D:(int)d S:(int)s attackBy:(int)ab ImageString:(NSString *)imageString{
    self = [self initWithName:n H:h A:a B:b C:c D:d S:s ImageString:imageString];
    if(self){
        attackBy = ab;
        switch (attackBy) {
            case 1:
                // 魔法攻撃の場合
                effect = [[MBAnimationView alloc] init];
                [effect setAnimationImage:@"mag.png" :120 :120 :14];
                effect.animationDuration = 0.8;
                effect.animationRepeatCount = 1;
                break;
        }
        // デフォルトでは打撃になる
    }
    return self;
}

- (UIImageView *)getBattleImage{
    return [self getLeftImage];
}
- (UIImageView *)getLeftImage{
    return leftimg;
}
- (void) removeLeftImage{
    [leftimg setImage:[UIImage imageNamed:@""]];
}

-(Boolean)isPlayer{
    return false;
}

// 攻撃する関数
- (int)attack:(Meishi *)target{
    int damage = 0;
    // とりあえずAで攻撃するようにしよう
    
    [self getBattleImage].transform = CGAffineTransformMakeTranslation(-10, 0);
    switch (attackBy) {
        case 1:
            // 魔法攻撃
            damage = p[3] - [target getD];
            break;
            
        default:
            // 打撃
            damage = p[1] - [target getB];
            break;
    }
    
    // 最低でも1ダメージは与えることができる
    if(damage <= 0) damage = 0;
    
    // エフェクト描写
    CGRect rect = [target getBattleImage].frame;
    rect.origin.x += (rect.size.width/2.0 - 40);
    rect.origin.y += (rect.size.height/2.0 - 40);
    rect.size.width = 80;
    rect.size.height = 80;
    effect.frame = rect;
    [[[target getBattleImage] superview] addSubview:effect];
    [effect startAnimating];
    // エフェクト描写待ち
    [[NSRunLoop currentRunLoop] runUntilDate:[NSDate dateWithTimeIntervalSinceNow:0.5]];
    
    // 乱数を生成してダメージ計算(100% - 90%)
    damage = [self damageRand:damage];
    // 対象のHPをマイナス
    damage = [target damage:damage];
    
    // 鮫肌判定
    if([target getAbilityID] == 9){
        MBAnimationView *abl_effect = [[MBAnimationView alloc] init];
        [abl_effect setAnimationImage:@"samehada.png" :120 :120 :5];
        abl_effect.animationDuration = 0.2;
        CGRect rect = [self getBattleImage].frame;
        rect.origin.x += (rect.size.width/2.0 - 15);
        rect.origin.y += (rect.size.height/2.0 - 15);
        rect.size.width = 30;
        rect.size.height = 30;
        abl_effect.frame = rect;
        [[[self getBattleImage] superview] addSubview:abl_effect];
        [abl_effect startAnimating];
        // ダメージはとりあえず最大HPの1/16
        int samehada_damage = [self getH] / 16.0;
        // 最大ダメージは20としておく
        if(samehada_damage <= 0) samehada_damage = 1;
        if(samehada_damage > 20) samehada_damage = 20;
        [self damage:samehada_damage];
    }
    
    [self getBattleImage].transform = CGAffineTransformMakeTranslation(0, 0);
    
    return damage;
}

@end


