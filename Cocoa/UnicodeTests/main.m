//
//  main.m
//  UnicodeTests
//
//  Created by Peter W A Wood on 14/05/2014.
//  Copyright (c) 2014 Peter W A Wood. All rights reserved.
//

#import <Foundation/Foundation.h>

int passed = 0;
int failed = 0;

int countGraphemeClusters(NSString *str) {
    int graphemeClusterCount = 0;
    for (int i=0; i < [str length]; ++graphemeClusterCount) {
        i += [str rangeOfComposedCharacterSequenceAtIndex:i].length;
    }
    return graphemeClusterCount;
}

void test(NSString *name, BOOL result) {
    if (result) {
        passed++;
    } else {
        failed++;
        printf("Test %s Failed\n", [name UTF8String]);
    }
}

int main(int argc, const char * argv[])
{

    @autoreleasepool {
        NSString *unicodeString;
        NSMutableString *reversed = [NSMutableString stringWithCapacity:10];
        NSMutableString *changed = [NSMutableString stringWithCapacity:25];
        NSMutableArray *graphemeClusters = [NSMutableArray arrayWithCapacity:10];
        NSRange aCluster;
        NSRange substrRange;
        int position;
        int elements;
        NSLocale *turkish = [[NSLocale alloc] initWithLocaleIdentifier:@"tr_TR"];
        NSLocale *german = [[NSLocale alloc] initWithLocaleIdentifier:@"de_DE"];
        
        test(@"Unicode  1", [@"c\u0327" isEqualToString:[@"\u00E7" decomposedStringWithCanonicalMapping]]);

        test(@"Unicode 2", ![@"c\u0327" isEqualToString:@"\u00E7"]);
        
        test(@"Unicode 3", countGraphemeClusters(@"noe\u0308l") == 4);
        
        unicodeString = @"noe\u0308l";
        position = 0;
        elements = -1;
        while (position < [unicodeString length]) {
            aCluster = [unicodeString rangeOfComposedCharacterSequenceAtIndex:position];
            position += aCluster.length;
            [graphemeClusters addObject:[NSValue valueWithRange:aCluster]];
            elements += 1;
        }
        for (int i = elements; i > -1; i--) {
            [reversed appendString:[unicodeString substringWithRange:[[graphemeClusters objectAtIndex:i] rangeValue]]];
        }
        test(@"Unicode 4", [reversed isEqualToString:@"le\u0308on"]);

        unicodeString = @"noe\u0308l";
        elements = 3;
        for (position = 0; (position < 3) && (position < [unicodeString length]); ++elements) {
            position += [unicodeString rangeOfComposedCharacterSequenceAtIndex:position].length;
        }
        substrRange.location = 0;
        substrRange.length = position;
        test(@"Unicode 5", [[unicodeString substringWithRange:substrRange]
                            isEqualToString:@"noe\u0308"]);
             
        test(@"Unicode 6", [[@"ba\uFB04e" uppercaseString] isEqualToString: @"BAFFLE"]);
        
        test(@"Unicode 7", [[@"cant\u00F9" uppercaseString] isEqualToString:@"CANT\u00D9"]);
        
        test(@"Unicode 8", [[@"cantu\u0300" uppercaseString] isEqualToString:@"CANTU\u0300"]);
        
        unicodeString = @"\U0001D11E - The Treble Clef";
        [changed setString:unicodeString];
        [changed replaceOccurrencesOfString:@"\U0001D11E"
                                 withString:@"\U0001D122"
                                    options: 0
                                      range: NSMakeRange(0, [unicodeString length])];
        [changed replaceOccurrencesOfString:@"Treble"
                                 withString:@"Bass"
                                    options:0
                                      range:NSMakeRange(0, [unicodeString length])];
        test(@"Unicode 9", [changed isEqualToString:@"\U0001D122 - The Bass Clef"]);
        
        test(@"Unicode 10", countGraphemeClusters(@"\U0001D122 - The Bass Clef") == 17);
        
        test(@"Unicode 11", [[@"i" uppercaseStringWithLocale:turkish] isEqualToString:@"\u0130"]);
                
        test(@"Unicode 12", [[@"I" lowercaseStringWithLocale:turkish] isEqualToString:@"\u0131"]);
        
        test(@"Unicode 13", [[@"stra\u00DFe" uppercaseString] isEqualToString:@"STRASSE"]);
        
        test(@"Unicode 14", countGraphemeClusters(@"\u03C8\u3099") == 1);
        
        test(@"Unicode 15", countGraphemeClusters(@"e\u0308\U0001D11E\u03C8\u3099") == 3);
        
        test(@"Unicode 16", NSOrderedSame == [@"wei\u00DF" compare:@"weiss"
                                                            options:NSCaseInsensitiveSearch
                                                              range:NSMakeRange(
                                                                    0,                                                            [@"wei\u00DF" length])
                                                            locale:german]);
       
        printf("Number of Tests: %d\n", passed + failed);
        printf("Number Passed:   %d\n", passed);
        printf("Number Failed:   %d\n", failed);
       
        
    }
    return 0;
}


