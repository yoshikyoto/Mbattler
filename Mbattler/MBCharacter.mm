//
//  MBCharacter.m
//  Mbattler
//
//  Created by Yoshiyuki Sakamoto on 2013/06/02.
//  Copyright (c) 2013年 Mbattler. All rights reserved.
//

#import "MBCharacter.h"
#import "MBAnimationView.h"

@implementation MBCharacter
- (id)init{
    self = [super init];
    if(self){
        // 初期化処理
        // デフォのエフェクト
        effect = [[MBAnimationView alloc] init];
        [effect setAnimationImage:@"sl.png" :120 :120 :9];
        effect.animationDuration = 0.2;
        effect.animationRepeatCount = 1;
    }
    return self;
}

// ゲッター
- (NSString *) getName{
    return name;
}
- (int) getH{ return p[0]; }
- (int) getA{ return p[1]; }
- (int) getB{ return p[2]; }
- (int) getC{ return p[3]; }
- (int) getD{ return p[4]; }
- (int) getS{ return p[5]; }
- (int) getNowH{ return nowh; }

- (MBAnimationView *)getEffect{
    return effect;
}

// セッター
- (void)setName:(NSString *)n{
    name = n;
}


// 戦闘関係の
- (int)damagedA:(MBCharacter *)subject{
    int damage = [subject getA] - [self getB];
    if(damage <= 0) damage = 1;
    
    //エフェクト描写
    int x = [self getBattleImage].frame.origin.x;
    int y = [self getBattleImage].frame.origin.y;
    effect.frame = CGRectMake(x, y, 40, 40);
    [[[self getBattleImage] superview] addSubview:effect];
    [effect startAnimating];
    
    [[NSRunLoop currentRunLoop] runUntilDate:[NSDate dateWithTimeIntervalSinceNow:0.5]];
    
    return [self damaged:damage];
}

-(int) damaged:(int)d{
    // 乱数を生成。 0〜9の整数
    int r = rand()%10;
    r = 100 - r;
    // NSLog(@"%d", r);
    // NSLog(@"%d", r/100.0);
    d = d * (r/100.0);
    // NSLog(@"%d", d);
    if(d <= 0) d = 1; // 少なくとも1はくらう
    nowh = nowh - d;
    
    // HPが負にはならないように
    if(nowh < 0){
        nowh = 0;
    }
    // HPバー描写
    [self drawHpBar];
    return d;
}

- (Boolean)isDead{
    if(nowh == 0)
        return true;
    else{
        return false;
    }
}

- (UIImageView *)getHpBar:(int)x :(int)y{
    hpbar = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"hp1.png"]];
    hpbar.frame = CGRectMake(x, y, 32, 5);
    return hpbar;
}

- (void)drawHpBar{
    if(hpbar){ // HPバーがインスタンスとして生成されてる場合だけ
        int x = hpbar.frame.origin.x;
        int y = hpbar.frame.origin.y;
        int w = 32 * ((float)nowh / p[0]);
        NSLog(@"nowh/h = %d/%d", nowh, p[0]);
        NSLog(@"HpBar width %d", w);
        // 0じゃないときに長さ0にならないように
        if((w == 0)&&(nowh != 0)) w = 1;
        hpbar.frame = CGRectMake(x, y, w, 5);
    }
}


@end
