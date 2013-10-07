//
//  MBDatabase.m
//  Mbattler
//
//  Created by Yoshiyuki Sakamoto on 2013/10/07.
//  Copyright (c) 2013年 Mbattler. All rights reserved.
//

#import "MBDatabase.h"

@implementation MBDatabase

- (id)init{
    self = [super init];
    if(self){
        NSLog(@"%s", __func__);
        
        // ファイルマネージャー初期化
        file_manager = [NSFileManager defaultManager];
        // データベースファイルを格納する文書フォルダーのパスを取得
        NSString *workDir_path = [NSSearchPathForDirectoriesInDomains(NSDocumentationDirectory, NSUserDomainMask, YES) objectAtIndex:0];
        NSLog(@"%@", workDir_path);
        // その作業ディレクトリが存在しているかどうかの確認
        if(![file_manager fileExistsAtPath:workDir_path]){
            // ディレクトリが存在していない場合は作成する
            NSLog(@"作業ディレクトリが存在していません %@", workDir_path);
            [file_manager createDirectoryAtPath:workDir_path withIntermediateDirectories:YES attributes:nil error:nil];
        }
        
        // データベースのファイル名
        NSString *database_filename = @"MBDatabase.db";
        // データベースファイルのパスを取得する
        NSString *database_path = [NSString stringWithFormat:@"%@/%@", workDir_path, database_filename];
        

        // パスにデータベースが存在しているかを確認
        if(![file_manager fileExistsAtPath:database_path]){
            // データベースのファイルが存在していない場合
            NSLog(@"データベースがありません。作成します。 %@", database_path);
            // テンプレートのデータベースをコピー
            NSString *template_database_path = [[[NSBundle mainBundle] resourcePath] stringByAppendingPathComponent:database_filename];
            if(![file_manager fileExistsAtPath:template_database_path]) NSLog(@"テンプレートファイルが見つからない");
            NSLog(@"テンプレートのパス %@", template_database_path);
            if(![file_manager copyItemAtPath:template_database_path toPath:database_path error:nil]){
                NSLog(@"データベーステンプレートのコピーに失敗しました");
            }
            /* CREATEで作成
            db = [FMDatabase databaseWithPath:database_path];
            NSString *create_meishi = @"CREATE TABLE meishi (meishiId INTEGER NOT NULL PRIMARY KEY, name TEXT, lv INTEGER, imageNum INTEGER, job INTEGER, abilityId INTEGER, H INTEGER, A INTEGER, B INTEGER, C INTEGER, D INTEGER, S INTEGER, sex INTEGER, history TEXT, company TEXT, mail1 TEXT, mail2 TEXT, zip1 INTEGER, zip2 INTEGER, exp INTEGER);";
            [db open];
            [db executeUpdate:create_meishi];
            [db close];
             */
        }
        db = [FMDatabase databaseWithPath:database_path];
    }
    return self;
}

// 名刺を保存するメソッド
- (void)saveMeishi:(int)id :(Meishi *)meishi{
    NSString *sql = [NSString stringWithFormat:@"INSERT INTO meishi VALUES (%d, '%@', %d, %d, %d, %d, %d, %d, %d, %d, %d, %d, %d, '%@', '%@', '%@', '%@', %d, %d, %d);",
                     id,
                     [meishi getName],
                     [meishi getLv],
                     [meishi getImageInt],
                     [meishi getJobInt],
                     [meishi getAbilityID],
                     [meishi getH],
                     [meishi getA],
                     [meishi getB],
                     [meishi getC],
                     [meishi getD],
                     [meishi getS],
                     [meishi getSex],
                     [meishi getHistory],
                     [meishi getCompany],
                     [meishi getMail1],
                     [meishi getMail2],
                     [meishi getZip1],
                     [meishi getZip2],
                     [meishi getExp]];
    //@"insert into meishi values (0, 'sakamoto', 5, 1, 0, 0, 1, 1, 1, 1, 1, 1, 0, 'hist', 'comname', 'mail1', 'mail2', 'zip1', 'zip2', 0);";
    [db open];
    NSString *delete_sql = [NSString stringWithFormat:@"DELETE FROM meishi WHERE meishiId = %d", id];
    [db executeUpdate:delete_sql];
    if([db executeUpdate:sql]){
        NSLog(@"insert成功");
    }else{
        NSLog(@"insert失敗");
    }
    [db close];
}

@end
