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
        }
        db = [FMDatabase databaseWithPath:database_path];
    }
    return self;
}

// 名刺を保存するメソッド
- (void)saveMeishi:(int)id :(Meishi *)meishi{
    NSLog(@"%s, %@", __func__, meishi.date_string);
    NSString *sql = [NSString stringWithFormat:@"INSERT INTO meishi VALUES (%d, '%@', %d, %d, %d, %d, %d, %d, %d, %d, %d, %d, %d, '%@', '%@', '%@', '%@', %d, %d, %d, '%@');",
                     id,
                     [meishi getName],
                     [meishi getLv],
                     [meishi getImageInt],
                     [meishi getJobInt],
                     [meishi getAbilityID],
                     [meishi getIndividualHInt],
                     [meishi getIndividualAInt],
                     [meishi getIndividualBInt],
                     [meishi getIndividualCInt],
                     [meishi getIndividualDInt],
                     [meishi getIndividualSInt],
                     [meishi getSex],
                     meishi.history,
                     [meishi getCompany],
                     [meishi getMail1],
                     [meishi getMail2],
                     [meishi getZip1],
                     [meishi getZip2],
                     [meishi getExp],
                     meishi.date_string];
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

// 名刺を読むメソッド

- (NSMutableArray *)loadAllMeishi{
    NSMutableArray *return_result = [[NSMutableArray alloc] init];
    // データベースから名刺のロード
    NSString *query = @"SELECT * FROM meishi ORDER BY meishiId";
    [db open];
    FMResultSet *rs = [db executeQuery:query];
    
    // 持ってた名刺の数を見る
    NSUserDefaults *ud = [NSUserDefaults standardUserDefaults];
    int meishi_count = [ud integerForKey:@"MEISHI_NUM"];
    //while([rs next]){
    for(int i = 0; i < meishi_count; i++){
        if(![rs next]) break;
        NSLog(@"%d", [rs intForColumn:@"meishiId"]);
        Meishi *m = [[Meishi alloc] init];
        [m setName:[rs stringForColumn:@"name"]];
        [m setLv:[rs intForColumn:@"lv"]];
        [m setSex:[rs intForColumn:@"sex"]];
        [m setJob: [rs intForColumn:@"job"]];
        int ind[6] = {[rs intForColumn:@"H"], [rs intForColumn:@"A"], [rs intForColumn:@"B"], [rs intForColumn:@"C"], [rs intForColumn:@"D"], [rs intForColumn:@"S"]};
        [m setIndividual:ind];
        [m calcParameter];
        [m setExp:[rs intForColumn:@"exp"]];
        [m setAbility:[rs intForColumn:@"abilityId"]];
        [m setDateString:[rs stringForColumn:@"date"]];
        m.history = [rs stringForColumn:@"history"];
        [return_result addObject:m];
        NSLog(@"%s, %@", __func__, m.date_string);
    }
    [rs close];
    [db close];
    return return_result;
}

@end
