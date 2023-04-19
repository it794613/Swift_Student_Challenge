//
//  File.swift
//  
//
//  Created by 최진용 on 2023/04/17.
//

import SwiftUI

extension AttributedString {
    init(text: String, highlight: String) {
        self.init(text: text, highlight: [highlight])
    }
    
    init(text: String, highlight: [String]) {
        var attrString: AttributedString = AttributedString(text)
        for highlighted in highlight {
            if let range = attrString.range(of: highlighted) {
                attrString[range].foregroundColor = .accentColor
            }
        }
        self = attrString
    }
}
