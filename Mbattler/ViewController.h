//
//  ViewController.h
//  Mbattler
//
//  Created by Yoshiyuki Sakamoto on 2013/03/09.
//  Copyright (c) 2013年 Mbattler. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Player.h"
#import <AVFoundation/AVFoundation.h>

@interface ViewController : UIViewController<UITextFieldDelegate>{
    Player *player;
    UITextField *name_textfield;
    AVAudioPlayer *audio_player;
}

@end


