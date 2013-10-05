//
//  Dungeon.m
//  Mbattler
//
//  Created by Yoshiyuki Sakamoto on 2013/05/26.
//  Copyright (c) 2013年 Mbattler. All rights reserved.
//

#import "Dungeon.h"
#import "Enemy.h"

@implementation Dungeon

- (id)init{
    self = [super init];
    if(self){
        // ダンジョン名一覧 ！！最後にはnilを入れること！！
        names = [NSArray arrayWithObjects:
                 @"ふつうのダンジョン",
                 @"つよそう",
                 @"よわそう",
                 @"アビリティデバッガー",
                 @"全体攻撃デバッガー2",
                 nil];
        
    }
    return self;
}

- (NSArray *)getNames{ return names; }
- (NSString *)getName{ return name; }

- (void)reset{
    nowgroupnum = 0;
    arr = [[NSMutableArray alloc] init];
}

- (void)setDungeon:(int)i{
    NSLog(@"ダンジョンをセット");
    // ダンジョンの名前をセット
    name = [names objectAtIndex:i];
    switch (i) {
        case 0:
            [self dungeon0];
            break;
        case 1:
            [self dungeon1];
            break;
        case 2:
            [self dungeon2];
            break;
        case 3:
            [self dungeon3];
            break;
        case 4:
            [self dungeon4];
            break;
    }
}

- (void)dungeon0{
    [self reset];
    NSLog(@"ダンジョン1生成 in Dungeon");
    
    // 敵集団1
    NSArray *subarr = [NSArray arrayWithObjects:
                       [[Enemy alloc] initWithName:@"TDN" H:100 A:70 B:0 C:0 D:0 S:0 ImageString:@"c0c.PNG"],
                       [[Enemy alloc] initWithName:@"MUR" H:100 A:70 B:0 C:0 D:0 S:0 ImageString:@"c1c.PNG"],
                       [[Enemy alloc] initWithName:@"YJSNPI" H:100 A:70 B:0 C:0 D:0 S:0 ImageString:@"c2c.PNG"],
                       nil];
    [arr addObject:subarr];
    
    // 敵襲団2
    subarr = [NSArray arrayWithObjects:
              [[Enemy alloc] initWithName:@"淫夢くん" H:1000 A:70 B:0 C:0 D:0 S:50 ImageString:@"c3c.PNG"],
              nil];
    [arr addObject:subarr];
    exp = 124;
    stamina = 5;
    [self setBackgroundInt:0];
}

- (void)dungeon1{
    [self reset];
    NSLog(@"ダンジョン2");
    // 敵集団1
    NSArray *subarr = [NSArray arrayWithObjects:
              [[Enemy alloc] initWithName:@"TNOK" H:400 A:200 B:200 C:200 D:200 S:100 ImageString:@"c4c.PNG"],
              nil];
    [arr addObject:subarr];
    exp = 5000;
    stamina = 10;
    [self setBackgroundInt:1];
}

- (void)dungeon2{
    [self reset];
    NSLog(@"ダンジョン3");
    
    // 敵集団1
    NSArray *subarr = [NSArray arrayWithObjects:
                       [[Enemy alloc] initWithName:@"KBTIT" H:100 A:70 B:0 C:0 D:0 S:0 ImageString:@"c0c.PNG"],
                       [[Enemy alloc] initWithName:@"Akino" H:100 A:70 B:0 C:0 D:0 S:0 ImageString:@"c1c.PNG"],
                       nil];
    
    [arr addObject:subarr];
    exp = 1000;
    stamina = 20;
    [self setBackgroundInt:2];
}

- (void)dungeon3{
    [self reset];
    NSLog(@"%s", __func__);
    
    // 敵集団1
    NSArray *subarr = [NSArray arrayWithObjects:
                       [[Enemy alloc] initWithName:@"サンドバッグくん" H:2000 A:0 B:0 C:0 D:0 S:0 ImageString:@"c0c.PNG"],
                       nil];
    
    [arr addObject:subarr];
    exp = 1000;
    stamina = 5;
    [self setBackgroundInt:3];
}

- (void)dungeon4{
    [self reset];
    NSLog(@"%s", __func__);
    
    // 敵集団1
    NSArray *subarr = [NSArray arrayWithObjects:
                       [[Enemy alloc] initWithName:@"サンドバッグくんA" H:2000 A:0 B:40 C:0 D:40 S:0 ImageString:@"c0c.PNG"],
                       [[Enemy alloc] initWithName:@"サンドバッグくんB" H:2000 A:0 B:0 C:0 D:0 S:200 ImageString:@"c0c.PNG"],
                       [[Enemy alloc] initWithName:@"サンドバッグくんD" H:2000 A:0 B:0 C:0 D:0 S:0 ImageString:@"c0c.PNG"],
                       [[Enemy alloc] initWithName:@"サンドバッグくんE" H:20 A:0 B:4 C:0 D:4 S:0 ImageString:@"c0c.PNG"],
                       nil];
    
    [arr addObject:subarr];
    exp = 1000;
    stamina = 5;
    [self setBackgroundInt:3];
}

- (void)setBackgroundInt:(int)image_num{
    NSString *image_string = [NSString stringWithFormat:@"battlebg%d.jpg", image_num];
    bgImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:image_string]];
}

// ダンジョンの消費すたみなを取得
- (int)getStamina{ return stamina; }
// ダンジョンの背景を取得
-(UIImageView *)getBackground{ return bgImageView; }

- (NSMutableArray *) next{
    NSLog(@"Next Enemy");
    // もしもう敵がいないようなら nil を返す
    if([arr count] == 0) return nil;
    // 敵がいるなら、敵集合をPOPして返す
    nowgroup = [arr objectAtIndex:0];
    [arr removeObjectAtIndex:0];
    num_of_enemy = [nowgroup count];
    return nowgroup;
}

// 何回敵が出現するか
- (int)getLength{ return [arr count]; }
// グループに敵が何体行くか
- (int)getNumOfEnemy{ return num_of_enemy; }
// 経験値
- (int)getExp{ return exp; }

- (Boolean)isDead{
    for(int i =0; i < num_of_enemy; i++){
        if(![[nowgroup objectAtIndex:i] isDead]) return false;
    }
    return true;
}

@end
