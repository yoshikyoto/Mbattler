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
                 @"チュートリアル",
                 @"はじまりの森",
                 @"昆虫の森",
                 @"食人の花",
                 @"植物たちの下克上",
                 @"少女寄生中",
                 @"海原の戦い",
                 @"海中の魔物たち",
                 @"触手の猛撃",
                 @"野生の反乱",
                 @"君臨せし空中王女",
                 @"かぼちゃの愉快な仲間たち",
                 @"いにしえの悪魔",
                 @"和世界の邪鬼",
                 @"洋館の悪霊",
                 @"ゴブリン集会場",
                 @"スライムの洞窟",
                 @"盗賊の住処",
                 @"遊戯の館",
                 @"食物の天国",
                 @"陽落つる祭壇",
                 @"不死者の巣食う世界",
                 @"獅子奮迅の空",
                 @"鎧の蠢く城",
                 @"大洋の魔物",
                 @"大海の深世界",
                 @"溟海潜入路",
                 @"芸術の都",
                 @"道化師の住まいし古城",
                 @"死足の突撃",
                 @"妖怪の使役者",
                 @"昼と夜",
                 @"機械の行進",
                 @"蛮族の住みたる地",
                 @"奇怪生物の群れ",
                 @"巨顔の信奉者",
                 @"魔法煌夜祭",
                 @"閻魔王女の下僕達",
                 @"劇薬指定の森",
                 @"赤巨人の西伐",
                 @"青巨人の東征",
                 @"世界を統べる双火竜",
                 nil];
    }
    return self;
}

- (NSArray *)getNames{
    // クリア情報の応じてダンジョン配列を返す
    NSUserDefaults *ud = [NSUserDefaults standardUserDefaults];
    NSMutableArray *result_array = [[NSMutableArray alloc] init];
    // 以下、クリアしてないダンジョンが出てくるまで繰り返す
    for(int i = 0; i < [names count]; i++){
        [result_array addObject:[names objectAtIndex:i]];
        // ダンジョンクリア回数見る
        NSString *key = [NSString stringWithFormat:@"CLEARCOUNT_DUNGEON_%d", i];
        int clear_count = [ud integerForKey:key];
        NSLog(@"クリアカウント%d", clear_count);
        if(clear_count <= 0) break;
    }
    return result_array;
}

- (NSArray *)getAllNames{
    return names;
}

- (NSString *)getName{ return name; }

- (void)reset{
    nowgroupnum = 0;
    arr = [[NSMutableArray alloc] init];
}

- (int)clear{
    // クリアカウントを1増やす
    NSUserDefaults *ud = [NSUserDefaults standardUserDefaults];
    NSString *key = [NSString stringWithFormat:@"CLEARCOUNT_DUNGEON_%d", dungeon_id];
    int clear_count = [ud integerForKey:key];
    if(clear_count <= 0){
        clear_count = 1;
    }else{
        clear_count++;
    }
    // セーブ
    [ud setInteger:clear_count forKey:key];
    return exp;
}

- (void)setDungeon:(int)i{
    NSLog(@"ダンジョンをセット");
    // ダンジョンの名前をセット
    name = [names objectAtIndex:i];
    dungeon_id = i;
    _id = i;
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
        case 5:
            [self dungeon5];
            break;
        case 6:
            [self dungeon6];
            break;
        case 7:
            [self dungeon7];
            break;
        case 8:
            [self dungeon8];
            break;
        case 9:
            [self dungeon9];
            break;
        case 10:
            [self dungeon10];
            break;
        case 11:
            [self dungeon11];
            break;
        case 12:
            [self dungeon12];
            break;
        case 13:
            [self dungeon13];
            break;
        case 14:
            [self dungeon14];
            break;
        case 15:
            [self dungeon15];
            break;
        case 16:
            [self dungeon16];
            break;
        case 17:
            [self dungeon17];
            break;
        case 18:
            [self dungeon18];
            break;
        case 19:
            [self dungeon19];
            break;
        case 20:
            [self dungeon20];
            break;
        case 21:
            [self dungeon21];
            break;
        case 22:
            [self dungeon22];
            break;
        case 23:
            [self dungeon23];
            break;
        case 24:
            [self dungeon24];
            break;
        case 25:
            [self dungeon25];
            break;
        case 26:
            [self dungeon26];
            break;
        case 27:
            [self dungeon27];
            break;
        case 28:
            [self dungeon28];
            break;
        case 29:
            [self dungeon29];
            break;
        case 30:
            [self dungeon30];
            break;
        case 31:
            [self dungeon31];
            break;
        case 32:
            [self dungeon32];
            break;
        case 33:
            [self dungeon33];
            break;
        case 34:
            [self dungeon34];
            break;
        case 35:
            [self dungeon35];
            break;
        case 36:
            [self dungeon36];
            break;
        case 37:
            [self dungeon37];
            break;
        case 38:
            [self dungeon38];
            break;
        case 39:
            [self dungeon39];
            break;
        case 40:
            [self dungeon40];
            break;
        case 41:
            [self dungeon41];
            break;
            
    }
}

/*
- (void)testDungeon1{
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

- (void)testDungeon2{
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

- (void)testDungeon3{
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

- (void)abilityDebuger{
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

- (void)wholeAbilityDebuger{
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
*/
// 以下本番ダンジョン
- (void)dungeon0{
    
    //推奨レベル1
    
    [self reset];
    NSLog(@"%s チュートリアルステージ生成", __func__);
    
    // 敵集団1
    NSArray *subarr = [NSArray arrayWithObjects:
                       [[Enemy alloc] initWithName:@"ビックリネズミ１" H:60 	A:25 	B:0 	C:25 	D:0 	S:30
                                          attackBy:1 ImageString:@"solid07.png"],
                       [[Enemy alloc] initWithName:@"ビックリネズミ２" H:60 	A:25 	B:0 	C:25 	D:0 	S:30 attackBy:1 ImageString:@"solid07.png"],
                       [[Enemy alloc] initWithName:@"ビックリネズミ３" H:60 	A:25 	B:0 	C:25 	D:0 	S:30 attackBy:1 ImageString:@"solid07.png"],
                       nil];
    [arr addObject:subarr];
    
    // 敵襲団2
    subarr = [NSArray arrayWithObjects:
              [[Enemy alloc] initWithName:@"汚いネズミ１" H:65 	A:30 	B:0 	C:30 	D:0 	S:35
                                 attackBy:0 ImageString:@"animal19.png"],
              [[Enemy alloc] initWithName:@"汚いネズミ１" H:65 	A:30 	B:0 	C:30 	D:0 	S:35
                                 attackBy:0 ImageString:@"animal19.png"],
              [[Enemy alloc] initWithName:@"汚いネズミ１" H:65 	A:30 	B:0 	C:30 	D:0 	S:35
                                 attackBy:0 ImageString:@"animal19.png"],
              nil];
    [arr addObject:subarr];
    
    //敵集団3
    subarr = [NSArray arrayWithObjects:
              [[Enemy alloc] initWithName:@"獰猛カマキリ" H:150 	A:40 	B:0 	C:30 	D:0 	S:35
                                 attackBy:0 ImageString:@"animal22.png"],
              nil];
    [arr addObject:subarr];
    
    
    exp = 20;
    stamina = 5;
    [self setBackgroundInt:0];
}

- (void)dungeon1{
    
    //推奨レベル2
    
    [self reset];
    NSLog(@"%s はじまりの森生成", __func__);
    
    // 敵集団1
    NSArray *subarr = [NSArray arrayWithObjects:
                       [[Enemy alloc] initWithName:@"毒々しいちょうちょ１" H:60 	A:42 	B:0 	C:42 	D:0 	S:35 attackBy:1 ImageString:@"spirit81.png"],
                       [[Enemy alloc] initWithName:@"毒々しいちょうちょ２" H:60 	A:42 	B:0 	C:42 	D:0 	S:35 attackBy:1 ImageString:@"spirit81.png"],
                       [[Enemy alloc] initWithName:@"毒々しいちょうちょ３" H:60 	A:42 	B:0 	C:42 	D:0 	S:35 attackBy:1 ImageString:@"animal17.png"],
                       [[Enemy alloc] initWithName:@"毒々しいちょうちょ４" H:60 	A:42 	B:0 	C:42 	D:0 	S:35 attackBy:1 ImageString:@"animal17.png"],
                       nil];
    [arr addObject:subarr];
    
    // 敵襲団2
    subarr = [NSArray arrayWithObjects:
              [[Enemy alloc] initWithName:@"巨大アリ１" H:70 	A:44 	B:0 	C:40 	D:0 	S:45
               
                                 attackBy:0  ImageString:@"animal24.png"],
              [[Enemy alloc] initWithName:@"巨大アリ２" H:70 	A:44 	B:0 	C:40 	D:0 	S:45
               
                                 attackBy:0  ImageString:@"animal24.png"],
              [[Enemy alloc] initWithName:@"巨大アリ３" H:70 	A:44 	B:0 	C:40 	D:0 	S:45
               
                                 attackBy:0  ImageString:@"animal24.png"],
              nil];
    [arr addObject:subarr];
    
    //敵集団3
    subarr = [NSArray arrayWithObjects:
              [[Enemy alloc] initWithName:@"わりとでかいクモ１" H:200 	A:46 	B:14 	C:40 	D:13 	S:40
               
                                 attackBy:0 ImageString:@"animal27.png"],
              [[Enemy alloc] initWithName:@"わりとでかいクモ２" H:200 	A:46 	B:14 	C:40 	D:13 	S:40
               
                                 attackBy:0 ImageString:@"animal27.png"],
              nil];
    [arr addObject:subarr];
    
    
    exp = 40;
    stamina = 5;
    [self setBackgroundInt:2];
}

- (void)dungeon2{
    
    //推奨レベル3
    
    [self reset];
    NSLog(@"%s 昆虫の森生成", __func__);
    
    // 敵集団1
    NSArray *subarr = [NSArray arrayWithObjects:
                       [[Enemy alloc] initWithName:@"獰猛カマキリ１" H:150 	A:50 	B:0 	C:40 	D:0 	S:40 attackBy:0 ImageString:@"animal22.PNG"],
                       [[Enemy alloc] initWithName:@"獰猛カマキリ２" H:150 	A:50 	B:0 	C:40 	D:0 	S:40 attackBy:0 ImageString:@"animal22.PNG"],
                       [[Enemy alloc] initWithName:@"獰猛カマキリ３" H:150 	A:50 	B:0 	C:40 	D:0 	S:40 attackBy:0 ImageString:@"animal22.PNG"],
                       nil];
    [arr addObject:subarr];
    
    // 敵襲団2
    subarr = [NSArray arrayWithObjects:
              [[Enemy alloc] initWithName:@"微毒サソリ１" H:100 	A:55 	B:25 	C:55 	D:25 	S:45
               
                                 attackBy:0 ImageString:@"animal21.png"],
              [[Enemy alloc] initWithName:@"微毒サソリ２" H:100 	A:55 	B:25 	C:55 	D:25 	S:45
               
                                 attackBy:0 ImageString:@"animal21.png"],
              [[Enemy alloc] initWithName:@"微毒サソリ３" H:100 	A:55 	B:25 	C:55 	D:25 	S:45
               
                                 attackBy:0 ImageString:@"animal21.png"],
              nil];
    [arr addObject:subarr];
    
    //敵集団3
    subarr = [NSArray arrayWithObjects:
              [[Enemy alloc] initWithName:@"ヘラクレスビートル１" H:80 	A:50 	B:20 	C:45 	D:20 	S:40
                                 attackBy:0 ImageString:@"animal20.png"],
              [[Enemy alloc] initWithName:@"ヘラクレスビートル２" H:80 	A:50 	B:20 	C:45 	D:20 	S:40
                                 attackBy:0 ImageString:@"animal20.png"],
              [[Enemy alloc] initWithName:@"ミヤマクワガタ１" H:80 	A:45 	B:20 	C:50 	D:20 	S:40
                                 attackBy:1 ImageString:@"animal06.png"],
              [[Enemy alloc] initWithName:@"ミヤマクワガタ２" H:80 	A:45 	B:20 	C:50 	D:20 	S:40
                                 attackBy:1 ImageString:@"animal06.png"],
              nil];
    [arr addObject:subarr];
    
    
    exp = 80;
    stamina = 5;
    [self setBackgroundInt:2];
}


- (void)dungeon3{
    
    //推奨レベル3
    
    [self reset];
    NSLog(@"%s 食人の花生成", __func__);
    
    // 敵集団1
    NSArray *subarr = [NSArray arrayWithObjects:
                       [[Enemy alloc] initWithName:@"シアンフラワー１" H:120 	A:50 	B:0 	C:51 	D:0 	S:45 attackBy:1 ImageString:@"plant03.png"],
                       [[Enemy alloc] initWithName:@"シアンフラワー２" H:120 	A:50 	B:0 	C:51 	D:0 	S:45 attackBy:1 ImageString:@"plant03.png"],
                       [[Enemy alloc] initWithName:@"シアンフラワー３" H:120 	A:50 	B:0 	C:51 	D:0 	S:45 attackBy:1 ImageString:@"plant03.png"],
                       nil];
    [arr addObject:subarr];
    
    // 敵襲団2
    subarr = [NSArray arrayWithObjects:
              
              [[Enemy alloc] initWithName:@"小型パックン１" H:80 	A:53 	B:0 	C:45 	D:0 	S:55
                                 attackBy:0 ImageString:@"plant14.png"],
              [[Enemy alloc] initWithName:@"小型パックン２" H:80 	A:53 	B:0 	C:45 	D:0 	S:55
                                 attackBy:0 ImageString:@"plant14.png"],
              [[Enemy alloc] initWithName:@"小型パックン３" H:80 	A:53 	B:0 	C:45 	D:0 	S:55
                                 attackBy:0 ImageString:@"plant14.png"],
              nil];
    [arr addObject:subarr];
    
    //敵集団3
    subarr = [NSArray arrayWithObjects:
              [[Enemy alloc] initWithName:@"小型パックン１" H:80 	A:53 	B:0 	C:45 	D:0 	S:55
                                 attackBy:0 ImageString:@"plant14.png"],
              [[Enemy alloc] initWithName:@"クサイハナ" H:150 	A:60 	B:10 	C:60 	D:10 	S:45
                                 attackBy:1 ImageString:@"plant05.png"],
              [[Enemy alloc] initWithName:@"小型パックン２" H:80 	A:53 	B:0 	C:45 	D:0 	S:55
                                 attackBy:0 ImageString:@"plant14.png"],
              nil];
    [arr addObject:subarr];
    
    
    exp = 100;
    stamina = 5;
    [self setBackgroundInt:0];
}

- (void)dungeon4{
    
    //推奨レベル4
    
    [self reset];
    NSLog(@"%s 植物たちの下克上生成", __func__);
    
    // 敵集団1
    NSArray *subarr = [NSArray arrayWithObjects:
                       
                       [[Enemy alloc] initWithName:@"小型パックン１" H:100 	A:55 	B:0 	C:45 	D:0 	S:55
                                          attackBy:0 ImageString:@"plant14.png"],
                       [[Enemy alloc] initWithName:@"小型パックン２" H:100 	A:55 	B:0 	C:45 	D:0 	S:55
                                          attackBy:0 ImageString:@"plant14.png"],
                       [[Enemy alloc] initWithName:@"小型パックン３" H:100 	A:55 	B:0 	C:45 	D:0 	S:55
                                          attackBy:0 ImageString:@"plant14.png"],
                       nil];
    [arr addObject:subarr];
    
    // 敵襲団2
    subarr = [NSArray arrayWithObjects:
              [[Enemy alloc] initWithName:@"とげの多すぎるバラ１" H:130 	A:58 	B:20 	C:63 	D:0 	S:50
                                 attackBy:1 ImageString:@"plant02.png"],
              [[Enemy alloc] initWithName:@"とげの多すぎるバラ２" H:130 	A:58 	B:20 	C:63 	D:0 	S:50
                                 attackBy:1 ImageString:@"plant02.png"],
              [[Enemy alloc] initWithName:@"とげの多すぎるバラ３" H:130 	A:58 	B:20 	C:63 	D:0 	S:50
                                 attackBy:1 ImageString:@"plant02.png"],
              nil];
    [arr addObject:subarr];
    
    //敵集団3
    subarr = [NSArray arrayWithObjects:
              [[Enemy alloc] initWithName:@"人食いキノコ１" H:180 	A:63 	B:0 	C:65 	D:15 	S:50
                                 attackBy:1 ImageString:@"plant01.png"],
              [[Enemy alloc] initWithName:@"人食いキノコ２" H:180 	A:63 	B:0 	C:65 	D:15 	S:50
                                 attackBy:1 ImageString:@"plant01.png"],
              [[Enemy alloc] initWithName:@"人食いキノコ３" H:180 	A:63 	B:0 	C:65 	D:15 	S:50
                                 attackBy:1 ImageString:@"plant01.png"],
              nil];
    [arr addObject:subarr];
    
    
    exp = 170;
    stamina = 5;
    [self setBackgroundInt:0];
}

- (void)dungeon5{
    
    //推奨レベル5
    
    [self reset];
    NSLog(@"%s 少女寄生中生成", __func__);
    
    // 敵集団1
    NSArray *subarr = [NSArray arrayWithObjects:
                       [[Enemy alloc] initWithName:@"とげの多すぎるバラ１" H:130 	A:58 	B:20 	C:63 	D:0 	S:50
                                          attackBy:1 ImageString:@"plant02.png"],
                       [[Enemy alloc] initWithName:@"とげの多すぎるバラ２" H:130 	A:58 	B:20 	C:63 	D:0 	S:50
                                          attackBy:1 ImageString:@"plant02.png"],
                       [[Enemy alloc] initWithName:@"とげの多すぎるバラ３" H:130 	A:58 	B:20 	C:63 	D:0 	S:50
                                          attackBy:1 ImageString:@"plant02.png"],
                       nil];
    [arr addObject:subarr];
    
    // 敵襲団2
    subarr = [NSArray arrayWithObjects:
              [[Enemy alloc] initWithName:@"巨大樹１" H:180 	A:62 	B:25 	C:55 	D:0 	S:53
                                 attackBy:0 ImageString:@"plant04.png"],
              [[Enemy alloc] initWithName:@"巨大樹２" H:180 	A:62 	B:25 	C:55 	D:0 	S:53
                                 attackBy:0 ImageString:@"plant04.png"],
              [[Enemy alloc] initWithName:@"巨大樹３" H:180 	A:62 	B:25 	C:55 	D:0 	S:53
                                 attackBy:0 ImageString:@"plant04.png"],
              nil];
    [arr addObject:subarr];
    
    //敵集団3
    subarr = [NSArray arrayWithObjects:
              [[Enemy alloc] initWithName:@"暴走大根１" H:150 	A:65 	B:0 	C:55 	D:0 	S:55
                                 attackBy:0 ImageString:@"plant07.png"],
              [[Enemy alloc] initWithName:@"キノコ少女" H:800 	A:75 	B:0 	C:70 	D:0 	S:60
                                 attackBy:1 ImageString:@"monster56.png"],
              [[Enemy alloc] initWithName:@"暴走大根２" H:150 	A:65 	B:0 	C:55 	D:0 	S:55
                                 attackBy:0 ImageString:@"plant07.png"],
              nil];
    [arr addObject:subarr];
    
    
    exp = 240;
    stamina = 5;
    [self setBackgroundInt:2];
}

- (void)dungeon6{
    
    //推奨レベル5
    
    [self reset];
    NSLog(@"%s 海原の戦い生成", __func__);
    
    // 敵集団1
    NSArray *subarr = [NSArray arrayWithObjects:
                       [[Enemy alloc] initWithName:@"ぐったりしたヒトデ１" H:130 	A:63 	B:0 	C:63 	D:0 	S:55
                                          attackBy:1 ImageString:@"aquatic20.png"],
                       [[Enemy alloc] initWithName:@"ぐったりしたヒトデ２" H:130 	A:63 	B:0 	C:63 	D:0 	S:55
                                          attackBy:1 ImageString:@"aquatic20.png"],
                       [[Enemy alloc] initWithName:@"ぐったりしたヒトデ３" H:130 	A:63 	B:0 	C:63 	D:0 	S:55
                                          attackBy:1 ImageString:@"aquatic20.png"],
                       nil];
    [arr addObject:subarr];
    
    // 敵襲団2
    subarr = [NSArray arrayWithObjects:
              [[Enemy alloc] initWithName:@"迷子の亀１" H:200 	A:63 	B:20 	C:63 	D:10 	S:55
                                 attackBy:0 ImageString:@"aquatic12.png"],
              [[Enemy alloc] initWithName:@"迷子の亀２" H:200 	A:63 	B:20 	C:63 	D:10 	S:55
                                 attackBy:0 ImageString:@"aquatic12.png"],
              [[Enemy alloc] initWithName:@"迷子の亀３" H:200 	A:63 	B:20 	C:63 	D:10 	S:55
                                 attackBy:0 ImageString:@"aquatic12.png"],
              nil];
    [arr addObject:subarr];
    
    //敵集団3
    subarr = [NSArray arrayWithObjects:
              [[Enemy alloc] initWithName:@"泡吹きガニ１" H:180 	A:65 	B:10 	C:56 	D:20 	S:60
                                 attackBy:1 ImageString:@"aquatic13.png"],
              [[Enemy alloc] initWithName:@"泡吹きガニ２" H:180 	A:65 	B:10 	C:56 	D:20 	S:60
                                 attackBy:1 ImageString:@"aquatic13.png"],
              [[Enemy alloc] initWithName:@"泡吹きガニ３" H:180 	A:65 	B:10 	C:56 	D:20 	S:50
                                 attackBy:1 ImageString:@"aquatic13.png"],
              nil];
    [arr addObject:subarr];
    
    //敵襲団4
    subarr = [NSArray arrayWithObjects:
              [[Enemy alloc] initWithName:@"皇帝ペンギン" H:800 	A:75 	B:0 	C:65 	D:0 	S:65
                                 attackBy:0 ImageString:@"animal26.png"],
              nil];
    [arr addObject:subarr];
    
    exp = 260;
    stamina = 5;
    [self setBackgroundInt:18];
}

- (void)dungeon7{
    
    //推奨レベル6
    
    [self reset];
    NSLog(@"%s 海中の魔物たち生成", __func__);
    
    // 敵集団1
    NSArray *subarr = [NSArray arrayWithObjects:
                       [[Enemy alloc] initWithName:@"殺意に満ちたクリオネ１" H:150 	A:62 	B:0 	C:62 	D:0 	S:55
                                          attackBy:1 ImageString:@"aquatic02.png"],
                       [[Enemy alloc] initWithName:@"殺意に満ちたクリオネ２" H:150 	A:62 	B:0 	C:62 	D:0 	S:55
                                          attackBy:1 ImageString:@"aquatic02.png"],
                       [[Enemy alloc] initWithName:@"殺意に満ちたクリオネ３" H:150 	A:62 	B:0 	C:62 	D:0 	S:55
                                          attackBy:1 ImageString:@"aquatic02.png"],
                       [[Enemy alloc] initWithName:@"殺意に満ちたクリオネ４" H:150 	A:62 	B:0 	C:62 	D:0 	S:55
                                          attackBy:1 ImageString:@"aquatic02.png"],
                       [[Enemy alloc] initWithName:@"殺意に満ちたクリオネ５" H:150 	A:62 	B:0 	C:62 	D:0 	S:55
                                          attackBy:1 ImageString:@"aquatic02.png"],
                       nil];
    [arr addObject:subarr];
    
    // 敵襲団2
    subarr = [NSArray arrayWithObjects:
              [[Enemy alloc] initWithName:@"イカの子分１" H:150 	A:64 	B:0 	C:55 	D:0 	S:56
                                 attackBy:0 ImageString:@"aquatic04.png"],
              [[Enemy alloc] initWithName:@"イカの子分２" H:150 	A:64 	B:0 	C:55 	D:0 	S:56
                                 attackBy:0 ImageString:@"aquatic04.png"],
              [[Enemy alloc] initWithName:@"イカの子分３" H:150 	A:64 	B:0 	C:55 	D:0 	S:56
                                 attackBy:0 ImageString:@"aquatic04.png"],
              nil];
    [arr addObject:subarr];
    
    //敵集団3
    subarr = [NSArray arrayWithObjects:
              [[Enemy alloc] initWithName:@"竜宮の使い１" H:250 	A:67 	B:0 	C:65 	D:0 	S:60
                                 attackBy:1 ImageString:@"aquatic11.png"],
              [[Enemy alloc] initWithName:@"竜宮の使い２" H:250 	A:67 	B:0 	C:65 	D:0 	S:60
                                 attackBy:1 ImageString:@"aquatic11.png"],
              [[Enemy alloc] initWithName:@"竜宮の使い３" H:250 	A:67 	B:0 	C:65 	D:0 	S:60
                                 attackBy:1 ImageString:@"aquatic11.png"],
              nil];
    [arr addObject:subarr];
    
    //敵集団4
    subarr = [NSArray arrayWithObjects:
              [[Enemy alloc] initWithName:@"竜宮の使い１" H:250 	A:67 	B:0 	C:65 	D:0 	S:60
                                 attackBy:1 ImageString:@"aquatic11.png"],
              [[Enemy alloc] initWithName:@"ラッセンのイルカ" H:800 	A:70 	B:0 	C:72 	D:0 	S:65
                                 attackBy:0 ImageString:@"aquatic08.png"],
              [[Enemy alloc] initWithName:@"竜宮の使い２" H:250 	A:67 	B:0 	C:65 	D:0 	S:60
                                 attackBy:1 ImageString:@"aquatic11.png"],
              nil];
    [arr addObject:subarr];
    
    
    exp = 350;
    stamina = 5;
    [self setBackgroundInt:18];
}

- (void)dungeon8{
    
    //推奨レベル7
    
    [self reset];
    NSLog(@"%s 触手の猛撃生成", __func__);
    
    // 敵集団1
    NSArray *subarr = [NSArray arrayWithObjects:
                       [[Enemy alloc] initWithName:@"遊泳エイ１" H:150 	A:63 	B:0 	C:67 	D:0 	S:60
                                          attackBy:0 ImageString:@"aquatic09.png"],
                       [[Enemy alloc] initWithName:@"遊泳エイ２" H:150 	A:63 	B:0 	C:67 	D:0 	S:60
                                          attackBy:0 ImageString:@"aquatic09.png"],
                       [[Enemy alloc] initWithName:@"遊泳エイ３" H:150 	A:63 	B:0 	C:67 	D:0 	S:60
                                          attackBy:0 ImageString:@"aquatic09.png"],
                       nil];
    [arr addObject:subarr];
    
    // 敵襲団2
    subarr = [NSArray arrayWithObjects:
              [[Enemy alloc] initWithName:@"大王イカのおみ足１" H:200 	A:66 	B:15 	C:64 	D:15	S:65
                                 attackBy:0 ImageString:@"aquatic18e.png"],
              [[Enemy alloc] initWithName:@"大王イカのおみ足２" H:200 	A:66 	B:15	C:64 	D:15	S:65
                                 attackBy:0 ImageString:@"aquatic18b.png"],
              [[Enemy alloc] initWithName:@"大王イカのおみ足３" H:200 	A:66 	B:15	C:64 	D:15	S:65
                                 attackBy:0 ImageString:@"aquatic18d.png"],
              [[Enemy alloc] initWithName:@"大王イカのおみ足４" H:200 	A:66 	B:15	C:64 	D:15	S:65
                                 attackBy:0 ImageString:@"aquatic18g.png"],
              nil];
    [arr addObject:subarr];
    
    //敵集団3
    subarr = [NSArray arrayWithObjects:
              [[Enemy alloc] initWithName:@"大王イカのおみ足５" H:200 	A:66 	B:15	C:64 	D:15	S:65
                                 attackBy:0 ImageString:@"aquatic18g.png"],
              [[Enemy alloc] initWithName:@"大王イカのおみ足６" H:200 	A:66 	B:15	C:64 	D:15	S:65
                                 attackBy:0 ImageString:@"aquatic18f.png"],
              [[Enemy alloc] initWithName:@"大王イカのおみ足７" H:200 	A:66 	B:15	C:64 	D:15	S:65
                                 attackBy:0 ImageString:@"aquatic18a.png"],
              [[Enemy alloc] initWithName:@"大王イカのおみ足８" H:200 	A:66 	B:15	C:64 	D:15	S:65
                                 attackBy:0 ImageString:@"aquatic18c.png"],
              nil];
    [arr addObject:subarr];
    
    //敵集団4
    subarr = [NSArray arrayWithObjects:
              [[Enemy alloc] initWithName:@"大王イカのおみ足９" H:200 	A:66 	B:15	C:64 	D:15 	S:65
                                 attackBy:0 ImageString:@"aquatic18e.png"],
              [[Enemy alloc] initWithName:@"大王イカ" H:500 	A:75 B:35 	C:90 	D:30 	S:65
                                 attackBy:0 ImageString:@"aquatic18.png"],
              [[Enemy alloc] initWithName:@"大王イカのおみ足１０" H:200 	A:66 	B:15 	C:64 	D:15 	S:65
                                 attackBy:0 ImageString:@"aquatic18b.png"],
              
              nil];
    [arr addObject:subarr];
    
    
    exp = 500;
    stamina = 5;
    [self setBackgroundInt:18];
}

- (void)dungeon9{
    
    //推奨レベル8
    
    [self reset];
    NSLog(@"%s 野生の反乱生成", __func__);
    
    // 敵集団1
    NSArray *subarr = [NSArray arrayWithObjects:
                       [[Enemy alloc] initWithName:@"怪タカ１" H:175 	A:70 	B:20 	C:57 	D:20 	S:70
                                          attackBy:0 ImageString:@"animal04.png"],
                       [[Enemy alloc] initWithName:@"怪タカ２" H:175 	A:70 	B:20 	C:57 	D:20 	S:70
                                          attackBy:0 ImageString:@"animal04.png"],
                       [[Enemy alloc] initWithName:@"怪タカ３" H:175 	A:70 	B:20 	C:57 	D:20 	S:70
                                          attackBy:0 ImageString:@"animal04.png"],
                       nil];
    [arr addObject:subarr];
    
    // 敵襲団2
    subarr = [NSArray arrayWithObjects:
              [[Enemy alloc] initWithName:@"妖力が乏しいキツネ１" H:250 	A:70 	B:0 	C:70 	D:25 	S:65
                                 attackBy:1 ImageString:@"animal11.png"],
              [[Enemy alloc] initWithName:@"妖力が乏しいキツネ２" H:250 	A:70 	B:0 	C:70 	D:25 	S:65
                                 attackBy:1 ImageString:@"animal11.png"],
              [[Enemy alloc] initWithName:@"妖力が乏しいキツネ３" H:250 	A:70 	B:0 	C:70 	D:25 	S:65
                                 attackBy:1 ImageString:@"animal11.png"],
              nil];
    [arr addObject:subarr];
    
    //敵集団3
    subarr = [NSArray arrayWithObjects:
              [[Enemy alloc] initWithName:@"一匹オオカミ" H:800 	A:85 	B:35 	C:40 	D:35 	S:70
                                 attackBy:0 ImageString:@"animal05.png"],
              nil];
    [arr addObject:subarr];
    
    //敵集団4
    subarr = [NSArray arrayWithObjects:
              [[Enemy alloc] initWithName:@"ふわふわウサギ１" H:250 	A:75 	B:15 	C:40 	D:15 	S:65
                                 attackBy:0 ImageString:@"animal14.png"],
              [[Enemy alloc] initWithName:@"首狩りグマ" H:1000 	A:90 	B:25 	C:50 	D:25 	S:90
                                 attackBy:0 ImageString:@"monster71.png"],
              [[Enemy alloc] initWithName:@"ふわふわウサギ２" H:250 	A:75 	B:15 	C:40 	D:15 	S:65
                                 attackBy:0 ImageString:@"animal14.png"],
              nil];
    [arr addObject:subarr];
    
    
    exp = 640;
    stamina = 5;
    [self setBackgroundInt:1];
}

- (void)dungeon10{
    
    //推奨レベル10
    
    [self reset];
    NSLog(@"%s 君臨せし空中王女生成", __func__);
    
    // 敵集団1
    NSArray *subarr = [NSArray arrayWithObjects:
                       [[Enemy alloc] initWithName:@"怪タカ１" H:175 	A:75 	B:20 	C:57 	D:20 	S:70
                                          attackBy:0 ImageString:@"animal04.png"],
                       [[Enemy alloc] initWithName:@"怪タカ２" H:175 	A:75 	B:20 	C:57 	D:20 	S:70
                                          attackBy:0 ImageString:@"animal04.png"],
                       [[Enemy alloc] initWithName:@"怪タカ３" H:175 	A:75 	B:20 	C:57 	D:20 	S:70
                                          attackBy:0 ImageString:@"animal04.png"],
                       nil];
    [arr addObject:subarr];
    
    // 敵襲団2
    subarr = [NSArray arrayWithObjects:
              [[Enemy alloc] initWithName:@"ホワイトバード１" H:250 	A:80 	B:20 	C:57 	D:20 	S:80
                                 attackBy:0 ImageString:@"animal30.png"],
              [[Enemy alloc] initWithName:@"ホワイトバード２" H:250 	A:80 	B:20 	C:57 	D:20 	S:80
                                 attackBy:0 ImageString:@"animal30.png"],
              [[Enemy alloc] initWithName:@"ホワイトバード３" H:250 	A:80 	B:20 	C:57 	D:20 	S:80
                                 attackBy:0 ImageString:@"animal30.png"],
              [[Enemy alloc] initWithName:@"ホワイトバード４" H:250 	A:80 	B:20 	C:57 	D:20 	S:80
                                 attackBy:0 ImageString:@"animal30.png"],
              [[Enemy alloc] initWithName:@"ホワイトバード５" H:250 	A:80 	B:20 	C:57 	D:20 	S:80
                                 attackBy:0 ImageString:@"animal30.png"],
              nil];
    [arr addObject:subarr];
    
    //敵集団3
    subarr = [NSArray arrayWithObjects:
              [[Enemy alloc] initWithName:@"ブラックバード１" H:250 	A:80 	B:20 	C:57 	D:20 	S:80
                                 attackBy:0 ImageString:@"animal09.png"],
              [[Enemy alloc] initWithName:@"ブラックバード２" H:250 	A:80 	B:20 	C:57 	D:20 	S:80                              attackBy:0 ImageString:@"animal09.png"],
              [[Enemy alloc] initWithName:@"ブラックバード３" H:250 	A:80 	B:20 	C:57 	D:20 	S:80
                                 attackBy:0 ImageString:@"animal09.png"],
              [[Enemy alloc] initWithName:@"ブラックバード４" H:250 	A:80 	B:20 	C:57 	D:20 	S:80
                                 attackBy:0 ImageString:@"animal09.png"],
              [[Enemy alloc] initWithName:@"ブラックバード５" H:250 	A:80 	B:20 	C:57 	D:20 	S:80
                                 attackBy:0 ImageString:@"animal09.png"],
              nil];
    [arr addObject:subarr];
    
    //敵襲団4
    subarr = [NSArray arrayWithObjects:
              [[Enemy alloc] initWithName:@"ブラックバード１" H:250 	A:80 	B:20 	C:57 	D:20 	S:80
                                 attackBy:0 ImageString:@"animal09.png"],
              [[Enemy alloc] initWithName:@"空ノ妖精" H:1000 	A:90 	B:20 	C:90 	D:40 	S:90
                                 attackBy:1 ImageString:@"dh10.png"],
              [[Enemy alloc] initWithName:@"ブラックバード２" H:250 	A:80 	B:20 	C:57 	D:20 	S:80
                                 attackBy:0 ImageString:@"animal09.png"],
              [[Enemy alloc] initWithName:@"ホワイトバード１" H:250 	A:80 	B:20 	C:57 	D:20 	S:80
                                 attackBy:0 ImageString:@"animal30.png"],
              [[Enemy alloc] initWithName:@"ホワイトバード２" H:250 	A:80 	B:20 	C:57 	D:20 	S:80
                                 attackBy:0 ImageString:@"animal30.png"],
              nil];
    [arr addObject:subarr];
    
    
    exp = 700;
    stamina = 8;
    [self setBackgroundInt:17];
}

- (void)dungeon11{
    
    //推奨レベル10
    
    [self reset];
    NSLog(@"%s かぼちゃの愉快な仲間たち生成", __func__);
    
    // 敵集団1
    NSArray *subarr = [NSArray arrayWithObjects:
                       [[Enemy alloc] initWithName:@"すり抜ける炎" H:100 	A:88 	B:200 	C:88 	D:0 	S:60
                                          attackBy:1 ImageString:@"monster11.png"],
                       nil];
    [arr addObject:subarr];
    
    // 敵襲団2
    subarr = [NSArray arrayWithObjects:
              [[Enemy alloc] initWithName:@"すり抜ける炎１" H:100 	A:88 	B:200 	C:88 	D:0 	S:60
                                 attackBy:1 ImageString:@"monster11.png"],
              [[Enemy alloc] initWithName:@"死泥の手" H:300 	A:90 	B:10 	C:60 	D:10 	S:75
                                 attackBy:0 ImageString:@"undead13.png"],
              [[Enemy alloc] initWithName:@"すり抜ける炎２" H:100 	A:88 	B:200 	C:88 	D:0 	S:60
                                 attackBy:1 ImageString:@"monster11.png"],
              nil];
    [arr addObject:subarr];
    
    //敵集団3
    subarr = [NSArray arrayWithObjects:
              [[Enemy alloc] initWithName:@"すり抜ける炎１" H:100 	A:88 	B:200 	C:88 	D:0 	S:60
                                 attackBy:1 ImageString:@"monster11.png"],
              [[Enemy alloc] initWithName:@"死のマリオネット" H:300 	A:90 	B:10 	C:60 	D:10 	S:85
                                 attackBy:0 ImageString:@"solid03.png"],
              [[Enemy alloc] initWithName:@"すり抜ける炎２" H:100 	A:88 	B:200 	C:88 	D:0 	S:60
                                 attackBy:1 ImageString:@"monster11.png"],
              nil];
    [arr addObject:subarr];
    
    //敵集団4
    subarr = [NSArray arrayWithObjects:
              [[Enemy alloc] initWithName:@"死のマリオネット" H:300 	A:90 	B:10 	C:60 	D:10 	S:85
                                 attackBy:0 ImageString:@"solid03.png"],
              [[Enemy alloc] initWithName:@"道化師パンプキン" H:1200 	A:95 	B:15 	C:95 	D:15 	S:90
                                 attackBy:1 ImageString:@"monster25.png"],
              [[Enemy alloc] initWithName:@"死泥の手" H:300 	A:90 	B:10 	C:60 	D:10 	S:75
                                 attackBy:0 ImageString:@"undead13.png"],
              nil];
    [arr addObject:subarr];
    
    
    exp = 760;
    stamina = 8;
    [self setBackgroundInt:10];
}

- (void)dungeon12{
    
    //推奨レベル11
    
    [self reset];
    NSLog(@"%s いにしえの悪魔生成", __func__);
    
    // 敵集団1
    NSArray *subarr = [NSArray arrayWithObjects:
                       [[Enemy alloc] initWithName:@"フライングアイ１" H:200 	A:90 	B:20 	C:85 	D:20 	S:85
                                          attackBy:0 ImageString:@"monster86.png"],
                       [[Enemy alloc] initWithName:@"フライングアイ２" H:200 	A:90 	B:20 	C:85 	D:20 	S:85
                                          attackBy:0 ImageString:@"monster86.png"],
                       [[Enemy alloc] initWithName:@"フライングアイ３" H:200 	A:90 	B:20 	C:85 	D:20 	S:85
                                          attackBy:0 ImageString:@"monster86.png"],
                       nil];
    [arr addObject:subarr];
    
    // 敵襲団2
    subarr = [NSArray arrayWithObjects:
              [[Enemy alloc] initWithName:@"骸骨の盾" H:200 	A:90 	B:200 	C:85 	D:20 	S:60
                                 attackBy:0 ImageString:@"monster110.png"],
              [[Enemy alloc] initWithName:@"マミー" H:350 	A:95 	B:10	C:95 	D:50 	S:85
                                 attackBy:1 ImageString:@"undead26.png"],
              nil];
    [arr addObject:subarr];
    
    //敵集団3
    subarr = [NSArray arrayWithObjects:
              [[Enemy alloc] initWithName:@"骸骨の盾" H:200 	A:90 	B:200 	C:85 	D:20 	S:60
                                 attackBy:0 ImageString:@"monster110.png"],
              [[Enemy alloc] initWithName:@"マミー" H:350 	A:95 	B:10	C:95 	D:50 	S:85
                                 attackBy:1 ImageString:@"undead26.png"],
              nil];
    [arr addObject:subarr];
    //敵集団4
    subarr = [NSArray arrayWithObjects:
              [[Enemy alloc] initWithName:@"マミー１" H:350 	A:95 	B:10	C:95 	D:50 	S:85
                                 attackBy:1 ImageString:@"undead26.png"],
              [[Enemy alloc] initWithName:@"マミー２" H:350 	A:95 	B:10	C:95 	D:50 	S:85
                                 attackBy:1 ImageString:@"undead26.png"],
              nil];
    [arr addObject:subarr];
    
    //敵集団5
    subarr = [NSArray arrayWithObjects:
              [[Enemy alloc] initWithName:@"マミー１" H:350 	A:95 	B:10	C:95 	D:50 	S:85
                                 attackBy:1 ImageString:@"undead26.png"],
              [[Enemy alloc] initWithName:@"バフォメット" H:1300 	A:100 	B:10 	C:100 	D:10 	S:90
                                 attackBy:1 ImageString:@"spirit38.png"],
              [[Enemy alloc] initWithName:@"マミー２" H:350 	A:95 	B:10	C:95 	D:50 	S:85
                                 attackBy:1 ImageString:@"undead26.png"],
              [[Enemy alloc] initWithName:@"骸骨の盾１" H:200 	A:90 	B:200 	C:85 	D:20 	S:60
                                 attackBy:0 ImageString:@"monster110.png"],
              [[Enemy alloc] initWithName:@"骸骨の盾２" H:200 	A:90 	B:200 	C:85 	D:20 	S:60
                                 attackBy:0 ImageString:@"monster110.png"],
              nil];
    [arr addObject:subarr];
    
    
    exp = 840;
    stamina = 8;
    [self setBackgroundInt:10];
}

- (void)dungeon13{
    
    //推奨レベル11
    
    [self reset];
    NSLog(@"%s 和世界の邪鬼生成", __func__);
    
    // 敵集団1
    NSArray *subarr = [NSArray arrayWithObjects:
                       [[Enemy alloc] initWithName:@"熱中症河童１" H:300 	A:90 	B:20 	C:90 	D:40 	S:85
                                          attackBy:1 ImageString:@"spirit19.png"],
                       [[Enemy alloc] initWithName:@"熱中症河童２" H:300 	A:90 	B:20 	C:90 	D:40 	S:85
                                          attackBy:1 ImageString:@"spirit19.png"],
                       [[Enemy alloc] initWithName:@"熱中症河童３" H:300 	A:90 	B:20 	C:90 	D:40 	S:85
                                          attackBy:1 ImageString:@"spirit19.png"],
                       nil];
    [arr addObject:subarr];
    
    // 敵襲団2
    subarr = [NSArray arrayWithObjects:
              [[Enemy alloc] initWithName:@"小豆洗い(洗剤使用)１" H:350 	A:95 	B:10	C:95 	D:40 	S:85
                                 attackBy:1 ImageString:@"spirit24.png"],
              [[Enemy alloc] initWithName:@"小豆洗い(洗剤使用)２" H:350 	A:95 	B:10	C:95 	D:40 	S:85
                                 attackBy:1 ImageString:@"spirit24.png"],
              [[Enemy alloc] initWithName:@"小豆洗い(洗剤使用)３" H:350 	A:95 	B:10	C:95 	D:40 	S:85
                                 attackBy:1 ImageString:@"spirit24.png"],
              nil];
    [arr addObject:subarr];
    
    //敵集団3
    subarr = [NSArray arrayWithObjects:
              [[Enemy alloc] initWithName:@"穴の空いたカラカサお化け１" H:400 	A:86 	B:0	C:86 	D:20 	S:90
                                 attackBy:1 ImageString:@"spirit25.png"],
              [[Enemy alloc] initWithName:@"穴の空いたカラカサお化け２" H:400 	A:86 	B:0	C:86 	D:20 	S:90
                                 attackBy:1 ImageString:@"spirit25.png"],
              [[Enemy alloc] initWithName:@"穴の空いたカラカサお化け３" H:400 	A:86 	B:0	C:86 	D:20 	S:90
                                 attackBy:1 ImageString:@"spirit25.png"],
              nil];
    [arr addObject:subarr];
    //敵集団4
    subarr = [NSArray arrayWithObjects:
              [[Enemy alloc] initWithName:@"熱中症河童１" H:300 	A:90 	B:20 	C:90 	D:40 	S:85
                                 attackBy:1 ImageString:@"spirit19.png"],
              [[Enemy alloc] initWithName:@"穴の空いたカラカサお化け１" H:400 	A:86 	B:0	C:86 	D:20 	S:90
                                 attackBy:1 ImageString:@"spirit25.png"],
              [[Enemy alloc] initWithName:@"熱中症河童２" H:300 	A:90 	B:20 	C:90 	D:40 	S:85
                                 attackBy:1 ImageString:@"spirit19.png"],
              nil];
    [arr addObject:subarr];
    
    //敵集団5
    subarr = [NSArray arrayWithObjects:
              [[Enemy alloc] initWithName:@"小豆洗い(洗剤使用)１" H:350 	A:95 	B:10	C:95 	D:40 	S:85
                                 attackBy:1 ImageString:@"spirit24.png"],
              [[Enemy alloc] initWithName:@"妖幽鬼" H:1300 	A:95 	B:0	C:95 	D:40 	S:85
                                 attackBy:1 ImageString:@"spirit20.png"],
              [[Enemy alloc] initWithName:@"小豆洗い(洗剤使用)１" H:350 	A:95 	B:10	C:95 	D:40 	S:85
                                 attackBy:1 ImageString:@"spirit24.png"],
              nil];
    [arr addObject:subarr];
    
    
    exp = 880;
    stamina = 8;
    [self setBackgroundInt:10];
}

- (void)dungeon14{
    
    //推奨レベル11
    
    [self reset];
    NSLog(@"%s 洋館の悪霊生成", __func__);
    
    // 敵集団1
    NSArray *subarr = [NSArray arrayWithObjects:
                       [[Enemy alloc] initWithName:@"スケルトンウーマン１" H:300 	A:90 	B:20 	C:90 	D:20 	S:85
                                          attackBy:1 ImageString:@"undead05.png"],
                       [[Enemy alloc] initWithName:@"スケルトンウーマン１" H:300 	A:90 	B:20 	C:90 	D:20 	S:85
                                          attackBy:1 ImageString:@"undead05.png"],
                       [[Enemy alloc] initWithName:@"スケルトンウーマン１" H:300 	A:90 	B:20 	C:90 	D:20 	S:85
                                          attackBy:1 ImageString:@"undead05.png"],
                       nil];
    [arr addObject:subarr];
    
    // 敵襲団2
    subarr = [NSArray arrayWithObjects:
              [[Enemy alloc] initWithName:@"死へ誘う鏡１" H:250 	A:88 	B:10	C:88 	D:200 	S:85
                                 attackBy:1 ImageString:@"solid08.png"],
              [[Enemy alloc] initWithName:@"デスゴブリン" H:400 	A:95 	B:20	C:92 	D:20 	S:90
                                 attackBy:0 ImageString:@"undead06.png"],
              [[Enemy alloc] initWithName:@"死へ誘う鏡２" H:250 	A:88 	B:10	C:88 	D:200 	S:85
                                 attackBy:1 ImageString:@"solid08.png"],
              nil];
    [arr addObject:subarr];
    
    //敵集団3
    subarr = [NSArray arrayWithObjects:
              [[Enemy alloc] initWithName:@"死へ誘う鏡１" H:250 	A:88 	B:10	C:88 	D:200 	S:85
                                 attackBy:1 ImageString:@"solid08.png"],
              [[Enemy alloc] initWithName:@"操り少女" H:400 	A:92 	B:30	C:92 	D:30 	S:85
                                 attackBy:1 ImageString:@"undead04.png"],
              [[Enemy alloc] initWithName:@"死へ誘う鏡２" H:250 	A:88 	B:10	C:88 	D:200 	S:85
                                 attackBy:1 ImageString:@"solid08.png"],
              nil];
    [arr addObject:subarr];
    //敵集団4
    subarr = [NSArray arrayWithObjects:
              [[Enemy alloc] initWithName:@"デスゴブリン" H:400 	A:95 	B:20	C:92 	D:20 	S:90
                                 attackBy:0 ImageString:@"undead06.png"],
              [[Enemy alloc] initWithName:@"操り少女" H:400 	A:92 	B:30	C:92 	D:30 	S:85
                                 attackBy:1 ImageString:@"undead04.png"],
              [[Enemy alloc] initWithName:@"デスゴブリン" H:400 	A:95 	B:20	C:92 	D:20 	S:90
                                 attackBy:0 ImageString:@"undead06.png"],
              nil];
    [arr addObject:subarr];
    
    //敵集団5
    subarr = [NSArray arrayWithObjects:
              [[Enemy alloc] initWithName:@"死へ誘う鏡１" H:250 	A:88 	B:10	C:88 	D:200 	S:85
                                 attackBy:1 ImageString:@"solid08.png"],
              [[Enemy alloc] initWithName:@"妖幽鬼" H:1300 	A:95 	B:0	C:95 	D:40 	S:85
                                 attackBy:1 ImageString:@"spirit20.png"],
              [[Enemy alloc] initWithName:@"死へ誘う鏡２" H:250 	A:88 	B:10	C:88 	D:200 	S:85
                                 attackBy:1 ImageString:@"solid08.png"],
              nil];
    [arr addObject:subarr];
    
    
    exp = 920;
    stamina = 8;
    [self setBackgroundInt:9];
}

- (void)dungeon15{
    
    //推奨レベル13
    
    [self reset];
    NSLog(@"%s ゴブリン集会場生成", __func__);
    
    // 敵集団1
    NSArray *subarr = [NSArray arrayWithObjects:
                       [[Enemy alloc] initWithName:@"ごろつきゴブリン" H:350 	A:92 	B:20 	C:85 	D:20 	S:90
                                          attackBy:0 ImageString:@"dh04.png"],
                       [[Enemy alloc] initWithName:@"ごろつきゴブリン" H:350 	A:92 	B:20 	C:85 	D:20 	S:90
                                          attackBy:0 ImageString:@"dh04.png"],
                       [[Enemy alloc] initWithName:@"ごろつきゴブリン" H:350 	A:92 	B:20 	C:85 	D:20 	S:90
                                          attackBy:0 ImageString:@"dh04.png"],
                       nil];
    [arr addObject:subarr];
    
    // 敵襲団2
    subarr = [NSArray arrayWithObjects:
              [[Enemy alloc] initWithName:@"ゴブリン下級戦士" H:400 	A:95 	B:40 	C:85 	D:20 	S:90
                                 attackBy:0 ImageString:@"dh08.png"],
              [[Enemy alloc] initWithName:@"ゴブリンメイジ" H:300 	A:95 	B:30 	C:95 	D:60 	S:90
                                 attackBy:1 ImageString:@"dh21.png"],
              [[Enemy alloc] initWithName:@"ゴブリン下級戦士" H:400 	A:95 	B:40 	C:85 	D:20 	S:90
                                 attackBy:0 ImageString:@"dh08.png"],
              nil];
    [arr addObject:subarr];
    
    //敵集団3
    subarr = [NSArray arrayWithObjects:
              [[Enemy alloc] initWithName:@"ゴブリンメイジ" H:300 	A:95 	B:30 	C:95 	D:60 	S:90
                                 attackBy:1 ImageString:@"dh21.png"],
              [[Enemy alloc] initWithName:@"ゴブリン上級戦士" H:500 	A:100 	B:40 	C:85 	D:20 	S:90
                                 attackBy:0 ImageString:@"dh22.png"],
              [[Enemy alloc] initWithName:@"ゴブリンメイジ" H:300 	A:95 	B:30 	C:95 	D:60 	S:90
                                 attackBy:1 ImageString:@"dh21.png"],
              nil];
    [arr addObject:subarr];
    //敵集団4
    subarr = [NSArray arrayWithObjects:
              [[Enemy alloc] initWithName:@"ゴブリン下級戦士" H:400 	A:95 	B:40 	C:85 	D:20 	S:90
                                 attackBy:0 ImageString:@"dh08.png"],
              [[Enemy alloc] initWithName:@"ゴブリン上級戦士" H:500 	A:100 	B:40 	C:85 	D:20 	S:90
                                 attackBy:0 ImageString:@"dh22.png"],
              [[Enemy alloc] initWithName:@"ゴブリン下級戦士" H:400 	A:95 	B:40 	C:85 	D:20 	S:90
                                 attackBy:0 ImageString:@"dh08.png"],
              nil];
    [arr addObject:subarr];
    
    //敵集団5
    subarr = [NSArray arrayWithObjects:
              [[Enemy alloc] initWithName:@"ゴブリン上級戦士" H:500 	A:100 	B:40 	C:85 	D:20 	S:90
                                 attackBy:0 ImageString:@"dh22.png"],
              [[Enemy alloc] initWithName:@"ゴブリンナイト" H:1500 	A:105 	B:50 	C:85 	D:50 	S:100
                                 attackBy:0 ImageString:@"dh05.png"],
              [[Enemy alloc] initWithName:@"ゴブリン上級戦士" H:500 	A:100 	B:40 	C:85 	D:20 	S:90
                                 attackBy:0 ImageString:@"dh22.png"],
              nil];
    [arr addObject:subarr];
    
    
    exp = 1040;
    stamina = 8;
    [self setBackgroundInt:8];
}

- (void)dungeon16{
    
    //推奨レベル13
    
    [self reset];
    NSLog(@"%s スライムの洞窟生成", __func__);
    
    // 敵集団1
    NSArray *subarr = [NSArray arrayWithObjects:
                       [[Enemy alloc] initWithName:@"毒々しいスライム１" H:300 	A:98 	B:50 	C:85 	D:20 	S:90
                                          attackBy:0 ImageString:@"monster26.png"],
                       [[Enemy alloc] initWithName:@"毒々しいスライム２" H:300 	A:98 	B:50 	C:85 	D:20 	S:90
                                          attackBy:0 ImageString:@"monster26.png"],
                       [[Enemy alloc] initWithName:@"毒々しいスライム３" H:300 	A:98 	B:50 	C:85 	D:20 	S:90
                                          attackBy:0 ImageString:@"monster26.png"],
                       nil];
    [arr addObject:subarr];
    
    // 敵襲団2
    subarr = [NSArray arrayWithObjects:
              [[Enemy alloc] initWithName:@"腐ったスライム１" H:350 	A:98 	B:50	C:98 	D:20 	S:90
                                 attackBy:1 ImageString:@"solid40.png"],
              [[Enemy alloc] initWithName:@"腐ったスライム１" H:350 	A:98 	B:50	C:98 	D:20 	S:90
                                 attackBy:1 ImageString:@"solid40.png"],
              [[Enemy alloc] initWithName:@"腐ったスライム１" H:350 	A:98 	B:50	C:98 	D:20 	S:90
                                 attackBy:1 ImageString:@"solid40.png"],
              nil];
    [arr addObject:subarr];
    
    //敵集団3
    subarr = [NSArray arrayWithObjects:
              [[Enemy alloc] initWithName:@"炎スライム１" H:400 	A:98 	B:50	C:95 	D:20 	S:90
                                 attackBy:0 ImageString:@"monster141.png"],
              [[Enemy alloc] initWithName:@"炎スライム２" H:400 	A:98 	B:50	C:95 	D:20 	S:90
                                 attackBy:0 ImageString:@"monster141.png"],
              [[Enemy alloc] initWithName:@"炎スライム３" H:400 	A:98 	B:50	C:95 	D:20 	S:90
                                 attackBy:0 ImageString:@"monster141.png"],
              nil];
    [arr addObject:subarr];
    //敵集団4
    subarr = [NSArray arrayWithObjects:
              [[Enemy alloc] initWithName:@"はぐれスライム１" H:10 	A:98 	B:130	C:95 	D:130 	S:90
                                 attackBy:0 ImageString:@"monster67.png"],
              [[Enemy alloc] initWithName:@"はぐれスライムキング" H:20 	A:98 	B:130	C:95 	D:130 	S:90
                                 attackBy:0 ImageString:@"monster67.png"],
              [[Enemy alloc] initWithName:@"はぐれスライム２" H:10 	A:98 	B:130	C:95 	D:130 	S:90
                                 attackBy:0 ImageString:@"monster67.png"],
              nil];
    [arr addObject:subarr];
    
    //敵集団5
    subarr = [NSArray arrayWithObjects:
              [[Enemy alloc] initWithName:@"はぐれスライム１" H:10 	A:98 	B:130	C:95 	D:130 	S:90
                                 attackBy:0 ImageString:@"monster67.png"],
              [[Enemy alloc] initWithName:@"スライムクイーン" H:1500 	A:102 	B:40	C:102 	D:20 	S:110
                                 attackBy:1 ImageString:@"monster38.png"],
              [[Enemy alloc] initWithName:@"はぐれスライム２" H:10 	A:98 	B:130	C:95 	D:130 	S:90
                                 attackBy:0 ImageString:@"monster67.png"],
              nil];
    [arr addObject:subarr];
    
    
    exp = 1100;
    stamina = 8;
    [self setBackgroundInt:8];
}

- (void)dungeon17{
    
    //推奨レベル13
    
    [self reset];
    NSLog(@"%s 盗賊の住処生成", __func__);
    
    // 敵集団1
    NSArray *subarr = [NSArray arrayWithObjects:
                       [[Enemy alloc] initWithName:@"フライングアイ１" H:250 	A:95 	B:20 	C:85 	D:20 	S:100
                                          attackBy:0 ImageString:@"monster86.png"],
                       [[Enemy alloc] initWithName:@"フライングアイ２" H:250 	A:95 	B:20 	C:85 	D:20 	S:100
                                          attackBy:0 ImageString:@"monster86.png"],
                       [[Enemy alloc] initWithName:@"フライングアイ３" H:250 	A:95 	B:20 	C:85 	D:20 	S:100
                                          attackBy:0 ImageString:@"monster86.png"],
                       nil];
    [arr addObject:subarr];
    
    // 敵襲団2
    subarr = [NSArray arrayWithObjects:
              [[Enemy alloc] initWithName:@"護衛スケルトン１" H:300 	A:98 	B:50 	C:90 	D:50 	S:90
                                 attackBy:0 ImageString:@"undead68.png"],
              [[Enemy alloc] initWithName:@"護衛スケルトン２" H:300 	A:98 	B:50 	C:90 	D:50 	S:90
                                 attackBy:0 ImageString:@"undead68.png"],
              [[Enemy alloc] initWithName:@"護衛スケルトン３" H:300 	A:98 	B:50 	C:90 	D:50 	S:90
                                 attackBy:0 ImageString:@"undead68.png"],
              nil];
    [arr addObject:subarr];
    
    //敵集団3
    subarr = [NSArray arrayWithObjects:
              [[Enemy alloc] initWithName:@"からっぽミミック１" H:325 	A:102 	B:50 	C:102   D:50 	S:60
                                 attackBy:1 ImageString:@"solid02.png"],
              [[Enemy alloc] initWithName:@"からっぽミミック２" H:325 	A:102 	B:50 	C:102	D:50 	S:60
                                 attackBy:1 ImageString:@"solid02.png"],
              [[Enemy alloc] initWithName:@"からっぽミミック３" H:325 	A:102 	B:50 	C:102	D:50 	S:60
                                 attackBy:1 ImageString:@"solid02.png"],
              nil];
    [arr addObject:subarr];
    //敵集団4
    subarr = [NSArray arrayWithObjects:
              [[Enemy alloc] initWithName:@"泥人形１" H:350 	A:102 	B:50	C:102 	D:50 	S:94
                                 attackBy:1 ImageString:@"monster17.png"],
              [[Enemy alloc] initWithName:@"泥人形２" H:350 	A:102 	B:50	C:102 	D:50 	S:94
                                 attackBy:1 ImageString:@"monster17.png"],
              [[Enemy alloc] initWithName:@"泥人形３" H:350 	A:102 	B:50	C:102 	D:50 	S:94
                                 attackBy:1 ImageString:@"monster17.png"],
              nil];
    [arr addObject:subarr];
    
    //敵集団5
    subarr = [NSArray arrayWithObjects:
              [[Enemy alloc] initWithName:@"護衛スケルトン１" H:300 	A:95 	B:50 	C:90 	D:50 	S:90
                                 attackBy:0 ImageString:@"undead68.png"],
              [[Enemy alloc] initWithName:@"盗賊A" H:1600 	A:95 	B:30	C:95 	D:30 	S:100
                                 attackBy:1 ImageString:@"human102.png"],
              [[Enemy alloc] initWithName:@"護衛スケルトン２" H:300 	A:95 	B:50 	C:90 	D:50 	S:90
                                 attackBy:0 ImageString:@"undead68.png"],
              
              nil];
    [arr addObject:subarr];
    
    
    exp = 1120;
    stamina = 8;
    [self setBackgroundInt:8];
}

- (void)dungeon18{
    
    //推奨レベル14
    
    [self reset];
    NSLog(@"%s 遊戯の館生成", __func__);
    
    // 敵集団1
    NSArray *subarr = [NSArray arrayWithObjects:
                       [[Enemy alloc] initWithName:@"壱" H:300 	A:100 	B:40 	C:100 	D:40 	S:95
                                          attackBy:1 ImageString:@"spirit83_1.png"],
                       nil];
    [arr addObject:subarr];
    
    // 敵襲団2
    subarr = [NSArray arrayWithObjects:
              [[Enemy alloc] initWithName:@"弐" H:350 	A:101 	B:40 	C:101 	D:40 	S:95
                                 attackBy:1 ImageString:@"spirit83_2.png"],
              [[Enemy alloc] initWithName:@"弐" H:350 	A:101 	B:40 	C:101 	D:40 	S:95
                                 attackBy:1 ImageString:@"spirit83_2.png"],
              nil];
    [arr addObject:subarr];
    
    //敵集団3
    subarr = [NSArray arrayWithObjects:
              [[Enemy alloc] initWithName:@"参" H:400 	A:102 	B:40 	C:102 	D:40 	S:95
                                 attackBy:1 ImageString:@"spirit83_3.png"],
              [[Enemy alloc] initWithName:@"参" H:400 	A:102 	B:40 	C:102 	D:40 	S:95
                                 attackBy:1 ImageString:@"spirit83_3.png"],
              [[Enemy alloc] initWithName:@"参" H:400 	A:102 	B:40 	C:102 	D:40 	S:95
                                 attackBy:1 ImageString:@"spirit83_3.png"],
              nil];
    [arr addObject:subarr];
    //敵集団4
    subarr = [NSArray arrayWithObjects:
              [[Enemy alloc] initWithName:@"四" H:400 	A:103 	B:40 	C:103 	D:40 	S:95
                                 attackBy:1 ImageString:@"spirit83_4.png"],
              [[Enemy alloc] initWithName:@"四" H:400 	A:103 	B:40 	C:103 	D:40 	S:95
                                 attackBy:1 ImageString:@"spirit83_4.png"],
              [[Enemy alloc] initWithName:@"四" H:400 	A:103 	B:40 	C:103 	D:40 	S:95
                                 attackBy:1 ImageString:@"spirit83_4.png"],
              [[Enemy alloc] initWithName:@"四" H:400 	A:103 	B:40 	C:103 	D:40 	S:95
                                 attackBy:1 ImageString:@"spirit83_4.png"],
              nil];
    [arr addObject:subarr];
    
    //敵集団5
    subarr = [NSArray arrayWithObjects:
              [[Enemy alloc] initWithName:@"伍" H:400 	A:104 	B:40 	C:104 	D:40 	S:95
                                 attackBy:1 ImageString:@"spirit83_5.png"],
              [[Enemy alloc] initWithName:@"伍" H:400 	A:104 	B:40 	C:104 	D:40 	S:95
                                 attackBy:1 ImageString:@"spirit83_5.png"],
              [[Enemy alloc] initWithName:@"伍" H:400 	A:104 	B:40 	C:104 	D:40 	S:95
                                 attackBy:1 ImageString:@"spirit83_5.png"],
              [[Enemy alloc] initWithName:@"伍" H:400 	A:104 	B:40 	C:104 	D:40 	S:95
                                 attackBy:1 ImageString:@"spirit83_5.png"],
              [[Enemy alloc] initWithName:@"伍" H:400 	A:104 	B:40 	C:104 	D:40 	S:95
                                 attackBy:1 ImageString:@"spirit83_5.png"],
              nil];
    [arr addObject:subarr];
    
    //敵集団6
    subarr = [NSArray arrayWithObjects:
              [[Enemy alloc] initWithName:@"六" H:400 	A:105 	B:40 	C:105 	D:40 	S:95
                                 attackBy:1 ImageString:@"spirit83_6.png"],
              [[Enemy alloc] initWithName:@"七" H:1800 	A:110 	B:40 	C:110 	D:40 	S:105
                                 attackBy:1 ImageString:@"spirit83_7.png"],
              [[Enemy alloc] initWithName:@"六" H:400 	A:105 	B:40 	C:105 	D:40 	S:95
                                 attackBy:1 ImageString:@"spirit83_6.png"],
              nil];
    [arr addObject:subarr];
    
    
    exp = 1200;
    stamina = 8;
    [self setBackgroundInt:9];
}

- (void)dungeon19{
    
    //推奨レベル14
    
    [self reset];
    NSLog(@"%s 食物パラダイス生成", __func__);
    
    // 敵集団1
    NSArray *subarr = [NSArray arrayWithObjects:
                       [[Enemy alloc] initWithName:@"人食いキノコ１" H:350 	A:103 	B:35 	C:103 	D:35 	S:92
                                          attackBy:1 ImageString:@"plant01.png"],
                       [[Enemy alloc] initWithName:@"人食いキノコ２" H:350 	A:103 	B:35 	C:103 	D:35 	S:92
                                          attackBy:1 ImageString:@"plant01.png"],
                       [[Enemy alloc] initWithName:@"人食いキノコ３" H:350 	A:103 	B:35 	C:103 	D:35 	S:92
                                          attackBy:1 ImageString:@"plant01.png"],
                       nil];
    [arr addObject:subarr];
    
    // 敵襲団2
    subarr = [NSArray arrayWithObjects:
              [[Enemy alloc] initWithName:@"鬨の声１" H:400 	A:105 	B:50	C:105 	D:20 	S:100
                                 attackBy:1 ImageString:@"monster83.png"],
              [[Enemy alloc] initWithName:@"相思相愛煮干し" H:450 	A:106 	B:40	C:95 	D:40 	S:100
                                 attackBy:0 ImageString:@"undead28.png"],
              [[Enemy alloc] initWithName:@"鬨の声２" H:400 	A:105 	B:50	C:105 	D:20 	S:100
                                 attackBy:1 ImageString:@"monster83.png"],
              nil];
    [arr addObject:subarr];
    
    //敵集団3
    subarr = [NSArray arrayWithObjects:
              [[Enemy alloc] initWithName:@"相思相愛煮干し１" H:450 	A:106 	B:40	C:95 	D:40 	S:100
                                 attackBy:0 ImageString:@"undead28.png"],
              [[Enemy alloc] initWithName:@"鬨の声" H:400 	A:105 	B:50	C:105 	D:20 	S:100
                                 attackBy:1 ImageString:@"monster83.png"],
              [[Enemy alloc] initWithName:@"相思相愛煮干し２" H:450 	A:106 	B:40	C:95 	D:40 	S:100
                                 attackBy:0 ImageString:@"undead28.png"],
              nil];
    [arr addObject:subarr];
    //敵集団4
    subarr = [NSArray arrayWithObjects:
              [[Enemy alloc] initWithName:@"謎のプリン男" H:500 	A:107 	B:60	C:95 	D:0 	S:95
                                 attackBy:0 ImageString:@"solid04.png"],
              nil];
    [arr addObject:subarr];
    
    //敵集団5
    subarr = [NSArray arrayWithObjects:
              [[Enemy alloc] initWithName:@"謎のプリン男１" H:500 	A:107 	B:60	C:95 	D:0 	S:95
                                 attackBy:0 ImageString:@"solid04.png"],
              [[Enemy alloc] initWithName:@"謎のショートケーキ男" H:1800 	A:107 	B:60	C:95 	D:0 	S:95
                                 attackBy:0 ImageString:@"monster89.png"],
              [[Enemy alloc] initWithName:@"謎のプリン男２" H:500 	A:107 	B:60	C:95 	D:0 	S:95
                                 attackBy:0 ImageString:@"solid04.png"],
              nil];
    [arr addObject:subarr];
    
    
    exp = 1240;
    stamina = 8;
    [self setBackgroundInt:12];
}


- (void)dungeon20{
    [self reset];
    NSLog(@"%s 陽落つる祭壇生成", __func__);
    
    // 敵集団1
    NSArray *subarr = [NSArray arrayWithObjects:
                       [[Enemy alloc] initWithName:@"ケルベロス１" H:350 	A:103 	B:35 	C:103 	D:35 	S:92
                                          attackBy:1 ImageString:@"monster24"],
                       [[Enemy alloc] initWithName:@"ケルベロス２" H:350 	A:103 	B:35 	C:103 	D:35 	S:92
                                          attackBy:1 ImageString:@"monster24"],
                       [[Enemy alloc] initWithName:@"ケルベロス３" H:350 	A:103 	B:35 	C:103 	D:35 	S:92
                                          attackBy:1 ImageString:@"monster24"],
                       nil];
    [arr addObject:subarr];
    
    // 敵襲団2
    subarr = [NSArray arrayWithObjects:
              [[Enemy alloc] initWithName:@"ケルベロス１" H:350 	A:103 	B:35 	C:103 	D:35 	S:92
                                 attackBy:1 ImageString:@"monster24"],
              [[Enemy alloc] initWithName:@"マミーナイト" H:450 	A:106 	B:40	C:95 	D:40 	S:100
                                 attackBy:0 ImageString:@"undead03.png"],
              [[Enemy alloc] initWithName:@"ケルベロス２" H:350 	A:103 	B:35 	C:103 	D:35 	S:92
                                 attackBy:1 ImageString:@"monster24"],
              nil];
    [arr addObject:subarr];
    
    //敵集団3
    subarr = [NSArray arrayWithObjects:
              [[Enemy alloc] initWithName:@"マミーナイト１" H:450 	A:106 	B:40	C:95 	D:40 	S:100
                                 attackBy:0 ImageString:@"undead03.png"],
              [[Enemy alloc] initWithName:@"マミーナイト２" H:450 	A:106 	B:40	C:95 	D:40 	S:100
                                 attackBy:0 ImageString:@"undead03.png"],
              [[Enemy alloc] initWithName:@"マミーナイト３" H:450 	A:106 	B:40	C:95 	D:40 	S:100
                                 attackBy:0 ImageString:@"undead03.png"],
              nil];
    [arr addObject:subarr];
    //敵集団4
    subarr = [NSArray arrayWithObjects:
              [[Enemy alloc] initWithName:@"王の従者" H:500 	A:107 	B:60	C:95 	D:0 	S:95
                                 attackBy:0 ImageString:@"spirit15.png"],
              [[Enemy alloc] initWithName:@"女王の従者" H:500 	A:107 	B:60	C:107 	D:0 	S:95
                                 attackBy:1 ImageString:@"spirit15.png"],
              nil];
    [arr addObject:subarr];
    
    //敵集団5
    subarr = [NSArray arrayWithObjects:
              [[Enemy alloc] initWithName:@"落陽の王" H:1800 	A:107 	B:50	C:95 	D:50 	S:95
                                 attackBy:0 ImageString:@"spirit16.png"],
              [[Enemy alloc] initWithName:@"落陽の女王" H:1800 	A:107 	B:50	C:107 	D:50 	S:95
                                 attackBy:1 ImageString:@"spirit14.png"],
              nil];
    [arr addObject:subarr];
    
    
    exp = 1280;
    stamina = 8;
    [self setBackgroundInt:13];
}

- (void)dungeon21{
    [self reset];
    NSLog(@"%s 不死者の巣食う世界生成", __func__);
    
    // 敵集団1
    NSArray *subarr = [NSArray arrayWithObjects:
                       [[Enemy alloc] initWithName:@"墓から這い出しもの１" H:500 	A:107 	B:20	C:107 	D:20 	S:100
                                          attackBy:1 ImageString:@"undead02.png"],
                       [[Enemy alloc] initWithName:@"墓から這い出しもの２" H:500 	A:107 	B:20	C:107 	D:20 	S:100
                                          attackBy:1 ImageString:@"undead02.png"],
                       [[Enemy alloc] initWithName:@"墓から這い出しもの３" H:500 	A:107 	B:20	C:107 	D:20 	S:100
                                          attackBy:1 ImageString:@"undead02.png"],
                       nil];
    [arr addObject:subarr];
    
    // 敵襲団2
    subarr = [NSArray arrayWithObjects:
              [[Enemy alloc] initWithName:@"暗闇の女１" H:650 	A:112 	B:40	C:112 	D:40 	S:110
                                 attackBy:1 ImageString:@"human193.png"],
              [[Enemy alloc] initWithName:@"暗闇の女２" H:650 	A:112 	B:40	C:112 	D:40 	S:110
                                 attackBy:1 ImageString:@"human193.png"],
              [[Enemy alloc] initWithName:@"暗闇の女３" H:650 	A:112 	B:40	C:112 	D:40 	S:110
                                 attackBy:1 ImageString:@"human193.png"],
              nil];
    [arr addObject:subarr];
    
    //敵集団3
    subarr = [NSArray arrayWithObjects:
              [[Enemy alloc] initWithName:@"空の不死者１" H:650 	A:115 	B:40	C:115 	D:40 	S:115
                                 attackBy:1 ImageString:@"monster31.png"],
              [[Enemy alloc] initWithName:@"空の不死者２" H:650 	A:115 	B:40	C:115 	D:40 	S:115
                                 attackBy:1 ImageString:@"monster31.png"],
              [[Enemy alloc] initWithName:@"空の不死者３" H:650 	A:115 	B:40	C:115 	D:40 	S:115
                                 attackBy:1 ImageString:@"monster31.png"],
              nil];
    [arr addObject:subarr];
    //敵集団4
    subarr = [NSArray arrayWithObjects:
              [[Enemy alloc] initWithName:@"闇のならずもの１" H:650 	A:115 	B:40	C:115 	D:40 	S:120
                                 attackBy:1 ImageString:@"human147.png"],
              [[Enemy alloc] initWithName:@"闇のならずもの２" H:650 	A:115 	B:40	C:115 	D:40 	S:120
                                 attackBy:1 ImageString:@"human147.png"],
              [[Enemy alloc] initWithName:@"闇のならずもの３" H:650 	A:115 	B:40	C:115 	D:40 	S:120
                                 attackBy:1 ImageString:@"human147.png"],
              nil];
    [arr addObject:subarr];
    
    //敵集団5
    subarr = [NSArray arrayWithObjects:
              [[Enemy alloc] initWithName:@"闇のならずもの１" H:650 	A:115 	B:40	C:115 	D:40 	S:120
                                 attackBy:1 ImageString:@"human147.png"],
              [[Enemy alloc] initWithName:@"暗闇の召喚者" H:2200 	A:120 	B:0	C:95 	D:60 	S:95
                                 attackBy:1 ImageString:@"undead27.png"],
              [[Enemy alloc] initWithName:@"闇のならずもの２" H:650 	A:115 	B:40	C:115 	D:40 	S:120
                                 attackBy:1 ImageString:@"human147.png"],
              nil];
    [arr addObject:subarr];
    
    
    exp = 1440;
    stamina = 10;
    [self setBackgroundInt:11];
}

- (void)dungeon22{
    [self reset];
    NSLog(@"%s 獅子奮迅の空生成", __func__);
    
    // 敵集団1
    NSArray *subarr = [NSArray arrayWithObjects:
                       [[Enemy alloc] initWithName:@"空飛竜" H:500 	A:110 	B:20	C:110 	D:20 	S:120
                                          attackBy:1 ImageString:@"monster57.png"],
                       [[Enemy alloc] initWithName:@"地飛竜" H:500 	A:110 	B:20	C:100 	D:20 	S:120
                                          attackBy:0 ImageString:@"monster103.png"],
                       nil];
    [arr addObject:subarr];
    
    // 敵襲団2
    subarr = [NSArray arrayWithObjects:
              [[Enemy alloc] initWithName:@"空飛竜" H:500 	A:110 	B:20	C:110 	D:20 	S:120
                                 attackBy:1 ImageString:@"monster57.png"],
              [[Enemy alloc] initWithName:@"ポイズンガーゴイル" H:800 	A:115 	B:60	C:110 	D:60 	S:100
                                 attackBy:0 ImageString:@"monster28.png"],
              [[Enemy alloc] initWithName:@"地飛竜" H:500 	A:110 	B:20	C:100 	D:20 	S:120
                                 attackBy:0 ImageString:@"monster103.png"],
              nil];
    [arr addObject:subarr];
    
    //敵集団3
    subarr = [NSArray arrayWithObjects:
              [[Enemy alloc] initWithName:@"白天使１" H:750 	A:115 	B:30	C:115 	D:30 	S:120
                                 attackBy:1 ImageString:@"spirit03.png"],
              [[Enemy alloc] initWithName:@"白天使２" H:750 	A:115 	B:30	C:115 	D:30 	S:120
                                 attackBy:1 ImageString:@"spirit03.png"],
              [[Enemy alloc] initWithName:@"白天使３" H:750 	A:115 	B:30	C:115 	D:30 	S:120
                                 attackBy:1 ImageString:@"spirit03.png"],
              nil];
    [arr addObject:subarr];
    //敵集団4
    subarr = [NSArray arrayWithObjects:
              [[Enemy alloc] initWithName:@"黒天使１" H:750 	A:115 	B:30	C:95 	D:30 	S:120
                                 attackBy:0 ImageString:@"spirit35.png"],
              [[Enemy alloc] initWithName:@"黒天使２" H:750 	A:115 	B:30	C:95 	D:30 	S:120
                                 attackBy:0 ImageString:@"spirit35.png"],
              [[Enemy alloc] initWithName:@"黒天使３" H:750 	A:115 	B:30	C:95 	D:30 	S:120
                                 attackBy:0 ImageString:@"spirit35.png"],
              nil];
    [arr addObject:subarr];
    
    //敵集団5
    subarr = [NSArray arrayWithObjects:
              [[Enemy alloc] initWithName:@"白天使" H:750 	A:115 	B:30	C:115 	D:30 	S:120
                                 attackBy:1 ImageString:@"spirit03.png"],
              [[Enemy alloc] initWithName:@"獅子奮迅" H:2500 	A:120 	B:30	C:95 	D:30 	S:110
                                 attackBy:0 ImageString:@"dh11.png"],
              [[Enemy alloc] initWithName:@"黒天使" H:750 	A:115 	B:30	C:95 	D:30 	S:120
                                 attackBy:0 ImageString:@"spirit35.png"],
              nil];
    [arr addObject:subarr];
    
    
    exp = 1520;
    stamina = 10;
    [self setBackgroundInt:17];
}

- (void)dungeon23{
    [self reset];
    NSLog(@"%s 鎧たちの蠢く城生成", __func__);
    
    // 敵集団1
    NSArray *subarr = [NSArray arrayWithObjects:
                       [[Enemy alloc] initWithName:@"上半身だけの鎧１" H:500 	A:110 	B:60	C:100 	D:30 	S:100
                                          attackBy:0 ImageString:@"solid06.png"],
                       [[Enemy alloc] initWithName:@"上半身だけの鎧２" H:500 	A:110 	B:60	C:100 	D:30 	S:100
                                          attackBy:0 ImageString:@"solid06.png"],
                       [[Enemy alloc] initWithName:@"上半身だけの鎧３" H:500 	A:110 	B:60	C:100 	D:30 	S:100
                                          attackBy:0 ImageString:@"solid06.png"],
                       nil];
    [arr addObject:subarr];
    
    // 敵襲団2
    subarr = [NSArray arrayWithObjects:
              [[Enemy alloc] initWithName:@"上半身だけの鎧１" H:500 	A:110 	B:60	C:100 	D:30 	S:100
                                 attackBy:0 ImageString:@"solid06.png"],
              [[Enemy alloc] initWithName:@"無言の鎧騎士" H:500 	A:116 	B:80	C:100 	D:30 	S:110
                                 attackBy:0 ImageString:@"human127.png"],
              [[Enemy alloc] initWithName:@"上半身だけの鎧２" H:500 	A:110 	B:60	C:100 	D:30 	S:100
                                 attackBy:0 ImageString:@"solid06.png"],
              nil];
    [arr addObject:subarr];
    
    //敵集団3
    subarr = [NSArray arrayWithObjects:
              [[Enemy alloc] initWithName:@"無言の鎧騎士１" H:500 	A:116 	B:80	C:100 	D:30 	S:110
                                 attackBy:0 ImageString:@"human127.png"],
              [[Enemy alloc] initWithName:@"蜥蜴戦士（柔）" H:800 	A:118 	B:50	C:100 	D:30 	S:110
                                 attackBy:0 ImageString:@"dh24.png"],
              [[Enemy alloc] initWithName:@"無言の鎧騎士２" H:500 	A:116 	B:80	C:100 	D:30 	S:110
                                 attackBy:0 ImageString:@"human127.png"],
              nil];
    [arr addObject:subarr];
    //敵集団4
    subarr = [NSArray arrayWithObjects:
              [[Enemy alloc] initWithName:@"蜥蜴戦士（柔）１" H:800 	A:118 	B:50	C:100 	D:30 	S:110
                                 attackBy:0 ImageString:@"dh24.png"],
              [[Enemy alloc] initWithName:@"蜥蜴戦士（硬）" H:800 	A:118 	B:80	C:100 	D:30 	S:110
                                 attackBy:0 ImageString:@"dh24.png"],
              [[Enemy alloc] initWithName:@"蜥蜴戦士（柔）２" H:800 	A:118 	B:50	C:100 	D:30 	S:110
                                 attackBy:0 ImageString:@"dh24.png"],
              nil];
    [arr addObject:subarr];
    
    //敵集団5
    subarr = [NSArray arrayWithObjects:
              [[Enemy alloc] initWithName:@"蜥蜴戦士（硬）１" H:800 	A:118 	B:80	C:100 	D:30 	S:110
                                 attackBy:0 ImageString:@"dh24.png"],
              [[Enemy alloc] initWithName:@"ゴブリンナイト（強）" H:2500 	A:120 	B:80	C:100 	D:30 	S:120
                                 attackBy:0 ImageString:@"dh05.png"],
              [[Enemy alloc] initWithName:@"蜥蜴戦士（硬）２" H:800 	A:118 	B:80	C:100 	D:30 	S:110
                                 attackBy:0 ImageString:@"dh24.png"],
              nil];
    [arr addObject:subarr];
    
    
    exp = 1740;
    stamina = 10;
    [self setBackgroundInt:14];
}

- (void)dungeon24{
    [self reset];
    NSLog(@"%s 大海の魔物生成", __func__);
    
    // 敵集団1
    NSArray *subarr = [NSArray arrayWithObjects:
                       [[Enemy alloc] initWithName:@"ラッセンのイルカ１" H:500 	A:119 	B:40	C:119 	D:40 	S:118
                                          attackBy:0 ImageString:@"aquatic08.png"],
                       [[Enemy alloc] initWithName:@"ラッセンのイルカ２" H:500 	A:119 	B:40	C:119 	D:40 	S:118
                                          attackBy:0 ImageString:@"aquatic08.png"],
                       [[Enemy alloc] initWithName:@"ラッセンのイルカ３" H:500 	A:119 	B:40	C:119 	D:40 	S:118
                                          attackBy:0 ImageString:@"aquatic08.png"],
                       nil];
    [arr addObject:subarr];
    
    // 敵襲団2
    subarr = [NSArray arrayWithObjects:
              [[Enemy alloc] initWithName:@"ラッセンのイルカ１" H:500 	A:119 	B:40	C:119 	D:40 	S:118
                                 attackBy:0 ImageString:@"aquatic08.png"],
              [[Enemy alloc] initWithName:@"巨大コバンザメ" H:750 	A:119 	B:35	C:95 	D:35 	S:115
                                 attackBy:0 ImageString:@"aquatic07.png"],
              [[Enemy alloc] initWithName:@"ラッセンのイルカ２" H:500 	A:119 	B:40	C:119 	D:40 	S:118
                                 attackBy:0 ImageString:@"aquatic08.png"],
              nil];
    [arr addObject:subarr];
    
    //敵集団3
    subarr = [NSArray arrayWithObjects:
              [[Enemy alloc] initWithName:@"巨大コバンザメ１" H:750 	A:119 	B:35	C:95 	D:35 	S:115
                                 attackBy:0 ImageString:@"aquatic07.png"],
              [[Enemy alloc] initWithName:@"極悪深海魚" H:1000 	A:119 	B:25	C:95 	D:25 	S:110
                                 attackBy:0 ImageString:@"aquatic22.png"],
              [[Enemy alloc] initWithName:@"巨大コバンザメ２" H:750 	A:119 	B:35	C:95 	D:35 	S:115
                                 attackBy:0 ImageString:@"aquatic07.png"],
              nil];
    [arr addObject:subarr];
    //敵集団4
    subarr = [NSArray arrayWithObjects:
              [[Enemy alloc] initWithName:@"極悪深海魚１" H:1000 	A:119 	B:25	C:95 	D:25 	S:110
                                 attackBy:0 ImageString:@"aquatic22.png"],
              [[Enemy alloc] initWithName:@"極悪深海魚２" H:1000 	A:119 	B:25	C:95 	D:25 	S:110
                                 attackBy:0 ImageString:@"aquatic22.png"],
              [[Enemy alloc] initWithName:@"極悪深海魚３" H:1000 	A:119 	B:25	C:95 	D:25 	S:110
                                 attackBy:0 ImageString:@"aquatic22.png"],
              nil];
    [arr addObject:subarr];
    
    //敵集団5
    subarr = [NSArray arrayWithObjects:
              [[Enemy alloc] initWithName:@"極悪深海魚１" H:1000 	A:119 	B:25	C:95 	D:25 	S:110
                                 attackBy:0 ImageString:@"aquatic22.png"],
              [[Enemy alloc] initWithName:@"皇帝シーホース" H:2500 	A:123 	B:40	C:125 	D:40 	S:115
                                 attackBy:1 ImageString:@"monster70.png"],
              [[Enemy alloc] initWithName:@"極悪深海魚２" H:1000 	A:119 	B:25	C:95 	D:25 	S:110
                                 attackBy:0 ImageString:@"aquatic22.png"],
              nil];
    [arr addObject:subarr];
    
    
    exp = 1880;
    stamina = 10;
    [self setBackgroundInt:18];
}

- (void)dungeon25{
    [self reset];
    NSLog(@"%s 大海の深世界生成", __func__);
    
    // 敵集団1
    NSArray *subarr = [NSArray arrayWithObjects:
                       [[Enemy alloc] initWithName:@"墨染めシャーク１" H:650 	A:115   B:50	C:95 	D:50 	S:113
                                          attackBy:0 ImageString:@"aquatic03.png"],
                       [[Enemy alloc] initWithName:@"墨染めシャーク２" H:650 	A:115   B:50	C:95 	D:50 	S:113
                                          attackBy:0 ImageString:@"aquatic03.png"],
                       [[Enemy alloc] initWithName:@"墨染めシャーク３" H:650 	A:115   B:50	C:95 	D:50 	S:113
                                          attackBy:0 ImageString:@"aquatic03.png"],
                       nil];
    [arr addObject:subarr];
    
    // 敵襲団2
    subarr = [NSArray arrayWithObjects:
              [[Enemy alloc] initWithName:@"墨染めシャーク１" H:650 	A:115   B:50	C:95 	D:50 	S:113
                                 attackBy:0 ImageString:@"aquatic03.png"],
              [[Enemy alloc] initWithName:@"未発達人魚" H:750 	A:123   B:50	C:123 	D:50 	S:115
                                 attackBy:1 ImageString:@"aquatic10.png"],
              [[Enemy alloc] initWithName:@"墨染めシャーク２" H:650 	A:115   B:50	C:95 	D:50 	S:113
                                 attackBy:0 ImageString:@"aquatic03.png"],
              nil];
    [arr addObject:subarr];
    
    //敵集団3
    subarr = [NSArray arrayWithObjects:
              [[Enemy alloc] initWithName:@"未発達人魚１" H:750 	A:123   B:50	C:123 	D:50 	S:115
                                 attackBy:1 ImageString:@"aquatic10.png"],
              [[Enemy alloc] initWithName:@"赤ウミヘビ" H:1000 	A:126 	B:35	C:126 	D:35 	S:112
                                 attackBy:1 ImageString:@"monster73.png"],
              [[Enemy alloc] initWithName:@"未発達人魚２" H:750 	A:123   B:50	C:123 	D:50 	S:115
                                 attackBy:1 ImageString:@"aquatic10.png"],
              nil];
    [arr addObject:subarr];
    //敵集団4
    subarr = [NSArray arrayWithObjects:
              [[Enemy alloc] initWithName:@"赤ウミヘビ１" H:1000 	A:126 	B:35	C:126 	D:35 	S:112
                                 attackBy:1 ImageString:@"monster73.png"],
              [[Enemy alloc] initWithName:@"赤ウミヘビ２" H:1000 	A:126 	B:35	C:126 	D:35 	S:112
                                 attackBy:1 ImageString:@"monster73.png"],
              [[Enemy alloc] initWithName:@"赤ウミヘビ３" H:1000 	A:126 	B:35	C:126 	D:35 	S:112
                                 attackBy:1 ImageString:@"monster73.png"],
              nil];
    [arr addObject:subarr];
    
    //敵集団5
    subarr = [NSArray arrayWithObjects:
              [[Enemy alloc] initWithName:@"赤ウミヘビ１" H:1000 	A:126 	B:35	C:126 	D:35 	S:112
                                 attackBy:1 ImageString:@"monster73.png"],
              [[Enemy alloc] initWithName:@"皇帝シーホース" H:2500 	A:128 	B:40	C:125 	D:40 	S:126
                                 attackBy:1 ImageString:@"monster70.png"],
              [[Enemy alloc] initWithName:@"赤ウミヘビ２" H:1000 	A:126 	B:35	C:126 	D:35 	S:112
                                 attackBy:1 ImageString:@"monster73.png"],
              nil];
    [arr addObject:subarr];
    
    
    exp = 2100;
    stamina = 10;
    [self setBackgroundInt:18];
}

- (void)dungeon26{
    [self reset];
    NSLog(@"%s 溟海潜入路生成", __func__);
    
    // 敵集団1
    NSArray *subarr = [NSArray arrayWithObjects:
                       [[Enemy alloc] initWithName:@"墨染めシャーク１" H:650 	A:115   B:50	C:95 	D:50 	S:113
                                          attackBy:0 ImageString:@"aquatic03.png"],
                       [[Enemy alloc] initWithName:@"墨染めシャーク２" H:650 	A:115   B:50	C:95 	D:50 	S:113
                                          attackBy:0 ImageString:@"aquatic03.png"],
                       [[Enemy alloc] initWithName:@"墨染めシャーク３" H:650 	A:115   B:50	C:95 	D:50 	S:113
                                          attackBy:0 ImageString:@"aquatic03.png"],
                       nil];
    [arr addObject:subarr];
    
    // 敵襲団2
    subarr = [NSArray arrayWithObjects:
              [[Enemy alloc] initWithName:@"墨染めシャーク１" H:650 	A:115   B:50	C:95 	D:50 	S:113
                                 attackBy:0 ImageString:@"aquatic03.png"],
              [[Enemy alloc] initWithName:@"極悪深海魚" H:1000 	A:119 	B:25	C:95 	D:25 	S:115
                                 attackBy:0 ImageString:@"aquatic22.png"],
              [[Enemy alloc] initWithName:@"墨染めシャーク２" H:650 	A:115   B:50	C:95 	D:50 	S:113
                                 attackBy:0 ImageString:@"aquatic03.png"],
              nil];
    [arr addObject:subarr];
    
    //敵集団3
    subarr = [NSArray arrayWithObjects:
              [[Enemy alloc] initWithName:@"極悪深海魚１" H:1000 	A:119 	B:25	C:95 	D:25 	S:115
                                 attackBy:0 ImageString:@"aquatic22.png"],
              [[Enemy alloc] initWithName:@"深海の密猟者" H:1200 	A:125 	B:25	C:125 	D:25 	S:125
                                 attackBy:1 ImageString:@"dh25.png"],
              [[Enemy alloc] initWithName:@"極悪深海魚２" H:1000 	A:119 	B:25	C:95 	D:25 	S:115
                                 attackBy:0 ImageString:@"aquatic22.png"],
              nil];
    [arr addObject:subarr];
    //敵集団4
    subarr = [NSArray arrayWithObjects:
              [[Enemy alloc] initWithName:@"深海の密猟者１" H:1200 	A:125 	B:25	C:125 	D:25 	S:125
                                 attackBy:1 ImageString:@"dh25.png"],
              [[Enemy alloc] initWithName:@"深海の密猟者２" H:1200 	A:125 	B:25	C:125 	D:25 	S:125
                                 attackBy:1 ImageString:@"dh25.png"],
              [[Enemy alloc] initWithName:@"深海の密猟者３" H:1200 	A:125 	B:25	C:125 	D:25 	S:125
                                 attackBy:1 ImageString:@"dh25.png"],
              nil];
    [arr addObject:subarr];
    
    //敵集団5
    subarr = [NSArray arrayWithObjects:
              [[Enemy alloc] initWithName:@"深海の密猟者１" H:1200 	A:125 	B:25	C:125 	D:25 	S:125
                                 attackBy:1 ImageString:@"dh25.png"],
              [[Enemy alloc] initWithName:@"溟海に住まう王女" H:3200 	A:135 	B:0	C:135 	D:0 	S:135
                                 attackBy:1 ImageString:@"dh38.png"],
              [[Enemy alloc] initWithName:@"深海の密猟者２" H:1200 	A:125 	B:25	C:125 	D:25 	S:125
                                 attackBy:1 ImageString:@"dh25.png"],
              nil];
    [arr addObject:subarr];
    
    
    exp = 2260;
    stamina = 10;
    [self setBackgroundInt:18];
}

- (void)dungeon27{
    [self reset];
    NSLog(@"芸術の都生成 in Dungeon");
    
    // 敵集団1
    NSArray *subarr = [NSArray arrayWithObjects:
                       [[Enemy alloc] initWithName:@"うごくせきぞう１" H:650 	A:120   B:80	C:95 	D:20 	S:105
                                          attackBy:0 ImageString:@"solid43.png"],
                       [[Enemy alloc] initWithName:@"うごくせきぞう２" H:650 	A:120   B:80	C:95 	D:20 	S:105
                                          attackBy:0 ImageString:@"solid43.png"],
                       [[Enemy alloc] initWithName:@"うごくせきぞう３" H:650 	A:120   B:80	C:95 	D:20 	S:105
                                          attackBy:0 ImageString:@"solid43.png"],
                       nil];
    [arr addObject:subarr];
    
    // 敵襲団2
    subarr = [NSArray arrayWithObjects:
              [[Enemy alloc] initWithName:@"うごくせきぞう１" H:650 	A:120   B:80	C:95 	D:20 	S:105
                                 attackBy:0 ImageString:@"solid43.png"],
              [[Enemy alloc] initWithName:@"水を吐く者" H:800 	A:120   B:70	C:95 	D:30 	S:105
                                 attackBy:0 ImageString:@"solid58.png"],
              [[Enemy alloc] initWithName:@"うごくせきぞう２" H:650 	A:120   B:80	C:95 	D:20 	S:105
                                 attackBy:0 ImageString:@"solid43.png"],
              nil];
    [arr addObject:subarr];
    
    //敵集団3
    subarr = [NSArray arrayWithObjects:
              [[Enemy alloc] initWithName:@"水を吐く者１" H:800 	A:120   B:70	C:95 	D:30 	S:105
                                 attackBy:0 ImageString:@"solid58.png"],
              [[Enemy alloc] initWithName:@"生け贄の祭壇" H:1200 	A:115   B:80	C:125 	D:40 	S:115
                                 attackBy:1 ImageString:@"solid52.png"],
              [[Enemy alloc] initWithName:@"水を吐く者２" H:800 	A:120   B:70	C:95 	D:30 	S:105
                                 attackBy:0 ImageString:@"solid58.png"],
              nil];
    [arr addObject:subarr];
    //敵集団4
    subarr = [NSArray arrayWithObjects:
              [[Enemy alloc] initWithName:@"生け贄の祭壇１" H:1200 	A:115   B:80	C:125 	D:40 	S:115
                                 attackBy:1 ImageString:@"solid52.png"],
              [[Enemy alloc] initWithName:@"生け贄の祭壇２" H:1200 	A:115   B:80	C:125 	D:40 	S:115
                                 attackBy:1 ImageString:@"solid52.png"],
              [[Enemy alloc] initWithName:@"生け贄の祭壇３" H:1200 	A:115   B:80	C:125 	D:40 	S:115
                                 attackBy:1 ImageString:@"solid52.png"],
              nil];
    [arr addObject:subarr];
    
    //敵集団5
    subarr = [NSArray arrayWithObjects:
              [[Enemy alloc] initWithName:@"生け贄の祭壇１" H:1200 	A:115   B:80	C:125 	D:40 	S:115
                                 attackBy:1 ImageString:@"solid52.png"],
              [[Enemy alloc] initWithName:@"至高の芸術品" H:3200 	A:115   B:60	C:135 	D:60 	S:125
                                 attackBy:1 ImageString:@"solid44.png"],
              [[Enemy alloc] initWithName:@"生け贄の祭壇２" H:1200 	A:115   B:80	C:125 	D:40 	S:115
                                 attackBy:1 ImageString:@"solid52.png"],
              nil];
    [arr addObject:subarr];
    
    
    exp = 2300;
    stamina = 10;
    [self setBackgroundInt:9];
}

- (void)dungeon28{
    [self reset];
    NSLog(@"道化師の住まいし古城生成 in Dungeon");
    
    // 敵集団1
    NSArray *subarr = [NSArray arrayWithObjects:
                       [[Enemy alloc] initWithName:@"時計ウサギ１" H:750 	A:120   B:20	C:95 	D:20 	S:125
                                          attackBy:0 ImageString:@"animal15.png"],
                       [[Enemy alloc] initWithName:@"時計ウサギ２" H:750 	A:120   B:20	C:95 	D:20 	S:125
                                          attackBy:0 ImageString:@"animal15.png"],
                       [[Enemy alloc] initWithName:@"時計ウサギ３" H:750 	A:120   B:20	C:95 	D:20 	S:125
                                          attackBy:0 ImageString:@"animal15.png"],
                       nil];
    [arr addObject:subarr];
    
    // 敵襲団2
    subarr = [NSArray arrayWithObjects:
              [[Enemy alloc] initWithName:@"時計ウサギ１" H:750 	A:120   B:20	C:95 	D:20 	S:125
                                 attackBy:0 ImageString:@"animal15.png"],
              [[Enemy alloc] initWithName:@"道化師パンプキン" H:850 	A:125   B:20	C:125 	D:20 	S:135
                                 attackBy:1 ImageString:@"monster15.png"],
              [[Enemy alloc] initWithName:@"時計ウサギ２" H:750 	A:120   B:20	C:95 	D:20 	S:125
                                 attackBy:0 ImageString:@"animal15.png"],
              nil];
    [arr addObject:subarr];
    
    //敵集団3
    subarr = [NSArray arrayWithObjects:
              [[Enemy alloc] initWithName:@"道化師パンプキン１" H:850 	A:125   B:20	C:125 	D:20 	S:135
                                 attackBy:1 ImageString:@"monster15.png"],
              [[Enemy alloc] initWithName:@"Mr.ノーフェイス" H:1000 	A:130   B:20	C:125 	D:20 	S:120
                                 attackBy:0 ImageString:@"monster32.png"],
              [[Enemy alloc] initWithName:@"道化師パンプキン２" H:850 	A:125   B:20	C:125 	D:20 	S:135
                                 attackBy:1 ImageString:@"monster15.png"],
              nil];
    [arr addObject:subarr];
    //敵集団4
    subarr = [NSArray arrayWithObjects:
              [[Enemy alloc] initWithName:@"Mr.ノーフェイス１" H:1000 	A:130   B:20	C:125 	D:20 	S:120
                                 attackBy:0 ImageString:@"monster32.png"],
              [[Enemy alloc] initWithName:@"Mr.ノーフェイス２" H:1000 	A:130   B:20	C:125 	D:20 	S:120
                                 attackBy:0 ImageString:@"monster32.png"],
              [[Enemy alloc] initWithName:@"Mr.ノーフェイス３" H:1000 	A:130   B:20	C:125 	D:20 	S:120
                                 attackBy:0 ImageString:@"monster32.png"],
              nil];
    [arr addObject:subarr];
    
    //敵集団5
    subarr = [NSArray arrayWithObjects:
              [[Enemy alloc] initWithName:@"道化師パンプキン１" H:850 	A:125   B:20	C:125 	D:20 	S:135
                                 attackBy:1 ImageString:@"monster15.png"],
              [[Enemy alloc] initWithName:@"ツクヨミ" H:3200 	A:130   B:45	C:140 	D:45 	S:125
                                 attackBy:1 ImageString:@"monster135.png"],
              [[Enemy alloc] initWithName:@"道化師パンプキン２" H:850 	A:125   B:20	C:125 	D:20 	S:135
                                 attackBy:1 ImageString:@"monster15.png"],
              nil];
    [arr addObject:subarr];
    
    
    exp = 2300;
    stamina = 10;
    [self setBackgroundInt:9];
}

- (void)dungeon29{
    [self reset];
    NSLog(@"死足の突撃生成 in Dungeon");
    
    // 敵集団1
    NSArray *subarr = [NSArray arrayWithObjects:
                       [[Enemy alloc] initWithName:@"遺伝子組み換え馬１" H:500 	A:125   B:20	C:125 	D:20 	S:128
                                          attackBy:0 ImageString:@"monster45.png"],
                       [[Enemy alloc] initWithName:@"遺伝子組み換え馬２" H:500 	A:125   B:20	C:125 	D:20 	S:128
                                          attackBy:0 ImageString:@"monster45.png"],
                       [[Enemy alloc] initWithName:@"遺伝子組み換え馬３" H:500 	A:125   B:20	C:125 	D:20 	S:128
                                          attackBy:0 ImageString:@"monster45.png"],
                       [[Enemy alloc] initWithName:@"遺伝子組み換え馬４" H:500 	A:125   B:20	C:125 	D:20 	S:128
                                          attackBy:0 ImageString:@"monster45.png"],
                       [[Enemy alloc] initWithName:@"遺伝子組み換え馬５" H:500 	A:125 B:20	C:125 	D:20 	S:128
                                          attackBy:0 ImageString:@"monster45.png"],
                       nil];
    [arr addObject:subarr];
    
    // 敵襲団2
    subarr = [NSArray arrayWithObjects:
              [[Enemy alloc] initWithName:@"猛き一角獣１" H:600 	A:125   B:20	C:95 	D:20 	S:128
                                 attackBy:0 ImageString:@"animal25.png"],
              [[Enemy alloc] initWithName:@"猛き一角獣２" H:600 	A:125   B:20	C:95 	D:20 	S:128
                                 attackBy:0 ImageString:@"animal25.png"],
              [[Enemy alloc] initWithName:@"猛き一角獣３" H:600 	A:125   B:20	C:95 	D:20 	S:128
                                 attackBy:0 ImageString:@"animal25.png"],
              [[Enemy alloc] initWithName:@"猛き一角獣４" H:600 	A:125   B:20	C:95 	D:20 	S:128
                                 attackBy:0 ImageString:@"animal25.png"],
              nil];
    [arr addObject:subarr];
    
    //敵集団3
    subarr = [NSArray arrayWithObjects:
              [[Enemy alloc] initWithName:@"鹿毛ケンタウルス１" H:850 	A:125   B:20	C:128 	D:20 	S:130
                                 attackBy:1 ImageString:@"dh17.png"],
              [[Enemy alloc] initWithName:@"鹿毛ケンタウルス２" H:850 	A:125   B:20	C:128 	D:20 	S:130
                                 attackBy:1 ImageString:@"dh17.png"],
              [[Enemy alloc] initWithName:@"鹿毛ケンタウルス３" H:850 	A:125   B:20	C:128 	D:20 	S:130
                                 attackBy:1 ImageString:@"dh17.png"],
              nil];
    [arr addObject:subarr];
    //敵集団4
    subarr = [NSArray arrayWithObjects:
              [[Enemy alloc] initWithName:@"骸骨の騎士１" H:1400 	A:130   B:20	C:120 	D:20 	S:130
                                 attackBy:0 ImageString:@"undead07.png"],
              [[Enemy alloc] initWithName:@"骸骨の騎士２" H:1400 	A:130   B:20	C:120 	D:20 	S:130
                                 attackBy:0 ImageString:@"undead07.png"],
              [[Enemy alloc] initWithName:@"骸骨の騎士３" H:1400 	A:130   B:20	C:120 	D:20 	S:130
                                 attackBy:0 ImageString:@"undead07.png"],
              nil];
    [arr addObject:subarr];
    
    //敵集団5
    subarr = [NSArray arrayWithObjects:
              [[Enemy alloc] initWithName:@"骸骨の騎士１" H:1400 	A:130   B:20	C:120 	D:20 	S:130
                                 attackBy:0 ImageString:@"undead07.png"],
              [[Enemy alloc] initWithName:@"死を駆る死神" H:3500 	A:133   B:20	C:140 	D:20 	S:132
                                 attackBy:1 ImageString:@"spirit12.png"],
              [[Enemy alloc] initWithName:@"骸骨の騎士２" H:1400 	A:130   B:20	C:120 	D:20 	S:130
                                 attackBy:0 ImageString:@"undead07.png"],
              nil];
    [arr addObject:subarr];
    
    
    exp = 2500;
    stamina = 13;
    [self setBackgroundInt:11];
}

- (void)dungeon30{
    [self reset];
    NSLog(@"妖怪の使役者生成 in Dungeon");
    
    // 敵集団1
    NSArray *subarr = [NSArray arrayWithObjects:
                       [[Enemy alloc] initWithName:@"火装毛蟹１" H:700 	A:100   B:20	C:125 	D:200 	S:120
                                          attackBy:1 ImageString:@"spirit69.png"],
                       [[Enemy alloc] initWithName:@"火装毛蟹２" H:700 	A:100   B:20	C:125 	D:200 	S:120
                                          attackBy:1 ImageString:@"spirit69.png"],
                       [[Enemy alloc] initWithName:@"火装毛蟹３" H:700 	A:100   B:20	C:125 	D:200 	S:120
                                          attackBy:1 ImageString:@"spirit69.png"],
                       
                       nil];
    [arr addObject:subarr];
    
    // 敵襲団2
    subarr = [NSArray arrayWithObjects:
              [[Enemy alloc] initWithName:@"塗り壁１"H:700 	A:125   B:200	C:100 	D:20 	S:110
                                 attackBy:0 ImageString:@"spirit27.png"],
              [[Enemy alloc] initWithName:@"ろくろっくび" H:1000 	A:128   B:50	C:100 	D:20 	S:120
                                 attackBy:0 ImageString:@"spirit18.png"],
              [[Enemy alloc] initWithName:@"塗り壁２" H:700 	A:125   B:200	C:100 	D:20 	S:110
                                 attackBy:0 ImageString:@"spirit27.png"],
              nil];
    [arr addObject:subarr];
    
    //敵集団3
    subarr = [NSArray arrayWithObjects:
              [[Enemy alloc] initWithName:@"妖狐１" H:1000 	A:125   B:20	C:135 	D:20 	S:130
                                 attackBy:1 ImageString:@"spirit21.png"],
              [[Enemy alloc] initWithName:@"妖狐２" H:1000 	A:125   B:20	C:135 	D:20 	S:130
                                 attackBy:1 ImageString:@"spirit21.png"],
              [[Enemy alloc] initWithName:@"妖狐３" H:1000 	A:125   B:20	C:135 	D:20 	S:130
                                 attackBy:1 ImageString:@"spirit21.png"],
              nil];
    [arr addObject:subarr];
    //敵集団4
    subarr = [NSArray arrayWithObjects:
              [[Enemy alloc] initWithName:@"アーマーモルド１" H:1500 	A:135   B:20	C:100 	D:20 	S:120
                                 attackBy:0 ImageString:@"monster64.png"],
              [[Enemy alloc] initWithName:@"アーマーモルド２" H:1500 	A:135   B:20	C:100 	D:20 	S:120
                                 attackBy:0 ImageString:@"monster64.png"],
              [[Enemy alloc] initWithName:@"アーマーモルド３" H:1500 	A:135   B:20	C:100 	D:20 	S:120
                                 attackBy:0 ImageString:@"monster64.png"],
              nil];
    [arr addObject:subarr];
    
    //敵集団5
    subarr = [NSArray arrayWithObjects:
              [[Enemy alloc] initWithName:@"火装毛蟹" H:700 	A:100   B:20	C:125 	D:200 	S:120
                                 attackBy:1 ImageString:@"spirit69.png"],
              [[Enemy alloc] initWithName:@"妖怪の使役者" H:3800 	A:145   B:20	C:145 	D:20 	S:110
                                 attackBy:1 ImageString:@"undead27.png"],
              [[Enemy alloc] initWithName:@"塗り壁" H:700 	A:125   B:200	C:100 	D:20 	S:110
                                 attackBy:0 ImageString:@"spirit27.png"],
              nil];
    [arr addObject:subarr];
    
    
    exp = 2600;
    stamina = 13;
    [self setBackgroundInt:10];
}
- (void)dungeon31{
    [self reset];
    NSLog(@"昼と夜生成 in Dungeon");
    
    // 敵集団1
    NSArray *subarr = [NSArray arrayWithObjects:
                       [[Enemy alloc] initWithName:@"リザードマンメイジ１" H:500 	A:100   B:20	C:125 	D:70 	S:123
                                          attackBy:1 ImageString:@"dh27.png"],
                       [[Enemy alloc] initWithName:@"オリエントの使い魔" H:800 	A:100   B:20	C:130 	D:70 	S:126
                                          attackBy:1 ImageString:@"spirit61.png"],
                       [[Enemy alloc] initWithName:@"リザードマンメイジ２" H:500 	A:100   B:20	C:125 	D:70 	S:123
                                          attackBy:1 ImageString:@"dh27.png"],
                       [[Enemy alloc] initWithName:@"リザードマンメイジ３" H:500 	A:100   B:20	C:125 	D:70 	S:123
                                          attackBy:1 ImageString:@"dh27.png"],
                       [[Enemy alloc] initWithName:@"リザードマンメイジ４" H:500 	A:100   B:20	C:125 	D:70 	S:123
                                          attackBy:1 ImageString:@"dh27.png"],
                       nil];
    [arr addObject:subarr];
    
    // 敵襲団2
    subarr = [NSArray arrayWithObjects:
              [[Enemy alloc] initWithName:@"オリエントの使い魔１" H:800 	A:100   B:20	C:130 	D:70 	S:126
                                 attackBy:1 ImageString:@"spirit61.png"],
              [[Enemy alloc] initWithName:@"堕落僧侶" H:1000 	A:100   B:20	C:135 	D:60 	S:132
                                 attackBy:1 ImageString:@"human159.png"],
              [[Enemy alloc] initWithName:@"オリエントの使い魔２" H:800 	A:100   B:20	C:130 	D:70 	S:126
                                 attackBy:1 ImageString:@"spirit61.png"],
              nil];
    [arr addObject:subarr];
    
    //敵集団3
    subarr = [NSArray arrayWithObjects:
              [[Enemy alloc] initWithName:@"堕落僧侶１" H:1000 	A:100   B:20	C:135 	D:60 	S:132
                                 attackBy:1 ImageString:@"human159.png"],
              [[Enemy alloc] initWithName:@"堕落僧侶２" H:1000 	A:100   B:20	C:135 	D:60 	S:132
                                 attackBy:1 ImageString:@"human159.png"],
              [[Enemy alloc] initWithName:@"堕落僧侶３" H:1000 	A:100   B:20	C:135 	D:60 	S:132
                                 attackBy:1 ImageString:@"human159.png"],
              nil];
    [arr addObject:subarr];
    //敵集団4
    subarr = [NSArray arrayWithObjects:
              [[Enemy alloc] initWithName:@"不死の呪術師１" H:1400 	A:130   B:20	C:145 	D:60 	S:132
                                 attackBy:1 ImageString:@"spirit78.png"],
              [[Enemy alloc] initWithName:@"不死の呪術師２" H:1400 	A:130   B:20	C:145 	D:60 	S:132
                                 attackBy:1 ImageString:@"spirit78.png"],
              [[Enemy alloc] initWithName:@"不死の呪術師３" H:1400 	A:130   B:20	C:145 	D:60 	S:132
                                 attackBy:1 ImageString:@"spirit78.png"],
              nil];
    [arr addObject:subarr];
    
    //敵集団5
    subarr = [NSArray arrayWithObjects:
              [[Enemy alloc] initWithName:@"月" H:2000 	A:130   B:20	C:140 	D:60 	S:132
                                 attackBy:1 ImageString:@"solid50.png"],
              [[Enemy alloc] initWithName:@"昼夜の支配者" H:3500 	A:133   B:20	C:145 	D:20 	S:132
                                 attackBy:1 ImageString:@"undead52.png"],
              [[Enemy alloc] initWithName:@"太陽" H:2000 	A:140   B:60	C:130 	D:20 	S:132
                                 attackBy:0 ImageString:@"solid51.png"],
              nil];
    [arr addObject:subarr];
    
    
    exp = 2760;
    stamina = 13;
    [self setBackgroundInt:14];
}
- (void)dungeon32{
    [self reset];
    NSLog(@"機械の行進生成 in Dungeon");
    
    // 敵集団1
    NSArray *subarr = [NSArray arrayWithObjects:
                       [[Enemy alloc] initWithName:@"R-2　1" H:500 	A:100   B:45	C:125 	D:45 	S:132
                                          attackBy:1 ImageString:@"m01.png"],
                       [[Enemy alloc] initWithName:@"R-2　２" H:500 	A:100   B:45	C:125 	D:45 	S:132
                                          attackBy:1 ImageString:@"m01.png"],
                       [[Enemy alloc] initWithName:@"R-2　３" H:500 	A:100   B:45	C:125 	D:45 	S:132
                                          attackBy:1 ImageString:@"m01.png"],
                       [[Enemy alloc] initWithName:@"D-2　1" H:500 	A:125   B:45	C:100 	D:45 	S:132
                                          attackBy:0 ImageString:@"m15.png"],
                       [[Enemy alloc] initWithName:@"D-2　２" H:500 	A:125   B:45	C:100 	D:45 	S:132
                                          attackBy:0 ImageString:@"m15.png"],
                       nil];
    [arr addObject:subarr];
    
    // 敵襲団2
    subarr = [NSArray arrayWithObjects:
              [[Enemy alloc] initWithName:@"Z-38(魔法防御仕様) １" H:600 	A:135   B:15	C:95 	D:200 	S:135
                                 attackBy:0 ImageString:@"m04.png"],
              [[Enemy alloc] initWithName:@"Z-38(魔法防御仕様) ２" H:600 	A:135   B:15	C:95 	D:200 	S:135
                                 attackBy:0 ImageString:@"m04.png"],
              [[Enemy alloc] initWithName:@"Z-38(魔法防御仕様) ３" H:600 	A:135   B:15	C:95 	D:200 	S:135
                                 attackBy:0 ImageString:@"m04.png"],
              [[Enemy alloc] initWithName:@"A-21(物理防御仕様) １" H:600 	A:135   B:200	C:95 	D:15 	S:135
                                 attackBy:0 ImageString:@"m12.png"],
              [[Enemy alloc] initWithName:@"A-21(物理防御仕様) ２" H:600 	A:135   B:200	C:95 	D:15 	S:135
                                 attackBy:0 ImageString:@"m12.png"],
              nil];
    [arr addObject:subarr];
    
    //敵集団3
    subarr = [NSArray arrayWithObjects:
              [[Enemy alloc] initWithName:@"Z-38(魔法防御仕様)" H:600 	A:135   B:15	C:95 	D:200 	S:135
                                 attackBy:0 ImageString:@"m04.png"],
              [[Enemy alloc] initWithName:@"SSS-5" H:850 	A:138   B:60	C:128 	D:60 	S:130
                                 attackBy:0 ImageString:@"m09.png"],
              [[Enemy alloc] initWithName:@"A-21(物理防御仕様)" H:600 	A:135   B:200	C:95 	D:15 	S:135
                                 attackBy:0 ImageString:@"m12.png"],
              
              nil];
    [arr addObject:subarr];
    //敵集団4
    subarr = [NSArray arrayWithObjects:
              [[Enemy alloc] initWithName:@"SSS-5 １" H:850 	A:138   B:60	C:128 	D:60 	S:130
                                 attackBy:0 ImageString:@"m09.png"],
              [[Enemy alloc] initWithName:@"SSS-5 ２" H:850 	A:138   B:60	C:128 	D:60 	S:130
                                 attackBy:0 ImageString:@"m09.png"],
              [[Enemy alloc] initWithName:@"SSS-5 ３" H:850 	A:138   B:60	C:128 	D:60 	S:130
                                 attackBy:0 ImageString:@"m09.png"],
              nil];
    [arr addObject:subarr];
    
    //敵集団5
    subarr = [NSArray arrayWithObjects:
              [[Enemy alloc] initWithName:@"創りし者" H:6000 	A:130   B:30	C:150 	D:30 	S:110
                                 attackBy:1 ImageString:@"dh37.png"],
              nil];
    [arr addObject:subarr];
    
    
    exp = 2800;
    stamina = 13;
    [self setBackgroundInt:14];
}
- (void)dungeon33{
    [self reset];
    NSLog(@"蛮族の住みたる地生成 in Dungeon");
    
    // 敵集団1
    NSArray *subarr = [NSArray arrayWithObjects:
                       [[Enemy alloc] initWithName:@"蛮族のペット１" H:800 	A:125   B:0	C:50 	D:0 	S:135
                                          attackBy:0 ImageString:@"dh28.png"],
                       [[Enemy alloc] initWithName:@"蛮族のならずもの" H:900 	A:125   B:0	C:50 	D:0 	S:135
                                          attackBy:0 ImageString:@"monster60.png"],
                       [[Enemy alloc] initWithName:@"蛮族のペット２" H:800 	A:125   B:0	C:50 	D:0 	S:135
                                          attackBy:0 ImageString:@"dh28.png"],
                       nil];
    [arr addObject:subarr];
    
    // 敵襲団2
    subarr = [NSArray arrayWithObjects:
              [[Enemy alloc] initWithName:@"戦闘君１" H:900 	A:135   B:0	C:95 	D:0 	S:128
                                 attackBy:0 ImageString:@"dh15.png"],
              [[Enemy alloc] initWithName:@"蛮族の尖兵" H:1000 	A:138   B:0	C:95 	D:0 	S:128
                                 attackBy:0 ImageString:@"spirit09.png"],
              [[Enemy alloc] initWithName:@"戦闘君２" H:900 	A:135   B:0	C:95 	D:0 	S:128
                                 attackBy:0 ImageString:@"dh15.png"],
              nil];
    [arr addObject:subarr];
    
    //敵集団3
    subarr = [NSArray arrayWithObjects:
              [[Enemy alloc] initWithName:@"蛮族の強いペット１" H:1000 	A:140   B:0	C:95 	D:0 	S:130
                                 attackBy:0 ImageString:@"dh14.png"],
              [[Enemy alloc] initWithName:@"蛮族の強いペット２" H:1000 	A:140   B:0	C:95 	D:0 	S:130
                                 attackBy:0 ImageString:@"dh14.png"],
              [[Enemy alloc] initWithName:@"蛮族の強いペット３" H:1000 	A:140   B:0	C:95 	D:0 	S:130
                                 attackBy:0 ImageString:@"dh14.png"],
              nil];
    [arr addObject:subarr];
    //敵集団4
    subarr = [NSArray arrayWithObjects:
              [[Enemy alloc] initWithName:@"蛮族の強いペット１" H:1000 	A:140   B:0	C:95 	D:0 	S:130
                                 attackBy:0 ImageString:@"dh14.png"],
              [[Enemy alloc] initWithName:@"蛮族の有力者" H:1200 	A:143   B:0	C:95 	D:0 	S:130
                                 attackBy:0 ImageString:@"human151.png"],
              [[Enemy alloc] initWithName:@"蛮族の強いペット２" H:1000 	A:140   B:0	C:95 	D:0 	S:130
                                 attackBy:0 ImageString:@"dh14.png"],
              nil];
    [arr addObject:subarr];
    
    //敵集団5
    subarr = [NSArray arrayWithObjects:
              [[Enemy alloc] initWithName:@"蛮族の有力者" H:1200 	A:143   B:0	C:95 	D:0 	S:130
                                 attackBy:0 ImageString:@"human151.png"],
              [[Enemy alloc] initWithName:@"蛮族の酋長" H:4000 	A:148   B:0	C:148 	D:0 	S:130
                                 attackBy:1 ImageString:@"human199.png"],
              [[Enemy alloc] initWithName:@"蛮族の有力者" H:1200 	A:143   B:0	C:95 	D:0 	S:130
                                 attackBy:0 ImageString:@"human151.png"],
              nil];
    [arr addObject:subarr];
    
    
    exp = 2840;
    stamina = 13;
    [self setBackgroundInt:3];
}
- (void)dungeon34{
    [self reset];
    NSLog(@"奇怪生物の群れ生成 in Dungeon");
    
    // 敵集団1
    NSArray *subarr = [NSArray arrayWithObjects:
                       [[Enemy alloc] initWithName:@"狂乱テリア１" H:700 	A:133   B:0	C:125 	D:0 	S:138
                                          attackBy:0 ImageString:@"spirit80.png"],
                       [[Enemy alloc] initWithName:@"拳闘カンガルー" H:800 	A:140   B:0	C:125 	D:0 	S:135
                                          attackBy:0 ImageString:@"animal32.png"],
                       [[Enemy alloc] initWithName:@"狂乱テリア２" H:700 	A:133   B:0	C:125 	D:0 	S:138
                                          attackBy:0 ImageString:@"spirit80.png"],
                       [[Enemy alloc] initWithName:@"狂乱テリア３" H:700 	A:133   B:0	C:125 	D:0 	S:138
                                          attackBy:0 ImageString:@"spirit80.png"],
                       [[Enemy alloc] initWithName:@"狂乱テリア４" H:700 	A:133   B:0	C:125 	D:0 	S:138
                                          attackBy:0 ImageString:@"spirit80.png"],
                       nil];
    [arr addObject:subarr];
    
    // 敵襲団2
    subarr = [NSArray arrayWithObjects:
              [[Enemy alloc] initWithName:@"空飛竜１" H:800 	A:140   B:0	C:140 	D:0 	S:145
                                 attackBy:1 ImageString:@"monster57.png"],
              [[Enemy alloc] initWithName:@"未発達な馬" H:1200 	A:120   B:0	C:140 	D:0 	S:135
                                 attackBy:1 ImageString:@"monster45.png"],
              [[Enemy alloc] initWithName:@"空飛竜２" H:800 	A:140   B:0	C:140 	D:0 	S:145
                                 attackBy:1 ImageString:@"monster57.png"],
              nil];
    [arr addObject:subarr];
    
    //敵集団3
    subarr = [NSArray arrayWithObjects:
              [[Enemy alloc] initWithName:@"未発達な馬１" H:1200 	A:120   B:0	C:140 	D:0 	S:135
                                 attackBy:1 ImageString:@"monster45.png"],
              [[Enemy alloc] initWithName:@"ハウンドドッグ" H:1300 	A:143   B:0	C:120 	D:0 	S:140
                                 attackBy:0 ImageString:@"monster09.png"],
              [[Enemy alloc] initWithName:@"未発達な馬２" H:1200 	A:120   B:0	C:140 	D:0 	S:135
                                 attackBy:1 ImageString:@"monster45.png"],
              nil];
    [arr addObject:subarr];
    //敵集団4
    subarr = [NSArray arrayWithObjects:
              [[Enemy alloc] initWithName:@"コドモオオトカゲ１" H:1400 	A:145   B:20	C:120 	D:20 	S:130
                                 attackBy:0 ImageString:@"monster109.png"],
              [[Enemy alloc] initWithName:@"コドモオオトカゲ２" H:1400 	A:145   B:20	C:120 	D:20 	S:130
                                 attackBy:0 ImageString:@"monster109.png"],
              [[Enemy alloc] initWithName:@"コドモオオトカゲ３" H:1400 	A:145   B:20	C:120 	D:20 	S:130
                                 attackBy:0 ImageString:@"monster109.png"],
              nil];
    [arr addObject:subarr];
    
    //敵集団5
    subarr = [NSArray arrayWithObjects:
              [[Enemy alloc] initWithName:@"隔世遺伝アルマジロ１" H:1400 	A:145  B:20	C:120 	D:20 	S:130
                                 attackBy:0 ImageString:@"monster90.png"],
              [[Enemy alloc] initWithName:@"ゴリラの酋長" H:3500 	A:150   B:20	C:133 	D:20 	S:138
                                 attackBy:0 ImageString:@"animal16.png"],
              [[Enemy alloc] initWithName:@"隔世遺伝アルマジロ２" H:1400 	A:145  B:20	C:120 	D:20 	S:130
                                 attackBy:0 ImageString:@"monster90.png"],
              nil];
    [arr addObject:subarr];
    
    
    exp = 3080;
    stamina = 13
    ;
    [self setBackgroundInt:2];
}
- (void)dungeon35{
    [self reset];
    NSLog(@"巨顔の信奉者生成 in Dungeon");
    
    // 敵集団1
    NSArray *subarr = [NSArray arrayWithObjects:
                       [[Enemy alloc] initWithName:@"水に潜む貝竜１" H:650 	A:130   B:80	C:125 	D:60 	S:128
                                          attackBy:0 ImageString:@"spirit82.png"],
                       [[Enemy alloc] initWithName:@"水に潜む貝竜２" H:650 	A:130   B:80	C:125 	D:60 	S:128
                                          attackBy:0 ImageString:@"spirit82.png"],
                       [[Enemy alloc] initWithName:@"水に潜む貝竜３" H:650 	A:130   B:80	C:125 	D:60 	S:128
                                          attackBy:0 ImageString:@"spirit82.png"],
                       [[Enemy alloc] initWithName:@"緑の潜水者１" H:800 	A:135   B:25	C:125 	D:25 	S:135
                                          attackBy:0 ImageString:@"dh35.png"],
                       [[Enemy alloc] initWithName:@"緑の潜水者２" H:800 	A:135   B:25	C:125 	D:25 	S:135
                                          attackBy:0 ImageString:@"dh35.png"],
                       nil];
    [arr addObject:subarr];
    
    // 敵襲団2
    subarr = [NSArray arrayWithObjects:
              [[Enemy alloc] initWithName:@"ピッグメイジ１" H:800 	A:125   B:20	C:135 	D:80 	S:138
                                 attackBy:1 ImageString:@"dh33.png"],
              [[Enemy alloc] initWithName:@"ピッグメイジ２" H:800 	A:125   B:20	C:135 	D:80 	S:138
                                 attackBy:1 ImageString:@"dh33.png"],
              [[Enemy alloc] initWithName:@"ピッグメイジ３" H:800 	A:125   B:20	C:135 	D:80 	S:138
                                 attackBy:1 ImageString:@"dh33.png"],
              nil];
    [arr addObject:subarr];
    
    //敵集団3
    subarr = [NSArray arrayWithObjects:
              [[Enemy alloc] initWithName:@"リザードマンメイジ１" H:900 	A:125   B:20	C:138 	D:80 	S:138
                                 attackBy:1 ImageString:@"dh27.png"],
              [[Enemy alloc] initWithName:@"リザードマンメイジ２" H:900 	A:125   B:20	C:138 	D:80 	S:138
                                 attackBy:1 ImageString:@"dh27.png"],
              [[Enemy alloc] initWithName:@"リザードマンメイジ３" H:900 	A:125   B:20	C:138 	D:80 	S:138
                                 attackBy:1 ImageString:@"dh27.png"],
              nil];
    [arr addObject:subarr];
    //敵集団4
    subarr = [NSArray arrayWithObjects:
              [[Enemy alloc] initWithName:@"スライムクイーン１" H:1200 	A:130   B:20	C:145 	D:80 	S:138
                                 attackBy:1 ImageString:@"monster38.png"],
              [[Enemy alloc] initWithName:@"スライムクイーン２" H:1200 	A:130   B:20	C:145 	D:80 	S:138
                                 attackBy:1 ImageString:@"monster38.png"],
              [[Enemy alloc] initWithName:@"スライムクイーン３" H:1200 	A:130   B:20	C:145 	D:80 	S:138
                                 attackBy:1 ImageString:@"monster38.png"],
              nil];
    [arr addObject:subarr];
    
    //敵集団5
    subarr = [NSArray arrayWithObjects:
              [[Enemy alloc] initWithName:@"闇の信奉者１" H:1400 	A:130   B:20	C:145 	D:50 	S:140
                                 attackBy:1 ImageString:@"undead18.png"],
              [[Enemy alloc] initWithName:@"魔力の巨顔" H:3800 	A:133   B:40	C:152 	D:40 	S:132
                                 attackBy:1 ImageString:@"undead17.png"],
              [[Enemy alloc] initWithName:@"闇の信奉者２" H:1400 	A:130   B:20	C:145 	D:50 	S:140
                                 attackBy:1 ImageString:@"undead18.png"],
              nil];
    [arr addObject:subarr];
    
    
    exp = 3120;
    stamina = 13;
    [self setBackgroundInt:10];
}

- (void)dungeon36{
    [self reset];
    NSLog(@"魔法煌夜祭生成 in Dungeon");
    
    // 敵集団1
    NSArray *subarr = [NSArray arrayWithObjects:
                       [[Enemy alloc] initWithName:@"魔に取り憑かれし者１" H:1000 	A:100   B:20	C:135 	D:20 	S:138
                                          attackBy:1 ImageString:@"human04.png"],
                       [[Enemy alloc] initWithName:@"魔に取り憑かれし者２" H:1000 	A:100   B:20	C:135 	D:20 	S:138
                                          attackBy:1 ImageString:@"human04.png"],
                       [[Enemy alloc] initWithName:@"魔に取り憑かれし者３" H:1000 	A:100   B:20	C:135 	D:20 	S:138
                                          attackBy:1 ImageString:@"human04.png"],
                       nil];
    [arr addObject:subarr];
    
    // 敵襲団2
    subarr = [NSArray arrayWithObjects:
              [[Enemy alloc] initWithName:@"魔に取り憑かれし者１" H:1000 	A:100   B:20	C:135 	D:20 	S:138
                                 attackBy:1 ImageString:@"human04.png"],
              [[Enemy alloc] initWithName:@"オリエントの使い魔" H:1200 	A:100   B:20	C:140 	D:20 	S:142
                                 attackBy:1 ImageString:@"spirit61.png"],
              [[Enemy alloc] initWithName:@"魔に取り憑かれし者２" H:1000 	A:100   B:20	C:135 	D:20 	S:138
                                 attackBy:1 ImageString:@"human04.png"],
              nil];
    [arr addObject:subarr];
    
    //敵集団3
    subarr = [NSArray arrayWithObjects:
              [[Enemy alloc] initWithName:@"オリエントの使い魔１" H:1200 	A:100   B:20	C:140 	D:20 	S:142
                                 attackBy:1 ImageString:@"spirit61.png"],
              [[Enemy alloc] initWithName:@"落陽の女王" H:1350 	A:100   B:20	C:150 	D:20 	S:145
                                 attackBy:1 ImageString:@"spirit14.png"],
              [[Enemy alloc] initWithName:@"オリエントの使い魔２" H:1200 	A:100   B:20	C:140 	D:20 	S:142
                                 attackBy:1 ImageString:@"spirit61.png"],
              nil];
    [arr addObject:subarr];
    //敵集団4
    subarr = [NSArray arrayWithObjects:
              [[Enemy alloc] initWithName:@"落陽の女王" H:1350 	A:100   B:20	C:150 	D:20 	S:145
                                 attackBy:1 ImageString:@"spirit14.png"],
              [[Enemy alloc] initWithName:@"落陽の女王" H:1350 	A:100   B:20	C:150 	D:20 	S:145
                                 attackBy:1 ImageString:@"spirit14.png"],
              [[Enemy alloc] initWithName:@"落陽の女王" H:1350 	A:100   B:20	C:150 	D:20 	S:145
                                 attackBy:1 ImageString:@"spirit14.png"],
              nil];
    [arr addObject:subarr];
    
    //敵集団5
    subarr = [NSArray arrayWithObjects:
              [[Enemy alloc] initWithName:@"妖怪の使役者１" H:1400 	A:130   B:20	C:160 	D:20 	S:150
                                 attackBy:1 ImageString:@"undead27.png"],
              [[Enemy alloc] initWithName:@"バルトロメオ" H:4000 	A:133   B:0	C:165 	D:0 	S:155
                                 attackBy:1 ImageString:@"m18.png"],
              [[Enemy alloc] initWithName:@"妖怪の使役者２" H:1400 	A:130   B:20	C:160 	D:20 	S:150
                                 attackBy:1 ImageString:@"undead27.png"],
              nil];
    [arr addObject:subarr];
    
    
    exp = 3320;
    stamina = 15;
    [self setBackgroundInt:13];
}

- (void)dungeon37{
    [self reset];
    NSLog(@"閻魔王女の下僕達生成 in Dungeon");
    
    // 敵集団1
    NSArray *subarr = [NSArray arrayWithObjects:
                       [[Enemy alloc] initWithName:@"空飛竜１" H:800 	A:100   B:20	C:142 	D:20 	S:155
                                          attackBy:1 ImageString:@"monster57.png"],
                       [[Enemy alloc] initWithName:@"空飛竜２" H:800 	A:100   B:20	C:142 	D:20 	S:155
                                          attackBy:1 ImageString:@"monster57.png"],
                       [[Enemy alloc] initWithName:@"空飛竜３" H:800 	A:100   B:20	C:142 	D:20 	S:155
                                          attackBy:1 ImageString:@"monster57.png"],
                       nil];
    [arr addObject:subarr];
    
    // 敵襲団2
    subarr = [NSArray arrayWithObjects:
              [[Enemy alloc] initWithName:@"地飛竜１" H:800 	A:142   B:20	C:100 	D:20 	S:155
                                 attackBy:0 ImageString:@"monster103.png"],
              [[Enemy alloc] initWithName:@"地飛竜２" H:800 	A:142   B:20	C:100 	D:20 	S:155
                                 attackBy:0 ImageString:@"monster103.png"],
              [[Enemy alloc] initWithName:@"地飛竜３" H:800 	A:142   B:20	C:100 	D:20 	S:155
                                 attackBy:0 ImageString:@"monster103.png"],
              nil];
    [arr addObject:subarr];
    
    //敵集団3
    subarr = [NSArray arrayWithObjects:
              [[Enemy alloc] initWithName:@"天使ベビー１" H:900 	A:145   B:20	C:130 	D:20 	S:140
                                 attackBy:0 ImageString:@"monster107.png"],
              [[Enemy alloc] initWithName:@"ケルベロス" H:900 	A:130   B:20	C:145 	D:20 	S:140
                                 attackBy:1 ImageString:@"monster107.png"],
              [[Enemy alloc] initWithName:@"天使ベビー２" H:900 	A:145   B:20	C:130 	D:20 	S:140
                                 attackBy:0 ImageString:@"monster107.png"],
              nil];
    [arr addObject:subarr];
    //敵集団4
    subarr = [NSArray arrayWithObjects:
              [[Enemy alloc] initWithName:@"狂乱テリア１" H:1000 	A:147   B:20	C:120 	D:20 	S:142
                                 attackBy:0 ImageString:@"spirit80.png"],
              [[Enemy alloc] initWithName:@"ケルベロス" H:900 	A:130   B:20	C:150 	D:20 	S:140
                                 attackBy:1 ImageString:@"monster24.png"],
              [[Enemy alloc] initWithName:@"狂乱テリア２" H:1000 	A:147   B:20	C:120 	D:20 	S:142
                                 attackBy:0 ImageString:@"spirit80.png"],
              nil];
    [arr addObject:subarr];
    
    //敵集団5
    subarr = [NSArray arrayWithObjects:
              [[Enemy alloc] initWithName:@"ポイズンガーゴイル１" H:1200 	A:152   B:200	C:120 	D:20 	S:150
                                 attackBy:0 ImageString:@"monster28.png"],
              [[Enemy alloc] initWithName:@"黒天使" H:4000 	A:163   B:0	C:163 	D:0 	S:148
                                 attackBy:0 ImageString:@"spirit35.png"],
              [[Enemy alloc] initWithName:@"ポイズンガーゴイル２" H:1200 	A:152   B:200	C:120 	D:20 	S:150
                                 attackBy:0 ImageString:@"monster28.png"],
              nil];
    [arr addObject:subarr];
    
    
    exp = 3400;
    stamina = 15;
    [self setBackgroundInt:11];
}

- (void)dungeon38{
    [self reset];
    NSLog(@"劇薬指定の森生成 in Dungeon");
    
    // 敵集団1
    NSArray *subarr = [NSArray arrayWithObjects:
                       [[Enemy alloc] initWithName:@"繁茂１" H:1000 	A:100   B:20	C:145 	D:20 	S:135
                                          attackBy:1 ImageString:@"plant06.png"],
                       [[Enemy alloc] initWithName:@"巨大樹" H:1000 	A:135   B:20	C:145 	D:20 	S:130
                                          attackBy:0 ImageString:@"plant04.png"],
                       [[Enemy alloc] initWithName:@"繁茂２" H:1000 	A:100   B:20	C:145 	D:20 	S:135
                                          attackBy:1 ImageString:@"plant06.png"],
                       nil];
    [arr addObject:subarr];
    
    // 敵襲団2
    subarr = [NSArray arrayWithObjects:
              [[Enemy alloc] initWithName:@"巨大樹" H:1000 	A:147   B:20	C:135 	D:20 	S:130
                                 attackBy:0 ImageString:@"plant04.png"],
              [[Enemy alloc] initWithName:@"樹木寄生患者" H:1200 	A:135   B:20	C:152 	D:20 	S:145
                                 attackBy:1 ImageString:@"monster128.png"],
              [[Enemy alloc] initWithName:@"巨大樹" H:1000 	A:147   B:20	C:135 	D:20 	S:130
                                 attackBy:0 ImageString:@"plant04.png"],
              nil];
    [arr addObject:subarr];
    
    //敵集団3
    subarr = [NSArray arrayWithObjects:
              [[Enemy alloc] initWithName:@"樹木寄生患者１" H:1200 	A:135   B:20	C:152 	D:20 	S:145
                                 attackBy:1 ImageString:@"monster128.png"],
              [[Enemy alloc] initWithName:@"レッドエッグ" H:1600 	A:135   B:0	C:158 	D:0 	S:135
                                 attackBy:1 ImageString:@"monster101.png"],
              [[Enemy alloc] initWithName:@"樹木寄生患者２" H:1200 	A:135   B:20	C:152 	D:20 	S:145
                                 attackBy:1 ImageString:@"monster128.png"],
              nil];
    [arr addObject:subarr];
    //敵集団4
    subarr = [NSArray arrayWithObjects:
              [[Enemy alloc] initWithName:@"血を吸い取りし者" H:5000 	A:155   B:20	C:145 	D:20 	S:140
                                 attackBy:0 ImageString:@"monster53.png"],
              nil];
    [arr addObject:subarr];
    
    //敵集団5
    subarr = [NSArray arrayWithObjects:
              [[Enemy alloc] initWithName:@"レッドエッグ１" H:1600 	A:135   B:0	C:158 	D:0 	S:135
                                 attackBy:1 ImageString:@"monster101.png"],
              [[Enemy alloc] initWithName:@"妖樹アルラウネ" H:4500 	A:135   B:0	C:160 	D:0 	S:148
                                 attackBy:1 ImageString:@"dh06.png"],
              [[Enemy alloc] initWithName:@"レッドエッグ２" H:1600 	A:135   B:0	C:158 	D:0 	S:135
                                 attackBy:1 ImageString:@"monster101.png"],
              nil];
    [arr addObject:subarr];
    
    
    exp = 3440;
    stamina = 15;
    [self setBackgroundInt:2];
}

- (void)dungeon39{
    [self reset];
    NSLog(@"赤巨人の西伐生成 in Dungeon");
    
    // 敵集団1
    NSArray *subarr = [NSArray arrayWithObjects:
                       [[Enemy alloc] initWithName:@"ピッグメイジ１" H:800 	A:100   B:20	C:145 	D:60 	S:148
                                          attackBy:1 ImageString:@"dh33.png"],
                       [[Enemy alloc] initWithName:@"戦闘君" H:1000 	A:145   B:60	C:120 	D:20 	S:152
                                          attackBy:0 ImageString:@"dh15.png"],
                       [[Enemy alloc] initWithName:@"ピッグメイジ２" H:800 	A:100   B:20	C:145 	D:20 	S:148
                                          attackBy:1 ImageString:@"dh33.png"],
                       nil];
    [arr addObject:subarr];
    
    // 敵襲団2
    subarr = [NSArray arrayWithObjects:
              [[Enemy alloc] initWithName:@"戦闘君１" H:1000 	A:145   B:60	C:120 	D:20 	S:152
                                 attackBy:0 ImageString:@"dh15.png"],
              [[Enemy alloc] initWithName:@"蛮族の尖兵" H:1250 	A:148   B:40	C:120 	D:40  S:158
                                 attackBy:0 ImageString:@"spirit09.png"],
              [[Enemy alloc] initWithName:@"戦闘君２" H:1000 	A:145   B:60	C:120 	D:20 	S:152
                                 attackBy:0 ImageString:@"dh15.png"],
              nil];
    [arr addObject:subarr];
    
    //敵集団3
    subarr = [NSArray arrayWithObjects:
              [[Enemy alloc] initWithName:@"ミノタウロスの王１" H:1400 	A:152 B:20	C:138 	D:20 	S:152
                                 attackBy:0 ImageString:@"dh09.png"],
              [[Enemy alloc] initWithName:@"ミノタウロスの王２" H:1400 	A:152   B:20	C:138 	D:20 	S:152
                                 attackBy:0 ImageString:@"dh09.png"],
              [[Enemy alloc] initWithName:@"ミノタウロスの王３" H:1400 	A:152   B:20	C:138 	D:20 	S:152
                                 attackBy:0 ImageString:@"dh09.png"],
              nil];
    [arr addObject:subarr];
    //敵集団4
    subarr = [NSArray arrayWithObjects:
              [[Enemy alloc] initWithName:@"文化を破壊する者１" H:1400 	A:130   B:20	C:152 	D:20 	S:152
                                 attackBy:1 ImageString:@"monster118.png"],
              [[Enemy alloc] initWithName:@"文化を破壊する者２" H:1400 	A:130   B:20	C:152 	D:20 	S:152
                                 attackBy:1 ImageString:@"monster118.png"],
              [[Enemy alloc] initWithName:@"文化を破壊する者３" H:1400 	A:130   B:20	C:152 	D:20 	S:152
                                 attackBy:1 ImageString:@"monster118.png"],
              nil];
    [arr addObject:subarr];
    
    //敵集団5
    subarr = [NSArray arrayWithObjects:
              [[Enemy alloc] initWithName:@"赤鬼１" H:1400 	A:158   B:20	C:145 	D:20 	S:145
                                 attackBy:0 ImageString:@"spirit22.png"],
              [[Enemy alloc] initWithName:@"赤巨人" H:5000 	A:170   B:20	C:145 	D:20 	S:150
                                 attackBy:0 ImageString:@"dh01.png"],
              [[Enemy alloc] initWithName:@"赤鬼２" H:1400 	A:158   B:20	C:145 	D:20 	S:145
                                 attackBy:0 ImageString:@"spirit22.png"],
              nil];
    [arr addObject:subarr];
    
    
    exp = 3600;
    stamina = 25;
    [self setBackgroundInt:4];
}

- (void)dungeon40{
    [self reset];
    NSLog(@"青巨人の東征生成 in Dungeon");
    
    // 敵集団1
    NSArray *subarr = [NSArray arrayWithObjects:
                       [[Enemy alloc] initWithName:@"ピッグメイジ１" H:800 	A:100   B:20	C:145 	D:60 	S:148
                                          attackBy:1 ImageString:@"dh33.png"],
                       [[Enemy alloc] initWithName:@"戦闘君" H:1000 	A:145   B:60	C:120 	D:20 	S:152
                                          attackBy:0 ImageString:@"dh15.png"],
                       [[Enemy alloc] initWithName:@"ピッグメイジ２" H:800 	A:100   B:20	C:145 	D:20 	S:148
                                          attackBy:1 ImageString:@"dh33.png"],
                       nil];
    [arr addObject:subarr];
    
    // 敵襲団2
    subarr = [NSArray arrayWithObjects:
              [[Enemy alloc] initWithName:@"戦闘君１" H:1000 	A:145   B:60	C:120 	D:20 	S:152
                                 attackBy:0 ImageString:@"dh15.png"],
              [[Enemy alloc] initWithName:@"蛮族の尖兵" H:1250 	A:148   B:40	C:120 	D:40  S:158
                                 attackBy:0 ImageString:@"spirit09.png"],
              [[Enemy alloc] initWithName:@"戦闘君２" H:1000 	A:145   B:60	C:120 	D:20 	S:152
                                 attackBy:0 ImageString:@"dh15.png"],
              nil];
    [arr addObject:subarr];
    
    //敵集団3
    subarr = [NSArray arrayWithObjects:
              [[Enemy alloc] initWithName:@"ミノタウロスの王１" H:1400 	A:152 B:20	C:138 	D:20 	S:152
                                 attackBy:0 ImageString:@"dh09.png"],
              [[Enemy alloc] initWithName:@"ミノタウロスの王２" H:1400 	A:152   B:20	C:138 	D:20 	S:152
                                 attackBy:0 ImageString:@"dh09.png"],
              [[Enemy alloc] initWithName:@"ミノタウロスの王３" H:1400 	A:152   B:20	C:138 	D:20 	S:152
                                 attackBy:0 ImageString:@"dh09.png"],
              nil];
    [arr addObject:subarr];
    //敵集団4
    subarr = [NSArray arrayWithObjects:
              [[Enemy alloc] initWithName:@"文化を破壊する者１" H:1400 	A:130   B:20	C:152 	D:20 	S:152
                                 attackBy:1 ImageString:@"monster118.png"],
              [[Enemy alloc] initWithName:@"文化を破壊する者２" H:1400 	A:130   B:20	C:152 	D:20 	S:152
                                 attackBy:1 ImageString:@"monster118.png"],
              [[Enemy alloc] initWithName:@"文化を破壊する者３" H:1400 	A:130   B:20	C:152 	D:20 	S:152
                                 attackBy:1 ImageString:@"monster118.png"],
              nil];
    [arr addObject:subarr];
    
    //敵集団5
    subarr = [NSArray arrayWithObjects:
              [[Enemy alloc] initWithName:@"赤鬼１" H:1400 	A:158   B:20	C:145 	D:20 	S:145
                                 attackBy:0 ImageString:@"spirit22.png"],
              [[Enemy alloc] initWithName:@"青巨人" H:5000 	A:145   B:20	C:170 	D:20 	S:150
                                 attackBy:0 ImageString:@"dh03.png"],
              [[Enemy alloc] initWithName:@"赤鬼２" H:1400 	A:158   B:20	C:145 	D:20 	S:145
                                 attackBy:0 ImageString:@"spirit22.png"],
              nil];
    [arr addObject:subarr];
    
    exp = 3600;
    stamina = 25;
    [self setBackgroundInt:4];
}

- (void)dungeon41{
    [self reset];
    NSLog(@"%s 世界を統べる双火竜生成", __func__);
    
    // 敵集団1
    NSArray *subarr = [NSArray arrayWithObjects:
                       [[Enemy alloc] initWithName:@"完全勝利するユニコーン１" H:1800 	A:155   B:50	C:155 	D:50 	S:165
                                          attackBy:1 ImageString:@"monster27.png"],
                       [[Enemy alloc] initWithName:@"完全勝利するユニコーン２" H:1800 	A:155   B:50	C:155 	D:50 	S:165                                       attackBy:1 ImageString:@"monster27.png"],
                       [[Enemy alloc] initWithName:@"完全勝利するユニコーン３" H:1800 	A:155   B:50	C:155 	D:50 	S:165                                       attackBy:1 ImageString:@"monster27.png"],
                       nil];
    [arr addObject:subarr];
    
    // 敵襲団2
    subarr = [NSArray arrayWithObjects:
              [[Enemy alloc] initWithName:@"黄金子ドラゴン" H:2000 	A:156   B:40	C:156 	D:40 	S:155
                                 attackBy:1 ImageString:@"monster63.png"],
              [[Enemy alloc] initWithName:@"古代竜" H:2200 	A:160   B:40	C:95 	D:40 	S:150
                                 attackBy:0 ImageString:@"animal29.png"],
              [[Enemy alloc] initWithName:@"黄金子ドラゴン" H:2000 	A:156   B:40	C:156 	D:40 	S:155
                                 attackBy:1 ImageString:@"monster63.png"],
              nil];
    [arr addObject:subarr];
    
    //敵集団3
    subarr = [NSArray arrayWithObjects:
              [[Enemy alloc] initWithName:@"紅玉竜１" H:2000 	A:157 	B:40	C:157 	D:40 	S:160
                                 attackBy:1 ImageString:@"monster44.png"],
              [[Enemy alloc] initWithName:@"紅玉竜２" H:2000 	A:157 	B:40	C:157 	D:40 	S:160
                                 attackBy:1 ImageString:@"monster44.png"],
              [[Enemy alloc] initWithName:@"紅玉竜３" H:2000 	A:157 	B:40	C:157 	D:40 	S:160
                                 attackBy:1 ImageString:@"monster44.png"],
              nil];
    [arr addObject:subarr];
    //敵集団4
    subarr = [NSArray arrayWithObjects:
              [[Enemy alloc] initWithName:@"緑毒竜１" H:2400 	A:158 	B:40	C:125 	D:40 	S:158
                                 attackBy:0 ImageString:@"dh12.png"],
              [[Enemy alloc] initWithName:@"緑毒竜２" H:2400 	A:158 	B:40	C:125 	D:40 	S:158
                                 attackBy:0 ImageString:@"dh12.png"],
              [[Enemy alloc] initWithName:@"緑毒竜３" H:2400 	A:158 	B:40	C:125 	D:40 	S:158
                                 attackBy:0 ImageString:@"dh12.png"],
              nil];
    [arr addObject:subarr];
    
    //敵集団5
    subarr = [NSArray arrayWithObjects:
              [[Enemy alloc] initWithName:@"赤竜王" H:4000 	A:180 	B:80	C:125 	D:80 	S:165
                                 attackBy:0 ImageString:@"monster08.png"],
              [[Enemy alloc] initWithName:@"青竜王" H:4000 	A:125 	B:80	C:180 	D:80 	S:165
                                 attackBy:1 ImageString:@"monster04.png"],
              nil];
    [arr addObject:subarr];
    
    
    exp = 6000;
    stamina = 25;
    [self setBackgroundInt:4];
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

- (BOOL)isCleard{
    if([self isDead]&&([arr count] == 0)){
        return true;
    }
    return false;
}

@end
