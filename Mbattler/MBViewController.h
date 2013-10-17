//
//  MBViewController.h
//  Mbattler
//
//  Created by Yoshiyuki Sakamoto on 2013/06/02.
//  Copyright (c) 2013年 Mbattler. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AppDelegate.h"
#import "Player.h"
#import "MBScrollView.h"
#import "MBDatabase.h"

@interface MBViewController : UIViewController<UINavigationControllerDelegate, UIImagePickerControllerDelegate>{
    UILabel *title;
    AppDelegate *ad;
    Player *player;
    UIColor *bgcolor;   // 背景
    UIColor *menucolor; // メニューとかタイトルとかの背景色
    UIColor *menutextcolor; // メニューとかのテキストの色
    UIColor *subbgcolor;
    MBDatabase *mbdb;
    
    int w;
    int h;
    int inside_h;
    int yposition;
    
    MBScrollView *nowScrollView;
    // ダンジョンの confirm_view 
    UIScrollView *confirm_view;
}

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info;
- (id)initWithPlayer:(Player *)p;
@end
