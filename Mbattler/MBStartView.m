//
//  MBStartView.m
//  Mbattler
//
//  Created by Yoshiyuki Sakamoto on 2013/09/14.
//  Copyright (c) 2013年 Mbattler. All rights reserved.
//

#import "MBStartView.h"

@implementation MBStartView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

- (id)init{
    self = [super initWithPlayer:nil];
    if(self){
        [self setTitle:@"はじめに"];
        

        UIImageView *summon = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"summon.png"]];
        summon.frame = CGRectMake(20, 60, 52, 52);
        [self addSubview:summon];
        
        UILabel *summon_desc_label = [[UILabel alloc] init];
        summon_desc_label.font = [UIFont fontWithName:@"mikachan_o" size:16];
        summon_desc_label.frame = CGRectMake(80, 60, 220, 52);
        summon_desc_label.text = @"名刺からキャラクターを生成して";
        summon_desc_label.backgroundColor = [UIColor clearColor];
        summon_desc_label.numberOfLines = 2;
        [self addSubview:summon_desc_label];
        
        
        
        
        
        UIImageView *character = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"character.png"]];
        character.frame = CGRectMake(20,130, 52, 52);
        [self addSubview:character];
        
        UILabel *character_desc_label = [[UILabel alloc] init];
        character_desc_label.font = [UIFont fontWithName:@"mikachan_o" size:16];
        character_desc_label.frame = CGRectMake(80, 130, 220, 52);
        character_desc_label.text = @"キャラクターの強さを見る";
        character_desc_label.backgroundColor = [UIColor clearColor];
        character_desc_label.numberOfLines = 2;
        [self addSubview:character_desc_label];
        
        
        
        
        
        UIImageView *party = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"party.png"]];
        party.frame = CGRectMake(20,200, 52, 52);
        [self addSubview:party];
        
        UILabel *party_desc_label = [[UILabel alloc] init];
        party_desc_label.font = [UIFont fontWithName:@"mikachan_o" size:16];
        party_desc_label.frame = CGRectMake(80, 200, 220, 52);
        party_desc_label.text = @"パーティ編成をして";
        party_desc_label.backgroundColor = [UIColor clearColor];
        party_desc_label.numberOfLines = 2;
        [self addSubview:party_desc_label];
        
        
        
        
        UIImageView *dungeon = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"dungeon.png"]];
        dungeon.frame = CGRectMake(20, 270, 52, 52);
        [self addSubview:dungeon];
        
        UILabel *dungeon_desc_label = [[UILabel alloc] init];
        dungeon_desc_label.font = [UIFont fontWithName:@"mikachan_o" size:16];
        dungeon_desc_label.frame = CGRectMake(80, 270, 220, 52);
        dungeon_desc_label.text = @"ダンジョンへ行こう！";
        dungeon_desc_label.backgroundColor = [UIColor clearColor];
        dungeon_desc_label.numberOfLines = 2;
        [self addSubview:dungeon_desc_label];

        

        
    }
    return self;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
