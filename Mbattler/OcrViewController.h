//
//  OcrViewController.h
//  Mbattler
//
//  Created by Yoshiyuki Sakamoto on 2013/08/19.
//  Copyright (c) 2013年 Mbattler. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Player.h"
#import "Meishi.h"

@interface OcrViewController : UIViewController<UITextFieldDelegate>{
    Player *player;
    Meishi *meishi;
    UIImage *img;
    UIImage *gray_img;
    UIImage *mono_img;
    
    NSString *str_eng;
    NSString *str_jpn;
    
    NSString *zip;
    int zip1;
    int zip2;
    NSString *company;
    NSString *name;
    NSString *mail;
    NSString *mail1;
    NSString *mail2;
    
    UIScrollView *correctView;
    UITextField *zipField;
    UITextField *companyField;
    UITextField *nameField;
    UITextField *mailField;
    UITextField *activeField;
    
    NSString *name_kanji;
}

- (id)initWithPlayer:(Player *)p OCRImage:(UIImage *)_img;

@end
