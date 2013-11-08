//
//  MBSummonView.h
//  Mbattler
//
//  Created by Yoshiyuki Sakamoto on 2013/11/08.
//  Copyright (c) 2013年 Mbattler. All rights reserved.
//

#import "MBScrollView.h"
#import "MBButton.h"
#import "MBAnimationView.h"

@interface MBSummonView : MBScrollView{
    UILabel *alert_label;
}

@property(readwrite) MBButton *cameraButton;

@end
