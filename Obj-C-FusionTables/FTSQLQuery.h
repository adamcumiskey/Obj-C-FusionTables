/* Copyright (c) 2013 Arseniy Kuznetsov
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 *     http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */

//  FTSQLQuery.h
//  Obj-C-FusionTables

/****
    Enables read-write access to Fusion Table rows.
****/

#import "FTTable.h"
#import "GoogleAuthorizationController.h"

@interface FTSQLQuery : NSObject

#pragma mark - Fusion Tables SQL API
#pragma mark SQL API for accessing FT data rows
- (void)queryFusionTablesSQL:(NSString *)sql WithCompletionHandler:(ServiceAPIHandler)handler;

#pragma mark SQL API for modifying FT data rows
- (void)modifyFusionTablesSQL:(NSString *)sql WithCompletionHandler:(ServiceAPIHandler)handler;


#pragma mark - Query Statements Helpers
- (NSString *)builDescribeStringForFusionTableID:(NSString *)fusionTableID;

- (NSString *)builSQLInsertStringForColumnNames:(NSArray *)columnNames FTTableID:(NSString *)fusionTableID, ...;

- (NSString *)builSQLUpdateStringForRowID:(NSUInteger)rowID ColumnNames:(NSArray *)columnNames FTTableID:(NSString *)fusionTableID, ...;

- (NSString *)buildDeleteAllRowStringForFusionTableID:(NSString *)fusionTableID;
- (NSString *)buildDeleteRowStringForFusionTableID:(NSString *)fusionTableID RowID:(NSUInteger)rowID;

- (NSString *)buildFTStringValueString:(NSString *)sourceString;

- (NSString *)buildKMLLineString:(NSString *)coordinatesString;
- (NSString *)buildKMLPointString:(NSString *)coordinatesString;
- (NSString *)buildKMLPolygonString:(NSString *)coordinatesString;




@end
