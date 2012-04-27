//
//  AppDelegate.h
//  Diplomat
//
//  Created by Developer on 2/17/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import <Carbon/Carbon.h>
#import "Bluetooth.h"
#import "Event.h"

@interface AppDelegate : NSObject <NSApplicationDelegate> {
  CFArrayRef sourceList;
  TISInputSourceRef originalKeyboardLayout;
  Bluetooth *bluetooth;
  Event *event;
}

@property (assign) IBOutlet NSWindow *window;

@end
