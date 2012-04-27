//
//  Event.m
//  Diplomat
//
//  Created by Developer on 4/24/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "Event.h"

@implementation Event

- (void)handleEvent:(NSAppleEventDescriptor *)event withReplyEvent:(NSAppleEventDescriptor *)replyEvent {
  NSLog(@"===[ event handler ]====================");
  NSLog(@"event: %@", event);
  NSLog(@"reply event: %@", replyEvent);
}


- (void)setup {
  eventManager = [NSAppleEventManager sharedAppleEventManager];

  /*
  [eventManager setEventHandler:self
                    andSelector:@selector(handleEvent:withReplyEvent:)
                  forEventClass:kCoreEventClass
                     andEventID:kAEQuitApplication];
  */
  [eventManager setEventHandler:self
                    andSelector:@selector(handleEvent:withReplyEvent:)
                  forEventClass:kEventClassKeyboard
                     andEventID:kEventRawKeyDown];
}

@end
