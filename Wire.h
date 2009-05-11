//
//  Wire.h
//  Induction
//
//  Created by Timothy Horton on 2009.05.11.
//  Copyright 2009 Rensselaer Polytechnic Institute. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import "GateView.h"

@interface Wire : NSObject
{
	GateView * begin;
	GateView * end;
	
	NSPoint endPoint;
	
	int endIndex;
}

@property (nonatomic,retain) GateView * begin;
@property (nonatomic,retain) GateView * end;
@property (nonatomic,assign) int endIndex;
@property (nonatomic,assign) NSPoint endPoint;

@end
