//
//  ViewController.m
//  Products
//
//  Created by zhaogyrain on 14-4-4.
//  Copyright (c) 2014 liweilin. All rights reserved.
//

#import "ViewController.h"
#import "DetailViewController.h"

#define DBNAME			@"products.sqlite"
#define TABLENAME		@"PRODUCTINFO"
#define ID				@"id"
#define PID				@"pid"
#define NAME			@"name"
#define DESCRIPTION		@"pdes"
#define REGULAR_PRICE	@"regular_price"
#define SALE_PRICE		@"sale_price"
#define COLORS			@"colors"
#define STORES			@"stores"

@interface ViewController ()

@property (nonatomic, strong) NSArray *jsonArray;
@property (nonatomic, strong) NSMutableArray *dataArray;
@property (nonatomic, assign) NSInteger alreadyAddCount;

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    _dataArray = [NSMutableArray arrayWithCapacity:3];

    NSString *database_path = [self getDBFilePath];
    [[NSFileManager defaultManager] removeItemAtPath:database_path error:nil];

    // get json data
	NSData *data = [NSData dataWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"ProductJson.json" ofType:nil]];
    id JsonObject=[NSJSONSerialization JSONObjectWithData:data
                                                  options:NSJSONReadingAllowFragments
                                                    error:nil];

	_jsonArray = (NSArray *)JsonObject;
    NSLog (@"%@, arr 1 is %@",JsonObject, _jsonArray);
	NSDictionary *dic1 = (NSDictionary *)[_jsonArray objectAtIndex:0];
	NSLog(@"name is %@", [dic1 objectForKey:@"name"]);
    // Dispose of any resources that can be recreated.
	NSArray *arrColors = (NSArray *)[dic1 objectForKey:@"colors"];
	NSString *strColors = [arrColors componentsJoinedByString:@","];

    [_createProductButton setTitle:[NSString stringWithFormat:@"Create Product %d/%d", _alreadyAddCount, _jsonArray.count] forState:UIControlStateNormal];

	[self openDB];
	NSString *sqlCreateTable = @"CREATE TABLE IF NOT EXISTS PRODUCTINFO (ID INTEGER PRIMARY KEY AUTOINCREMENT, pid TEXT, name TEXT, pdes TEXT, regular_price REAL, sale_price REAL, colors TEXT, stores TEXT)";

    [self execSql:sqlCreateTable];

}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self selectData];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

- (NSString *)getDBFilePath
{
	//获取数据库路径
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documents = [paths objectAtIndex:0];
    NSString *database_path = [documents stringByAppendingPathComponent:DBNAME];
    NSLog(@"database_path is %@", database_path);
    return database_path;
}

-(BOOL) openDB
{
    NSString *database_path = [self getDBFilePath];


    if (sqlite3_open([database_path UTF8String], &db) == SQLITE_OK) {
        return YES;
    }else{
        return NO;
        NSLog(@"database open failed");
        sqlite3_close(db);
    }
}

- (void)execSql:(NSString *)sql
{
    if ([self openDB]) {
        char *err;
        if (sqlite3_exec(db, [sql UTF8String], NULL, NULL, &err) != SQLITE_OK) {
            NSLog(@"database operation failed!");
			printf("err is %s\n", err);
        }else{
            NSLog(@"%@",sql);
        }
        sqlite3_close(db);
    }
}

-(void) insertData{
    if (_alreadyAddCount >= _jsonArray.count) {
        NSLog(@"all of the product alreay added");
        return;
    }
	NSDictionary *dic1 = (NSDictionary *)[_jsonArray objectAtIndex:_alreadyAddCount];
	NSLog(@"name is %@", [dic1 objectForKey:@"name"]);
    // Dispose of any resources that can be recreated.
	NSArray *arrColors = (NSArray *)[dic1 objectForKey:@"colors"];
	NSString *strColors = [arrColors componentsJoinedByString:@","];

	NSArray *arrStores = (NSArray *)[dic1 objectForKey:@"stores"];
	NSString *strStores = [arrStores componentsJoinedByString:@","];

    NSString *insertSql1= [NSString stringWithFormat:
						   @"INSERT INTO '%@' ('%@', '%@', '%@', '%@', '%@', '%@', '%@') VALUES ('%@', '%@', '%@', '%@', '%@', '%@', '%@')",
						   TABLENAME, PID, NAME, DESCRIPTION, REGULAR_PRICE, SALE_PRICE, COLORS, STORES, [dic1 objectForKey:@"id"], [dic1 objectForKey:@"name"], [dic1 objectForKey:@"description"], [dic1 objectForKey:@"regular price"], [dic1 objectForKey:@"id"], strColors, strStores];
    [self execSql:insertSql1];
    _alreadyAddCount += 1;
    [self selectData];

}
//
-(void) updateData{
    NSString *updateSql = [NSString stringWithFormat:
						   @"UPDATE '%@' SET '%@' = '%@' WHERE '%@' = '%@'",
						   TABLENAME,   NAME,  @"product1" ,NAME,  @"product11"];
    [self execSql:updateSql];
}

-(void) deleteData:(NSString *)pid{
    NSString *sdeleteSql = [NSString stringWithFormat:
							@"delete from %@ where %@ = '%@'",
							TABLENAME, PID, pid];
    [self execSql:sdeleteSql];
    [self selectData];
}

-(void) selectData{
    [self openDB];
    NSString *sqlQuery = [NSString stringWithFormat:
						  @"SELECT * FROM %@",TABLENAME];
    sqlite3_stmt * statement;

    if (sqlite3_prepare_v2(db, [sqlQuery UTF8String], -1, &statement, nil) == SQLITE_OK) {



        while (sqlite3_step(statement) == SQLITE_ROW) {
            char *pid = (char*)sqlite3_column_text(statement, 1);
            NSString *nspid = [[NSString alloc]initWithUTF8String:pid];

//            int age = sqlite3_column_int(statement, 2);
			char *name = (char*)sqlite3_column_text(statement, 2);
            NSString *nsname = [[NSString alloc]initWithUTF8String:name];

            char *des = (char*)sqlite3_column_text(statement, 3);
            NSString *nsDes = [[NSString alloc]initWithUTF8String:des];

//			char *regular_price = (char*)sqlite3_column_text(statement, 4);
//            NSString *nsAddressStr = [[NSString alloc]initWithUTF8String:address];

			float regular_price = sqlite3_column_double(statement, 4);
			float sale_price = sqlite3_column_double(statement, 5);
			char *colors = (char*)sqlite3_column_text(statement, 6);
            NSString *nscolors = [[NSString alloc]initWithUTF8String:colors];
			char *stores = (char*)sqlite3_column_text(statement, 7);
            NSString *nsstores = [[NSString alloc]initWithUTF8String:stores];

            NSDictionary *dataDic = [NSDictionary dictionaryWithObjectsAndKeys:nspid , @"id", nsname, @"name", nsDes, @"description", [NSString stringWithFormat:@"%f", regular_price], @"regular price", [NSString stringWithFormat:@"%f", regular_price], @"sale price", nscolors, @"colors", nsstores, @"stores", nil];
            [_dataArray addObject:dataDic];

			NSArray *arrColors = [nscolors componentsSeparatedByString:@","];
			NSArray *arrStores = [nsstores componentsSeparatedByString:@","];
            NSLog(@"1:%@  2:%@  3:%@ 4:%f 5:%f 6:%@ 7:%@", nspid, nsname, nsDes, regular_price, sale_price, nscolors, nsstores);
        }
    }else{
        NSLog(@"select error:%@",sqlQuery);

    }
    sqlite3_close(db);
}

- (IBAction)onAddProductButtonClicked:(id)sender {
    [self insertData];
    UIButton *btn = (UIButton *)sender;
    [btn setTitle:[NSString stringWithFormat:@"Create Product %d/%d", _alreadyAddCount, _jsonArray.count] forState:UIControlStateNormal];
    [_productTableView reloadData];
}

- (IBAction)onShowProductsButtonClicked:(id)sender {
//    DetailViewController *dvc = [[DetailViewController alloc] initWithNibName:@"DetailViewController" bundle:nil];
//    [self presentViewController:dvc animated:YES completion:^{
//        // do some thing
//    }];
}


#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _alreadyAddCount;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"productCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    NSDictionary *dic = [_dataArray objectAtIndex:indexPath.row];
    cell.textLabel.text = [dic objectForKey:@"name"];
    cell.detailTextLabel.text = [dic objectForKey:@"description"];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    DetailViewController *dvc = [[DetailViewController alloc] initWithNibName:@"DetailViewController" bundle:nil];
    dvc.jsonDic = [_jsonArray objectAtIndex:indexPath.row];
    dvc.deleteProduct = ^{
        NSLog(@"deleteProduct is aaaa");
        [self deleteData:[[_jsonArray objectAtIndex:indexPath.row] objectForKey:@"id"]];
    };
    [self presentViewController:dvc animated:YES completion:^{
        // do some thing
    }];

}
@end
