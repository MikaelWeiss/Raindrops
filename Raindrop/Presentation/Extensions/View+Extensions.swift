//
//  View+Extensions.swift
//  Raindrop
//
//  Created by Mikael Weiss on 5/8/21.
//

import SwiftUI

extension View {
    /// Used when you want to have a conditional modifier
    @ViewBuilder
    func `if`<Content: View>(_ condition: Bool, content: (Self) -> Content) -> some View {
        if condition {
            content(self)
        } else {
            self
        }
    }
    
    /// Used when you want to use conditional setup with if-else
    @ViewBuilder
    func `if`<Content: View, ContentElse: View>(_ condition: Bool, content: (Self) -> Content, else: (Self) -> ContentElse) -> some View {
        if condition {
            content(self)
        } else {
            `else`(self)
        }
    }
}

/// A modifier that animates a font through various sizes.
private struct AnimatableSystemFontModifier: AnimatableModifier {
    var size: CGFloat
    var weight: Font.Weight
    var design: Font.Design
    
    var animatableData: CGFloat {
        get { size }
        set { size = newValue }
    }
    
    func body(content: Content) -> some View {
        content
            .font(.system(size: size, weight: weight, design: design))
    }
}

extension View {
    /// A modifier that animates a font through various sizes.
    func animatableSystemFont(size: CGFloat, weight: Font.Weight = .regular, design: Font.Design = .default) -> some View {
        modifier(AnimatableSystemFontModifier(size: size, weight: weight, design: design))
    }
}
