//
//  String+Extensions.swift
//  Raindrop
//
//  Created by Mikael Weiss on 5/8/21.
//

import SwiftUI

extension String {
    func widthOfString(usingFont font: UIFont) -> CGFloat {
        let fontAttributes = [NSAttributedString.Key.font: font]
        let size = self.size(withAttributes: fontAttributes)
        return size.width
    }
}

extension String: View {
    public var body: some View {
        Text(self)
    }
}
