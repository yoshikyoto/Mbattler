//
//  DungeonViewController.m
//  Mbattler
//
//  Created by Yoshiyuki Sakamoto on 2013/04/06.
//  Copyright (c) 2013年 Mbattler. All rights reserved.
//

#import "DungeonViewController.h"
#import "AppDelegate.h"
#import "Meishi.h"
#import "Player.h"
#import "Enemy.h"
#import "Dungeon.h"
#import "MBCharacter.h"
#import "MBAnimationView.h"
#import "MBScrollView.h"
#import "DamageValueLabel.h"
#import "MBAbilityCutin.h"
#import "UIOutlineLabel.h"
#import "MBButton.h"
#import "MBButton.h"

@interface DungeonViewController ()

@end

@implementation DungeonViewController


- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (id)initWithPlayer:(Player *)p{
    self = [super init];
    if(self){
        player = p;
    }
    return self;
}


// 外部メソッド
// ダンジョンの情報を登録する
- (void)setDungeon:(Dungeon *)d{
    NSLog(@"DungeonViewController: ダンジョンの情報をセット");
    dungeon = d;
}

- (void)setPlayer:(Player *)p{
    NSLog(@"DungeonViewController: Playerの情報をセット");
    player = p;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    NSLog(@"%s", __func__);
    
    // パーティを取得し、戦闘参加者配列に突っ込む
    party = [player getParty];
    // 味方を初期化
    [player reflesh];
    for(int i = 0; i < [party count]; i++){
        Meishi *meishi = [party objectAtIndex:i];
        [meishi prepareForDungeon];
    }
    combatant = [[NSMutableArray alloc] init];
    [self addCombatants:party];
    
    // 画面の縦横所取得
    CGRect screen_rect = [UIScreen mainScreen].applicationFrame;
    int h = screen_rect.size.height;
    int position_y = 15;
    
    // ダンジョン名の背景部分表示
    navImage = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"dungeonNav.png"]];
    navImage.frame = CGRectMake(-119, -40, 558, 100);
    [[self view] addSubview:navImage];
    
    // ポーズボタン
    UIButton *pause_button = [UIButton buttonWithType:UIButtonTypeCustom];
    pause_button.frame = CGRectMake(280, 5, 40, 40);
    pause_button.backgroundColor = [UIColor colorWithRed:0.6 green:0.3 blue:0.05 alpha:0.5];
    [pause_button setTitle:@"止" forState:UIControlStateNormal];
    pause_button.titleLabel.font = [UIFont fontWithName:@"mikachan_o" size:16];
    [pause_button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [pause_button addTarget:self action:@selector(pauseButtonTapped:) forControlEvents:UIControlEventTouchUpInside];
    [[self view] addSubview:pause_button];
    pause_flag = false;
    battle_continue_flag = true;
    
    // ダンジョン名を取得して表示
    title = [[UILabel alloc] initWithFrame:CGRectMake(0, position_y, 320, 30)];
    title.text = [dungeon getName];
    title.font = [UIFont fontWithName:@"mikachan_o" size:16]; //[UIFont systemFontOfSize:18];
    title.textAlignment = NSTextAlignmentCenter;
    title.backgroundColor = [UIColor clearColor];
    [[self view] addSubview:title];
    position_y += 30;
    
    
    // 背景イメージの設定
    UIImageView *bg = [dungeon getBackground];
    bg.frame = CGRectMake(0, position_y, 320, 240);
    [[self view] addSubview:bg];
    position_y += 240;
    
    // アイテム　薬草
    item1_button = [UIButton buttonWithType:UIButtonTypeCustom];
    [item1_button setBackgroundImage:[UIImage imageNamed:@"yakusou.png"] forState:UIControlStateNormal];
    item1_button.frame = CGRectMake(232, position_y, 44, 44);
    item1_button.backgroundColor = [UIColor lightGrayColor];
    item1_button.tag = 1;
    [item1_button addTarget:self action:@selector(itemTapped:) forControlEvents:UIControlEventTouchUpInside];
    [item1_button setTitle:[NSString stringWithFormat:@"x%d",[player getNumOfItem:1]] forState:UIControlStateNormal];
    [item1_button setTitleColor:[UIColor yellowColor] forState:UIControlStateNormal];
    [item1_button setTitleEdgeInsets:UIEdgeInsetsMake(20, 0, 0, 0)];
    [[self view] addSubview:item1_button];
    
    // アイテム　果実
    item2_button = [UIButton buttonWithType:UIButtonTypeCustom];
    [item2_button setBackgroundImage:[UIImage imageNamed:@"ringo.png"] forState:UIControlStateNormal];
    item2_button.frame = CGRectMake(276, position_y, 44, 44);
    item2_button.backgroundColor = [UIColor lightGrayColor];
    item2_button.tag = 2;
    [item2_button addTarget:self action:@selector(itemTapped:) forControlEvents:UIControlEventTouchUpInside];
    [item2_button setTitle:[NSString stringWithFormat:@"x%d",[player getNumOfItem:2]] forState:UIControlStateNormal];
    [item2_button setTitleColor:[UIColor yellowColor] forState:UIControlStateNormal];
    [item2_button setTitleEdgeInsets:UIEdgeInsetsMake(20, 0, 0, 0)];
    [[self view] addSubview:item2_button];
    
    // conbatant表示部分
    combatant_view = [[MBConbatantView alloc] initWithFrame:CGRectMake(0, position_y, 232, 44)];
    [[self view] addSubview:combatant_view];
    
    position_y += 44;
    
    

    
    // ポーズマスク
    mask_view = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, 320, 600)];
    mask_view.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:1.0];
    
    UIOutlineLabel *pause_label = [[UIOutlineLabel alloc] init];
    [pause_label setOutlineColor:[UIColor whiteColor]];
    [pause_label setOutlineWidth:3];
    pause_label.textAlignment = NSTextAlignmentCenter;
    pause_label.font = [UIFont fontWithName:@"mikachan_o" size:30];
    pause_label.text = @"ＰＡＵＳＥ";
    pause_label.textColor = [UIColor colorWithRed:0.6 green:0.3 blue:0.05 alpha:1.0];
    pause_label.frame = CGRectMake(30, 50, 260, 40);
    pause_label.backgroundColor = [UIColor clearColor];
    [mask_view addSubview:pause_label];
    
    UIOutlineLabel *pause_dungeon_label = [[UIOutlineLabel alloc] init];
    [pause_dungeon_label setOutlineColor:[UIColor whiteColor]];
    [pause_dungeon_label setOutlineWidth:3];
    pause_dungeon_label.textAlignment = NSTextAlignmentCenter;
    pause_dungeon_label.font = [UIFont fontWithName:@"mikachan_o" size:12];
    pause_dungeon_label.text = [dungeon getName];
    pause_dungeon_label.textColor = [UIColor grayColor]; //[UIColor colorWithRed:0.6 green:0.3 blue:0.05 alpha:1.0];
    pause_dungeon_label.frame = CGRectMake(30, 90, 260, 40);
    pause_dungeon_label.backgroundColor = [UIColor clearColor];
    [mask_view addSubview:pause_dungeon_label];

    UIButton *continue_button = [UIButton buttonWithType:UIButtonTypeCustom];
    [continue_button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    continue_button.titleLabel.font = [UIFont fontWithName:@"mikachan_o" size:20];
    continue_button.frame = CGRectMake(30, 160, 260, 40);
    continue_button.backgroundColor = [UIColor colorWithRed:0.7 green:0.7 blue:1.0 alpha:1.0];
    [continue_button setTitle:@"続ける" forState:UIControlStateNormal];
    [continue_button addTarget:self action:@selector(continueButtonTapped:) forControlEvents:UIControlEventTouchUpInside];
    [mask_view addSubview:continue_button];
    
    UIButton *retire_button = [UIButton buttonWithType:UIButtonTypeCustom];
    [retire_button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    retire_button.titleLabel.font = [UIFont fontWithName:@"mikachan_o" size:20];
    retire_button.frame = CGRectMake(30, 220, 260, 40);
    retire_button.backgroundColor = [UIColor colorWithRed:1.0 green:0.6 blue:0.6 alpha:1.0];
    [retire_button setTitle:@"リタイアする" forState:UIControlStateNormal];
    [retire_button addTarget:self action:@selector(ritireButtonTapped:) forControlEvents:UIControlEventTouchUpInside];
    [mask_view addSubview:retire_button];
    
    
    // アイテムフラグの初期化
    item_flag = -1;
    // アイテム説明ラベルの初期化
    item_desc = [[UILabel alloc] init];
    item_desc.backgroundColor = [UIColor colorWithRed:0.8 green:0.8 blue:0.8 alpha:0.6];
    item_desc.frame = CGRectMake(0, position_y, 320, 20);
    item_desc.textAlignment = NSTextAlignmentRight;
    if(dungeon.id == 0){
        // チュートリアルなので
        item_desc.text = @"アイテムで体力回復ができます↓";
        [[self view] addSubview:item_desc];
    }
    position_y += 20;

    
    // キャラクターアイコン部分
    MBMassageLabel *party_view = [[MBMassageLabel alloc] initWithFrame:CGRectMake(0, position_y, 320, 48)];
    [party_view setInnerBackgroundColor:[UIColor orangeColor]];
    [[self view] addSubview:party_view];
    for(int i = 0; i < [party count]; i++){
        Meishi *meishi = [party objectAtIndex:i];
        // 名前
        meishi.nameLabel.frame = CGRectMake(i*64+2, position_y+5, 60, 12);
        meishi.nameLabel.textAlignment = NSTextAlignmentLeft;
        [[self view] addSubview:meishi.nameLabel];
        
        // アイコン
        meishi.battleIcon.frame = CGRectMake(i*64+2, position_y+12, 32, 32);
        [[self view] addSubview:meishi.battleIcon];
        
        // HP
        UIOutlineLabel *hp_label = [[UIOutlineLabel alloc] init];
        hp_label.frame = CGRectMake(i*64+30, position_y+20, 34, 12);
        [hp_label setCharacterName:@"HP"];
        hp_label.textAlignment = NSTextAlignmentLeft;  
        [[self view] addSubview:hp_label];
        meishi.hpValueLabel.frame = CGRectMake(i*64+30, position_y+32, 34, 12);
        meishi.hpValueLabel.textAlignment = NSTextAlignmentRight;
        [[self view] addSubview:meishi.hpValueLabel];
        
        UILabel *border_label = [[UILabel alloc] initWithFrame:CGRectMake(i*64+64, position_y+5, 1, 38)];
        border_label.backgroundColor = [UIColor whiteColor];
        [[self view] addSubview:border_label];
    }
    position_y += 48;


    // メッセージウィンドウ(旧)
    /*
    messege_window = [[UITextView alloc] initWithFrame:CGRectMake(0, position_y, 320, h-position_y)];
    messege_window.editable = NO;
    messege_window.font = [UIFont systemFontOfSize:16];
    messege_window.backgroundColor = [UIColor colorWithRed:0.95 green:0.95 blue:0.95 alpha:1.0];
    messege_window.text = @"タップで戦闘を開始します";
    [[self view] addSubview:messege_window];
     */
    
    self.view.backgroundColor = [UIColor colorWithRed:0.95 green:0.95 blue:0.95 alpha:1.0];
    
    // メッセージウインドウ（新）
    message = [[MBMassageLabel alloc] initWithFrame:CGRectMake(0, position_y, 320, 80)];
    [message setNumberOfLines:3];
    [message setText:@"タップして戦闘を開始します"];
    [message addText:@"戦闘はオートで進みます"];
    [message showNextButton];
    [[self view] addSubview:message];
    
    // ability queue の初期化
    ability_meishi_queue = [[NSMutableArray alloc] init];
    
    // 味方を描写
    [self drawParty];
    
    // 画面をタップした時に戦闘が始まるようにする
    tap_alert_image = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"tap_to_start.png"]];
    tap_alert_image.frame = CGRectMake(35, 200, 250, 65);
    [[self view] addSubview:tap_alert_image];
    
    tgr = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(battle:)];
    [[self view] addGestureRecognizer:tgr];
}

- (void)pauseButtonTapped:(UIButton *)sender{
    pause_flag = true;
}

- (void)continueButtonTapped:(UIButton *)sender{
    pause_flag = false;
    [mask_view removeFromSuperview];
}

- (void)ritireButtonTapped:(UIButton *)sender{
    battle_continue_flag = false;
    exp = 0;
    [mask_view removeFromSuperview];
    pause_flag = false;
}


- (void)battle:(UITapGestureRecognizer *)sender{
    // NSLog(@"戦闘開始");
    // スクリーンタップイベンターを除去
    [[self view] removeGestureRecognizer:tgr];
    [message removeNextButton];
    [tap_alert_image removeFromSuperview];
    // アイテム使えるようにフラグたてる
    item_flag = 0;
    
    // チュートリアルの説明
    if(dungeon.id == 0){
        UIImageView *baloon_image = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"enemy_tap_baloon.png"]];
        baloon_image.frame = CGRectMake(60, 40, 200, 60);
        [[self view] addSubview:baloon_image];
    }
    
    // 戦闘開始前のアビリティ for 味方
    
    [self startupAblityForParty];
    
    NSLog(@"%s 敵の長さ %d", __func__, [dungeon getLength]);
    // 敵の長さだけループ
    eimgs = [[NSMutableArray alloc] init];
    enemy = [[dungeon next] mutableCopy];
    while(enemy) {
        NSLog(@"%s 敵の長さ %d", __func__, [dungeon getLength]);
        // enemy に次の敵を取得 -> combatant にぶちこむ
        
        enemy_const = [enemy copy];
        [self addCombatants:enemy];
        // 敵を描写
        [self appear];
        //[self addMessege:@"敵が出現!"];
        if([enemy_const count] ==1){
            Enemy *representative_enemy = [enemy_const objectAtIndex:0];
            [message setText:[NSString stringWithFormat:@"%@ が あらわれた！", [representative_enemy getName]]];
        }else{
            Enemy *representative_enemy = [enemy_const objectAtIndex:0];
            [message setText:[NSString stringWithFormat:@"%@たち が あらわれた！", [representative_enemy getName]]];
        }
        //[message setText:@"敵が出現！"]:
        // 敵が出現した時に発動するスタートアップアビリティ
        [self startupAbilityToEnemy];
        
        // ゲームループに入る
        NSLog(@"%s gameLoop", __func__);
        turn = 0;
        while((!([player isDead] || [dungeon isDead]))&&battle_continue_flag){ // どちらかが全滅するまで
            // NSLog(@"ゲームループ");
            // ウェイトを入れる
            [[NSRunLoop currentRunLoop] runUntilDate:[NSDate dateWithTimeIntervalSinceNow:0.5]];
            
            // 特殊能力--------------------------------------------------------------------------
            if([ability_meishi_queue count] >= 1){
                
                NSLog(@"%s 特殊能力発動", __func__);
                Meishi *attacker = [ability_meishi_queue objectAtIndex:0];
                [ability_meishi_queue removeObjectAtIndex:0];
                // 単体攻撃か全体攻撃かで分類
                switch([attacker getAbilityID]){
                    // 単体攻撃の場合-----------------------------------------
                    case 0: // ギガインパクト
                    case 1: // 破壊光線
                    case 8: // ソニックブーム
                    {
                        Enemy *defender;
                        if(target){
                            // もしtargetが決まっているなら そいつに攻撃
                            defender = target;
                        }else{
                            // 決まってなかったら0の奴に攻撃
                            defender = [enemy objectAtIndex:0];
                        }
                        [message setText:[NSString stringWithFormat:@"%@ の %@！", [attacker getName], [attacker getAbilityString]]];
                        // カットイン
                        MBAbilityCutin *cutin = [[MBAbilityCutin alloc] initWithMeishi:attacker];
                        [[self view] addSubview:cutin];
                        [[NSRunLoop currentRunLoop] runUntilDate:[NSDate dateWithTimeIntervalSinceNow:1]];
                        [cutin removeFromSuperview];
                        
                        int damage = [attacker abilityAttack:defender];
                        // ダメージ数値描写
                        // [self viewDamage:[defender getBattleImage] :damage];
                        [message addText:[NSString stringWithFormat:@"%@ に %d のダメージ！",[defender getName], damage]];

                        // デバッグ用
                        NSLog(@"%s %@ -> %@ %d",__func__ , [attacker getName], [defender getName], damage);
                        // 倒した場合
                        if([defender isDead]) [self beatEnemy:defender];
     
                        break;
                    }
                    case 2:
                    {   // 自己再生---------------------------------------------
                        // 攻撃対象の情報は必要ない
                        [message setText:[NSString stringWithFormat:@"%@ の %@！", [attacker getName], [attacker getAbilityString]]];
                        // カットイン
                        MBAbilityCutin *cutin = [[MBAbilityCutin alloc] initWithMeishi:attacker];
                        [[self view] addSubview:cutin];
                        [[NSRunLoop currentRunLoop] runUntilDate:[NSDate dateWithTimeIntervalSinceNow:1]];
                        [cutin removeFromSuperview];
                        
                        int recover = [attacker abilityAttack:nil];
                        CGRect rect = [attacker getBattleImage].frame;
                        int x = rect.origin.x; // + rect.size.width // 2.0;
                        int y = rect.origin.y + rect.size.height / 2.0;
                        DamageValueLabel *dl = [[DamageValueLabel alloc] init];
                        dl.text = [NSString stringWithFormat:@"%3.0d", recover];
                        dl.center = CGPointMake(x, y);
                        //dl.textAlignment = NSTextAlignmentCenter;
                        dl.textColor = [UIColor yellowColor];
                        [[self view] addSubview:dl];
                        [dl startAnimation];
                        [message addText:[NSString stringWithFormat:@"HPを%d回復した！", recover]];
                        break;
                    }
                    case 10: // 鳴き声
                    case 11: // しっぽをふる
                    case 12: // バークアウト
                    case 13: // うそなき
                    case 20: // 岩雪崩
                    case 21: // 波乗り
                    {   // 全体攻撃の場合----------------------------------------
                        // 必殺技名表示
                        [message setText:[NSString stringWithFormat:@"%@ の %@！", [attacker getName], [attacker getAbilityString]]];
                        // カットイン
                        MBAbilityCutin *cutin = [[MBAbilityCutin alloc] initWithMeishi:attacker];
                        [[self view] addSubview:cutin];
                        [[NSRunLoop currentRunLoop] runUntilDate:[NSDate dateWithTimeIntervalSinceNow:1]];
                        [cutin removeFromSuperview];
                        
                        [attacker abilityAttackWhole:enemy];
                        // 敵全体に対して、倒したかどうか判定が必要
                        for(int i = 0; i < [enemy count]; i++){
                            Enemy *e = [enemy objectAtIndex:i];
                            if([e isDead]) [self beatEnemy:e];
                        }
                    }
                }
            }else{
                // 通常攻撃の場合---------------------------------------------------------------------------------------
                // 攻撃キャラを決める
                MBCharacter *attacker = [combatant objectAtIndex:(turn % [combatant count])];
                [message setText:[NSString stringWithFormat:@"%@ の攻撃！", [attacker getName]]];

                if([attacker isPlayer]){
                    // プレイヤーの攻撃→ターゲットは敵
                    // 攻撃対象を決定
                    Enemy *defender;
                    if(target){
                         // もしtargetが決まっているなら そいつに攻撃
                        defender = target;
                    }else{
                        // 決まってなかったら0の奴に攻撃
                        defender = [enemy objectAtIndex:0];
                    }
                    // defender に攻撃
                    int damage = [(Meishi *)attacker attack:defender];
                    // メッセージ表示
                    [message addText:[NSString stringWithFormat:@"%@ に %d のダメージ！",[defender getName], damage]];
                    // デバッグ用
                    NSLog(@"%s %@(%d) -> %@(%d) %d",__func__ , [attacker getName], [attacker getA], [defender getName], [defender getB], damage);
                    // 倒した
                    if([defender isDead]){
                    NSLog(@"%s 敵を倒した", __func__);
                    [self beatEnemy:defender];
                    // 自信過剰はここで処理
                    if([(Meishi *)attacker getAbilityID] == 7){
                        NSLog(@"%s 自信過剰が発動", __func__);
                        [self viewCutin:(Meishi *)attacker];
                        [attacker multParameter:1 :0.1];
                        [attacker multParameter:3 :0.1];
                    }
                }
                }else{
                    // 敵の攻撃対象 ランダム
                    Meishi *defender = [party objectAtIndex:arc4random()%[party count]];
                    // とりあえず物理に攻撃
                    int damage = [(Enemy *)attacker attack:defender];
                    // メッセージを表示
                    [message addText:[NSString stringWithFormat:@"%@ に %d のダメージ！",[defender getName], damage]];
                    // デバッグ用
                    NSLog(@"%s %@(%d) -> %@(%d) %d",__func__ , [attacker getName], [attacker getA], [defender getName], [defender getB], damage);
                    if([defender isDead]){  // 倒した場合
                        [message addText:[NSString stringWithFormat:@"%@ は倒れた！", [defender getName]]];
                        // conbatantから除去
                        [self removeCombatant:defender];
                        [party removeObject:defender];
                    }
                    // 鮫肌の可能性もあるので
                    if([attacker isDead]) [self beatEnemy:(Enemy *)attacker];
                }
                turn++;
                if(turn >= [combatant count]) turn = 0;
            }
            [[NSRunLoop currentRunLoop] runUntilDate:[NSDate dateWithTimeIntervalSinceNow:0.5]];
            // ポーズ判定
            if(pause_flag){
                NSLog(@"%s ポーズ中…", __func__);
                [[self view] addSubview:mask_view];
                // ポーズが解かれるまで停止
                while(pause_flag){
                [[NSRunLoop currentRunLoop] runUntilDate:[NSDate dateWithTimeIntervalSinceNow:0.1]];
                }
                // タイトルだけ全面に持ってくる
                //[[self view] bringSubviewToFront:navImage];
                //[[self view] bringSubviewToFront:title];
            }
        }// ゲームループの終わり
        
        NSLog(@"%s end of gameLoop", __func__);
        // ウェイト
        [[NSRunLoop currentRunLoop] runUntilDate:[NSDate dateWithTimeIntervalSinceNow:1]];
        
        // 結果画面のセット
        if([dungeon isCleard]){
            // 勝利した場合
            exp = [dungeon getExp];
            break;
        }else if([player isDead] || !battle_continue_flag){
            // 全滅した場合
            // 経験値0 →　敗北と判定される。
            exp = 0;
            break;
        }
        
        enemy = [[dungeon next] mutableCopy];
    }
    
    // アイテム使用不可に
    item_flag = -1;
    if(battle_continue_flag){
        if(dungeon.id == 0){
            UIImageView *tap_to_result_image = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"tap_to_result.png"]];
            tap_to_result_image.frame = CGRectMake(35, 100, 250, 100);
            [[self view] addSubview:tap_to_result_image];
        }
        // タッチイベントリスナー
        tgr = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(viewResult:)];
        [[self view] addGestureRecognizer:tgr];
    }else{
        [self viewResult:nil];
    }
}

// 戦闘開始時に味方全体に効果のあるアビリティ
- (void)startupAblityForParty{
    NSLog(@"%s", __func__);
    for(int i = 0; i < [party count]; i++){
        Meishi *meishi = [party objectAtIndex:i];
        switch ([meishi getAbilityID]) {
            case 15: // 剣の舞
            case 16: // 鉄壁
            case 17: // 悪巧み
            case 18: // ど忘れ
            case 19: // 高速移動
                [self addMessege:[NSString stringWithFormat:@"%@ の %@！", [meishi getName], [meishi getAbilityString]]];
                [self viewCutin:meishi];
                [meishi startupAbilityForParty:party];
                break;
        }
    }
}

// 敵出現時に敵に効果を及ぼすスタートアップアビリティ
- (void)startupAbilityToEnemy{
    NSLog(@"%s", __func__);
    
    for(int i = 0; i < [party count]; i++){
        Meishi *meishi = [party objectAtIndex:i];
        switch ([meishi getAbilityID]) {
            case 3: // 威嚇
                [self addMessege:[NSString stringWithFormat:@"%@ の %@！", [meishi getName], [meishi getAbilityString]]];
                [self viewCutin:meishi];
                [meishi startupAbilityToEnemy:enemy];
                break;
        }
    }
}

- (void)viewCutin:(Meishi *)meishi{
    MBAbilityCutin *cutin = [[MBAbilityCutin alloc] initWithMeishi:meishi];
    [[self view] addSubview:cutin];
    [[NSRunLoop currentRunLoop] runUntilDate:[NSDate dateWithTimeIntervalSinceNow:1]];
    [cutin removeFromSuperview];
}

// 敵を倒した時に呼ぶ関数
- (void)beatEnemy:(Enemy *)e{
    // 倒した場合
    // ここで間を置く
    [[NSRunLoop currentRunLoop] runUntilDate:[NSDate dateWithTimeIntervalSinceNow:0.5]];
    // メッセージを表示
    [message addText:[NSString stringWithFormat:@"%@ を 倒した！", [e getName]]];
    // combatantから除去
    [self removeCombatant:e];
    // リストからも除去してしまおう
    [enemy removeObject:e];
    // 画像を除去
    [e removeBattleImage];
    // 必要ならポインタの差し替え
    if(target == e){
        target = nil;
    }
}

// ダメージを表示させる関数
- (void)viewDamage:(UIView *)view :(int)damage{
    // ダメージ描写
    CGRect rect = view.frame;
    int x = rect.origin.x; // + rect.size.width // 2.0;
    int y = rect.origin.y + rect.size.height / 2.0;
    DamageValueLabel *dl = [[DamageValueLabel alloc] init];
    dl.text = [NSString stringWithFormat:@"%3.0d", damage];
    dl.center = CGPointMake(x, y);
    //dl.textAlignment = NSTextAlignmentCenter;
    dl.textColor = [UIColor whiteColor];
    [[self view] addSubview:dl];
    [dl startAnimation];
}

// メッセージボックスにstrを表示させる関数
- (void)setMessege:(NSString *)str{
    messege.text = str;
}

// メッセージボックスに追記する関数
- (void)addMessege:(NSString *)str{
    messege_window.text = [NSString stringWithFormat:@"%@\n%@", messege_window.text, str];
    // 追記した分下にスクロール
    messege_window.scrollEnabled = NO;  // turn off scrolling or you'll get dizzy ... I promise
    NSRange range = messege_window.selectedRange;
    range.location += [str length];
    messege_window.selectedRange = range;
    messege_window.scrollEnabled = YES;  // turn scrolling back on.
}

// combatant にリストを突っ込む ---------------------------------------------------------------
- (void)addCombatants:(NSMutableArray *)array{
    for(int i = 0; i < [array count]; i++){
        NSLog(@"combatant に突っ込む");
        [self addCombatant:[array objectAtIndex:i]];
    }
}

// combatant に一人突っ込む
- (void)addCombatant:(MBCharacter *)chr{
    // とりあえず、誰も入ってなかったらそのまま突っ込む(これ必要かな？)
    if([combatant count] == 0){
        [combatant addObject:chr];
    }else{
        for(int i = 0; i < [combatant count]; i++){
            if([[combatant objectAtIndex:i] getS] < [chr getS]){
                [combatant insertObject:chr atIndex:i];
                return;
            }
        }
        [combatant addObject:chr];
    }
}

// combatamt からキャラを除外する
- (void)removeCombatant:(MBCharacter *)chr{
    int position = [combatant indexOfObject:chr];
    if((position != -1)&&(position <= turn%[combatant count])){
        turn --;
        NSLog(@"indexOfObject %d",position);
    }
    [combatant removeObject:chr];
}

// キャラ画像描写 ------------------------------------------------------------------------------------------
- (void)drawParty{
    NSLog(@"パーティ描写");
    for(int i = 0; i < [player getPartynum]; i++){
        Meishi *m = [player getMeishi:i];
        UIImageView *view = [m getBattleImage];
        view.tag = i;
        // タップイベントを取得
        view.userInteractionEnabled = true;
        UITapGestureRecognizer *etgr = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(partyTapped:)];
        [view addGestureRecognizer:etgr]; // 狙い変更のための

        //UIImageView *hp0view = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"hp0.png"]];
        //UIImageView *hp1view;
        int x = 0;
        int y = 0;
        switch(i){
            case 0:
                x = 30;
                y = 100;
                break;
            case 1:
                x = 30;
                y = 160;
                break;
            case 2:
                x = 30;
                y = 220;
                break;
            case 3:
                x = 80;
                y = 130;
                break;
            case 4:
                x = 80;
                y = 190;
                break;
        }
        
        view.frame = CGRectMake(x, y, 32, 48);
        //hp0view.frame = CGRectMake(x, y+48, 32, 5);
        //hp1view = [m getHpBar:x :y+48];
        UIImageView *hpbar = [m getHPBarWithFrame:CGRectMake(x, y+48, 32, 5)];
        [[self view] addSubview:view];
        //[[self view] addSubview:hp0view];
        //[[self view] addSubview:hp1view];
        [[self view] addSubview:hpbar];
    }
}

// 味方がタップされた時
- (void)partyTapped:(UITapGestureRecognizer *)t{
    NSLog(@"%s", __func__);
    
    // 戦闘終了時はタップ無効
    if(item_flag == -1) return;
    
    // 対象の名刺を取得
    Meishi *meishi = [player getMeishi:t.view.tag];
    switch (item_flag) {
        // 薬草のとき
        case 1:
            // 薬草を使うかどうかの判断
            switch ([meishi recover:0]) {
                // 対象キャラが死んでいるとき
                case -1:
                    item_desc.text = @"死んでいます";
                    break;
                // 対象キャラのHPが全快のとき
                case 0:
                    item_desc.text = @"HPが満タンです";
                    break;
                // 使用できるとき
                default:
                    // 回復できた場合
                    // エフェクト描写
                    MBAnimationView *effect = [[MBAnimationView alloc] init];
                    [effect setAnimationImage:@"recover.png" :120 :120 :8];
                    CGRect rect = t.view.frame;
                    // エフェクトの位置調整
                    rect.origin.x = rect.origin.x + rect.size.width / 2.0 - 30;
                    rect.origin.y = rect.origin.y - 15;
                    rect.size.width = 60;
                    rect.size.height = 60;
                    effect.frame = rect;
                    effect.animationDuration = 0.8;
                    [[self view] addSubview:effect];
                    [effect startAnimating];
                    // アイテムを消費
                    [player useItem:1];
                    // 個数を再描写
                    [item1_button setTitle:[NSString stringWithFormat:@"x%d",[player getNumOfItem:1]] forState:UIControlStateNormal];
                    // 選択を解除
                    item_flag = 0;
                    item1_button.backgroundColor = [UIColor lightGrayColor];
                    [item_desc removeFromSuperview];
                    break;
            }
            break;
            
        // 復活の果実の時
        case 2:
            // 回復
            if([meishi revive]){
                // 回復できた場合選択を解除
                item_flag = 0;
                item2_button.backgroundColor = [UIColor lightGrayColor];
                [item_desc removeFromSuperview];
                // エフェクト
                // エフェクト描写
                MBAnimationView *effect = [[MBAnimationView alloc] init];
                [effect setAnimationImage:@"revive.png" :120 :120 :8];
                CGRect rect = t.view.frame;
                // 位置調整
                rect.origin.x = rect.origin.x + rect.size.width / 2.0 - 40;
                rect.origin.y = rect.origin.y - 25;
                rect.size.width = 80;
                rect.size.height = 80;
                effect.frame = rect;
                effect.animationDuration = 0.8;
                [[self view] addSubview:effect];
                [effect startAnimating];
                // アイテムを消費
                [player useItem:2];
                // 個数を再描写
                [item2_button setTitle:[NSString stringWithFormat:@"x%d",[player getNumOfItem:2]] forState:UIControlStateNormal];
                // 戦闘復帰
                [self addCombatant:meishi];
                [party addObject:meishi];
            }else{
                // 死んでなかった場合
                item_desc.text = @"死んでいません";
            }
            break;
            
        // アイテムボタンがタップされてないとき
        default:
            if([meishi tapped]){
                // 発動条件が満たされていた時は
                // キューにキャラを突っ込む
                [ability_meishi_queue addObject:meishi];
            }
            break;
    }
}

// 敵画像描写
- (void)appear{
    for(int i = 0; i < [dungeon getNumOfEnemy]; i++){
        [self appear:i];
    }
}
- (void)appear:(int)i{
    NSLog(@"敵描写");
    Enemy *e = [enemy objectAtIndex:i];
    UIImageView *view = [e getLeftImage];
    view.tag = i;
    view.userInteractionEnabled = true;
    // タップされた時のレコ具ナイザー
    UITapGestureRecognizer *etgr = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(eTarget:)];
    // etgr.tag = i;
    [view addGestureRecognizer:etgr]; // 狙い変更のための
    int x = 0;
    int y = 0;
    switch(i){
        case 0:
            x = 230;
            y = 100;
            break;
        case 1:
            x = 230;
            y = 160;
            break;
        case 2:
            x = 230;
            y = 220;
            break;
        case 3:
            x = 180;
            y = 130;
            break;
        case 4:
            x = 180;
            y = 190;
            break;
    }
    // もろもろのために座標を記録
    enemypositions[i][0] = x;
    enemypositions[i][1] = y;
    
    UIImageView *hpbar = [e getHPBarWithFrame:CGRectMake(x, y+48, 32, 5)];
    [[self view] addSubview:hpbar];
    
    view.frame = CGRectMake(x, y, 32, 48);
    [[self view] addSubview:view];
    //[eimgs addObject:view];
}

// 敵の狙い変更
- (void)eTarget:(id)sender{
    UITapGestureRecognizer *etgr = (UITapGestureRecognizer *)sender;
    UIImageView *view = (UIImageView *)etgr.view;
    target = [enemy_const objectAtIndex:view.tag];
}
- (void)close{
    NSLog(@"ダンジョン");
    [self dismissViewControllerAnimated:NO completion:nil];
}

- (void)close:(id)sender{
    NSLog(@"ダンジョン");
    [self dismissViewControllerAnimated:NO completion:nil];
}

// アイテムがタップされたとき--------------------------------------------------------------
- (void)itemTapped:(UIButton *)button{
    // まだ戦闘が始まっていない場合は何もしない
    if(item_flag == -1) return;
    // アイテムが無いとき
    if([player getNumOfItem:button.tag] == 0){
        item_desc.text = @"アイテムがありません";
        [[self view] addSubview:item_desc];
        // 表示したら数秒で消す
        [NSTimer scheduledTimerWithTimeInterval:2.0
                                         target:self
                                       selector:@selector(removeItemDesc)
                                       userInfo:nil
                                        repeats:false];

        return;
    }
    
    if(button.tag == item_flag){
        // 選択を解除
        item_flag = 0;
    }else{
        // 選択
        item_flag = button.tag;
    }
    
    // 説明をまず除去
    [item_desc removeFromSuperview];
    
    // 選択によってボタンの色を変更
    if(item_flag == 1){
        item1_button.backgroundColor = [UIColor whiteColor];
        item_desc.text = @"薬草：味方一人を全快します";
        [[self view] addSubview:item_desc];
    }else{
        item1_button.backgroundColor = [UIColor lightGrayColor];
    }
    
    if(item_flag == 2){
        item2_button.backgroundColor = [UIColor whiteColor];
        item_desc.text = @"果実：味方一人を復活させます";
        [[self view] addSubview:item_desc];
    }else{
        item2_button.backgroundColor = [UIColor lightGrayColor];
    }
    
}

- (void)removeItemDesc{
    [item_desc removeFromSuperview];
}

/***********************************************************************************
 * 結果画面関係
 ***********************************************************************************/
// 結果ウィンドウを開くためのイベントリスナー
- (void)viewResult:(UITapGestureRecognizer *)sender{
    // タップイベントリスナーの除去
    [[self view] removeGestureRecognizer:tgr];
    
    // 結果画面の初期化
    resultView = [[MBScrollView alloc] initWithPlayer:player];
    CGRect screen_rect = [UIScreen mainScreen].applicationFrame;
    resultView.frame = CGRectMake(0, 40, screen_rect.size.width, screen_rect.size.height-40);
    UIImage *backgroundImage = [UIImage imageNamed:@"bg.png"];
    resultView.backgroundColor = [UIColor colorWithPatternImage:backgroundImage];

    [resultView setTitle:@"リザルト"];
    
    // 勝ったかどうかで分岐
    if(exp == 0){
        // 負けた場合
        UILabel *resultlabel = [[UILabel alloc] init];
        resultlabel.frame = CGRectMake(10, 160, 300, 32);
        resultlabel.text = @"撤退した…";
        resultlabel.font = [UIFont fontWithName:@"mikachan_o" size:16];
        resultlabel.backgroundColor = [UIColor clearColor];
        resultlabel.textAlignment = NSTextAlignmentCenter;
        [resultView addSubview:resultlabel];
        
        // 画面閉じるボタン設置
        [self viewBackButton];
    }else{
        // 勝った場合
        // 一人あたりの経験値を計算
        [dungeon clear];
        int exp_per_m = ceil((double)exp * (1.05 - 0.05*[player getPartynum]));
        NSLog(@"Exp: %d", exp_per_m);
        
        UILabel *resultlabel = [[UILabel alloc] init];
        resultlabel.frame = CGRectMake(10, 60, 300, 24);
        resultlabel.text = [NSString stringWithFormat:@"%d 経験値を手に入れた！", exp_per_m];
        resultlabel.textAlignment = NSTextAlignmentCenter;
        resultlabel.backgroundColor = [UIColor clearColor];
        [resultView addSubview:resultlabel];
        
        BOOL lvup_flag = false;
        
        for(int i = 0; i < [player getPartynum]; i++){
            Meishi *meishi = [player getMeishi:i];
            int uplv = [meishi exp:exp_per_m];
            
            // アイコン
            UIImageView *view = [meishi getCenterImage];
            view.frame = CGRectMake(40, 100+(50*i), 32, 48);
            [resultView addSubview:view];
            // 名前
            
            UIOutlineLabel *name_label = [[UIOutlineLabel alloc] init];
            [name_label setOutlineColor:[UIColor whiteColor]];
            [name_label setOutlineWidth:2];
            name_label.text = [meishi getName];
            name_label.frame = CGRectMake(25, 136+50*i, 62, 12);
            name_label.font = [UIFont systemFontOfSize:12];
            name_label.backgroundColor = [UIColor clearColor];
            name_label.textAlignment = NSTextAlignmentCenter;
            [resultView addSubview:name_label];
            
            
            UILabel *attention = [[UILabel alloc] init];
            attention.frame = CGRectMake(80, 124+(50*i), 200, 24);
            attention.backgroundColor = [UIColor clearColor];
            [resultView addSubview:attention];
            // レベルアップしたかどうか
            if(uplv > 0){
                attention.text = [NSString stringWithFormat:@"Lv %d　→　Lv %d", [meishi getLv] - uplv, [meishi getLv]];
                lvup_flag = true;
            }else{
                attention.text = [NSString stringWithFormat:@"Lv %d", [meishi getLv]];
            }
        }
        // 画面をタップした時に次に行くように
        if(lvup_flag){
            tgr = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(viewResult2:)];
            [[self view] addGestureRecognizer:tgr];
        }else{
            // 画面閉じるボタン設置
            [self viewBackButton];
        }
    }
    [[self view] addSubview:resultView];
    
    // タイトルとかを全面に持ってくる
    //[[self view] bringSubviewToFront:navImage];
    //[[self view] bringSubviewToFront:title];
    
    // セーブ
    [player save];
    // ここでnotificationcenter に通知
    NSNotification *n = [NSNotification notificationWithName:@"DungeonFinished" object:self];
    [[NSNotificationCenter defaultCenter] postNotification:n];
}


- (void)viewResult2:(UITapGestureRecognizer *)sender{
    // タップイベントリスナーの除去
    [[self view] removeGestureRecognizer:tgr];
    [self viewBackButton];
    
    // 上にかぶせるビューの初期化
    UIScrollView *result2_view = [[UIScrollView alloc] init];
    result2_view.frame = CGRectMake(100, 100, 220, 260);
    UIImage *backgroundImage = [UIImage imageNamed:@"bg.png"];
    result2_view.backgroundColor = [UIColor colorWithPatternImage:backgroundImage];
    
    
    for(int i = 0; i < [player getPartynum]; i++){
        Meishi *meishi = [player getMeishi:i];
        
        // アイコン
        /*
        UIImageView *view = [meishi getCenterImage];
        view.frame = CGRectMake(40, 50*i, 32, 48);
        [result2_view addSubview:view];
        // 名前
        
        UIOutlineLabel *name_label = [[UIOutlineLabel alloc] init];
        [name_label setOutlineColor:[UIColor whiteColor]];
        [name_label setOutlineWidth:2];
        name_label.text = [meishi getName];
        name_label.frame = CGRectMake(20, 24+50*i, 80, 24);
        name_label.font = [UIFont systemFontOfSize:12];
        name_label.backgroundColor = [UIColor clearColor];
        name_label.textAlignment = NSTextAlignmentCenter;
        [result2_view addSubview:name_label];
         */
        
        // レベルアップしたかどうか
        NSLog(@"%d", [meishi getUpLvInt]);
        if([meishi getUpLvInt] > 0){
            UILabel *upH_label  = [[UILabel alloc] initWithFrame:CGRectMake(0, 2+50*i, 80, 16)];
            upH_label.font = [UIFont systemFontOfSize:14];
            upH_label.text = [NSString stringWithFormat:@"HP +%d", [meishi getUpHInt]];
            upH_label.backgroundColor = [UIColor clearColor];
            [result2_view addSubview:upH_label];
            
            
            UILabel *upA_label  = [[UILabel alloc] initWithFrame:CGRectMake(0, 17+50*i, 80, 16)];
            upA_label.font = [UIFont systemFontOfSize:14];
            upA_label.text = [NSString stringWithFormat:@"攻撃 +%d", [meishi getUpAInt]];
            upA_label.backgroundColor = [UIColor clearColor];
            [result2_view addSubview:upA_label];
            
            
            UILabel *upB_label  = [[UILabel alloc] initWithFrame:CGRectMake(0, 32+50*i, 80, 16)];
            upB_label.font = [UIFont systemFontOfSize:14];
            upB_label.text = [NSString stringWithFormat:@"防御 +%d", [meishi getUpBInt]];
            upB_label.backgroundColor = [UIColor clearColor];
            [result2_view addSubview:upB_label];
            
            UILabel *upC_label  = [[UILabel alloc] initWithFrame:CGRectMake(100, 2+50*i, 80, 16)];
            upC_label.font = [UIFont systemFontOfSize:14];
            upC_label.text = [NSString stringWithFormat:@"魔攻 +%d", [meishi getUpCInt]];
            upC_label.backgroundColor = [UIColor clearColor];
            [result2_view addSubview:upC_label];
            
            
            UILabel *upD_label  = [[UILabel alloc] initWithFrame:CGRectMake(100, 17+50*i, 80, 16)];
            upD_label.font = [UIFont systemFontOfSize:14];
            upD_label.text = [NSString stringWithFormat:@"魔防 +%d", [meishi getUpDInt]];
            upD_label.backgroundColor = [UIColor clearColor];
            [result2_view addSubview:upD_label];
            
            
            UILabel *upS_label  = [[UILabel alloc] initWithFrame:CGRectMake(100, 32+50*i, 80, 16)];
            upS_label.font = [UIFont systemFontOfSize:14];
            upS_label.text = [NSString stringWithFormat:@"素早さ +%d", [meishi getUpSInt]];
            upS_label.backgroundColor = [UIColor clearColor];
            [result2_view addSubview:upS_label];
        }
    }
    [resultView addSubview:result2_view];
}

- (void)viewBackButton{
    // 画面閉じるボタン設置
    MBButton *backbutton = [MBButton buttonWithType:UIButtonTypeRoundedRect];
    backbutton.frame = CGRectMake(100, 360, 120, 32);
    [backbutton setColorType:1];
    [backbutton setText:@"戻る"];
    [backbutton addTarget:self action:@selector(close:)forControlEvents:UIControlEventTouchUpInside];
    [resultView addSubview:backbutton];
}

@end
