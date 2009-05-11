//
//  MyDocument.h
//  Induction
//
//  Created by Timothy Horton on 2009.05.11.
//  Copyright Rensselaer Polytechnic Institute 2009 . All rights reserved.
//


#import <Cocoa/Cocoa.h>
#import "WireView.h"

@interface MyDocument : NSDocument
{
	IBOutlet WireView * wires;
	NSWindow * myWindow;
}

- (IBAction)addSomeRandomGates:(id)sender;

@property (nonatomic,retain) IBOutlet WireView * wires;

@end
