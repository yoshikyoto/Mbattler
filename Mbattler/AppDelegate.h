//
//  AppDelegate.h
//  Mbattler
//
//  Created by Yoshiyuki Sakamoto on 2013/03/09.
//  Copyright (c) 2013年 Mbattler. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Meishi.h"
#import "Player.h"

@interface AppDelegate : UIResponder <UIApplicationDelegate>{
}
//@property (nonatomic, retain) NSMutableArray *meishis;
@property (nonatomic, retain) NSMutableArray *player;

@property (strong, nonatomic) UIWindow *window;

@end

