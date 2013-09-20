//
//  OcrViewController.m
//  Mbattler
//
//  Created by Yoshiyuki Sakamoto on 2013/08/19.
//  Copyright (c) 2013年 Mbattler. All rights reserved.
//

#import "OcrViewController.h"
#import "MonochromeFilter.h"
#import "Tesseract.h"
#import "SVProgressHUD.h"
#import "Meishi.h"
#import "SummonViewController.h"

@interface OcrViewController ()

@end

@implementation OcrViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}


- (id)initWithPlayerAndImg:(Player *)p OCRImage:(UIImage *)_img{
    self = [super init];
    if(self){
        player = p;
        img = _img;
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    
    // 背景白
    [self.view setBackgroundColor:[UIColor whiteColor]];
    
    // ぐるぐる表示
    [SVProgressHUD showWithStatus:@"画像認識中"];
    
    // 0.5秒後に処理を開始
    [NSTimer scheduledTimerWithTimeInterval:0.5
                                     target:self
                                   selector:@selector(meishi:)
                                   userInfo:nil
                                    repeats:false];
}

- (void)meishi:(id)sender{
    // 画像を縮小
    [self resizeHalf];
    
    [self viewTextFields];
    UIImageView *view = [[UIImageView alloc] initWithImage:img];
    view.frame = CGRectMake(40, 0, 240, 180);
    [[self view] addSubview:view];
    
    // 画像を二値化
    [self do2ValueFilter];
    
    // OCRを実行
    [self ocr];
    
    // ぐるぐる消す
    [SVProgressHUD dismiss];
}

// 画像を縮小するやつ
- (UIImage *)resize:(float)w{
    // 横幅を640に合わせてリサイズ
    // 縮小割合を求める
    CGImageRef image_ref = img.CGImage;
    size_t image_w = CGImageGetWidth(image_ref);
    size_t image_h = CGImageGetHeight(image_ref);
    double mult;
    NSLog(@"OCR image size %ld * %ld", image_w, image_h);
    mult = w / image_w;
    
    image_w = image_w * mult;
    image_h = image_h * mult;
    NSLog(@"mult: %f, w: %ld, h: %ld", mult, image_w, image_h);
    
    UIGraphicsBeginImageContext(CGSizeMake(image_w, image_h));
    [img drawInRect:CGRectMake(0, 0, image_w, image_h)];
    img = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return img;
}

// 画像を縮小するやつ
- (UIImage *)resizeHalf{
    // 画像の縦横を半分に
    CGImageRef image_ref = img.CGImage;
    size_t image_w = CGImageGetWidth(image_ref);
    size_t image_h = CGImageGetHeight(image_ref);
    NSLog(@"OCR image size %ld * %ld", image_w, image_h);
    
    UIGraphicsBeginImageContext(CGSizeMake(image_w/2, image_h/2));
    [img drawInRect:CGRectMake(0, 0, image_w/2, image_h/2)];
    img = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return img;
}

// 画像を2値化する
- (UIImage *)do2ValueFilter{
    NSLog(@"do 2value Filter");
    CGImageRef image_ref = img.CGImage; // refを取得
    MonochromeFilter *mf = [[MonochromeFilter alloc] init];
    CGImageRef gray_ref = [mf do2ValueFilter:image_ref];
    mono_img = [UIImage imageWithCGImage:gray_ref];
    return mono_img;
}

- (void)ocr{
    NSLog(@"OCR Language: eng, by monotone image");
    Tesseract *tesseract_en = [[Tesseract alloc] initWithDataPath:@"tessdata" language:@"eng"];
    [tesseract_en setImage:mono_img];
    //[tesseract_en setVariableValue:@"〒" forKey:@"user_words_suffix"];
    //[tesseract_en setVariableValue:@"0123456789〒-" forKey:@"tessedit_char_whitelist"]; // ホワイトリスト
    //[tesseract_en setVariableValue:@":(){},'+%?!~&<*|/\\$" forKey:@"tessedit_char_blacklist"]; //　ブラックリスト
    // どうも o を 0 に誤認識してしまうので、小文字 a-z 以外の文字にはペナルティを課す
    [tesseract_en setVariableValue:@"abcdefghijklmnopqrstuvwxyz0123456789-" forKey:@"freq_dawg"];
    [tesseract_en setVariableValue:@"0.8" forKey:@"language_model_penalty_non_freq_dict_word"];
    [tesseract_en recognize];
    // スペースを除去
    NSString *mono_eng = [[tesseract_en recognizedText] stringByReplacingOccurrencesOfString:@" " withString:@""];
    NSLog(@"%@", mono_eng);
    
    NSLog(@"OCR Language:jpn Color:monotone");
    Tesseract *tesseract = [[Tesseract alloc] initWithDataPath:@"tessdata" language:@"jpn"];
    // 画像をセット
    [tesseract setImage:mono_img];
    // 日本語の認識率を上げる魔法の呪文 by http://code.google.com/p/tesseract-ocr/wiki/ControlParams こ↑こ↓
    [tesseract setVariableValue:@"T" forKey:@"chop_enable"];
    [tesseract setVariableValue:@"F" forKey:@"use_new_state_cost"];
    [tesseract setVariableValue:@"F" forKey:@"segment_segcost_rating"];
    [tesseract setVariableValue:@"0" forKey:@"enable_new_segsearch"];
    [tesseract setVariableValue:@"0" forKey:@"language_model_ngram_on"];
    [tesseract setVariableValue:@"F" forKey:@"textord_force_make_prop_words"];
    [tesseract setVariableValue:@"{}[]｛｝'”〝’()（）【】『』「」・" forKey:@"tessedit_char_blacklist"]; // ブラックリスト
    //[tesseract_en setVariableValue:@"株式会社" forKey:@"freq_dawg"];    // 頻出語彙と、それ以外につけるペナルティ
    //[tesseract_en setVariableValue:@"0.2" forKey:@"language_model_penalty_non_freq_dict_word"];
    [tesseract recognize];  // OCR実行
    // スペースを除去
    NSString *mono_jpn = [[tesseract recognizedText] stringByReplacingOccurrencesOfString:@" " withString:@""];
    mono_jpn = [mono_jpn stringByReplacingOccurrencesOfString:@"　" withString:@""];
    NSLog(@"%@", mono_jpn);
    //NSLog(@"%@", [tesseract recognizedText]);
}

- (void)viewTextFields{
    CGRect screen_rect = [UIScreen mainScreen].applicationFrame;
    int h = screen_rect.size.height;
    correctView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 180, 320, h-180)];
    correctView.backgroundColor = [UIColor lightGrayColor];
    correctView.contentSize = CGSizeMake(320, 640);
    [[self view] addSubview:correctView];
    
    int x = 20;
    int th = 30;
    
    // 名前
    UILabel *nameLabel = [[UILabel alloc] initWithFrame:CGRectMake(x, 0, 320 - 2*x, 30)];
    nameLabel.text = @"名前";
    nameLabel.backgroundColor = [UIColor clearColor];
    [correctView addSubview:nameLabel];
    
    nameField = [[UITextField alloc] initWithFrame:CGRectMake(x, 30, 320 - 2*x, th)];
    nameField.borderStyle = UITextBorderStyleRoundedRect;
    nameField.placeholder = @"名前";
    nameField.clearButtonMode = UITextFieldViewModeUnlessEditing;
    nameField.returnKeyType = UIReturnKeyDefault;
    nameField.delegate = self;
    [correctView addSubview:nameField];
    
    
    // 郵便番号
    UILabel *zipLabel = [[UILabel alloc] initWithFrame:CGRectMake(x, 70, 320 - 2*x, 30)];
    zipLabel.text = @"郵便番号";
    zipLabel.backgroundColor = [UIColor clearColor];
    [correctView addSubview:zipLabel];
    
    zipField = [[UITextField alloc] initWithFrame:CGRectMake(x, 100, 320 - 2*x, th)];
    zipField.borderStyle = UITextBorderStyleRoundedRect;
    zipField.placeholder = @"郵便番号";
    zipField.clearButtonMode = UITextFieldViewModeUnlessEditing;
    zipField.returnKeyType = UIReturnKeyDefault;
    zipField.keyboardType = UIKeyboardTypeNumberPad;
    zipField.delegate = self;
    [correctView addSubview:zipField];
    
    
    // 会社
    UILabel *companyLabel = [[UILabel alloc] initWithFrame:CGRectMake(x, 140, 320 - 2*x, 30)];
    companyLabel.text = @"会社名";
    companyLabel.backgroundColor = [UIColor clearColor];
    [correctView addSubview:companyLabel];
    
    companyField = [[UITextField alloc] initWithFrame:CGRectMake(x, 170, 320 - 2*x, th)];
    companyField.borderStyle = UITextBorderStyleRoundedRect;
    companyField.placeholder = @"会社名";
    companyField.clearButtonMode = UITextFieldViewModeUnlessEditing;
    companyField.returnKeyType = UIReturnKeyDefault;
    companyField.delegate = self;
    [correctView addSubview:companyField];
    
    
    // メール
    UILabel *mailLabel = [[UILabel alloc] initWithFrame:CGRectMake(x, 210, 320 - 2*x, 30)];
    mailLabel.text = @"メールアドレス";
    mailLabel.backgroundColor = [UIColor clearColor];
    [correctView addSubview:mailLabel];
    
    mailField = [[UITextField alloc] initWithFrame:CGRectMake(x, 240, 320 - 2*x, th)];
    mailField.borderStyle = UITextBorderStyleRoundedRect;
    mailField.placeholder = @"メールアドレス";
    mailField.clearButtonMode = UITextFieldViewModeUnlessEditing;
    mailField.returnKeyType = UIReturnKeyDefault;
    mailField.keyboardType = UIKeyboardTypeEmailAddress;
    mailField.delegate = self;
    [correctView addSubview:mailField];
    
    UIButton *submit = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    submit.frame = CGRectMake(60, 300, 200, 40);
    [submit setTitle:@"召喚！" forState:UIControlStateNormal];
    [submit addTarget:self action:@selector(summon:) forControlEvents:UIControlEventTouchDown];
    [correctView addSubview:submit];
    
    UIButton *cancel = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    cancel.frame = CGRectMake(60, 360, 200, 40);
    [cancel setTitle:@"キャンセル" forState:UIControlStateNormal];
    [cancel addTarget:self action:@selector(cancel:) forControlEvents:UIControlEventTouchDown];
    [correctView addSubview:cancel];
    
    // 画面をタップした時に戦闘が始まるようにする
    UITapGestureRecognizer *tgr = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(textFieldShouldReturn:)];
    [[self view] addGestureRecognizer:tgr];
}

// テキストフィールド隠す
- (BOOL)textFieldShouldReturn:(id)sender {
    if(activeField) [activeField resignFirstResponder];
    activeField = nil;
    return YES;
}

// 選択されてるキーボードを取得
- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField{
    // メンバ変数activeFieldに選択されたテキストフィールドを代入
    activeField = textField;
    [correctView setContentOffset:CGPointMake(0, textField.frame.origin.y - 30) animated:YES];
    return YES;
}

// 召喚ボタンが押されたとき
- (void)summon:(UIButton *)sender{
    NSLog(@"召喚！ pushed");
    if(zipField.text&&companyField.text&&nameField.text&&mailField.text){
        UIAlertView *alert = [[UIAlertView alloc] init];
        alert.delegate = self;
        alert.title = @"確認";
        alert.message = @"よろしいですか？";
        [alert addButtonWithTitle:@"はい"];
        [alert addButtonWithTitle:@"いいえ"];
        [alert show];
    }else{
        // 複数行で書くタイプ（１ボタンタイプ）
        UIAlertView *alert = [[UIAlertView alloc] init];
        alert.title = @"エラー";
        alert.message = @"入力されていないフィールドがあります";
        [alert addButtonWithTitle:@"確認"];
        [alert show];
    }
}

-(void)alertView:(UIAlertView*)alertView
clickedButtonAtIndex:(NSInteger)buttonIndex {
    if(buttonIndex == 0){
        NSLog(@"OKボタン");
        // メールアドレスを分ける
        NSLog(@"メールアドレス処理");
        NSString *pattern = @"(.+)@(.+)";
        mail = mailField.text;
        NSRegularExpression *regex = [NSRegularExpression regularExpressionWithPattern:pattern options:0 error:nil];
        NSTextCheckingResult *match = [regex firstMatchInString:mail options:0 range:NSMakeRange(0, mail.length)];
        if(match.numberOfRanges){
            mail1 = [mail substringWithRange:[match rangeAtIndex:1]];
            mail2 = [mail substringWithRange:[match rangeAtIndex:2]];
            NSLog(@"%@, %@", mail1, mail2);
        }
        
        // 郵便番号を分ける
        zip = zipField.text;
        NSLog(@"郵便番号処理 %d", zip.length);
        zip1 = [[zip substringWithRange:NSMakeRange(0,3)] intValue];
        NSLog(@"郵便番号処理 %@ %d", zip, zip1);
        zip2 = [[zip substringWithRange:NSMakeRange(3,4)] intValue];
        NSLog(@"郵便番号処理");
        
        company = companyField.text;
        name = nameField.text;
        
        // 名刺生成
        NSLog(@"名刺生成");
        meishi = [[Meishi alloc] initWithInformation:name CompanyName:company Mail1:mail1 Mail2:mail2 Zip1:zip1 Zip2:zip2 Sex:0];
        
        SummonViewController *svc = [[SummonViewController alloc] init];
        [svc setMeishi:meishi];
        [self presentViewController:svc animated:NO completion:nil];
        
        //[self dismissViewControllerAnimated:YES completion:nil];
    }
}

- (void)cancel:(id)sender{
    [self dismissViewControllerAnimated:YES completion:nil];
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
