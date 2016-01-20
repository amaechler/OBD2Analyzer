/*
 *  NSStreamAdditions.h
 *  OBD2Kit
 *
 *  Copyright (c) 2009-2011 FuzzyLuke Inc.
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 * 
 * http://www.apache.org/licenses/LICENSE-2.0
 * 
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 *
 */

#import <Foundation/NSStream.h>

/* 
 We are adding this as an addition to the NSStream class
 because Apple removed it from the iPhone SDK for some reason.
 */
@interface NSStream (NSStreamAdditions)

+ (void)getIOStreamsToHostNamed:(NSString *)hostName port:(NSInteger)port inputStream:(NSInputStream * __strong *)inputStream outputStream:(NSOutputStream * __strong *)outputStream;

@end