//
//  MBViewController.m
//  Mbattler
//
//  Created by Yoshiyuki Sakamoto on 2013/06/02.
//  Copyright (c) 2013年 Mbattler. All rights reserved.
//

#import "MBViewController.h"
#import "MBScrollView.h"
#import "MBCharacterView.h"
#import "MBPartyView.h"
#import "MBItemView.h"
#import "DungeonViewController.h"
#import "MBSummonView.h"
#import "MBOptionView.h"
#import "SummonViewController.h"
#import "Tesseract.h"
#import <Foundation/Foundation.h>
#import <opencv2/opencv.hpp>
#import "FilterBase.h"
#import "MonochromeFilter.h"
#import "OcrViewController.h"
#import "SVProgressHUD.h"


@interface MBViewController ()

@end

@implementation MBViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // 画面の縦横比を取得
    CGRect screen_rect = [UIScreen mainScreen].applicationFrame;
    w = screen_rect.size.width;
    h = screen_rect.size.height;
    inside_h = h - 56 - 52;
    
    // 色の設定
    bgcolor = [UIColor whiteColor];
    menucolor = [UIColor colorWithRed:0.75 green:0.75 blue:0.75 alpha:1.0];
    menutextcolor = [UIColor blackColor];
    subbgcolor = [UIColor colorWithRed:0.9 green:0.9 blue:0.9 alpha:1.0];
    
    // 背景の設定
    UIImage *backgroundImage = [UIImage imageNamed:@"bg.png"];
    [self view].backgroundColor = [UIColor colorWithPatternImage:backgroundImage];
    // AppDelegate 初期化(グローバル変数的な使い方)
    ad = [[UIApplication sharedApplication] delegate];
    //player = ad.player;
    player = [[Player alloc] init];
    
    // ステータス部分の背景
    UIImageView *navImage = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"nav.png"]];
    navImage.frame = CGRectMake(-119, -30, 558, 100);
    [[self view] addSubview:navImage];
    
    // 上にステータスみたいなのつける(仮)
    UIScrollView *status = [[UIScrollView alloc] init];
    //[status setBackgroundColor:menucolor]; // 背景
    status.backgroundColor = [UIColor clearColor];
    status.frame = CGRectMake(0, 0, 320, 56);
    [[self view] addSubview:status];
    
    // 名前
    UILabel *name = [[UILabel alloc] init];
    [name setBackgroundColor:subbgcolor];
    name.frame = CGRectMake(10, 6, 120, 20);
    name.text = [player getName];
    [status addSubview:name];
    
    // スタミナ
    UILabel *stamina_label = [[UILabel alloc] init];
    // [stamina_label setBackgroundColor:subbgcolor];
    stamina_label.backgroundColor = [UIColor lightGrayColor];
    stamina_label.frame = CGRectMake(10, 33, 300, 14);
    stamina_label.text = @"スタミナ";
    stamina_label.font = [UIFont systemFontOfSize:10];
    [status addSubview:stamina_label];
    
    // スタミナバー
    UIImageView *stamina_base = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"hp0.png"]];
    stamina_base.frame = CGRectMake(55, 35, 250, 10);
    [status addSubview:stamina_base];
    [status addSubview:[player getStaminaBar:55 :35]];
    
    // スタミナ数値
    UILabel *stamina_val = [player getStaminaLabel];
    stamina_val.frame = CGRectMake(40, 29, 60, 20);
    stamina_val.textAlignment = NSTextAlignmentRight;
    [status addSubview:stamina_val];
    
    
    MBScrollView *sv = [[MBScrollView alloc] init];
    [sv setTitle:@"トップ"];
    nowScrollView = sv;
    [[self view] addSubview:sv];
    
    // 下にメニューつける(仮)
    // メニューの影
    UILabel *menuLabel = [[UILabel alloc] initWithFrame:CGRectMake(1, h-54, 319, 2)];
    menuLabel.backgroundColor = [UIColor grayColor];
    [[self view] addSubview:menuLabel];
    
    // 上にステータスみたいなのつける(仮)
    UIScrollView *menu = [[UIScrollView alloc] init];
    [menu setBackgroundColor:menucolor];
    menu.frame = CGRectMake(0, h-52, 320, 52);
    [[self view] addSubview:menu];
    
    // 召喚ボタン
    UIButton *summon = [UIButton buttonWithType:UIButtonTypeCustom];
    summon.frame = CGRectMake(1, 0, 52, 52);
    [summon setBackgroundImage:[UIImage imageNamed:@"summon.png"] forState:UIControlStateNormal];
    [summon addTarget:self action:@selector(viewSummon:)forControlEvents:UIControlEventTouchUpInside];
    [menu addSubview:summon];
    
    // キャラクターボタン
    UIButton *character = [UIButton buttonWithType:UIButtonTypeCustom];
    character.frame = CGRectMake(54, 0, 52, 52);
    [character setBackgroundImage:[UIImage imageNamed:@"character.png"] forState:UIControlStateNormal];
    [character addTarget:self action:@selector(viewCharacter:)forControlEvents:UIControlEventTouchUpInside];
    [menu addSubview:character];
    
    // パーティボタン
    UIButton *party = [UIButton buttonWithType:UIButtonTypeCustom];
    party.frame = CGRectMake(107, 0, 52, 52);
    [party setBackgroundImage:[UIImage imageNamed:@"party.png"] forState:UIControlStateNormal];
    [party addTarget:self action:@selector(viewParty:)forControlEvents:UIControlEventTouchUpInside];
    [menu addSubview:party];
    
    // ダンジョン
    UIButton *dungeon = [UIButton buttonWithType:UIButtonTypeCustom];
    dungeon.frame = CGRectMake(160, 0, 52, 52);
    [dungeon setBackgroundImage:[UIImage imageNamed:@"dungeon.png"] forState:UIControlStateNormal];
    [dungeon addTarget:self action:@selector(viewDungeon:)forControlEvents:UIControlEventTouchUpInside];
    [menu addSubview:dungeon];
    
    // アイテムボタン
    UIButton *item = [UIButton buttonWithType:UIButtonTypeCustom];
    item.frame = CGRectMake(213, 0, 52, 52);
    [item setBackgroundImage:[UIImage imageNamed:@"item.png"] forState:UIControlStateNormal];
    [item addTarget:self action:@selector(viewItem:)forControlEvents:UIControlEventTouchUpInside];
    [menu addSubview:item];
    
    // 設定
    UIButton *option = [UIButton buttonWithType:UIButtonTypeCustom];
    option.frame = CGRectMake(266, 0, 52, 52);
    [option setBackgroundImage:[UIImage imageNamed:@"option.png"] forState:UIControlStateNormal];
    [option addTarget:self action:@selector(viewOption:)forControlEvents:UIControlEventTouchUpInside];
    [menu addSubview:option];
    
    // タイトル
    title = [[UILabel alloc] init];
    title.font = [UIFont systemFontOfSize:18];
    [title setBackgroundColor:menucolor];
    [title setTextColor:menutextcolor];
    title.frame = CGRectMake(10, 60, 300, 32);
    title.textAlignment = NSTextAlignmentCenter;
    
}

// キャラクター ------------------------------------------------------------
- (void)viewCharacter:(id)sender{
    // 今映ってるのを除去
    if(nowScrollView) [nowScrollView removeFromSuperview];
    MBCharacterView *view = [[MBCharacterView alloc] initWithPlayer:player];
    [[self view] addSubview:view];
    nowScrollView = view;
}

// パーティ
- (void)viewParty:(id)sender{
    if(nowScrollView) [nowScrollView removeFromSuperview];
    MBPartyView *view = [[MBPartyView alloc] initWithPlayer:player];
    [[self view] addSubview:view];
    nowScrollView = view;
}

// アイテム
- (void)viewItem:(id)sender{
    // 今映ってるのを除去
    if(nowScrollView) [nowScrollView removeFromSuperview];
    MBItemView *view = [[MBItemView alloc] initWithPlayer:player];
    [[self view] addSubview:view];
    nowScrollView = view;
}

// 設定
- (void)viewOption:(id)sender{
    // 今映ってるのを除去
    if(nowScrollView) [nowScrollView removeFromSuperview];
    MBOptionView *view = [[MBOptionView alloc] initWithPlayer:player];
    [[self view] addSubview:view];
    nowScrollView = view;
}


/**********************************************************************
 * ダンジョン関係
 **********************************************************************/
// ダンジョンビュー表示
- (void)viewDungeon:(id)sender{
    // 今映ってるのを除去
    if(nowScrollView) [nowScrollView removeFromSuperview];
    NSLog(@"MBViewController: viewDungeon");
    // まず、ダンジョンインスタンスを作成
    Dungeon *dungeon = [[Dungeon alloc] init];
    
    // ビューの準備
    MBScrollView *dungeonView = [[MBScrollView alloc] initWithPlayer:player];
    [dungeonView setTitle:@"ダンジョン選択"];
    
    // ダンジョン一覧を表示するスクロールエリア
    UIScrollView *dungeonsv = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 50, 320, 300)];
    dungeonsv.backgroundColor = [UIColor clearColor];
    dungeonsv.contentSize = CGSizeMake(300, 480);    // スクロール内部のサイズ
    [dungeonView addSubview:dungeonsv];
    
    // ダンジョン名一覧を取得
    NSArray *dungeonNames = [dungeon getNames];
    UIButton *button;
    for(int i = 0; i < [dungeonNames count]; i++){
        button = [UIButton buttonWithType:UIButtonTypeRoundedRect];
        button.frame = CGRectMake(10, 5 + 58*i, 300, 55);
        [button setBackgroundImage:[UIImage imageNamed:@"husen1.png"] forState:UIControlStateNormal];
        button.tag = i;
        [button setTitle:[dungeonNames objectAtIndex:i] forState:UIControlStateNormal];
        [button addTarget:self action:@selector(openDungeon:)forControlEvents:UIControlEventTouchUpInside];
        [dungeonsv addSubview:button];
    }

    [[self view] addSubview:dungeonView];
    nowScrollView = dungeonView;
}

- (void)openDungeon:(id)sender{
    NSLog(@"MBViewController: opeDungeon");
    UIButton *button = (UIButton *)sender;
    // 選択したダンジョンのデータを取得
    int dungeonid = button.tag;
    Dungeon *dungeon = [[Dungeon alloc] init];
    [dungeon setDungeon:dungeonid];
    
    if(![player minusStaimna:[dungeon getStamina]]){
        // 体力足りない場合
        NSLog(@"体力足りない"); // ドリンクを買いに行きますか？
        return;
    }
    DungeonViewController *dvc = [[DungeonViewController alloc] init];
    [dvc setPlayer:player];
    [dvc setDungeon:dungeon];
    [self presentViewController:dvc animated:NO completion:nil];
}

/**********************************************************************
 * 名刺召喚関係
 **********************************************************************/

- (void)viewSummon:(id)sender{
    // 今映ってるのを除去
    if(nowScrollView) [nowScrollView removeFromSuperview];
    NSLog(@"MBViewController: viewSummon");
    // ビューの準備
    MBSummonView *summonView = [[MBSummonView alloc] initWithPlayer:player];
    [[self view] addSubview:summonView];
    nowScrollView = summonView;
    
    // カメラ起動ボタン
    UIButton *camera_button = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    camera_button.frame = CGRectMake(30, 80, 260, 40);
    // ここでカメラが起動できるか確認
    if([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]){
        /* キャラクターがいっぱいかどうか確認が必要
         * 「すでにあるキャラと入れ替える必要がありますがよろしいですか？
         * 　はい　いいえ
         * 　キャラ上限増加（有料）」
         * みたいな */
        [camera_button setTitle:@"カメラ起動" forState:UIControlStateNormal];
        [camera_button addTarget:self action:@selector(launchCamera:)forControlEvents:UIControlEventTouchUpInside];
    }else{
        [camera_button setTitle:@"カメラ非対応なデバイスです" forState:UIControlStateNormal];
    }
    [summonView addSubview:camera_button];
    
    // デバッグ用
    UIButton *rand_button = [UIButton buttonWithType:UIButtonTypeCustom];
    rand_button.frame = CGRectMake(30, 140, 260, 40);
    [rand_button setTitle:@"ランダム名刺召喚" forState:UIControlStateNormal];
    [rand_button setImage:[UIImage imageNamed:@"button.png"] forState:UIControlStateNormal];
    [rand_button addTarget:self action:@selector(randMeishi:)forControlEvents:UIControlEventTouchUpInside];
    [summonView addSubview:rand_button];
    
    // OCRテスト（デバッグ用）
    UIButton *test_button = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    test_button.frame = CGRectMake(30, 200, 260, 40);
    [test_button setTitle:@"OCRテスト" forState:UIControlStateNormal];
    [test_button addTarget:self action:@selector(ocrTest:)forControlEvents:UIControlEventTouchUpInside];
    [summonView addSubview:test_button];
    
    UILabel *test_label = [[UILabel alloc] initWithFrame:CGRectMake(30, 240, 260, 50)];
    test_label.numberOfLines = 2;
    test_label.text = @"少し処理に時間がかかります。連打しないでください。";
    [summonView addSubview:test_label];
    
    // 名刺作成テスト
    //Meishi *test_meishi = [[Meishi alloc] initWithInformation:@"坂本祥之" CompanyName:@"秋乃株式会社" Mail1:@"sakamoto" Mail2:@"db.soc.i.kyoto-u.ac.jp" Zip1:606 Zip2:8267 Sex:rand()%2];
}

// OCRテスト（デバッグ用）
- (void)ocrTest:(id)sender{
    UIImage *img = [UIImage imageNamed:@"IMG_2810.JPG"];
    UIImageView *view = [[UIImageView alloc] initWithImage:img];
    view.frame = CGRectMake(0, 0, 320, 240);
    //[[self view] addSubview:view];    // イメージを表示する部分
    
    NSLog(@"launch OCR");
    OcrViewController *ocr_vc = [[OcrViewController alloc] initWithPlayerAndImg:player OCRImage:img];
    [self presentViewController:ocr_vc animated:NO completion:nil];
}

// ランダムキャラ生成（デバッグ用）
- (void)randMeishi:(id)sender{
    NSLog(@"randMeishi");
    Meishi *m = [[Meishi alloc] init];
    [m setName:@"ランダム君"];
    [m setLv:5];
    [m setSex:rand()%2];
    [m setJob: rand()%4];
    int ind[6] = {rand()%32, rand()%32, rand()%32, rand()%32, rand()%32, rand()%32};
    [m setIndividual:ind];
    [m calcParameter];
    [m setExp:0];
    [player addMeishi:m];
    
    [self summonMeishi:m];
}

// カメラの起動
- (void)launchCamera:(id)sender{
    NSLog(@"laubch camera");
    UIImagePickerController *picker = [[UIImagePickerController alloc] init];
    picker.delegate = self;
    [picker setSourceType:UIImagePickerControllerSourceTypeCamera]; // カメラモード(SAダウン Cアップ)
    [self presentViewController:picker animated:YES completion:nil];
}

// カメラで撮影したあと
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    // picker から画像を取得する。
    UIImage *camera_img = [info objectForKey:UIImagePickerControllerOriginalImage];
    
    // 元の画面に画像をUIImageViewとして追加する
    //UIImageView *iv = [[UIImageView alloc] initWithImage:fromCamera];
    //[self.view addSubview:iv];
    
    // picker を閉じる
    NSLog(@"close Picker");
    //[picker dismissModalViewControllerAnimated:YES];
    [self dismissViewControllerAnimated:NO completion:nil];

    
    // ぐるぐる表示
    //[SVProgressHUD show];
    
    // OCRにかける
    NSLog(@"launch OCR");
    OcrViewController *ocr_vc = [[OcrViewController alloc] initWithPlayerAndImg:player OCRImage:camera_img];
    [self presentViewController:ocr_vc animated:NO completion:nil];
    //[SVProgressHUD dismiss];
}

- (Meishi *)ocr:(UIImage *)img{
    // openCVを試す
    // 対象画像からImageRefを作成
    NSLog(@"ImageRef 作成");
    CGImageRef image_ref = img.CGImage;
    
    // 長編を640に合わせてリサイズ
    // 縮小割合を求める
    size_t image_w = CGImageGetWidth(image_ref);
    size_t image_h = CGImageGetHeight(image_ref);
    double mult;
    NSLog(@"OCR image size %ld * %ld", image_w, image_h);
    if(image_w > image_h){
        mult = 320.0 / image_w;
    }else{
        mult = 320.0 / image_h;
    }
    image_w = image_w * mult;
    image_h = image_h * mult;
    NSLog(@"mult: %f, w: %ld, h: %ld", mult, image_w, image_h);
    
    UIGraphicsBeginImageContext(CGSizeMake(image_w, image_h));
    [img drawInRect:CGRectMake(0, 0, image_w, image_h)];
    img = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    UIImageView *view = [[UIImageView alloc] initWithImage:img];
    [[self view] addSubview:view];

    
    // MonochromeFilter を使う
    // まずはグレースケールに
    MonochromeFilter *mf = [[MonochromeFilter alloc] init];
    CGImageRef gray_ref = [mf doGrayScaleFilter:image_ref];
    // UIImageに
    UIImage *gray_img = [UIImage imageWithCGImage:gray_ref];
    // 表示してみる
    /* NSLog(@"表示");
     UIImageView *gray_view = [[UIImageView alloc] initWithImage:gray_img];
     gray_view.frame = CGRectMake(0, 100, 320, 240);
     [[self view] addSubview:gray_view];
     */
    
    // カラー画像→2値画像に
    CGImageRef monotone_ref = [mf do2ValueFilter:image_ref];
    UIImage *monotone_img = [UIImage imageWithCGImage:monotone_ref]; // UIImage に変換
    // UIImageView *view1 = [[UIImageView alloc] initWithImage:monotone_img];
    // view1.frame = CGRectMake(0, -50, 320, 240);
    // [[self view] addSubview:view1];
    // モノクロ画像→2値画像に
    /*
     CGImageRef monotone_ref2 = [mf do2ValueFilter:gray_ref];
     UIImage *monotone_img2 = [UIImage imageWithCGImage:monotone_ref2];
     UIImageView *view2 = [[UIImageView alloc] initWithImage:monotone_img2];
     view2.frame = CGRectMake(0, 190, 320, 240);
     [[self view] addSubview:view2];
     */
    
    // ここからOCR
    
    // 英語用OCR
    // フルカラー画像
    NSLog(@"OCR Language:eng Color:fullcolor");
    Tesseract *tesseract_en = [[Tesseract alloc] initWithDataPath:@"tessdata" language:@"eng"];
    [tesseract_en setImage:gray_img];
    //[tesseract_en setVariableValue:@"0123456789〒-" forKey:@"tessedit_char_whitelist"]; // ホワイトリスト
    // どうも o を 0 に誤認識してしまうので、小文字 a-z 以外の文字にはペナルティを課す
    [tesseract_en setVariableValue:@"abcdefghijklmnopqrstuvwxyz" forKey:@"freq_dawg"];
    [tesseract_en setVariableValue:@"0.2" forKey:@"language_model_penalty_non_freq_dict_word"];
    [tesseract_en recognize];
    NSLog(@"%@", [tesseract_en recognizedText]);
    
    // 2値画像
    NSLog(@"OCR Language:eng Color:monotone");
    tesseract_en = [[Tesseract alloc] initWithDataPath:@"tessdata" language:@"eng"];
    [tesseract_en setImage:monotone_img];
    //[tesseract_en setVariableValue:@"〒" forKey:@"user_words_suffix"];
    //[tesseract_en setVariableValue:@"0123456789〒-" forKey:@"tessedit_char_whitelist"]; // ホワイトリスト
    // どうも o を 0 に誤認識してしまうので、小文字 a-z 以外の文字にはペナルティを課す
    [tesseract_en setVariableValue:@"abcdefghijklmnopqrstuvwxyz" forKey:@"freq_dawg"];
    [tesseract_en setVariableValue:@"0.3" forKey:@"language_model_penalty_non_freq_dict_word"];
    [tesseract_en recognize];
    NSLog(@"%@", [tesseract_en recognizedText]);
    
    
    // 日本語用のOCR初期化
    // フルカラー画像
    NSLog(@"OCR Language:jpn Color:fullcolor");
    Tesseract *tesseract = [[Tesseract alloc] initWithDataPath:@"tessdata" language:@"jpn"];
    // 画像をセット
    [tesseract setImage:gray_img];
    // 日本語の認識率を上げる魔法の呪文 by http://code.google.com/p/tesseract-ocr/wiki/ControlParams こ↑こ↓
    [tesseract setVariableValue:@"T" forKey:@"chop_enable"];
    [tesseract setVariableValue:@"F" forKey:@"use_new_state_cost"];
    [tesseract setVariableValue:@"F" forKey:@"segment_segcost_rating"];
    [tesseract setVariableValue:@"0" forKey:@"enable_new_segsearch"];
    [tesseract setVariableValue:@"0" forKey:@"language_model_ngram_on"];
    [tesseract setVariableValue:@"F" forKey:@"textord_force_make_prop_words"];
    [tesseract recognize];  // OCR実行
    NSLog(@"%@", [tesseract recognizedText]);
    
    // 二値化
    NSLog(@"OCR Language:jpn Color:monotone");
    tesseract = [[Tesseract alloc] initWithDataPath:@"tessdata" language:@"jpn"];
    // 画像をセット
    [tesseract setImage:monotone_img];
    // 日本語の認識率を上げる魔法の呪文 by http://code.google.com/p/tesseract-ocr/wiki/ControlParams こ↑こ↓
    [tesseract setVariableValue:@"T" forKey:@"chop_enable"];
    [tesseract setVariableValue:@"F" forKey:@"use_new_state_cost"];
    [tesseract setVariableValue:@"F" forKey:@"segment_segcost_rating"];
    [tesseract setVariableValue:@"0" forKey:@"enable_new_segsearch"];
    [tesseract setVariableValue:@"0" forKey:@"language_model_ngram_on"];
    [tesseract setVariableValue:@"F" forKey:@"textord_force_make_prop_words"];
    [tesseract recognize];  // OCR実行
    NSLog(@"%@", [tesseract recognizedText]);
    
    return nil;
}


// 名刺召喚のエフェクト等表示
- (void)summonMeishi:(Meishi *)meishi{
    NSLog(@"summonMeishi show Effect");
    SummonViewController *view = [[SummonViewController alloc] init];
    [view setMeishi:meishi];
    [self presentViewController:view animated:NO completion:nil];
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
