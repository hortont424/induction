//
//  WireView.h
//  Induction
//
//  Created by Timothy Horton on 2009.05.11.
//  Copyright 2009 Rensselaer Polytechnic Institute. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import "Wire.h"

@class GateView;

@interface WireView : NSView
{
	NSMutableArray * wires;
	Wire * activeWire;
	
	NSPoint magnetLocation;
}

- (void)addWireFrom:(GateView *)begin to:(GateView *)end at:(int)endIndex;

- (void)addWire:(Wire *)w;
- (void)removeWire:(Wire *)w;

@property (nonatomic,retain) Wire * activeWire;
@property (nonatomic,assign) NSPoint magnetLocation;

@end
