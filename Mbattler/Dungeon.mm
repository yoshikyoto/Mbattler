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
                 @"チュートリアル",
                 @"はじまりの森",
                 @"昆虫の森",
                 @"食人の花",
                 @"植物たちの下克上",
                 @"少女寄生中",
                 @"海岸の戦い",
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
                 @"食物パラダイス",
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
            /*
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
             */
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

- (void)dungeon5{
    
    //推奨レベル1
    
    [self reset];
    NSLog(@"チュートリアルステージ生成 in Dungeon");
    
    // 敵集団1
    NSArray *subarr = [NSArray arrayWithObjects:
                       [[Enemy alloc] initWithName:@"ビックリネズミ１" H:60 	A:25 	B:0 	C:25 	D:0 	S:30
                                       ImageString:@"solid07.PNG"],
                       [[Enemy alloc] initWithName:@"ビックリネズミ２" H:60 	A:25 	B:0 	C:25 	D:0 	S:30 ImageString:@"solid07.PNG"],
                       [[Enemy alloc] initWithName:@"ビックリネズミ３" H:60 	A:25 	B:0 	C:25 	D:0 	S:30 ImageString:@"solid07.PNG"],
                       nil];
    [arr addObject:subarr];
    
    // 敵襲団2
    subarr = [NSArray arrayWithObjects:
              [[Enemy alloc] initWithName:@"汚いネズミ１" H:65 	A:30 	B:0 	C:30 	D:0 	S:35
                              ImageString:@"animal19.PNG"],
              [[Enemy alloc] initWithName:@"汚いネズミ１" H:65 	A:30 	B:0 	C:30 	D:0 	S:35
                              ImageString:@"animal19.PNG"],
              [[Enemy alloc] initWithName:@"汚いネズミ１" H:65 	A:30 	B:0 	C:30 	D:0 	S:35
                              ImageString:@"animal19.PNG"],
              nil];
    [arr addObject:subarr];
    
    //敵集団3
    subarr = [NSArray arrayWithObjects:
              [[Enemy alloc] initWithName:@"獰猛カマキリ" H:150 	A:40 	B:0 	C:30 	D:0 	S:35
                              ImageString:@"animal22.PNG"],
              nil];
    [arr addObject:subarr];
    
    
    exp = 124;
    stamina = 5;
    [self setBackgroundInt:0];
}

- (void)dungeon6{
    
    //推奨レベル2
    
    [self reset];
    NSLog(@"はじまりの森生成 in Dungeon");
    
    // 敵集団1
    NSArray *subarr = [NSArray arrayWithObjects:
                       [[Enemy alloc] initWithName:@"毒々しいちょうちょ１" H:60 	A:42 	B:0 	C:42 	D:0 	S:35 ImageString:@"spirit81.png"],
                       [[Enemy alloc] initWithName:@"毒々しいちょうちょ２" H:60 	A:42 	B:0 	C:42 	D:0 	S:35 ImageString:@"spirit81.png"],
                       [[Enemy alloc] initWithName:@"毒々しいちょうちょ３" H:60 	A:42 	B:0 	C:42 	D:0 	S:35 ImageString:@"animal17.png"],
                       [[Enemy alloc] initWithName:@"毒々しいちょうちょ４" H:60 	A:42 	B:0 	C:42 	D:0 	S:35 ImageString:@"animal17.png"],
                       nil];
    [arr addObject:subarr];
    
    // 敵襲団2
    subarr = [NSArray arrayWithObjects:
              [[Enemy alloc] initWithName:@"巨大アリ１" H:70 	A:44 	B:0 	C:40 	D:0 	S:45
               
                              ImageString:@"animal24.png"],
              [[Enemy alloc] initWithName:@"巨大アリ２" H:70 	A:44 	B:0 	C:40 	D:0 	S:45
               
                              ImageString:@"animal24.png"],
              [[Enemy alloc] initWithName:@"巨大アリ３" H:70 	A:44 	B:0 	C:40 	D:0 	S:45
               
                              ImageString:@"animal24.png"],
              nil];
    [arr addObject:subarr];
    
    //敵集団3
    subarr = [NSArray arrayWithObjects:
              [[Enemy alloc] initWithName:@"わりとでかいクモ１" H:200 	A:46 	B:14 	C:40 	D:13 	S:40
               
                              ImageString:@"animal27.png"],
              [[Enemy alloc] initWithName:@"わりとでかいクモ２" H:200 	A:46 	B:14 	C:40 	D:13 	S:40
               
                              ImageString:@"animal27.png"],
              nil];
    [arr addObject:subarr];
    
    
    exp = 124;
    stamina = 5;
    [self setBackgroundInt:0];
}

- (void)dungeon7{
    
    //推奨レベル3
    
    [self reset];
    NSLog(@"昆虫の森生成 in Dungeon");
    
    // 敵集団1
    NSArray *subarr = [NSArray arrayWithObjects:
                       [[Enemy alloc] initWithName:@"獰猛カマキリ１" H:150 	A:50 	B:0 	C:40 	D:0 	S:40 ImageString:@"animal22.PNG"],
                       [[Enemy alloc] initWithName:@"獰猛カマキリ２" H:150 	A:50 	B:0 	C:40 	D:0 	S:40 ImageString:@"animal22.PNG"],
                       [[Enemy alloc] initWithName:@"獰猛カマキリ３" H:150 	A:50 	B:0 	C:40 	D:0 	S:40 ImageString:@"animal22.PNG"],
                       nil];
    [arr addObject:subarr];
    
    // 敵襲団2
    subarr = [NSArray arrayWithObjects:
              [[Enemy alloc] initWithName:@"微毒サソリ１" H:100 	A:55 	B:25 	C:55 	D:25 	S:45
               
                              ImageString:@"animal21.png"],
              [[Enemy alloc] initWithName:@"微毒サソリ２" H:100 	A:55 	B:25 	C:55 	D:25 	S:45
               
                              ImageString:@"animal21.png"],
              [[Enemy alloc] initWithName:@"微毒サソリ３" H:100 	A:55 	B:25 	C:55 	D:25 	S:45
               
                              ImageString:@"animal21.png"],
              nil];
    [arr addObject:subarr];
    
    //敵集団3
    subarr = [NSArray arrayWithObjects:
              [[Enemy alloc] initWithName:@"ヘラクレスビートル１" H:80 	A:50 	B:20 	C:45 	D:20 	S:40
                              ImageString:@"animal20.png"],
              [[Enemy alloc] initWithName:@"ヘラクレスビートル２" H:80 	A:50 	B:20 	C:45 	D:20 	S:40
                              ImageString:@"animal20.png"],
              [[Enemy alloc] initWithName:@"ミヤマクワガタ１" H:80 	A:50 	B:20 	C:45 	D:20 	S:40
                              ImageString:@"animal06.png"],
              [[Enemy alloc] initWithName:@"ミヤマクワガタ２" H:80 	A:45 	B:20 	C:50 	D:20 	S:40
                              ImageString:@"animal06.png"],
              nil];
    [arr addObject:subarr];
    
    
    exp = 124;
    stamina = 5;
    [self setBackgroundInt:0];
}


- (void)dungeon8{
    
    //推奨レベル3
    
    [self reset];
    NSLog(@"食人の花生成 in Dungeon");
    
    // 敵集団1
    NSArray *subarr = [NSArray arrayWithObjects:
                       [[Enemy alloc] initWithName:@"シアンフラワー１" H:120 	A:50 	B:0 	C:51 	D:0 	S:45 ImageString:@"plant03.png"],
                       [[Enemy alloc] initWithName:@"シアンフラワー２" H:120 	A:50 	B:0 	C:51 	D:0 	S:45 ImageString:@"plant03.png"],
                       [[Enemy alloc] initWithName:@"シアンフラワー３" H:120 	A:50 	B:0 	C:51 	D:0 	S:45 ImageString:@"plant03.png"],
                       nil];
    [arr addObject:subarr];
    
    // 敵襲団2
    subarr = [NSArray arrayWithObjects:
              
              [[Enemy alloc] initWithName:@"小型パックン１" H:80 	A:53 	B:0 	C:45 	D:0 	S:55
                              ImageString:@"plant14.png"],
              [[Enemy alloc] initWithName:@"小型パックン２" H:80 	A:53 	B:0 	C:45 	D:0 	S:55
                              ImageString:@"plant14.png"],
              [[Enemy alloc] initWithName:@"小型パックン３" H:80 	A:53 	B:0 	C:45 	D:0 	S:55
                              ImageString:@"plant14.png"],
              nil];
    [arr addObject:subarr];
    
    //敵集団3
    subarr = [NSArray arrayWithObjects:
              [[Enemy alloc] initWithName:@"小型パックン１" H:80 	A:53 	B:0 	C:45 	D:0 	S:55
                              ImageString:@"plant14.png"],
              [[Enemy alloc] initWithName:@"クサイハナ" H:150 	A:60 	B:10 	C:60 	D:10 	S:45
                              ImageString:@"plant05.png"],
              [[Enemy alloc] initWithName:@"小型パックン２" H:80 	A:53 	B:0 	C:45 	D:0 	S:55
                              ImageString:@"plant14.png"],
              nil];
    [arr addObject:subarr];
    
    
    exp = 124;
    stamina = 5;
    [self setBackgroundInt:0];
}

- (void)dungeon9{
    
    //推奨レベル4
    
    [self reset];
    NSLog(@"植物たちの下克上生成 in Dungeon");
    
    // 敵集団1
    NSArray *subarr = [NSArray arrayWithObjects:
                       
                       [[Enemy alloc] initWithName:@"小型パックン１" H:100 	A:55 	B:0 	C:45 	D:0 	S:55
                                       ImageString:@"plant14.png"],
                       [[Enemy alloc] initWithName:@"小型パックン２" H:100 	A:55 	B:0 	C:45 	D:0 	S:55
                                       ImageString:@"plant14.png"],
                       [[Enemy alloc] initWithName:@"小型パックン３" H:100 	A:55 	B:0 	C:45 	D:0 	S:55
                                       ImageString:@"plant14.png"],
                       nil];
    [arr addObject:subarr];
    
    // 敵襲団2
    subarr = [NSArray arrayWithObjects:
              [[Enemy alloc] initWithName:@"とげの多すぎるバラ１" H:130 	A:58 	B:20 	C:63 	D:0 	S:50
                              ImageString:@"plant02.png"],
              [[Enemy alloc] initWithName:@"とげの多すぎるバラ２" H:130 	A:58 	B:20 	C:63 	D:0 	S:50
                              ImageString:@"plant02.png"],
              [[Enemy alloc] initWithName:@"とげの多すぎるバラ３" H:130 	A:58 	B:20 	C:63 	D:0 	S:50
                              ImageString:@"plant02.png"],
              nil];
    [arr addObject:subarr];
    
    //敵集団3
    subarr = [NSArray arrayWithObjects:
              [[Enemy alloc] initWithName:@"人食いキノコ１" H:180 	A:63 	B:0 	C:65 	D:15 	S:50
                              ImageString:@"plant01.png"],
              [[Enemy alloc] initWithName:@"人食いキノコ２" H:180 	A:63 	B:0 	C:65 	D:15 	S:50
                              ImageString:@"plant01.png"],
              [[Enemy alloc] initWithName:@"人食いキノコ３" H:180 	A:63 	B:0 	C:65 	D:15 	S:50
                              ImageString:@"plant01.png"],
              nil];
    [arr addObject:subarr];
    
    
    exp = 124;
    stamina = 5;
    [self setBackgroundInt:0];
}

- (void)dungeon10{
    
    //推奨レベル5
    
    [self reset];
    NSLog(@"少女寄生中生成 in Dungeon");
    
    // 敵集団1
    NSArray *subarr = [NSArray arrayWithObjects:
                       [[Enemy alloc] initWithName:@"とげの多すぎるバラ１" H:130 	A:58 	B:20 	C:63 	D:0 	S:50
                                       ImageString:@"plant02.png"],
                       [[Enemy alloc] initWithName:@"とげの多すぎるバラ２" H:130 	A:58 	B:20 	C:63 	D:0 	S:50
                                       ImageString:@"plant02.png"],
                       [[Enemy alloc] initWithName:@"とげの多すぎるバラ３" H:130 	A:58 	B:20 	C:63 	D:0 	S:50
                                       ImageString:@"plant02.png"],
                       nil];
    [arr addObject:subarr];
    
    // 敵襲団2
    subarr = [NSArray arrayWithObjects:
              [[Enemy alloc] initWithName:@"巨大樹１" H:180 	A:62 	B:25 	C:55 	D:0 	S:53
                              ImageString:@"plant04.png"],
              [[Enemy alloc] initWithName:@"巨大樹２" H:180 	A:62 	B:25 	C:55 	D:0 	S:53
                              ImageString:@"plant04.png"],
              [[Enemy alloc] initWithName:@"巨大樹３" H:180 	A:62 	B:25 	C:55 	D:0 	S:53
                              ImageString:@"plant04.png"],
              nil];
    [arr addObject:subarr];
    
    //敵集団3
    subarr = [NSArray arrayWithObjects:
              [[Enemy alloc] initWithName:@"暴走大根１" H:150 	A:65 	B:0 	C:55 	D:0 	S:55
                              ImageString:@"plant07.png"],
              [[Enemy alloc] initWithName:@"キノコ少女" H:800 	A:75 	B:0 	C:70 	D:0 	S:60
                              ImageString:@"monster56.png"],
              [[Enemy alloc] initWithName:@"暴走大根２" H:150 	A:65 	B:0 	C:55 	D:0 	S:55
                              ImageString:@"plant07.png"],
              nil];
    [arr addObject:subarr];
    
    
    exp = 124;
    stamina = 5;
    [self setBackgroundInt:0];
}

- (void)dungeon11{
    
    //推奨レベル5
    
    [self reset];
    NSLog(@"海岸の戦い生成 in Dungeon");
    
    // 敵集団1
    NSArray *subarr = [NSArray arrayWithObjects:
                       [[Enemy alloc] initWithName:@"ぐったりしたヒトデ１" H:130 	A:63 	B:0 	C:63 	D:0 	S:55
                                       ImageString:@"aquatic20.png"],
                       [[Enemy alloc] initWithName:@"ぐったりしたヒトデ２" H:130 	A:63 	B:0 	C:63 	D:0 	S:55
                                       ImageString:@"aquatic20.png"],
                       [[Enemy alloc] initWithName:@"ぐったりしたヒトデ３" H:130 	A:63 	B:0 	C:63 	D:0 	S:55
                                       ImageString:@"aquatic20.png"],
                       nil];
    [arr addObject:subarr];
    
    // 敵襲団2
    subarr = [NSArray arrayWithObjects:
              [[Enemy alloc] initWithName:@"迷子の亀１" H:200 	A:63 	B:20 	C:63 	D:10 	S:55
                              ImageString:@"aquatic12.png"],
              [[Enemy alloc] initWithName:@"迷子の亀２" H:200 	A:63 	B:20 	C:63 	D:10 	S:55
                              ImageString:@"aquatic12.png"],
              [[Enemy alloc] initWithName:@"迷子の亀３" H:200 	A:63 	B:20 	C:63 	D:10 	S:55
                              ImageString:@"aquatic12.png"],
              nil];
    [arr addObject:subarr];
    
    //敵集団3
    subarr = [NSArray arrayWithObjects:
              [[Enemy alloc] initWithName:@"泡吹きガニ１" H:180 	A:65 	B:10 	C:56 	D:20 	S:60
                              ImageString:@"aquatic13.png"],
              [[Enemy alloc] initWithName:@"泡吹きガニ２" H:180 	A:65 	B:10 	C:56 	D:20 	S:60
                              ImageString:@"aquatic13.png"],
              [[Enemy alloc] initWithName:@"泡吹きガニ３" H:180 	A:65 	B:10 	C:56 	D:20 	S:50
                              ImageString:@"aquatic13.png"],
              nil];
    [arr addObject:subarr];
    
    //敵襲団4
    subarr = [NSArray arrayWithObjects:
              [[Enemy alloc] initWithName:@"皇帝ペンギン" H:800 	A:75 	B:0 	C:65 	D:0 	S:65
                              ImageString:@"animal26.png"],
              nil];
    [arr addObject:subarr];
    
    exp = 124;
    stamina = 5;
    [self setBackgroundInt:0];
}

- (void)dungeon12{
    
    //推奨レベル6
    
    [self reset];
    NSLog(@"海中の魔物たち生成 in Dungeon");
    
    // 敵集団1
    NSArray *subarr = [NSArray arrayWithObjects:
                       [[Enemy alloc] initWithName:@"殺意に満ちたクリオネ１" H:150 	A:62 	B:0 	C:62 	D:0 	S:55
                                       ImageString:@"aquatic02.png"],
                       [[Enemy alloc] initWithName:@"殺意に満ちたクリオネ２" H:150 	A:62 	B:0 	C:62 	D:0 	S:55
                                       ImageString:@"aquatic02.png"],
                       [[Enemy alloc] initWithName:@"殺意に満ちたクリオネ３" H:150 	A:62 	B:0 	C:62 	D:0 	S:55
                                       ImageString:@"aquatic02.png"],
                       [[Enemy alloc] initWithName:@"殺意に満ちたクリオネ４" H:150 	A:62 	B:0 	C:62 	D:0 	S:55
                                       ImageString:@"aquatic02.png"],
                       [[Enemy alloc] initWithName:@"殺意に満ちたクリオネ５" H:150 	A:62 	B:0 	C:62 	D:0 	S:55
                                       ImageString:@"aquatic02.png"],
                       nil];
    [arr addObject:subarr];
    
    // 敵襲団2
    subarr = [NSArray arrayWithObjects:
              [[Enemy alloc] initWithName:@"イカの子分１" H:150 	A:64 	B:0 	C:55 	D:0 	S:56
                              ImageString:@"aquatic04.png"],
              [[Enemy alloc] initWithName:@"イカの子分２" H:150 	A:64 	B:0 	C:55 	D:0 	S:56
                              ImageString:@"aquatic04.png"],
              [[Enemy alloc] initWithName:@"イカの子分３" H:150 	A:64 	B:0 	C:55 	D:0 	S:56
                              ImageString:@"aquatic04.png"],
              nil];
    [arr addObject:subarr];
    
    //敵集団3
    subarr = [NSArray arrayWithObjects:
              [[Enemy alloc] initWithName:@"竜宮の使い１" H:250 	A:67 	B:0 	C:65 	D:0 	S:60
                              ImageString:@"aquatic11.png"],
              [[Enemy alloc] initWithName:@"竜宮の使い２" H:250 	A:67 	B:0 	C:65 	D:0 	S:60
                              ImageString:@"aquatic11.png"],
              [[Enemy alloc] initWithName:@"竜宮の使い３" H:250 	A:67 	B:0 	C:65 	D:0 	S:60
                              ImageString:@"aquatic11.png"],
              nil];
    [arr addObject:subarr];
    
    //敵集団4
    subarr = [NSArray arrayWithObjects:
              [[Enemy alloc] initWithName:@"竜宮の使い１" H:250 	A:67 	B:0 	C:65 	D:0 	S:60
                              ImageString:@"aquatic11.png"],
              [[Enemy alloc] initWithName:@"ラッセンのイルカ" H:800 	A:70 	B:0 	C:72 	D:0 	S:65
                              ImageString:@"aquatic08.png"],
              [[Enemy alloc] initWithName:@"竜宮の使い２" H:250 	A:67 	B:0 	C:65 	D:0 	S:60
                              ImageString:@"aquatic11.png"],
              nil];
    [arr addObject:subarr];
    
    
    exp = 124;
    stamina = 5;
    [self setBackgroundInt:0];
}

- (void)dungeon13{
    
    //推奨レベル7
    
    [self reset];
    NSLog(@"触手の猛撃生成 in Dungeon");
    
    // 敵集団1
    NSArray *subarr = [NSArray arrayWithObjects:
                       [[Enemy alloc] initWithName:@"遊泳エイ１" H:150 	A:63 	B:0 	C:67 	D:0 	S:60
                                       ImageString:@"aquatic09.png"],
                       [[Enemy alloc] initWithName:@"遊泳エイ２" H:150 	A:63 	B:0 	C:67 	D:0 	S:60
                                       ImageString:@"aquatic09.png"],
                       [[Enemy alloc] initWithName:@"遊泳エイ３" H:150 	A:63 	B:0 	C:67 	D:0 	S:60
                                       ImageString:@"aquatic09.png"],
                       nil];
    [arr addObject:subarr];
    
    // 敵襲団2
    subarr = [NSArray arrayWithObjects:
              [[Enemy alloc] initWithName:@"大王イカのおみ足１" H:200 	A:66 	B:15 	C:64 	D:15	S:65
                              ImageString:@"aquatic18e.png"],
              [[Enemy alloc] initWithName:@"大王イカのおみ足２" H:200 	A:66 	B:15	C:64 	D:15	S:65
                              ImageString:@"aquatic18b.png"],
              [[Enemy alloc] initWithName:@"大王イカのおみ足３" H:200 	A:66 	B:15	C:64 	D:15	S:65
                              ImageString:@"aquatic18d.png"],
              [[Enemy alloc] initWithName:@"大王イカのおみ足４" H:200 	A:66 	B:15	C:64 	D:15	S:65
                              ImageString:@"aquatic18g.png"],
              nil];
    [arr addObject:subarr];
    
    //敵集団3
    subarr = [NSArray arrayWithObjects:
              [[Enemy alloc] initWithName:@"大王イカのおみ足５" H:200 	A:66 	B:15	C:64 	D:15	S:65
                              ImageString:@"aquatic18g.png"],
              [[Enemy alloc] initWithName:@"大王イカのおみ足６" H:200 	A:66 	B:15	C:64 	D:15	S:65
                              ImageString:@"aquatic18f.png"],
              [[Enemy alloc] initWithName:@"大王イカのおみ足７" H:200 	A:66 	B:15	C:64 	D:15	S:65
                              ImageString:@"aquatic18a.png"],
              [[Enemy alloc] initWithName:@"大王イカのおみ足８" H:200 	A:66 	B:15	C:64 	D:15	S:65
                              ImageString:@"aquatic18c.png"],
              nil];
    [arr addObject:subarr];
    
    //敵集団4
    subarr = [NSArray arrayWithObjects:
              [[Enemy alloc] initWithName:@"大王イカのおみ足９" H:200 	A:66 	B:15	C:64 	D:15 	S:65
                              ImageString:@"aquatic18e.png"],
              [[Enemy alloc] initWithName:@"大王イカ" H:500 	A:75 B:35 	C:90 	D:30 	S:65
                              ImageString:@"aquatic18.png"],
              [[Enemy alloc] initWithName:@"大王イカのおみ足１０" H:200 	A:66 	B:15 	C:64 	D:15 	S:65
                              ImageString:@"aquatic18b.png"],
              
              nil];
    [arr addObject:subarr];
    
    
    exp = 124;
    stamina = 5;
    [self setBackgroundInt:0];
}

- (void)dungeon14{
    
    //推奨レベル8
    
    [self reset];
    NSLog(@"野生の反乱生成 in Dungeon");
    
    // 敵集団1
    NSArray *subarr = [NSArray arrayWithObjects:
                       [[Enemy alloc] initWithName:@"怪タカ１" H:175 	A:70 	B:20 	C:57 	D:20 	S:70
                                       ImageString:@"animal04.png"],
                       [[Enemy alloc] initWithName:@"怪タカ２" H:175 	A:70 	B:20 	C:57 	D:20 	S:70
                                       ImageString:@"animal04.png"],
                       [[Enemy alloc] initWithName:@"怪タカ３" H:175 	A:70 	B:20 	C:57 	D:20 	S:70
                                       ImageString:@"animal04.png"],
                       nil];
    [arr addObject:subarr];
    
    // 敵襲団2
    subarr = [NSArray arrayWithObjects:
              [[Enemy alloc] initWithName:@"妖力が乏しいキツネ１" H:250 	A:70 	B:0 	C:70 	D:25 	S:65
                              ImageString:@"animal11.png"],
              [[Enemy alloc] initWithName:@"妖力が乏しいキツネ２" H:250 	A:70 	B:0 	C:70 	D:25 	S:65
                              ImageString:@"animal11.png"],
              [[Enemy alloc] initWithName:@"妖力が乏しいキツネ３" H:250 	A:70 	B:0 	C:70 	D:25 	S:65
                              ImageString:@"animal11.png"],
              nil];
    [arr addObject:subarr];
    
    //敵集団3
    subarr = [NSArray arrayWithObjects:
              [[Enemy alloc] initWithName:@"一匹オオカミ" H:800 	A:85 	B:35 	C:40 	D:35 	S:70
                              ImageString:@"animal05.png"],
              nil];
    [arr addObject:subarr];
    
    //敵集団4
    subarr = [NSArray arrayWithObjects:
              [[Enemy alloc] initWithName:@"ふわふわウサギ１" H:250 	A:75 	B:15 	C:40 	D:15 	S:65
                              ImageString:@"animal14.png"],
              [[Enemy alloc] initWithName:@"首狩りグマ" H:1000 	A:90 	B:25 	C:50 	D:25 	S:90
                              ImageString:@"monster71.png"],
              [[Enemy alloc] initWithName:@"ふわふわウサギ２" H:250 	A:75 	B:15 	C:40 	D:15 	S:65
                              ImageString:@"animal14.png"],
              nil];
    [arr addObject:subarr];
    
    
    exp = 124;
    stamina = 5;
    [self setBackgroundInt:0];
}

- (void)dungeon15{
    
    //推奨レベル10
    
    [self reset];
    NSLog(@"君臨せし空中王女生成 in Dungeon");
    
    // 敵集団1
    NSArray *subarr = [NSArray arrayWithObjects:
                       [[Enemy alloc] initWithName:@"怪タカ１" H:175 	A:75 	B:20 	C:57 	D:20 	S:70
                                       ImageString:@"animal04.png"],
                       [[Enemy alloc] initWithName:@"怪タカ２" H:175 	A:75 	B:20 	C:57 	D:20 	S:70
                                       ImageString:@"animal04.png"],
                       [[Enemy alloc] initWithName:@"怪タカ３" H:175 	A:75 	B:20 	C:57 	D:20 	S:70
                                       ImageString:@"animal04.png"],
                       nil];
    [arr addObject:subarr];
    
    // 敵襲団2
    subarr = [NSArray arrayWithObjects:
              [[Enemy alloc] initWithName:@"ホワイトバード１" H:250 	A:80 	B:20 	C:57 	D:20 	S:80
                              ImageString:@"animal30.png"],
              [[Enemy alloc] initWithName:@"ホワイトバード２" H:250 	A:80 	B:20 	C:57 	D:20 	S:80
                              ImageString:@"animal30.png"],
              [[Enemy alloc] initWithName:@"ホワイトバード３" H:250 	A:80 	B:20 	C:57 	D:20 	S:80
                              ImageString:@"animal30.png"],
              [[Enemy alloc] initWithName:@"ホワイトバード４" H:250 	A:80 	B:20 	C:57 	D:20 	S:80
                              ImageString:@"animal30.png"],
              [[Enemy alloc] initWithName:@"ホワイトバード５" H:250 	A:80 	B:20 	C:57 	D:20 	S:80
                              ImageString:@"animal30.png"],
              nil];
    [arr addObject:subarr];
    
    //敵集団3
    subarr = [NSArray arrayWithObjects:
              [[Enemy alloc] initWithName:@"ブラックバード１" H:250 	A:80 	B:20 	C:57 	D:20 	S:80
                              ImageString:@"animal09.png"],
              [[Enemy alloc] initWithName:@"ブラックバード２" H:250 	A:80 	B:20 	C:57 	D:20 	S:80                              ImageString:@"animal09.png"],
              [[Enemy alloc] initWithName:@"ブラックバード３" H:250 	A:80 	B:20 	C:57 	D:20 	S:80
                              ImageString:@"animal09.png"],
              [[Enemy alloc] initWithName:@"ブラックバード４" H:250 	A:80 	B:20 	C:57 	D:20 	S:80
                              ImageString:@"animal09.png"],
              [[Enemy alloc] initWithName:@"ブラックバード５" H:250 	A:80 	B:20 	C:57 	D:20 	S:80
                              ImageString:@"animal09.png"],
              nil];
    [arr addObject:subarr];
    
    //敵襲団4
    subarr = [NSArray arrayWithObjects:
              [[Enemy alloc] initWithName:@"ブラックバード１" H:250 	A:80 	B:20 	C:57 	D:20 	S:80
                              ImageString:@"animal09.png"],
              [[Enemy alloc] initWithName:@"空ノ妖精" H:1000 	A:90 	B:20 	C:90 	D:40 	S:90
                              ImageString:@"dh10.png"],
              [[Enemy alloc] initWithName:@"ブラックバード２" H:250 	A:80 	B:20 	C:57 	D:20 	S:80
                              ImageString:@"animal09.png"],
              [[Enemy alloc] initWithName:@"ホワイトバード１" H:250 	A:80 	B:20 	C:57 	D:20 	S:80
                              ImageString:@"animal30.png"],
              [[Enemy alloc] initWithName:@"ホワイトバード２" H:250 	A:80 	B:20 	C:57 	D:20 	S:80
                              ImageString:@"animal30.png"],
              nil];
    [arr addObject:subarr];
    
    
    exp = 124;
    stamina = 5;
    [self setBackgroundInt:0];
}

- (void)dungeon16{
    
    //推奨レベル10
    
    [self reset];
    NSLog(@"かぼちゃの愉快な仲間たち生成 in Dungeon");
    
    // 敵集団1
    NSArray *subarr = [NSArray arrayWithObjects:
                       [[Enemy alloc] initWithName:@"すり抜ける炎" H:100 	A:88 	B:200 	C:88 	D:0 	S:60
                                       ImageString:@"monster11.png"],
                       nil];
    [arr addObject:subarr];
    
    // 敵襲団2
    subarr = [NSArray arrayWithObjects:
              [[Enemy alloc] initWithName:@"すり抜ける炎１" H:100 	A:88 	B:200 	C:88 	D:0 	S:60
                              ImageString:@"monster11.png"],
              [[Enemy alloc] initWithName:@"死泥の手" H:300 	A:90 	B:10 	C:60 	D:10 	S:75
                              ImageString:@"undead13.png"],
              [[Enemy alloc] initWithName:@"すり抜ける炎２" H:100 	A:88 	B:200 	C:88 	D:0 	S:60
                              ImageString:@"monster11.png"],
              nil];
    [arr addObject:subarr];
    
    //敵集団3
    subarr = [NSArray arrayWithObjects:
              [[Enemy alloc] initWithName:@"すり抜ける炎１" H:100 	A:88 	B:200 	C:88 	D:0 	S:60
                              ImageString:@"monster11.png"],
              [[Enemy alloc] initWithName:@"死のマリオネット" H:300 	A:90 	B:10 	C:60 	D:10 	S:85
                              ImageString:@"solid03.png"],
              [[Enemy alloc] initWithName:@"すり抜ける炎２" H:100 	A:88 	B:200 	C:88 	D:0 	S:60
                              ImageString:@"monster11.png"],
              nil];
    [arr addObject:subarr];
    
    //敵集団4
    subarr = [NSArray arrayWithObjects:
              [[Enemy alloc] initWithName:@"死のマリオネット" H:300 	A:90 	B:10 	C:60 	D:10 	S:85
                              ImageString:@"solid03.png"],
              [[Enemy alloc] initWithName:@"道化師パンプキン" H:1200 	A:95 	B:15 	C:95 	D:15 	S:90
                              ImageString:@"monster25.png"],
              [[Enemy alloc] initWithName:@"死泥の手" H:300 	A:90 	B:10 	C:60 	D:10 	S:75
                              ImageString:@"undead13.png"],
              nil];
    [arr addObject:subarr];
    
    
    exp = 124;
    stamina = 5;
    [self setBackgroundInt:0];
}

- (void)dungeon17{
    
    //推奨レベル11
    
    [self reset];
    NSLog(@"いにしえの悪魔生成 in Dungeon");
    
    // 敵集団1
    NSArray *subarr = [NSArray arrayWithObjects:
                       [[Enemy alloc] initWithName:@"フライングアイ１" H:200 	A:90 	B:20 	C:85 	D:20 	S:85
                                       ImageString:@"monster86.png"],
                       [[Enemy alloc] initWithName:@"フライングアイ２" H:200 	A:90 	B:20 	C:85 	D:20 	S:85
                                       ImageString:@"monster86.png"],
                       [[Enemy alloc] initWithName:@"フライングアイ３" H:200 	A:90 	B:20 	C:85 	D:20 	S:85
                                       ImageString:@"monster86.png"],
                       nil];
    [arr addObject:subarr];
    
    // 敵襲団2
    subarr = [NSArray arrayWithObjects:
              [[Enemy alloc] initWithName:@"骸骨の盾１" H:200 	A:90 	B:200 	C:85 	D:20 	S:60
                              ImageString:@"monster110.png"],
              [[Enemy alloc] initWithName:@"マミー" H:350 	A:95 	B:10	C:95 	D:50 	S:85
                              ImageString:@"undead26.png"],
              nil];
    [arr addObject:subarr];
    
    //敵集団3
    subarr = [NSArray arrayWithObjects:
              [[Enemy alloc] initWithName:@"骸骨の盾１" H:200 	A:90 	B:200 	C:85 	D:20 	S:60
                              ImageString:@"monster110.png"],
              [[Enemy alloc] initWithName:@"マミー" H:350 	A:95 	B:10	C:95 	D:50 	S:85
                              ImageString:@"undead26.png"],
              nil];
    [arr addObject:subarr];
    //敵集団4
    subarr = [NSArray arrayWithObjects:
              [[Enemy alloc] initWithName:@"マミー１" H:350 	A:95 	B:10	C:95 	D:50 	S:85
                              ImageString:@"undead26.png"],
              [[Enemy alloc] initWithName:@"マミー２" H:350 	A:95 	B:10	C:95 	D:50 	S:85
                              ImageString:@"undead26.png"],
              nil];
    [arr addObject:subarr];
    
    //敵集団5
    subarr = [NSArray arrayWithObjects:
              [[Enemy alloc] initWithName:@"マミー１" H:350 	A:95 	B:10	C:95 	D:50 	S:85
                              ImageString:@"undead26.png"],
              [[Enemy alloc] initWithName:@"バフォメット" H:1300 	A:100 	B:10 	C:100 	D:10 	S:90
                              ImageString:@"spirit38.png"],
              [[Enemy alloc] initWithName:@"マミー２" H:350 	A:95 	B:10	C:95 	D:50 	S:85
                              ImageString:@"undead26.png"],
              [[Enemy alloc] initWithName:@"骸骨の盾１" H:200 	A:90 	B:200 	C:85 	D:20 	S:60
                              ImageString:@"monster110.png"],
              [[Enemy alloc] initWithName:@"骸骨の盾２" H:200 	A:90 	B:200 	C:85 	D:20 	S:60
                              ImageString:@"monster110.png"],
              nil];
    [arr addObject:subarr];
    
    
    exp = 124;
    stamina = 5;
    [self setBackgroundInt:0];
}

- (void)dungeon18{
    
    //推奨レベル11
    
    [self reset];
    NSLog(@"和世界の邪鬼生成 in Dungeon");
    
    // 敵集団1
    NSArray *subarr = [NSArray arrayWithObjects:
                       [[Enemy alloc] initWithName:@"熱中症河童１" H:300 	A:90 	B:20 	C:90 	D:40 	S:85
                                       ImageString:@"spirit19.png"],
                       [[Enemy alloc] initWithName:@"熱中症河童２" H:300 	A:90 	B:20 	C:90 	D:40 	S:85
                                       ImageString:@"spirit19.png"],
                       [[Enemy alloc] initWithName:@"熱中症河童３" H:300 	A:90 	B:20 	C:90 	D:40 	S:85
                                       ImageString:@"spirit19.png"],
                       nil];
    [arr addObject:subarr];
    
    // 敵襲団2
    subarr = [NSArray arrayWithObjects:
              [[Enemy alloc] initWithName:@"小豆洗い(洗剤使用)１" H:350 	A:95 	B:10	C:95 	D:40 	S:85
                              ImageString:@"spirit24.png"],
              [[Enemy alloc] initWithName:@"小豆洗い(洗剤使用)２" H:350 	A:95 	B:10	C:95 	D:40 	S:85
                              ImageString:@"spirit24.png"],
              [[Enemy alloc] initWithName:@"小豆洗い(洗剤使用)３" H:350 	A:95 	B:10	C:95 	D:40 	S:85
                              ImageString:@"spirit24.png"],
              nil];
    [arr addObject:subarr];
    
    //敵集団3
    subarr = [NSArray arrayWithObjects:
              [[Enemy alloc] initWithName:@"穴の空いたカラカサお化け１" H:400 	A:86 	B:0	C:86 	D:20 	S:90
                              ImageString:@"spirit25.png"],
              [[Enemy alloc] initWithName:@"穴の空いたカラカサお化け２" H:400 	A:86 	B:0	C:86 	D:20 	S:90
                              ImageString:@"spirit25.png"],
              [[Enemy alloc] initWithName:@"穴の空いたカラカサお化け３" H:400 	A:86 	B:0	C:86 	D:20 	S:90
                              ImageString:@"spirit25.png"],
              nil];
    [arr addObject:subarr];
    //敵集団4
    subarr = [NSArray arrayWithObjects:
              [[Enemy alloc] initWithName:@"熱中症河童１" H:300 	A:90 	B:20 	C:90 	D:40 	S:85
                              ImageString:@"spirit19.png"],
              [[Enemy alloc] initWithName:@"穴の空いたカラカサお化け１" H:400 	A:86 	B:0	C:86 	D:20 	S:90
                              ImageString:@"spirit25.png"],
              [[Enemy alloc] initWithName:@"熱中症河童２" H:300 	A:90 	B:20 	C:90 	D:40 	S:85
                              ImageString:@"spirit19.png"],
              nil];
    [arr addObject:subarr];
    
    //敵集団5
    subarr = [NSArray arrayWithObjects:
              [[Enemy alloc] initWithName:@"小豆洗い(洗剤使用)１" H:350 	A:95 	B:10	C:95 	D:40 	S:85
                              ImageString:@"spirit24.png"],
              [[Enemy alloc] initWithName:@"妖幽鬼" H:1300 	A:95 	B:0	C:95 	D:40 	S:85
                              ImageString:@"spirit20.png"],
              [[Enemy alloc] initWithName:@"小豆洗い(洗剤使用)１" H:350 	A:95 	B:10	C:95 	D:40 	S:85
                              ImageString:@"spirit24.png"],
              nil];
    [arr addObject:subarr];
    
    
    exp = 124;
    stamina = 5;
    [self setBackgroundInt:0];
}

- (void)dungeon19{
    
    //推奨レベル11
    
    [self reset];
    NSLog(@"洋館の悪霊生成 in Dungeon");
    
    // 敵集団1
    NSArray *subarr = [NSArray arrayWithObjects:
                       [[Enemy alloc] initWithName:@"スケルトンウーマン１" H:300 	A:90 	B:20 	C:90 	D:20 	S:85
                                       ImageString:@"undead05.png"],
                       [[Enemy alloc] initWithName:@"スケルトンウーマン１" H:300 	A:90 	B:20 	C:90 	D:20 	S:85
                                       ImageString:@"undead05.png"],
                       [[Enemy alloc] initWithName:@"スケルトンウーマン１" H:300 	A:90 	B:20 	C:90 	D:20 	S:85
                                       ImageString:@"undead05.png"],
                       nil];
    [arr addObject:subarr];
    
    // 敵襲団2
    subarr = [NSArray arrayWithObjects:
              [[Enemy alloc] initWithName:@"死へ誘う鏡１" H:250 	A:88 	B:10	C:88 	D:200 	S:85
                              ImageString:@"solid08.png"],
              [[Enemy alloc] initWithName:@"デスゴブリン" H:400 	A:95 	B:20	C:92 	D:20 	S:90
                              ImageString:@"undead06.png"],
              [[Enemy alloc] initWithName:@"死へ誘う鏡２" H:250 	A:88 	B:10	C:88 	D:200 	S:85
                              ImageString:@"solid08.png"],
              nil];
    [arr addObject:subarr];
    
    //敵集団3
    subarr = [NSArray arrayWithObjects:
              [[Enemy alloc] initWithName:@"死へ誘う鏡１" H:250 	A:88 	B:10	C:88 	D:200 	S:85
                              ImageString:@"solid08.png"],
              [[Enemy alloc] initWithName:@"操り少女" H:400 	A:92 	B:30	C:92 	D:30 	S:85
                              ImageString:@"undead04.png"],
              [[Enemy alloc] initWithName:@"死へ誘う鏡２" H:250 	A:88 	B:10	C:88 	D:200 	S:85
                              ImageString:@"solid08.png"],
              nil];
    [arr addObject:subarr];
    //敵集団4
    subarr = [NSArray arrayWithObjects:
              [[Enemy alloc] initWithName:@"デスゴブリン" H:400 	A:95 	B:20	C:92 	D:20 	S:90
                              ImageString:@"undead06.png"],
              [[Enemy alloc] initWithName:@"操り少女" H:400 	A:92 	B:30	C:92 	D:30 	S:85
                              ImageString:@"undead04.png"],
              [[Enemy alloc] initWithName:@"デスゴブリン" H:400 	A:95 	B:20	C:92 	D:20 	S:90
                              ImageString:@"undead06.png"],
              nil];
    [arr addObject:subarr];
    
    //敵集団5
    subarr = [NSArray arrayWithObjects:
              [[Enemy alloc] initWithName:@"死へ誘う鏡１" H:250 	A:88 	B:10	C:88 	D:200 	S:85
                              ImageString:@"solid08.png"],
              [[Enemy alloc] initWithName:@"妖幽鬼" H:1300 	A:95 	B:0	C:95 	D:40 	S:85
                              ImageString:@"spirit20.png"],
              [[Enemy alloc] initWithName:@"死へ誘う鏡２" H:250 	A:88 	B:10	C:88 	D:200 	S:85
                              ImageString:@"solid08.png"],
              nil];
    [arr addObject:subarr];
    
    
    exp = 124;
    stamina = 5;
    [self setBackgroundInt:0];
}

- (void)dungeon20{
    
    //推奨レベル13
    
    [self reset];
    NSLog(@"ゴブリン集会場生成 in Dungeon");
    
    // 敵集団1
    NSArray *subarr = [NSArray arrayWithObjects:
                       [[Enemy alloc] initWithName:@"ごろつきゴブリン" H:350 	A:92 	B:20 	C:85 	D:20 	S:90
                                       ImageString:@"dh04.png"],
                       [[Enemy alloc] initWithName:@"ごろつきゴブリン" H:350 	A:92 	B:20 	C:85 	D:20 	S:90
                                       ImageString:@"dh04.png"],
                       [[Enemy alloc] initWithName:@"ごろつきゴブリン" H:350 	A:92 	B:20 	C:85 	D:20 	S:90
                                       ImageString:@"dh04.png"],
                       nil];
    [arr addObject:subarr];
    
    // 敵襲団2
    subarr = [NSArray arrayWithObjects:
              [[Enemy alloc] initWithName:@"ゴブリン下級戦士" H:400 	A:95 	B:40 	C:85 	D:20 	S:90
                              ImageString:@"dh08.png"],
              [[Enemy alloc] initWithName:@"ゴブリンメイジ" H:300 	A:95 	B:30 	C:95 	D:60 	S:90
                              ImageString:@"dh21.png"],
              [[Enemy alloc] initWithName:@"ゴブリン下級戦士" H:400 	A:95 	B:40 	C:85 	D:20 	S:90
                              ImageString:@"dh08.png"],
              nil];
    [arr addObject:subarr];
    
    //敵集団3
    subarr = [NSArray arrayWithObjects:
              [[Enemy alloc] initWithName:@"ゴブリンメイジ" H:300 	A:95 	B:30 	C:95 	D:60 	S:90
                              ImageString:@"dh21.png"],
              [[Enemy alloc] initWithName:@"ゴブリン上級戦士" H:500 	A:100 	B:40 	C:85 	D:20 	S:90
                              ImageString:@"dh22.png"],
              [[Enemy alloc] initWithName:@"ゴブリンメイジ" H:300 	A:95 	B:30 	C:95 	D:60 	S:90
                              ImageString:@"dh21.png"],
              nil];
    [arr addObject:subarr];
    //敵集団4
    subarr = [NSArray arrayWithObjects:
              [[Enemy alloc] initWithName:@"ゴブリン下級戦士" H:400 	A:95 	B:40 	C:85 	D:20 	S:90
                              ImageString:@"dh08.png"],
              [[Enemy alloc] initWithName:@"ゴブリン上級戦士" H:500 	A:100 	B:40 	C:85 	D:20 	S:90
                              ImageString:@"dh22.png"],
              [[Enemy alloc] initWithName:@"ゴブリン下級戦士" H:400 	A:95 	B:40 	C:85 	D:20 	S:90
                              ImageString:@"dh08.png"],
              nil];
    [arr addObject:subarr];
    
    //敵集団5
    subarr = [NSArray arrayWithObjects:
              [[Enemy alloc] initWithName:@"ゴブリン上級戦士" H:500 	A:100 	B:40 	C:85 	D:20 	S:90
                              ImageString:@"dh22.png"],
              [[Enemy alloc] initWithName:@"ゴブリンナイト" H:1500 	A:105 	B:50 	C:85 	D:50 	S:100
                              ImageString:@"dh05.png"],
              [[Enemy alloc] initWithName:@"ゴブリン上級戦士" H:500 	A:100 	B:40 	C:85 	D:20 	S:90
                              ImageString:@"dh22.png"],
              nil];
    [arr addObject:subarr];
    
    
    exp = 124;
    stamina = 5;
    [self setBackgroundInt:0];
}

- (void)dungeon21{
    
    //推奨レベル13
    
    [self reset];
    NSLog(@"スライムの洞窟生成 in Dungeon");
    
    // 敵集団1
    NSArray *subarr = [NSArray arrayWithObjects:
                       [[Enemy alloc] initWithName:@"毒々しいスライム１" H:300 	A:98 	B:50 	C:85 	D:20 	S:90
                                       ImageString:@"monster26.png"],
                       [[Enemy alloc] initWithName:@"毒々しいスライム２" H:300 	A:98 	B:50 	C:85 	D:20 	S:90
                                       ImageString:@"monster26.png"],
                       [[Enemy alloc] initWithName:@"毒々しいスライム３" H:300 	A:98 	B:50 	C:85 	D:20 	S:90
                                       ImageString:@"monster26.png"],
                       nil];
    [arr addObject:subarr];
    
    // 敵襲団2
    subarr = [NSArray arrayWithObjects:
              [[Enemy alloc] initWithName:@"腐ったスライム１" H:350 	A:98 	B:50	C:98 	D:20 	S:90
                              ImageString:@"solid40.png"],
              [[Enemy alloc] initWithName:@"腐ったスライム１" H:350 	A:98 	B:50	C:98 	D:20 	S:90
                              ImageString:@"solid40.png"],
              [[Enemy alloc] initWithName:@"腐ったスライム１" H:350 	A:98 	B:50	C:98 	D:20 	S:90
                              ImageString:@"solid40.png"],
              nil];
    [arr addObject:subarr];
    
    //敵集団3
    subarr = [NSArray arrayWithObjects:
              [[Enemy alloc] initWithName:@"炎スライム１" H:400 	A:98 	B:50	C:95 	D:20 	S:90
                              ImageString:@"monster141.png"],
              [[Enemy alloc] initWithName:@"炎スライム２" H:400 	A:98 	B:50	C:95 	D:20 	S:90
                              ImageString:@"monster141.png"],
              [[Enemy alloc] initWithName:@"炎スライム３" H:400 	A:98 	B:50	C:95 	D:20 	S:90
                              ImageString:@"monster141.png"],
              nil];
    [arr addObject:subarr];
    //敵集団4
    subarr = [NSArray arrayWithObjects:
              [[Enemy alloc] initWithName:@"はぐれスライム１" H:10 	A:98 	B:130	C:95 	D:130 	S:90
                              ImageString:@"monster67.png"],
              [[Enemy alloc] initWithName:@"はぐれスライムキング" H:20 	A:98 	B:130	C:95 	D:130 	S:90
                              ImageString:@"monster67.png"],
              [[Enemy alloc] initWithName:@"はぐれスライム２" H:10 	A:98 	B:130	C:95 	D:130 	S:90
                              ImageString:@"monster67.png"],
              nil];
    [arr addObject:subarr];
    
    //敵集団5
    subarr = [NSArray arrayWithObjects:
              [[Enemy alloc] initWithName:@"はぐれスライム１" H:10 	A:98 	B:130	C:95 	D:130 	S:90
                              ImageString:@"monster67.png"],
              [[Enemy alloc] initWithName:@"スライムクイーン" H:1500 	A:102 	B:40	C:102 	D:20 	S:110
                              ImageString:@"monster38.png"],
              [[Enemy alloc] initWithName:@"はぐれスライム２" H:10 	A:98 	B:130	C:95 	D:130 	S:90
                              ImageString:@"monster67.png"],
              nil];
    [arr addObject:subarr];
    
    
    exp = 124;
    stamina = 5;
    [self setBackgroundInt:0];
}

- (void)dungeon22{
    
    //推奨レベル13
    
    [self reset];
    NSLog(@"盗賊の住処生成 in Dungeon");
    
    // 敵集団1
    NSArray *subarr = [NSArray arrayWithObjects:
                       [[Enemy alloc] initWithName:@"フライングアイ１" H:250 	A:95 	B:20 	C:85 	D:20 	S:100
                                       ImageString:@"monster86.png"],
                       [[Enemy alloc] initWithName:@"フライングアイ２" H:250 	A:95 	B:20 	C:85 	D:20 	S:100
                                       ImageString:@"monster86.png"],
                       [[Enemy alloc] initWithName:@"フライングアイ３" H:250 	A:95 	B:20 	C:85 	D:20 	S:100
                                       ImageString:@"monster86.png"],
                       nil];
    [arr addObject:subarr];
    
    // 敵襲団2
    subarr = [NSArray arrayWithObjects:
              [[Enemy alloc] initWithName:@"護衛スケルトン１" H:300 	A:98 	B:50 	C:90 	D:50 	S:90
                              ImageString:@"undead68.png"],
              [[Enemy alloc] initWithName:@"護衛スケルトン２" H:300 	A:98 	B:50 	C:90 	D:50 	S:90
                              ImageString:@"undead68.png"],
              [[Enemy alloc] initWithName:@"護衛スケルトン３" H:300 	A:98 	B:50 	C:90 	D:50 	S:90
                              ImageString:@"undead68.png"],
              nil];
    [arr addObject:subarr];
    
    //敵集団3
    subarr = [NSArray arrayWithObjects:
              [[Enemy alloc] initWithName:@"からっぽミミック１" H:325 	A:102 	B:50 	C:102   D:50 	S:60
                              ImageString:@"solid02.png"],
              [[Enemy alloc] initWithName:@"からっぽミミック２" H:325 	A:102 	B:50 	C:102	D:50 	S:60
                              ImageString:@"solid02.png"],
              [[Enemy alloc] initWithName:@"からっぽミミック３" H:325 	A:102 	B:50 	C:102	D:50 	S:60
                              ImageString:@"solid02.png"],
              nil];
    [arr addObject:subarr];
    //敵集団4
    subarr = [NSArray arrayWithObjects:
              [[Enemy alloc] initWithName:@"泥人形１" H:350 	A:102 	B:50	C:102 	D:50 	S:94
                              ImageString:@"monster17.png"],
              [[Enemy alloc] initWithName:@"泥人形２" H:350 	A:102 	B:50	C:102 	D:50 	S:94
                              ImageString:@"monster17.png"],
              [[Enemy alloc] initWithName:@"泥人形３" H:350 	A:102 	B:50	C:102 	D:50 	S:94
                              ImageString:@"monster17.png"],
              nil];
    [arr addObject:subarr];
    
    //敵集団5
    subarr = [NSArray arrayWithObjects:
              [[Enemy alloc] initWithName:@"護衛スケルトン１" H:300 	A:95 	B:50 	C:90 	D:50 	S:90
                              ImageString:@"undead68.png"],
              [[Enemy alloc] initWithName:@"盗賊A" H:1600 	A:95 	B:30	C:95 	D:30 	S:100
                              ImageString:@"human102.png"],
              [[Enemy alloc] initWithName:@"護衛スケルトン２" H:300 	A:95 	B:50 	C:90 	D:50 	S:90
                              ImageString:@"undead68.png"],
              
              nil];
    [arr addObject:subarr];
    
    
    exp = 124;
    stamina = 5;
    [self setBackgroundInt:0];
}

- (void)dungeon23{
    
    //推奨レベル14
    
    [self reset];
    NSLog(@"遊戯の館生成 in Dungeon");
    
    // 敵集団1
    NSArray *subarr = [NSArray arrayWithObjects:
                       [[Enemy alloc] initWithName:@"壱" H:300 	A:100 	B:40 	C:100 	D:40 	S:95
                                       ImageString:@"spirit83_1.png"],
                       nil];
    [arr addObject:subarr];
    
    // 敵襲団2
    subarr = [NSArray arrayWithObjects:
              [[Enemy alloc] initWithName:@"弐" H:350 	A:101 	B:40 	C:101 	D:40 	S:95
                              ImageString:@"spirit83_2.png"],
              [[Enemy alloc] initWithName:@"弐" H:350 	A:101 	B:40 	C:101 	D:40 	S:95
                              ImageString:@"spirit83_2.png"],
              nil];
    [arr addObject:subarr];
    
    //敵集団3
    subarr = [NSArray arrayWithObjects:
              [[Enemy alloc] initWithName:@"参" H:400 	A:102 	B:40 	C:102 	D:40 	S:95
                              ImageString:@"spirit83_3.png"],
              [[Enemy alloc] initWithName:@"参" H:400 	A:102 	B:40 	C:102 	D:40 	S:95
                              ImageString:@"spirit83_3.png"],
              [[Enemy alloc] initWithName:@"参" H:400 	A:102 	B:40 	C:102 	D:40 	S:95
                              ImageString:@"spirit83_3.png"],
              nil];
    [arr addObject:subarr];
    //敵集団4
    subarr = [NSArray arrayWithObjects:
              [[Enemy alloc] initWithName:@"四" H:400 	A:103 	B:40 	C:103 	D:40 	S:95
                              ImageString:@"spirit83_4.png"],
              [[Enemy alloc] initWithName:@"四" H:400 	A:103 	B:40 	C:103 	D:40 	S:95
                              ImageString:@"spirit83_4.png"],
              [[Enemy alloc] initWithName:@"四" H:400 	A:103 	B:40 	C:103 	D:40 	S:95
                              ImageString:@"spirit83_4.png"],
              [[Enemy alloc] initWithName:@"四" H:400 	A:103 	B:40 	C:103 	D:40 	S:95
                              ImageString:@"spirit83_4.png"],
              nil];
    [arr addObject:subarr];
    
    //敵集団5
    subarr = [NSArray arrayWithObjects:
              [[Enemy alloc] initWithName:@"伍" H:400 	A:104 	B:40 	C:104 	D:40 	S:95
                              ImageString:@"spirit83_5.png"],
              [[Enemy alloc] initWithName:@"伍" H:400 	A:104 	B:40 	C:104 	D:40 	S:95
                              ImageString:@"spirit83_5.png"],
              [[Enemy alloc] initWithName:@"伍" H:400 	A:104 	B:40 	C:104 	D:40 	S:95
                              ImageString:@"spirit83_5.png"],
              [[Enemy alloc] initWithName:@"伍" H:400 	A:104 	B:40 	C:104 	D:40 	S:95
                              ImageString:@"spirit83_5.png"],
              [[Enemy alloc] initWithName:@"伍" H:400 	A:104 	B:40 	C:104 	D:40 	S:95
                              ImageString:@"spirit83_5.png"],
              nil];
    [arr addObject:subarr];
    
    //敵集団6
    subarr = [NSArray arrayWithObjects:
              [[Enemy alloc] initWithName:@"六" H:400 	A:105 	B:40 	C:105 	D:40 	S:95
                              ImageString:@"spirit83_6.png"],
              [[Enemy alloc] initWithName:@"七" H:1800 	A:110 	B:40 	C:110 	D:40 	S:105
                              ImageString:@"spirit83_7.png"],
              [[Enemy alloc] initWithName:@"六" H:400 	A:105 	B:40 	C:105 	D:40 	S:95
                              ImageString:@"spirit83_6.png"],
              nil];
    [arr addObject:subarr];
    
    
    exp = 124;
    stamina = 5;
    [self setBackgroundInt:0];
}

- (void)dungeon24{
    
    //推奨レベル14
    
    [self reset];
    NSLog(@"食物パラダイス生成 in Dungeon");
    
    // 敵集団1
    NSArray *subarr = [NSArray arrayWithObjects:
                       [[Enemy alloc] initWithName:@"人食いキノコ１" H:350 	A:103 	B:35 	C:103 	D:35 	S:92
                                       ImageString:@"plant01.png"],
                       [[Enemy alloc] initWithName:@"人食いキノコ２" H:350 	A:103 	B:35 	C:103 	D:35 	S:92
                                       ImageString:@"plant01.png"],
                       [[Enemy alloc] initWithName:@"人食いキノコ３" H:350 	A:103 	B:35 	C:103 	D:35 	S:92
                                       ImageString:@"plant01.png"],
                       nil];
    [arr addObject:subarr];
    
    // 敵襲団2
    subarr = [NSArray arrayWithObjects:
              [[Enemy alloc] initWithName:@"鬨の声１" H:400 	A:105 	B:50	C:105 	D:20 	S:100
                              ImageString:@"monster83.png"],
              [[Enemy alloc] initWithName:@"相思相愛煮干し" H:450 	A:106 	B:40	C:95 	D:40 	S:100
                              ImageString:@"undead28.png"],
              [[Enemy alloc] initWithName:@"鬨の声２" H:400 	A:105 	B:50	C:105 	D:20 	S:100
                              ImageString:@"monster83.png"],
              nil];
    [arr addObject:subarr];
    
    //敵集団3
    subarr = [NSArray arrayWithObjects:
              [[Enemy alloc] initWithName:@"相思相愛煮干し１" H:450 	A:106 	B:40	C:95 	D:40 	S:100
                              ImageString:@"undead28.png"],
              [[Enemy alloc] initWithName:@"鬨の声" H:400 	A:105 	B:50	C:105 	D:20 	S:100
                              ImageString:@"monster83.png"],
              [[Enemy alloc] initWithName:@"相思相愛煮干し２" H:450 	A:106 	B:40	C:95 	D:40 	S:100
                              ImageString:@"undead28.png"],
              nil];
    [arr addObject:subarr];
    //敵集団4
    subarr = [NSArray arrayWithObjects:
              [[Enemy alloc] initWithName:@"謎のプリン男" H:500 	A:107 	B:60	C:95 	D:0 	S:95
                              ImageString:@"solid04.png"],
              nil];
    [arr addObject:subarr];
    
    //敵集団5
    subarr = [NSArray arrayWithObjects:
              [[Enemy alloc] initWithName:@"謎のプリン男１" H:500 	A:107 	B:60	C:95 	D:0 	S:95
                              ImageString:@"solid04.png"],
              [[Enemy alloc] initWithName:@"謎のショートケーキ男" H:1800 	A:107 	B:60	C:95 	D:0 	S:95
                              ImageString:@"monster89.png"],
              [[Enemy alloc] initWithName:@"謎のプリン男２" H:500 	A:107 	B:60	C:95 	D:0 	S:95
                              ImageString:@"solid04.png"],
              nil];
    [arr addObject:subarr];
    
    
    exp = 124;
    stamina = 5;
    [self setBackgroundInt:0];
}


/*　ここから先、作成中
 
 - (void)dungeon25{
 [self reset];
 NSLog(@"いにしえの悪魔生成 in Dungeon");
 
 // 敵集団1
 NSArray *subarr = [NSArray arrayWithObjects:
 [[Enemy alloc] initWithName:@"フライングアイ１" H:200 	A:90 	B:20 	C:85 	D:20 	S:85
 ImageString:@"monster86.png"],
 nil];
 [arr addObject:subarr];
 
 // 敵襲団2
 subarr = [NSArray arrayWithObjects:
 [[Enemy alloc] initWithName:@"マミー" H:350 	A:95 	B:10	C:95 	D:50 	S:85
 ImageString:@"undead26.png"],
 nil];
 [arr addObject:subarr];
 
 //敵集団3
 subarr = [NSArray arrayWithObjects:
 [[Enemy alloc] initWithName:@"マミー" H:350 	A:95 	B:10	C:95 	D:50 	S:85
 ImageString:@"undead26.png"],
 nil];
 [arr addObject:subarr];
 //敵集団4
 subarr = [NSArray arrayWithObjects:
 [[Enemy alloc] initWithName:@"マミー１" H:350 	A:95 	B:10	C:95 	D:50 	S:85
 ImageString:@"undead26.png"],
 nil];
 [arr addObject:subarr];
 
 //敵集団5
 subarr = [NSArray arrayWithObjects:
 [[Enemy alloc] initWithName:@"マミー１" H:350 	A:95 	B:10	C:95 	D:50 	S:85
 ImageString:@"undead26.png"],
 nil];
 [arr addObject:subarr];
 
 
 exp = 124;
 stamina = 5;
 [self setBackgroundInt:0];
 }
 
 - (void)dungeon26{
 [self reset];
 NSLog(@"いにしえの悪魔生成 in Dungeon");
 
 // 敵集団1
 NSArray *subarr = [NSArray arrayWithObjects:
 [[Enemy alloc] initWithName:@"フライングアイ１" H:200 	A:90 	B:20 	C:85 	D:20 	S:85
 ImageString:@"monster86.png"],
 nil];
 [arr addObject:subarr];
 
 // 敵襲団2
 subarr = [NSArray arrayWithObjects:
 [[Enemy alloc] initWithName:@"マミー" H:350 	A:95 	B:10	C:95 	D:50 	S:85
 ImageString:@"undead26.png"],
 nil];
 [arr addObject:subarr];
 
 //敵集団3
 subarr = [NSArray arrayWithObjects:
 [[Enemy alloc] initWithName:@"マミー" H:350 	A:95 	B:10	C:95 	D:50 	S:85
 ImageString:@"undead26.png"],
 nil];
 [arr addObject:subarr];
 //敵集団4
 subarr = [NSArray arrayWithObjects:
 [[Enemy alloc] initWithName:@"マミー１" H:350 	A:95 	B:10	C:95 	D:50 	S:85
 ImageString:@"undead26.png"],
 nil];
 [arr addObject:subarr];
 
 //敵集団5
 subarr = [NSArray arrayWithObjects:
 [[Enemy alloc] initWithName:@"マミー１" H:350 	A:95 	B:10	C:95 	D:50 	S:85
 ImageString:@"undead26.png"],
 nil];
 [arr addObject:subarr];
 
 
 exp = 124;
 stamina = 5;
 [self setBackgroundInt:0];
 }
 
 - (void)dungeon27{
 [self reset];
 NSLog(@"いにしえの悪魔生成 in Dungeon");
 
 // 敵集団1
 NSArray *subarr = [NSArray arrayWithObjects:
 [[Enemy alloc] initWithName:@"フライングアイ１" H:200 	A:90 	B:20 	C:85 	D:20 	S:85
 ImageString:@"monster86.png"],
 nil];
 [arr addObject:subarr];
 
 // 敵襲団2
 subarr = [NSArray arrayWithObjects:
 [[Enemy alloc] initWithName:@"マミー" H:350 	A:95 	B:10	C:95 	D:50 	S:85
 ImageString:@"undead26.png"],
 nil];
 [arr addObject:subarr];
 
 //敵集団3
 subarr = [NSArray arrayWithObjects:
 [[Enemy alloc] initWithName:@"マミー" H:350 	A:95 	B:10	C:95 	D:50 	S:85
 ImageString:@"undead26.png"],
 nil];
 [arr addObject:subarr];
 //敵集団4
 subarr = [NSArray arrayWithObjects:
 [[Enemy alloc] initWithName:@"マミー１" H:350 	A:95 	B:10	C:95 	D:50 	S:85
 ImageString:@"undead26.png"],
 nil];
 [arr addObject:subarr];
 
 //敵集団5
 subarr = [NSArray arrayWithObjects:
 [[Enemy alloc] initWithName:@"マミー１" H:350 	A:95 	B:10	C:95 	D:50 	S:85
 ImageString:@"undead26.png"],
 nil];
 [arr addObject:subarr];
 
 
 exp = 124;
 stamina = 5;
 [self setBackgroundInt:0];
 }
 
 - (void)dungeon28{
 [self reset];
 NSLog(@"いにしえの悪魔生成 in Dungeon");
 
 // 敵集団1
 NSArray *subarr = [NSArray arrayWithObjects:
 [[Enemy alloc] initWithName:@"フライングアイ１" H:200 	A:90 	B:20 	C:85 	D:20 	S:85
 ImageString:@"monster86.png"],
 nil];
 [arr addObject:subarr];
 
 // 敵襲団2
 subarr = [NSArray arrayWithObjects:
 [[Enemy alloc] initWithName:@"マミー" H:350 	A:95 	B:10	C:95 	D:50 	S:85
 ImageString:@"undead26.png"],
 nil];
 [arr addObject:subarr];
 
 //敵集団3
 subarr = [NSArray arrayWithObjects:
 [[Enemy alloc] initWithName:@"マミー" H:350 	A:95 	B:10	C:95 	D:50 	S:85
 ImageString:@"undead26.png"],
 nil];
 [arr addObject:subarr];
 //敵集団4
 subarr = [NSArray arrayWithObjects:
 [[Enemy alloc] initWithName:@"マミー１" H:350 	A:95 	B:10	C:95 	D:50 	S:85
 ImageString:@"undead26.png"],
 nil];
 [arr addObject:subarr];
 
 //敵集団5
 subarr = [NSArray arrayWithObjects:
 [[Enemy alloc] initWithName:@"マミー１" H:350 	A:95 	B:10	C:95 	D:50 	S:85
 ImageString:@"undead26.png"],
 nil];
 [arr addObject:subarr];
 
 
 exp = 124;
 stamina = 5;
 [self setBackgroundInt:0];
 }
 
 - (void)dungeon29{
 [self reset];
 NSLog(@"いにしえの悪魔生成 in Dungeon");
 
 // 敵集団1
 NSArray *subarr = [NSArray arrayWithObjects:
 [[Enemy alloc] initWithName:@"フライングアイ１" H:200 	A:90 	B:20 	C:85 	D:20 	S:85
 ImageString:@"monster86.png"],
 nil];
 [arr addObject:subarr];
 
 // 敵襲団2
 subarr = [NSArray arrayWithObjects:
 [[Enemy alloc] initWithName:@"マミー" H:350 	A:95 	B:10	C:95 	D:50 	S:85
 ImageString:@"undead26.png"],
 nil];
 [arr addObject:subarr];
 
 //敵集団3
 subarr = [NSArray arrayWithObjects:
 [[Enemy alloc] initWithName:@"マミー" H:350 	A:95 	B:10	C:95 	D:50 	S:85
 ImageString:@"undead26.png"],
 nil];
 [arr addObject:subarr];
 //敵集団4
 subarr = [NSArray arrayWithObjects:
 [[Enemy alloc] initWithName:@"マミー１" H:350 	A:95 	B:10	C:95 	D:50 	S:85
 ImageString:@"undead26.png"],
 nil];
 [arr addObject:subarr];
 
 //敵集団5
 subarr = [NSArray arrayWithObjects:
 [[Enemy alloc] initWithName:@"マミー１" H:350 	A:95 	B:10	C:95 	D:50 	S:85
 ImageString:@"undead26.png"],
 nil];
 [arr addObject:subarr];
 
 
 exp = 124;
 stamina = 5;
 [self setBackgroundInt:0];
 }
 
 - (void)dungeon30{
 [self reset];
 NSLog(@"いにしえの悪魔生成 in Dungeon");
 
 // 敵集団1
 NSArray *subarr = [NSArray arrayWithObjects:
 [[Enemy alloc] initWithName:@"フライングアイ１" H:200 	A:90 	B:20 	C:85 	D:20 	S:85
 ImageString:@"monster86.png"],
 nil];
 [arr addObject:subarr];
 
 // 敵襲団2
 subarr = [NSArray arrayWithObjects:
 [[Enemy alloc] initWithName:@"マミー" H:350 	A:95 	B:10	C:95 	D:50 	S:85
 ImageString:@"undead26.png"],
 nil];
 [arr addObject:subarr];
 
 //敵集団3
 subarr = [NSArray arrayWithObjects:
 [[Enemy alloc] initWithName:@"マミー" H:350 	A:95 	B:10	C:95 	D:50 	S:85
 ImageString:@"undead26.png"],
 nil];
 [arr addObject:subarr];
 //敵集団4
 subarr = [NSArray arrayWithObjects:
 [[Enemy alloc] initWithName:@"マミー１" H:350 	A:95 	B:10	C:95 	D:50 	S:85
 ImageString:@"undead26.png"],
 nil];
 [arr addObject:subarr];
 
 //敵集団5
 subarr = [NSArray arrayWithObjects:
 [[Enemy alloc] initWithName:@"マミー１" H:350 	A:95 	B:10	C:95 	D:50 	S:85
 ImageString:@"undead26.png"],
 nil];
 [arr addObject:subarr];
 
 
 exp = 124;
 stamina = 5;
 [self setBackgroundInt:0];
 }
 */




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
