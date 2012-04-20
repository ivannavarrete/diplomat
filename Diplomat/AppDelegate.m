//
//  AppDelegate.m
//  Diplomat
//
//  Created by Developer on 2/17/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "AppDelegate.h"


@interface AppDelegate ()
- (void)saveKeyboardLayout;
- (void)setKeyboardLayout;
- (void)restoreKeyboardLayout;
@end


@implementation AppDelegate

@synthesize window = _window;


#pragma mark Application Lifecycle

- (void)applicationDidFinishLaunching:(NSNotification *)aNotification {
  [self saveKeyboardLayout];
  [self setKeyboardLayout];

  bluetooth = [[Bluetooth alloc] init];
  [bluetooth displayHostControllerInfo];
  [bluetooth displayPairedKeyboards];
}


- (BOOL)applicationShouldTerminateAfterLastWindowClosed:(NSApplication *)application {
  return YES;
}


- (void)applicationWillTerminate:(NSNotification *)aNotification {
  [self restoreKeyboardLayout];
}


#pragma mark Memory Management

- (void)dealloc {
  CFRelease(sourceList);
  [bluetooth dealloc];

  [super dealloc];
}


#pragma mark Private Methods

- (void)saveKeyboardLayout {
  NSDictionary *properties = [NSDictionary dictionaryWithObject:(NSString *)kTISTypeKeyboardLayout
                                                         forKey:(NSString *)kTISPropertyInputSourceType];
  sourceList = TISCreateInputSourceList((CFDictionaryRef)properties, false);
  originalKeyboardLayout = (TISInputSourceRef)CFArrayGetValueAtIndex(sourceList, 1);

  NSLog(@"Num languages: %lu", [(NSArray *)sourceList count]);
  NSLog(@"%@", sourceList);

  for (id inputSource in (NSArray *)sourceList) {
    NSLog(@"%@", inputSource);
  }

  //TISInputSourceRef newLanguage = (TISInputSourceRef)CFArrayGetValueAtIndex(sourceLi
  //TISGetInputSourceProperty(
}


- (void)setKeyboardLayout {
  TISInputSourceRef newLanguage = (TISInputSourceRef)CFArrayGetValueAtIndex(sourceList, 0);
  TISSelectInputSource(newLanguage);
}


- (void)restoreKeyboardLayout {
  TISSelectInputSource(originalKeyboardLayout);
}

@end
