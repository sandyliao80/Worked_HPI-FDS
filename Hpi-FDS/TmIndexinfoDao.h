//
//  TmIndexinfoDao.h
//  Hpi-FDS
//
//  Created by Hoshino Wei on 12-4-1.
//  Copyright (c) 2012年 Landscape. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <sqlite3.h>
#import "TmIndexinfo.h"

@interface TmIndexinfoDao : NSObject{

}

+(NSString *) dataFilePath;
+(void) openDataBase;
+(void) initDb;
+(void)insert:(TmIndexinfo*) tmIndexinfo;
+(void)delete:(TmIndexinfo*) tmIndexinfo;
+(NSMutableArray *) getTmIndexinfo:(NSInteger)infoId;
+(NSMutableArray *) getTmIndexinfo;
+(NSMutableArray *) getTmIndexinfoBySql:(NSString *)sql;

@end
