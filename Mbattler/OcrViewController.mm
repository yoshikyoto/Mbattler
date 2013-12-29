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
#import "MBButton.h"

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


- (id)initWithPlayer:(Player *)p OCRImage:(UIImage *)_img{
    self = [super init];
    if(self){
        player = p;
        img = _img;
        name_kanji = @"ぁあぃいぅうぇえぉおかがきぎくぐけげこごさざしじすずせぜそぞただちぢっつづてでとどなにぬねのはばぱひびぴふぶぷへべぺほぼぽまみむめもゃやゅゆょよらりるれろゎわゐゑをんァアィイゥウェエォオカガキギクグケゲコゴサザシジスズセゼソゾタダチヂッツヅテデトドナニヌネノハバパヒビピフブプヘベペホボポマミムメモャヤュユョヨラリルレロヮワヲンヴヵヶ亜哀愛悪握圧扱安暗案以位依偉囲委威尉意慰易為異移維緯胃衣違遺医井域育一壱逸稲芋印員因姻引飲院陰隠韻右宇羽雨渦浦運雲営影映栄永泳英衛詠鋭液疫益駅悦謁越閲円園宴延援沿演炎煙猿縁遠鉛塩汚凹央奥往応押横欧殴王翁黄沖億屋憶乙卸恩温穏音下化仮何価佳加可夏嫁家寡科暇果架歌河火禍稼箇花荷華菓課貨過蚊我画芽賀雅餓介会解回塊壊快怪悔懐戒拐改械海灰界皆絵開階貝劾外害慨概涯街該垣嚇各拡格核殻獲確穫覚角較郭閣隔革学岳楽額掛潟割喝括活渇滑褐轄且株刈乾冠寒刊勘勧巻喚堪完官寛干幹患感慣憾換敢棺款歓汗漢環甘監看管簡緩缶肝艦観貫還鑑間閑関陥館丸含岸眼岩頑顔願企危喜器基奇寄岐希幾忌揮机旗既期棋棄機帰気汽祈季紀規記貴起軌輝飢騎鬼偽儀宜戯技擬欺犠疑義議菊吉喫詰却客脚虐逆丘久休及吸宮弓急救朽求泣球究窮級糾給旧牛去居巨拒拠挙虚許距漁魚享京供競共凶協叫境峡強恐恭挟教橋況狂狭矯胸脅興郷鏡響驚仰凝暁業局曲極玉勤均斤琴禁筋緊菌襟謹近金吟銀九句区苦駆具愚虞空偶遇隅屈掘靴繰桑勲君薫訓群軍郡係傾刑兄啓型契形径恵慶憩掲携敬景渓系経継茎蛍計警軽鶏芸迎鯨劇撃激傑欠決潔穴結血月件倹健兼券剣圏堅嫌建憲懸検権犬献研絹県肩見謙賢軒遣険顕験元原厳幻弦減源玄現言限個古呼固孤己庫弧戸故枯湖誇雇顧鼓五互午呉娯後御悟碁語誤護交侯候光公功効厚口向后坑好孔孝工巧幸広康恒慌抗拘控攻更校構江洪港溝甲皇硬稿紅絞綱耕考肯航荒行衡講貢購郊酵鉱鋼降項香高剛号合拷豪克刻告国穀酷黒獄腰骨込今困墾婚恨懇昆根混紺魂佐唆左差査砂詐鎖座債催再最妻宰彩才採栽歳済災砕祭斎細菜裁載際剤在材罪財坂咲崎作削搾昨策索錯桜冊刷察撮擦札殺雑皿三傘参山惨散桟産算蚕賛酸暫残仕伺使刺司史嗣四士始姉姿子市師志思指支施旨枝止死氏祉私糸紙紫肢脂至視詞詩試誌諮資賜雌飼歯事似侍児字寺慈持時次滋治璽磁示耳自辞式識軸七執失室湿漆疾質実芝舎写射捨赦斜煮社者謝車遮蛇邪借尺爵酌釈若寂弱主取守手朱殊狩珠種趣酒首儒受寿授樹需囚収周宗就州修愁拾秀秋終習臭舟衆襲週酬集醜住充十従柔汁渋獣縦重銃叔宿淑祝縮粛塾熟出術述俊春瞬准循旬殉準潤盾純巡遵順処初所暑庶緒署書諸助叙女序徐除傷償勝匠升召商唱奨宵将小少尚床彰承抄招掌昇昭晶松沼消渉焼焦照症省硝礁祥称章笑粧紹肖衝訟証詔詳象賞鐘障上丈乗冗剰城場壌嬢常情条浄状畳蒸譲醸錠嘱飾植殖織職色触食辱伸信侵唇娠寝審心慎振新森浸深申真神紳臣薪親診身辛進針震人仁刃尋甚尽迅陣酢図吹垂帥推水炊睡粋衰遂酔随髄崇数枢据杉澄寸世瀬畝是制勢姓征性成政整星晴正清牲生盛精聖声製西誠誓請逝青静斉税隻席惜斥昔析石積籍績責赤跡切拙接摂折設窃節説雪絶舌仙先千占宣専川戦扇栓泉浅洗染潜旋線繊船薦践選遷銭鮮前善漸然全禅繕塑措疎礎祖租粗素組訴阻僧創双倉喪壮奏層想捜掃挿操早曹巣槽燥争相窓総草荘葬藻装走送遭霜騒像増憎臓蔵贈造促側則即息束測足速俗属賊族続卒存孫尊損村他多太堕妥惰打駄体対耐帯待怠態替泰滞胎袋貸退逮隊代台大第題滝卓宅択拓沢濯託濁諾但達奪脱棚谷丹単嘆担探淡炭短端胆誕鍛団壇弾断暖段男談値知地恥池痴稚置致遅築畜竹蓄逐秩窒茶嫡着中仲宙忠抽昼柱注虫衷鋳駐著貯丁兆帳庁弔張彫徴懲挑朝潮町眺聴腸調超跳長頂鳥勅直朕沈珍賃鎮陳津墜追痛通塚漬坪釣亭低停偵貞呈堤定帝底庭廷弟抵提程締艇訂逓邸泥摘敵滴的笛適哲徹撤迭鉄典天展店添転点伝殿田電吐塗徒斗渡登途都努度土奴怒倒党冬凍刀唐塔島悼投搭東桃棟盗湯灯当痘等答筒糖統到討謄豆踏逃透陶頭騰闘働動同堂導洞童胴道銅峠匿得徳特督篤毒独読凸突届屯豚曇鈍内縄南軟難二尼弐肉日乳入如尿任妊忍認寧猫熱年念燃粘悩濃納能脳農把覇波派破婆馬俳廃拝排敗杯背肺輩配倍培媒梅買売賠陪伯博拍泊白舶薄迫漠爆縛麦箱肌畑八鉢発髪伐罰抜閥伴判半反帆搬板版犯班畔繁般藩販範煩頒飯晩番盤蛮卑否妃彼悲扉批披比泌疲皮碑秘罷肥被費避非飛備尾微美鼻匹必筆姫百俵標氷漂票表評描病秒苗品浜貧賓頻敏瓶不付夫婦富布府怖扶敷普浮父符腐膚譜負賦赴附侮武舞部封風伏副復幅服福腹複覆払沸仏物分噴墳憤奮粉紛雰文聞丙併兵塀幣平弊柄並閉陛米壁癖別偏変片編辺返遍便勉弁保舗捕歩補穂募墓慕暮母簿倣俸包報奉宝峰崩抱放方法泡砲縫胞芳褒訪豊邦飽乏亡傍剖坊妨帽忘忙房暴望某棒冒紡肪膨謀貿防北僕墨撲朴牧没堀奔本翻凡盆摩磨魔麻埋妹枚毎幕膜又抹末繭万慢満漫味未魅岬密脈妙民眠務夢無矛霧婿娘名命明盟迷銘鳴滅免綿面模茂妄毛猛盲網耗木黙目戻問紋門夜野矢厄役約薬訳躍柳愉油癒諭輸唯優勇友幽悠憂有猶由裕誘遊郵雄融夕予余与誉預幼容庸揚揺擁曜様洋溶用窯羊葉要謡踊陽養抑欲浴翌翼羅裸来頼雷絡落酪乱卵欄濫覧利吏履理痢裏里離陸律率立略流留硫粒隆竜慮旅虜了僚両寮料涼猟療糧良量陵領力緑倫厘林臨輪隣塁涙累類令例冷励礼鈴隷零霊麗齢暦歴列劣烈裂廉恋練連錬炉路露労廊朗楼浪漏老郎六録論和話賄惑枠湾腕挨曖宛嵐畏萎椅彙茨咽淫唄鬱怨媛艶旺岡臆俺苛牙瓦楷潰諧崖蓋骸柿顎葛釜鎌韓玩伎亀毀畿臼嗅巾僅錦惧串窟熊詣憬稽隙桁拳鍵舷股虎錮勾梗喉乞傲駒頃痕沙挫采塞埼柵刹拶斬恣摯餌鹿";
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
    //[self resizeWithSize:1200];
    [self resize];
    
    // 画像を二値化
    [self do2ValueFilter];
    
    // 二値化した画像を表示
    [self viewTextFields];
    UIImageView *view = [[UIImageView alloc] initWithImage:mono_img];
    view.frame = CGRectMake(40, 0, 240, 180);
    [[self view] addSubview:view];
    
    // OCRを実行
    [self ocr];
    
    // ぐるぐる消す
    [SVProgressHUD dismiss];
}

// 画像を縮小するやつ
- (UIImage *)resizeWithSize:(int)resize_width{
    CGImageRef image_ref = img.CGImage;
    size_t image_w = CGImageGetWidth(image_ref);
    size_t image_h = CGImageGetHeight(image_ref);
    NSLog(@"%s original %ld * %ld",__func__, image_w, image_h);
    
    if(image_w >= image_h){
        image_h = (int)(image_h * ((float)resize_width / image_w));
        image_w = resize_width;
    }else{
        image_w = (int)(image_w * ((float)resize_width / image_h));
        image_h = resize_width;
    }
    
    NSLog(@"%s resized %ld * %ld",__func__, image_w, image_h);
    
    UIGraphicsBeginImageContext(CGSizeMake(image_w/2, image_h/2));
    [img drawInRect:CGRectMake(0, 0, image_w/2, image_h/2)];
    img = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return img;
}

// 画像を縮小するやつ
- (UIImage *)resize{
    // 画像の縦横を半分に
    CGImageRef image_ref = img.CGImage;
    size_t image_w = CGImageGetWidth(image_ref);
    size_t image_h = CGImageGetHeight(image_ref);
    NSLog(@"%s original %ld * %ld",__func__, image_w, image_h);
    
    image_h = (int)(image_h / 3.0);
    image_w = (int)(image_w / 3.0);
    
    NSLog(@"%s resized %ld * %ld",__func__, image_w, image_h);
    
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
    // 英語OCR
    NSLog(@"%s OCR Language: eng, by monotone image", __func__);
    Tesseract *tesseract_en = [[Tesseract alloc] initWithDataPath:@"tessdata" language:@"eng"];
    [tesseract_en setImage:mono_img];
    //[tesseract_en setVariableValue:@"〒" forKey:@"user_words_suffix"];
    [tesseract_en setVariableValue:@"ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789-:@.!#$%&*+/=?^_" forKey:@"tessedit_char_whitelist"]; // ホワイトリスト
    [tesseract_en setVariableValue:@":(){},'~\\" forKey:@"tessedit_char_blacklist"]; //　ブラックリスト
    // 指定した文字以外にはペナルティを課す
    [tesseract_en setVariableValue:@"0123456789-@" forKey:@"freq_dawg"];
    [tesseract_en setVariableValue:@"0.5" forKey:@"language_model_penalty_non_freq_dict_word"];
    [tesseract_en recognize];
    // スペースを除去
    str_eng = [[tesseract_en recognizedText] stringByReplacingOccurrencesOfString:@" " withString:@""];
    NSLog(@"%@", str_eng);
    
    // メールアドレス /^[a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9-]+(?:\.[a-zA-Z0-9-]+)*$/
    // 正規表現でメールアドレスを抽出
    NSRange mail_range = [str_eng rangeOfString:@"[a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9-]+(?:\\.[a-zA-Z0-9-]+)*" options:NSRegularExpressionSearch];
    if (mail_range.location != NSNotFound) {
        // 見つかった場合
        NSString *mail_string = [str_eng substringWithRange:mail_range];
        NSLog(@"%s, 見つかりました %@", __func__, mail_string);
        mailField.text = mail_string;
    }
    
    // 郵便番号抽出してみる
    NSRange zip_range = [str_eng rangeOfString:@"\\d\\d\\d-\\d\\d\\d\\d" options:NSRegularExpressionSearch];
    if (zip_range.location != NSNotFound) {
        // 見つかった場合
        NSString *zip_string = [str_eng substringWithRange:zip_range];
        zip_string = [zip_string stringByReplacingOccurrencesOfString:@"-" withString:@""];
        NSLog(@"%s, 見つかりました %@", __func__, zip_string);
        
        zipField.text = zip_string;
    }
    
    // 電話番号とか抽出していろいろする
    /*
    [NSTimer scheduledTimerWithTimeInterval:0.1
                                     target:self
                                   selector:@selector(getInformationHTTP:)
                                   userInfo:nil
                                    repeats:false];
     */
    
    [self performSelectorInBackground:@selector(getInformationHTTP:) withObject:nil];
    //[self getInformationHTTP:nil];

    //[self getInformationHTTP:mono_eng];
    

    // 日本語OCR
    NSLog(@"%s OCR Language:jpn Color:monotone", __func__);
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
    //[tesseract setVariableValue:name_kanji forKey:@"tessedit_char_whitelist"];
    [tesseract setVariableValue:@"{}[]｛｝'”〝’()（）【】『』「」・" forKey:@"tessedit_char_blacklist"]; // ブラックリスト
    // フリクエンシーワード
    [tesseract setVariableValue:name_kanji forKey:@"freq_dawg"];
    [tesseract setVariableValue:@"0.5" forKey:@"language_model_penalty_non_freq_dict_word"];
    //[tesseract_en setVariableValue:@"株式会社" forKey:@"freq_dawg"];    // 頻出語彙と、それ以外につけるペナルティ
    //[tesseract_en setVariableValue:@"0.2" forKey:@"language_model_penalty_non_freq_dict_word"];
    [tesseract recognize];  // OCR実行
    // スペースを除去
    NSString *recstr_jpn = [[tesseract recognizedText] stringByReplacingOccurrencesOfString:@" " withString:@""];
    recstr_jpn = [recstr_jpn stringByReplacingOccurrencesOfString:@"　" withString:@""];
    //recstr_jpn = [recstr_jpn stringByReplacingOccurrencesOfString:@"\n" withString:@""];
    NSLog(@"%@", recstr_jpn);
    
    // 会社名を取得
    NSString *company_char = [NSString stringWithFormat:@"%@ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789・，,．ー＆&", name_kanji];
    NSString *company_regex = [NSString stringWithFormat:@"[%@]+会社[%@]*", company_char ,company_char];
    //NSLog(@"%@", company_regex);
    NSRange com_range = [recstr_jpn rangeOfString:company_regex options:NSRegularExpressionSearch];
    if ((com_range.location != NSNotFound)&&(companyField.text.length == 0)) {
        companyField.text = [recstr_jpn substringWithRange:com_range];
        NSLog(@"会社名: %@", companyField.text);
    }else{
        NSLog(@"%s 会社名見つからず %d", __func__, companyField.text.length);
    }
    
    // 名前を取得　（ここで recstr_jpn は破壊されてしまっている）
    // まずは改行までの文字列を取得
    NSString *name_regex = @"[亜哀愛悪握圧扱安暗案以位依偉囲委威尉意慰易為異移維緯胃衣違遺医井域育一壱逸稲芋印員因姻引飲院陰隠韻右宇羽雨渦浦運雲営影映栄永泳英衛詠鋭液疫益駅悦謁越閲円園宴延援沿演炎煙猿縁遠鉛塩汚凹央奥往応押横欧殴王翁黄沖億屋憶乙卸恩温穏音下化仮何価佳加可夏嫁家寡科暇果架歌河火禍稼箇花荷華菓課貨過蚊我画芽賀雅餓介会解回塊壊快怪悔懐戒拐改械海灰界皆絵開階貝劾外害慨概涯街該垣嚇各拡格核殻獲確穫覚角較郭閣隔革学岳楽額掛潟割喝括活渇滑褐轄且株刈乾冠寒刊勘勧巻喚堪完官寛干幹患感慣憾換敢棺款歓汗漢環甘監看管簡緩缶肝艦観貫還鑑間閑関陥館丸含岸眼岩頑顔願企危喜器基奇寄岐希幾忌揮机旗既期棋棄機帰気汽祈季紀規記貴起軌輝飢騎鬼偽儀宜戯技擬欺犠疑義議菊吉喫詰却客脚虐逆丘久休及吸宮弓急救朽求泣球究窮級糾給旧牛去居巨拒拠挙虚許距漁魚享京供競共凶協叫境峡強恐恭挟教橋況狂狭矯胸脅興郷鏡響驚仰凝暁業局曲極玉勤均斤琴禁筋緊菌襟謹近金吟銀九句区苦駆具愚虞空偶遇隅屈掘靴繰桑勲君薫訓群軍郡係傾刑兄啓型契形径恵慶憩掲携敬景渓系経継茎蛍計警軽鶏芸迎鯨劇撃激傑欠決潔穴結血月件倹健兼券剣圏堅嫌建憲懸検権犬献研絹県肩見謙賢軒遣険顕験元原厳幻弦減源玄現言限個古呼固孤己庫弧戸故枯湖誇雇顧鼓五互午呉娯後御悟碁語誤護交侯候光公功効厚口向后坑好孔孝工巧幸広康恒慌抗拘控攻更校構江洪港溝甲皇硬稿紅絞綱耕考肯航荒行衡講貢購郊酵鉱鋼降項香高剛号合拷豪克刻告国穀酷黒獄腰骨込今困墾婚恨懇昆根混紺魂佐唆左差査砂詐鎖座債催再最妻宰彩才採栽歳済災砕祭斎細菜裁載際剤在材罪財坂咲崎作削搾昨策索錯桜冊刷察撮擦札殺雑皿三傘参山惨散桟産算蚕賛酸暫残仕伺使刺司史嗣四士始姉姿子市師志思指支施旨枝止死氏祉私糸紙紫肢脂至視詞詩試誌諮資賜雌飼歯事似侍児字寺慈持時次滋治璽磁示耳自辞式識軸七執失室湿漆疾質実芝舎写射捨赦斜煮社者謝車遮蛇邪借尺爵酌釈若寂弱主取守手朱殊狩珠種趣酒首儒受寿授樹需囚収周宗就州修愁拾秀秋終習臭舟衆襲週酬集醜住充十従柔汁渋獣縦重銃叔宿淑祝縮粛塾熟出術述俊春瞬准循旬殉準潤盾純巡遵順処初所暑庶緒署書諸助叙女序徐除傷償勝匠升召商唱奨宵将小少尚床彰承抄招掌昇昭晶松沼消渉焼焦照症省硝礁祥称章笑粧紹肖衝訟証詔詳象賞鐘障上丈乗冗剰城場壌嬢常情条浄状畳蒸譲醸錠嘱飾植殖織職色触食辱伸信侵唇娠寝審心慎振新森浸深申真神紳臣薪親診身辛進針震人仁刃尋甚尽迅陣酢図吹垂帥推水炊睡粋衰遂酔随髄崇数枢据杉澄寸世瀬畝是制勢姓征性成政整星晴正清牲生盛精聖声製西誠誓請逝青静斉税隻席惜斥昔析石積籍績責赤跡切拙接摂折設窃節説雪絶舌仙先千占宣専川戦扇栓泉浅洗染潜旋線繊船薦践選遷銭鮮前善漸然全禅繕塑措疎礎祖租粗素組訴阻僧創双倉喪壮奏層想捜掃挿操早曹巣槽燥争相窓総草荘葬藻装走送遭霜騒像増憎臓蔵贈造促側則即息束測足速俗属賊族続卒存孫尊損村他多太堕妥惰打駄体対耐帯待怠態替泰滞胎袋貸退逮隊代台大第題滝卓宅択拓沢濯託濁諾但達奪脱棚谷丹単嘆担探淡炭短端胆誕鍛団壇弾断暖段男談値知地恥池痴稚置致遅築畜竹蓄逐秩窒茶嫡着中仲宙忠抽昼柱注虫衷鋳駐著貯丁兆帳庁弔張彫徴懲挑朝潮町眺聴腸調超跳長頂鳥勅直朕沈珍賃鎮陳津墜追痛通塚漬坪釣亭低停偵貞呈堤定帝底庭廷弟抵提程締艇訂逓邸泥摘敵滴的笛適哲徹撤迭鉄典天展店添転点伝殿田電吐塗徒斗渡登途都努度土奴怒倒党冬凍刀唐塔島悼投搭東桃棟盗湯灯当痘等答筒糖統到討謄豆踏逃透陶頭騰闘働動同堂導洞童胴道銅峠匿得徳特督篤毒独読凸突届屯豚曇鈍内縄南軟難二尼弐肉日乳入如尿任妊忍認寧猫熱年念燃粘悩濃納能脳農把覇波派破婆馬俳廃拝排敗杯背肺輩配倍培媒梅買売賠陪伯博拍泊白舶薄迫漠爆縛麦箱肌畑八鉢発髪伐罰抜閥伴判半反帆搬板版犯班畔繁般藩販範煩頒飯晩番盤蛮卑否妃彼悲扉批披比泌疲皮碑秘罷肥被費避非飛備尾微美鼻匹必筆姫百俵標氷漂票表評描病秒苗品浜貧賓頻敏瓶不付夫婦富布府怖扶敷普浮父符腐膚譜負賦赴附侮武舞部封風伏副復幅服福腹複覆払沸仏物分噴墳憤奮粉紛雰文聞丙併兵塀幣平弊柄並閉陛米壁癖別偏変片編辺返遍便勉弁保舗捕歩補穂募墓慕暮母簿倣俸包報奉宝峰崩抱放方法泡砲縫胞芳褒訪豊邦飽乏亡傍剖坊妨帽忘忙房暴望某棒冒紡肪膨謀貿防北僕墨撲朴牧没堀奔本翻凡盆摩磨魔麻埋妹枚毎幕膜又抹末繭万慢満漫味未魅岬密脈妙民眠務夢無矛霧婿娘名命明盟迷銘鳴滅免綿面模茂妄毛猛盲網耗木黙目戻問紋門夜野矢厄役約薬訳躍柳愉油癒諭輸唯優勇友幽悠憂有猶由裕誘遊郵雄融夕予余与誉預幼容庸揚揺擁曜様洋溶用窯羊葉要謡踊陽養抑欲浴翌翼羅裸来頼雷絡落酪乱卵欄濫覧利吏履理痢裏里離陸律率立略流留硫粒隆竜慮旅虜了僚両寮料涼猟療糧良量陵領力緑倫厘林臨輪隣塁涙累類令例冷励礼鈴隷零霊麗齢暦歴列劣烈裂廉恋練連錬炉路露労廊朗楼浪漏老郎六録論和話賄惑枠湾腕挨曖宛嵐畏萎椅彙茨咽淫唄鬱怨媛艶旺岡臆俺苛牙瓦楷潰諧崖蓋骸柿顎葛釜鎌韓玩伎亀毀畿臼嗅巾僅錦惧串窟熊詣憬稽隙桁拳鍵舷股虎錮勾梗喉乞傲駒頃痕沙挫采塞埼柵刹拶斬恣摯餌鹿梶]+";
    NSString* parsedString;
    NSRange range, subrange;
    int length;
    int name_highscore = 10; // 名前スコアのハイスコア（低いほどいい
    NSString *name_result = @""; // 名前検索の結果
    
    length = [recstr_jpn length];
    range = NSMakeRange(0, length);
    while(range.length > 0) {
        subrange = [recstr_jpn lineRangeForRange:
                    NSMakeRange(range.location, 0)];
        parsedString = [recstr_jpn substringWithRange:subrange];
        NSLog(@"line: %@", parsedString);
        // 名前認識
        NSRange name_range = [parsedString rangeOfString:name_regex options:NSRegularExpressionSearch];
        // 見つかった場合
        if(name_range.location != NSNotFound){
            // スコアリング
            int score = fabs(name_range.length - 4) + name_range.location;
            if(name_highscore > score){
                name_highscore = score;
                name_result = [parsedString substringWithRange:name_range];
                NSLog(@"%@", name_result);
            }
        }
        range.location = NSMaxRange(subrange);
        range.length -= subrange.length;
    }
    NSLog(@"名前認識終わり");
    nameField.text = name_result;
    /*
    NSString *name_regex = "[亜哀愛悪握圧扱安暗案以位依偉囲委威尉意慰易為異移維緯胃衣違遺医井域育一壱逸稲芋印員因姻引飲院陰隠韻右宇羽雨渦浦運雲営影映栄永泳英衛詠鋭液疫益駅悦謁越閲円園宴延援沿演炎煙猿縁遠鉛塩汚凹央奥往応押横欧殴王翁黄沖億屋憶乙卸恩温穏音下化仮何価佳加可夏嫁家寡科暇果架歌河火禍稼箇花荷華菓課貨過蚊我画芽賀雅餓介会解回塊壊快怪悔懐戒拐改械海灰界皆絵開階貝劾外害慨概涯街該垣嚇各拡格核殻獲確穫覚角較郭閣隔革学岳楽額掛潟割喝括活渇滑褐轄且株刈乾冠寒刊勘勧巻喚堪完官寛干幹患感慣憾換敢棺款歓汗漢環甘監看管簡緩缶肝艦観貫還鑑間閑関陥館丸含岸眼岩頑顔願企危喜器基奇寄岐希幾忌揮机旗既期棋棄機帰気汽祈季紀規記貴起軌輝飢騎鬼偽儀宜戯技擬欺犠疑義議菊吉喫詰却客脚虐逆丘久休及吸宮弓急救朽求泣球究窮級糾給旧牛去居巨拒拠挙虚許距漁魚享京供競共凶協叫境峡強恐恭挟教橋況狂狭矯胸脅興郷鏡響驚仰凝暁業局曲極玉勤均斤琴禁筋緊菌襟謹近金吟銀九句区苦駆具愚虞空偶遇隅屈掘靴繰桑勲君薫訓群軍郡係傾刑兄啓型契形径恵慶憩掲携敬景渓系経継茎蛍計警軽鶏芸迎鯨劇撃激傑欠決潔穴結血月件倹健兼券剣圏堅嫌建憲懸検権犬献研絹県肩見謙賢軒遣険顕験元原厳幻弦減源玄現言限個古呼固孤己庫弧戸故枯湖誇雇顧鼓五互午呉娯後御悟碁語誤護交侯候光公功効厚口向后坑好孔孝工巧幸広康恒慌抗拘控攻更校構江洪港溝甲皇硬稿紅絞綱耕考肯航荒行衡講貢購郊酵鉱鋼降項香高剛号合拷豪克刻告国穀酷黒獄腰骨込今困墾婚恨懇昆根混紺魂佐唆左差査砂詐鎖座債催再最妻宰彩才採栽歳済災砕祭斎細菜裁載際剤在材罪財坂咲崎作削搾昨策索錯桜冊刷察撮擦札殺雑皿三傘参山惨散桟産算蚕賛酸暫残仕伺使刺司史嗣四士始姉姿子市師志思指支施旨枝止死氏祉私糸紙紫肢脂至視詞詩試誌諮資賜雌飼歯事似侍児字寺慈持時次滋治璽磁示耳自辞式識軸七執失室湿漆疾質実芝舎写射捨赦斜煮社者謝車遮蛇邪借尺爵酌釈若寂弱主取守手朱殊狩珠種趣酒首儒受寿授樹需囚収周宗就州修愁拾秀秋終習臭舟衆襲週酬集醜住充十従柔汁渋獣縦重銃叔宿淑祝縮粛塾熟出術述俊春瞬准循旬殉準潤盾純巡遵順処初所暑庶緒署書諸助叙女序徐除傷償勝匠升召商唱奨宵将小少尚床彰承抄招掌昇昭晶松沼消渉焼焦照症省硝礁祥称章笑粧紹肖衝訟証詔詳象賞鐘障上丈乗冗剰城場壌嬢常情条浄状畳蒸譲醸錠嘱飾植殖織職色触食辱伸信侵唇娠寝審心慎振新森浸深申真神紳臣薪親診身辛進針震人仁刃尋甚尽迅陣酢図吹垂帥推水炊睡粋衰遂酔随髄崇数枢据杉澄寸世瀬畝是制勢姓征性成政整星晴正清牲生盛精聖声製西誠誓請逝青静斉税隻席惜斥昔析石積籍績責赤跡切拙接摂折設窃節説雪絶舌仙先千占宣専川戦扇栓泉浅洗染潜旋線繊船薦践選遷銭鮮前善漸然全禅繕塑措疎礎祖租粗素組訴阻僧創双倉喪壮奏層想捜掃挿操早曹巣槽燥争相窓総草荘葬藻装走送遭霜騒像増憎臓蔵贈造促側則即息束測足速俗属賊族続卒存孫尊損村他多太堕妥惰打駄体対耐帯待怠態替泰滞胎袋貸退逮隊代台大第題滝卓宅択拓沢濯託濁諾但達奪脱棚谷丹単嘆担探淡炭短端胆誕鍛団壇弾断暖段男談値知地恥池痴稚置致遅築畜竹蓄逐秩窒茶嫡着中仲宙忠抽昼柱注虫衷鋳駐著貯丁兆帳庁弔張彫徴懲挑朝潮町眺聴腸調超跳長頂鳥勅直朕沈珍賃鎮陳津墜追痛通塚漬坪釣亭低停偵貞呈堤定帝底庭廷弟抵提程締艇訂逓邸泥摘敵滴的笛適哲徹撤迭鉄典天展店添転点伝殿田電吐塗徒斗渡登途都努度土奴怒倒党冬凍刀唐塔島悼投搭東桃棟盗湯灯当痘等答筒糖統到討謄豆踏逃透陶頭騰闘働動同堂導洞童胴道銅峠匿得徳特督篤毒独読凸突届屯豚曇鈍内縄南軟難二尼弐肉日乳入如尿任妊忍認寧猫熱年念燃粘悩濃納能脳農把覇波派破婆馬俳廃拝排敗杯背肺輩配倍培媒梅買売賠陪伯博拍泊白舶薄迫漠爆縛麦箱肌畑八鉢発髪伐罰抜閥伴判半反帆搬板版犯班畔繁般藩販範煩頒飯晩番盤蛮卑否妃彼悲扉批披比泌疲皮碑秘罷肥被費避非飛備尾微美鼻匹必筆姫百俵標氷漂票表評描病秒苗品浜貧賓頻敏瓶不付夫婦富布府怖扶敷普浮父符腐膚譜負賦赴附侮武舞部封風伏副復幅服福腹複覆払沸仏物分噴墳憤奮粉紛雰文聞丙併兵塀幣平弊柄並閉陛米壁癖別偏変片編辺返遍便勉弁保舗捕歩補穂募墓慕暮母簿倣俸包報奉宝峰崩抱放方法泡砲縫胞芳褒訪豊邦飽乏亡傍剖坊妨帽忘忙房暴望某棒冒紡肪膨謀貿防北僕墨撲朴牧没堀奔本翻凡盆摩磨魔麻埋妹枚毎幕膜又抹末繭万慢満漫味未魅岬密脈妙民眠務夢無矛霧婿娘名命明盟迷銘鳴滅免綿面模茂妄毛猛盲網耗木黙目戻問紋門夜野矢厄役約薬訳躍柳愉油癒諭輸唯優勇友幽悠憂有猶由裕誘遊郵雄融夕予余与誉預幼容庸揚揺擁曜様洋溶用窯羊葉要謡踊陽養抑欲浴翌翼羅裸来頼雷絡落酪乱卵欄濫覧利吏履理痢裏里離陸律率立略流留硫粒隆竜慮旅虜了僚両寮料涼猟療糧良量陵領力緑倫厘林臨輪隣塁涙累類令例冷励礼鈴隷零霊麗齢暦歴列劣烈裂廉恋練連錬炉路露労廊朗楼浪漏老郎六録論和話賄惑枠湾腕挨曖宛嵐畏萎椅彙茨咽淫唄鬱怨媛艶旺岡臆俺苛牙瓦楷潰諧崖蓋骸柿顎葛釜鎌韓玩伎亀毀畿臼嗅巾僅錦惧串窟熊詣憬稽隙桁拳鍵舷股虎錮勾梗喉乞傲駒頃痕沙挫采塞埼柵刹拶斬恣摯餌鹿梶]+";
    NSRange name_range = [recstr_jpn rangeOfString:@"" options:NSRegularExpressionSearch];
    int name_highscore = 10;
    NSString *name_result = @"";
    // NSLog(@"名前認識 %@", name_regex);
    while(name_range.location != NSNotFound){
        //NSLog(@"結果を取得 %d, %d", name_range.location, name_range.length);
        // 名前っぽさのすこあ算出(低いほど良い)
        int score = fabs(name_range.length - 4) + name_range.location;
        if(name_highscore > score){
            name_highscore = score;
            name_result = [recstr_jpn substringWithRange:name_range];
            NSLog(@"%@", name_result);
        }
        // 次の認識
        recstr_jpn = [recstr_jpn substringFromIndex:(name_range.location + name_range.length)];
        name_range = [recstr_jpn rangeOfString:name_regex options:NSRegularExpressionSearch];
    }
    NSLog(@"名前認識終わり");
    nameField.text = name_result;
     */
}

- (void)getInformationHTTP:(id)sender{
    // 各種データが見つかったかどうかのフラグ
    BOOL tel_flag = false;

     NSDataDetector *dataDetector = [NSDataDetector dataDetectorWithTypes:NSTextCheckingTypeLink|
                                     NSTextCheckingTypePhoneNumber
                                                                    error:nil];
     
     NSArray *resultArray = [dataDetector matchesInString:str_eng
                                                  options:0
                                                    range:NSMakeRange(0,[str_eng length])];
     
    for (NSTextCheckingResult *result in resultArray){
         if ([result resultType] == NSTextCheckingTypeLink){
             // URLとおぼしきものが見つかった場合
             // メールアドレスが見つかってなかったらメールアドレスとする。
             if([mailField.text length] <= 0){
                 NSURL *url = [result URL];
                 NSLog(@"url:%@",[url description]);
                 mailField.text = [url description];
             }
        } else if ([result resultType] == NSTextCheckingTypePhoneNumber) {
            // 電話番号らしきものが見つかった場合
            NSString *phoneNumber = [result phoneNumber];
            NSLog(@"tel:%@",phoneNumber);
            
            NSRange tel_range = [phoneNumber rangeOfString:@"[-\\d]+" options:NSRegularExpressionSearch];
            if ((tel_range.location != NSNotFound)&&(!tel_flag)) {
                // 見つかった場合
                NSString *tel_string = [phoneNumber substringWithRange:tel_range];
                NSLog(@"%s, 見つかりました %@", __func__, tel_string);
                // API叩く
                // URLからリクエストを生成
                // http://104.com/knj_%F1%D1%F1%CC/svp_/nm_06-6202-3376
                // http://www.jpnumber.com/searchnumber.do?number=
                NSString *url_string = [NSString stringWithFormat:@"http://www.jpnumber.com/searchnumber.do?number=%@", tel_string];
                NSLog(@"%s url %@", __func__, url_string);
                //NSString *url_encoded = [url_string stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
                //NSLog(@"%s url %@", __func__, url_encoded);
                NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:url_string]];
                
                //NSString *useragent = @"Mozilla/5.0 (Macintosh; Intel Mac OS X 10.7; rv:23.0) Gecko/20100101 Firefox/23.0";
                //[request setValue:useragent forHTTPHeaderField:@"User-Agent"];
                
                //結果をNSDataで受け取る
                NSData *data = [NSURLConnection sendSynchronousRequest:request returningResponse: nil error: nil];
                //NSStringに変換
                NSString *http_result_string = [[NSString alloc] initWithBytes: [data bytes] length:[data length] encoding: NSUTF8StringEncoding];
                //NSLog(@"%@", http_result_string);
                
                // 会社名を抽出する<dt>事業者名:<strong><
                // <dt>事業者名：<strong><a href="numberinfo_06_6202_3376.html" class="result">東邦金属株式会社</a></strong></dt>
                NSString *com_regex_string = @"<dt>事業者名：<strong><a href=\"numberinfo.+?\" class=\"result\">(.+?)</a></strong></dt>";
                NSLog(@"com_regex %@", com_regex_string);
                NSRegularExpression *com_regex = [NSRegularExpression regularExpressionWithPattern:com_regex_string options:0 error:nil];
                NSTextCheckingResult *com_match = [com_regex firstMatchInString:http_result_string options:0 range:NSMakeRange(0, http_result_string.length)];
                
                if(com_match.numberOfRanges) {
                    NSString *com_string = [http_result_string substringWithRange:[com_match rangeAtIndex:1]];
                    NSLog(@"マッチングしました %@", com_string);        // マッチ全体
                    companyField.text = com_string;
                    tel_flag = true;
                }
            }
        }
     }
    
    // 電話番号抽出
    /*
    NSRange tel_range = [str rangeOfString:@"\\d+-\\d+-\\d+" options:NSRegularExpressionSearch];
    if (tel_range.location != NSNotFound) {
        // 見つかった場合
        NSString *tel_string = [str substringWithRange:tel_range];
        NSLog(@"%s, 見つかりました %@", __func__, tel_string);
        // API叩く
        // URLからリクエストを生成
        // http://104.com/knj_%F1%D1%F1%CC/svp_/nm_06-6202-3376
        // http://www.jpnumber.com/searchnumber.do?number=
        NSString *url_string = [NSString stringWithFormat:@"http://www.jpnumber.com/searchnumber.do?number=%@", tel_string];
        NSLog(@"%s url %@", __func__, url_string);
        //NSString *url_encoded = [url_string stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
        //NSLog(@"%s url %@", __func__, url_encoded);
        NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:url_string]];
        
        //NSString *useragent = @"Mozilla/5.0 (Macintosh; Intel Mac OS X 10.7; rv:23.0) Gecko/20100101 Firefox/23.0";
        //[request setValue:useragent forHTTPHeaderField:@"User-Agent"];
        
        //結果をNSDataで受け取る
        NSData *data = [NSURLConnection sendSynchronousRequest:request returningResponse: nil error: nil];
        //NSStringに変換
        NSString *http_result_string = [[NSString alloc] initWithBytes: [data bytes] length:[data length] encoding: NSUTF8Stringa href="numberinfo_06_6202_3376.html" class="result">東邦金属株式会社</a></strong></dt>
        NSString *com_regex_string = @"<dt>事業者名：<strong><a href=\"numberinfo.+?\" class=\"result\">(.+?)</a></strong></dt>";
        NSLog(@"com_regex %@", com_regex_string);
        NSRegularExpression *com_regex = [NSRegularExpression regularExpressionWithPattern:com_regex_string options:0 error:nil];
        NSTextCheckingResult *com_match = [com_regex firstMatchInString:http_result_string options:0 range:NSMakeRange(0, http_result_string.length)];
        
        if(com_match.numberOfRanges) {
            NSString *com_string = [http_result_string substringWithRange:[com_match rangeAtIndex:1]];
            NSLog(@"マッチングしました %@", com_string);        // マッチ全体
            companyField.text = com_string;
        }
        /*
         NSRange com_range = [http_result_string rangeOfString:com_regex options:NSRegularExpressionSearch];
         if (com_range.location != NSNotFound) {
         NSString *com_string = [http_result_string substringWithRange:com_range];
         NSLog(@"RegularExpression みつかりました %@", com_string);
         }
         */
    //}

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
    
    MBButton *submit = [MBButton buttonWithType:UIButtonTypeRoundedRect];
    [submit setColorType:1];
    submit.frame = CGRectMake(60, 300, 200, 40);
    [submit setTitle:@"召喚！" forState:UIControlStateNormal];
    [submit addTarget:self action:@selector(summon:) forControlEvents:UIControlEventTouchDown];
    [correctView addSubview:submit];
     
    
    MBButton *cancel = [MBButton buttonWithType:UIButtonTypeRoundedRect];
    cancel.frame = CGRectMake(60, 360, 200, 40);
    [cancel setTitle:@"キャンセル" forState:UIControlStateNormal];
    [cancel setColorType:2];
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
    UIAlertView *alert = [[UIAlertView alloc] init];
    if(nameField.text.length == 0){ // 名前
        alert.title = @"名前";
        alert.message = @"を入力してください";
        [alert addButtonWithTitle:@"もどる"];
    }else if(zipField.text.length < 7){    // 郵便番号
        alert.title = @"郵便番号";
        alert.message = @"を正しく入力してください";
        [alert addButtonWithTitle:@"もどる"];
    }else if(companyField.text.length == 0){    // 会社名
        alert.title = @"会社名";
        alert.message = @"を入力してください";
        [alert addButtonWithTitle:@"もどる"];
    }else if([mailField.text rangeOfString:@".*@.*" options:NSRegularExpressionSearch].location == NSNotFound){
        // メールアドレス
        alert.title = @"メールアドレス";
        alert.message = @"を正しく入力してください";
        [alert addButtonWithTitle:@"もどる"];
    }else{
        alert.delegate = self;
        alert.tag = 1;
        alert.title = @"性別";
        alert.message = @"性別を選択してください";
        [alert addButtonWithTitle:@"男"];
        [alert addButtonWithTitle:@"女"];
        /*
        alert.title = @"決定したら変更できません";
        alert.message = @"これでよろしいですか？";
        [alert addButtonWithTitle:@"はい"];
        [alert addButtonWithTitle:@"いいえ"];
         */
    }
    [alert show];
}

// 召喚
-(void)alertView:(UIAlertView*)alertView
clickedButtonAtIndex:(NSInteger)buttonIndex {
    NSLog(@"%s %d", __func__, alertView.tag);
    switch (alertView.tag) {
        case 1:{
            sex_int = buttonIndex;
            // 性別が選ばれたとき
            UIAlertView *alert = [[UIAlertView alloc] init];
            alert.title = @"決定したら変更できません";
            alert.delegate = self;
            if(sex_int == 0){
                alert.message = @"キャラクターを生成します\n性別: 男";
            }else{
                alert.message = @"キャラクターを生成します\n性別: 女";
            }
            [alert addButtonWithTitle:@"はい"];
            [alert addButtonWithTitle:@"いいえ"];
            [alert show];
            break;
        }
            
        default:{
            // 決定ボタンが押されたとき
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
                meishi = [[Meishi alloc] initWithInformation:name CompanyName:company Mail1:mail1 Mail2:mail2 Zip1:zip1 Zip2:zip2 Sex:sex_int];
                
                svc = [[SummonViewController alloc] init];
                [svc setMeishi:meishi];
                [svc.close_button addTarget:self action:@selector(closeAll:)forControlEvents:UIControlEventTouchUpInside];
                
                [self presentViewController:svc animated:NO completion:nil];
                
                [player addMeishi:meishi];
                [player save];
                
                //[self dismissViewControllerAnimated:YES completion:nil];
            }
            break;
        }
    }

}

- (void)cancel:(id)sender{
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)closeAll:(UIButton *)sender{
    NSLog(@"%s", __func__);
    [svc dismissViewControllerAnimated:NO completion:nil];
    [self dismissViewControllerAnimated:YES completion:nil];
    
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
