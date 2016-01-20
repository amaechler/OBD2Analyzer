/*
 *  FLWifiScanTool.h
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

#import <Foundation/Foundation.h>
#import "FLScanTool.h"

@interface FLWifiScanTool : FLScanTool <NSStreamDelegate> {
	NSInputStream*			_inputStream;
	NSOutputStream*			_outputStream;
	NSMutableData*			_cachedWriteData;
	BOOL					_spaceAvailable;
    
    @protected
    NSString *_host;
    uint _port;
}

@property (nonatomic, readonly) NSString* host;
@property (nonatomic, readonly) uint port;

/**
 Returns scan tool instance
 
 @param host Ip address for connecting to a diagnostic device
 @param port Port for connecting to a diagnostic device
 
 @return WiFi scan tool instance
 */
+ (instancetype)scanToolWithHost:(NSString*)host andPort:(uint)port;

@end
