//
//  Enemy.m
//  Mbattler
//
//  Created by Yoshiyuki Sakamoto on 2013/05/19.
//  Copyright (c) 2013年 Mbattler. All rights reserved.
//

#import "Enemy.h"

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
@end
