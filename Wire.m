//
//  Wire.m
//  Induction
//
//  Created by Timothy Horton on 2009.05.11.
//  Copyright 2009 Rensselaer Polytechnic Institute. All rights reserved.
//

#import "Wire.h"

@implementation Wire

@synthesize begin, end, endIndex, endPoint;

- (id) init
{
	self = [super init];
	if (self != nil)
	{
		begin = end = nil;
	}
	return self;
}


@end
