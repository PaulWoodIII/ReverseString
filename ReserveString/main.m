//
//  main.m
//  ReserveString
//
//  Created by Paul Wood on 9/11/16.
//  Copyright © 2016 Paul Wood. All rights reserved.
//

#import <Foundation/Foundation.h>

int main(int argc, const char * argv[]) {
    @autoreleasepool {

        //Niave First crack at this
        NSString *string = @"Reserve This!";
        NSMutableString *buildingString = [[NSMutableString alloc] init];
        for (NSUInteger i = string.length - 1; i > 0; i--){
            NSRange range = NSMakeRange(i, 1);
            [buildingString appendString: [string substringWithRange:range]];
        }
        //Oops We forgot the last letter
        NSRange range = NSMakeRange(0, 1);
        [buildingString appendString: [string substringWithRange:range]];
        NSLog(@"%@", buildingString);
        
        // Because I know how to enumerate with blocks backward
        string = @"Reverse This!";
        buildingString = [[NSMutableString alloc] init];
        [string enumerateSubstringsInRange:NSMakeRange(0,string.length) options:(NSStringEnumerationReverse | NSStringEnumerationByComposedCharacterSequences) usingBlock:^(NSString * _Nullable substring, NSRange substringRange, NSRange enclosingRange, BOOL * _Nonnull stop) {
            [buildingString appendString:substring];
        }];
        NSLog(@"%@", buildingString);
        
        //Using while, being performant with a better initializer
        string = @"Reverse This!";
        buildingString = [NSMutableString stringWithCapacity:string.length];
        NSInteger length = string.length;
        while (length--){
            [buildingString appendFormat:@"%C", [string characterAtIndex:length]];
        }
        NSLog(@"%@", buildingString);

        
    }
    return 0;
}
