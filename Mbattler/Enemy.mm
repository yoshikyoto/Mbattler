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
        nowh = p[0];
        leftimg = [[UIImageView alloc] initWithImage:[UIImage imageNamed:imageString]];
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

// ダメージを受ける関数
- (int)damage:(int)damage{
    // HPが0にならないようにマイナス
    if(nowh <= damage){
        damage = nowh;
        nowh = 0;
    }else{
        nowh = nowh - damage;
    }
    return damage;
}

// 攻撃する関数
- (int)attack:(Meishi *)target{
    int damage = 0;
    // とりあえずAで攻撃するようにしよう
    damage = p[1] - [target getB];
    
    // 最低でも1ダメージは与えることができる
    if(damage <= 0) damage = 0;
    
    // エフェクト描写
    CGRect rect = [target getBattleImage].frame;
    rect.origin.x += (rect.size.width/2.0 - 30);
    rect.origin.y += (rect.size.height/2.0 - 30);
    effect.frame = rect;
    [[[target getBattleImage] superview] addSubview:effect];
    [effect startAnimating];
    
    // 乱数を生成してダメージ計算(100% - 90%)
    int r = arc4random()%10;
    r = 100 - r;
    damage = damage * (r/100.0);
    // ダメージは0にはならない
    if(damage <= 0) damage = 1;
    
    // 対象のHPをマイナスする
    return [target damage:damage];
}

@end


