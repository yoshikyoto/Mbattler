//
//  SummonViewController.h
//  Mbattler
//
//  Created by Yoshiyuki Sakamoto on 2013/08/12.
//  Copyright (c) 2013年 Mbattler. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Meishi.h"

@interface SummonViewController : UIViewController{
    Meishi *meishi;
    MBAnimationView *effect1;
    MBAnimationView *effect2;
    UITapGestureRecognizer *tgr;
}

- (void)setMeishi:(Meishi *)m;

@end
