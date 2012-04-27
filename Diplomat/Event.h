//
//  Event.h
//  Diplomat
//
//  Created by Developer on 4/24/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <Carbon/Carbon.h>

@interface Event : NSObject {
  NSAppleEventManager *eventManager;
}

- (void)setup;
- (void)handleEvent:(NSAppleEventDescriptor *)event withReplyEvent:(NSAppleEventDescriptor *)replyEvent;
@end
