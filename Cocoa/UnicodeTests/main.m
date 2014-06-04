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

BOOL compareGraphemeClusters(NSString *str1, NSRange cluster1, NSString *str2, NSRange cluster2) {
    return [[str1 substringWithRange:cluster1] isEqualToString:[str2 substringWithRange:cluster2]];
}

BOOL compareFirstGraphemeCluster(NSString *str1, NSString *str2){
    NSRange cluster1;
    NSRange cluster2;
    
    cluster1 = [str1 rangeOfComposedCharacterSequenceAtIndex:0];
    cluster2 = [str2 rangeOfComposedCharacterSequenceAtIndex:0];
    
    if (!compareGraphemeClusters(str1, cluster1, str2, cluster2)) {
        return FALSE;
    }
    return TRUE;
}


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
                                                                    0,                                                            [@"wei\u00DF" length])]);
        
        test(@"Unicode 17", [[@"e\u0303\u033D\u032A" decomposedStringWithCanonicalMapping] isEqualToString:[@"e\u032A\u0303\u033d" decomposedStringWithCanonicalMapping]]);
        
        test(@"Unicode 18", [@"XII" isEqualToString:[@"\u216B"
                                                     decomposedStringWithCompatibilityMapping]]);
        
        test(@"Unicode 19", ![@"XII" isEqualToString:[@"\u216B"
                                                     decomposedStringWithCanonicalMapping]]);
        
        test(@"Unicode 20",
             [@"\u1E14" isEqualToString:[@"\u1E14" precomposedStringWithCanonicalMapping]]);
       
        test(@"Unicode 21",
             [@"E\u0304\u0300" isEqualToString:[@"\u1E14"decomposedStringWithCanonicalMapping]]);
        
        test(@"Unicode 22",
             [@"\u1E14"isEqualToString:[@"\u0112\u0300" precomposedStringWithCanonicalMapping]]);
        
        test(@"Unicode 23",
             [@"E\u0304\u0300" isEqualToString:
              [@"\u0112\u0300" decomposedStringWithCanonicalMapping]]);
     
        test(@"Unicode 24",
             [@"\u00C8\u0304"isEqualToString:
                [@"\u00C8\u0304" precomposedStringWithCanonicalMapping]]);
        
        test(@"Unicode 25", !compareFirstGraphemeCluster(@"e\u0303\u033D\u032A",
                                                        @"e\u033d\u032A\u0303"));

        printf("Number of Tests: %d\n", passed + failed);
        printf("Number Passed:   %d\n", passed);
        printf("Number Failed:   %d\n", failed);
       
        
    }
    return 0;
}


