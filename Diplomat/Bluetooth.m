//
//  BluetoothDevice.m
//  Diplomat
//
//  Created by Developer on 4/20/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "Bluetooth.h"


@interface Bluetooth ()
- (void)displayDeviceInfo:(IOBluetoothDevice *)device;
@end


@implementation Bluetooth

- (void)displayHostControllerInfo {
  IOBluetoothHostController *bluetoothHostController = [IOBluetoothHostController defaultController];

  NSLog(@"===[ host controller info ]============");
  NSLog(@"name: %@\n", [bluetoothHostController nameAsString]);
  NSLog(@"address: %@\n", [bluetoothHostController addressAsString]);
  NSLog(@"\n");
}


- (void)displayPairedDevices {
  NSLog(@"===[ paired devices ]==================");
  for (IOBluetoothDevice *device in [IOBluetoothDevice pairedDevices]) {
    [self displayDeviceInfo:device];
  }
}


- (void)displayPairedKeyboards {
  NSLog(@"===[ paired keyboards ]==================");
  for (IOBluetoothDevice *device in [IOBluetoothDevice pairedDevices]) {
    if ([device getDeviceClassMajor] == kBluetoothDeviceClassMajorPeripheral &&
        [device getDeviceClassMinor] == kBluetoothDeviceClassMinorPeripheral1Keyboard) {
      [self displayDeviceInfo:device];
    }
  }
}


- (void)detectBluetoothDevices {
  NSLog(@"===[ detected devices ]================");

  deviceInquiry = [[IOBluetoothDeviceInquiry alloc] initWithDelegate:self];
  [deviceInquiry clearFoundDevices];
  [deviceInquiry setInquiryLength:254];
  [deviceInquiry setUpdateNewDeviceNames:FALSE];
  //[deviceInquiry setSearchCriteria:kBluetoothServiceClassMajorAny
  //                majorDeviceClass:kBluetoothDeviceClassMajorPeripheral
  //                minorDeviceClass:kBluetoothDeviceClassMinorPeripheral1Keyboard];
  [deviceInquiry start];

  /*
  if (res != kIOReturnSuccess) {
    NSLog(@"search failed");
    return;
  }
  */

  //NSLog(@"%s", (res == kIOReturnSuccess ? "searching for bluetooth devices..." : "search failed"));
  //NSLog(@"searching for bluetooth devices...");
}


#pragma mark Memory Management

- (void)dealloc {
  [deviceInquiry dealloc];
  [super dealloc];
}


#pragma mark IOBluetoothDeviceInquiryDelegate

- (void)deviceInquiryStarted:(IOBluetoothDeviceInquiry *)sender {
  NSLog(@"searching...");
}


- (void)deviceInquiryComplete:(IOBluetoothDeviceInquiry *)sender error:(IOReturn)error aborted:(BOOL)aborted {
  /*
  if (error != kIOReturnSuccess) {
    NSLog(@"search failed");
    return;
  } else if (aborted) {
    NSLog(@"search aborted");
    return;
  } else {
    NSLog(@"search complete");
  }
  */

  NSLog(@"search complete");
  NSLog(@"%lu devices found", [[sender foundDevices] count]);
  NSLog(@"Search time: %d", [sender inquiryLength]);

  /*
  NSArray *devices = [sender foundDevices];
  for (IOBluetoothDevice *device in devices) {
    NSLog(@"Devices: %@", device);
  }
  */

  [deviceInquiry stop];
}


- (void)deviceInquiryDeviceFound:(IOBluetoothDeviceInquiry *)sender device:(IOBluetoothDevice *)device {
  [self displayDeviceInfo:device];
}


- (void) deviceInquiryUpdatingDeviceNamesStarted:(IOBluetoothDeviceInquiry*)sender devicesRemaining:(uint32_t)devicesRemaining {
  NSLog(@"updating device names (%d)...", devicesRemaining);
}


- (void) deviceInquiryDeviceNameUpdated:(IOBluetoothDeviceInquiry*)sender device:(IOBluetoothDevice*)device devicesRemaining:(uint32_t)devicesRemaining {
  NSLog(@"device name updated");
}


#pragma mark Private Methods

- (void)displayDeviceInfo:(IOBluetoothDevice *)device {
  NSLog(@"name: %@", device.name);
  NSLog(@"address: %@", [device getAddressString]);
  NSLog(@"\n");
}

@end
