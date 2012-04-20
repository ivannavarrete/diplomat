//
//  BluetoothDevice.h
//  Diplomat
//
//  Created by Developer on 4/20/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <IOBluetooth/IOBluetooth.h>
#import <IOBluetooth/IOBluetoothUserLib.h>
#import <IOBluetooth/objc/IOBluetoothDeviceInquiry.h>

@interface Bluetooth : NSObject {
  IOBluetoothDeviceInquiry *deviceInquiry;
}

- (void)displayHostControllerInfo;
- (void)displayPairedDevices;
- (void)displayPairedKeyboards;
- (void)detectBluetoothDevices;

@end
