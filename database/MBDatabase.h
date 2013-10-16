//
//  MBDatabase.h
//  Mbattler
//
//  Created by Yoshiyuki Sakamoto on 2013/10/07.
//  Copyright (c) 2013年 Mbattler. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "FMDatabase.h"
#import "Meishi.h"

@interface MBDatabase : NSObject{
    // ファイルマネージャー
    NSFileManager *file_manager;
    
    // データベースアクセス用のFMDatabase
    FMDatabase *db;
}

- (id)init;

// 名刺を保存するメソッド
- (void)saveMeishi:(int)id :(Meishi *)meishi;

// 名刺を読み出す
- (NSMutableArray *)loadAllMeishi;

@end
