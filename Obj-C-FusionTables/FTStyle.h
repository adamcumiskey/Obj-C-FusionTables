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

//  FTStyle.h
//  Obj-C-FusionTables

/****
    Represents a Fusion Table Style. 
    Suports common table operations, such as insert / list / update delete
****/


#import "FTAPIResource.h"

@protocol FTStyleDelegate <NSObject>
@optional
- (NSString *)ftTableID;
- (NSString *)ftStyleID;
- (NSString *)ftStyleName;
- (BOOL)isDefaulForTable;
- (NSDictionary *)ftMarkerOptions;
- (NSDictionary *)ftPolylineOptions;
@end

@interface FTStyle : FTAPIResource

@property (nonatomic, weak) id <FTStyleDelegate> ftStyleDelegate;

#pragma mark - Fusion Table Styles Lifecycle Methods
- (void)lisFTStylesWithCompletionHandler:(ServiceAPIHandler)handler;
- (void)insertFTStyleWithCompletionHandler:(ServiceAPIHandler)handler;
- (void)updateFTStyleWithCompletionHandler:(ServiceAPIHandler)handler;
- (void)deleteFTStyleWithCompletionHandler:(ServiceAPIHandler)handler;

@end
