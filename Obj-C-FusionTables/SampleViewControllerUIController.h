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

//  SampleViewControllerUIController.h
//  Obj-C-FusionTables

#import "GroupedTableUIController.h"

/****
    A specific SampleViewController dispatcher class.
    
    SampleViewController is using GroupedUITableViews (https://github.com/akpw/GroupedUITableViews),
    to isolate sample logic of Fusion Table ops in small dedicated UITableView sections controller classes.
****/

@interface SampleViewControllerUIController : GroupedTableUIController

@end
