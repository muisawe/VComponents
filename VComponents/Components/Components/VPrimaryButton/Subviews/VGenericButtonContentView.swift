//
//  VGenericButtonContentView.swift
//  VComponents
//
//  Created by Vakhtang Kontridze on 12/21/20.
//

import SwiftUI

// MARK:- V Primary Button Content View
struct VGenericButtonContentView<Content>: View where Content: View {
    // MARK: Properties
    private let foregroundColor: Color
    private let foregroundOpacity: Double
    private let font: Font
    
    private let content: () -> Content
    
    // MARK: Initializers
    init(
        foregroundColor: Color,
        foregroundOpacity: Double,
        font: Font,
        @ViewBuilder content: @escaping () -> Content
    ) {
        self.foregroundColor = foregroundColor
        self.foregroundOpacity = foregroundOpacity
        self.font = font
        self.content = content
    }
}

// MARK:- Body
extension VGenericButtonContentView {
    @ViewBuilder var body: some View {
        content()
            // Text
            .lineLimit(1)
            .multilineTextAlignment(.center)
            .truncationMode(.tail)
            .foregroundColor(foregroundColor)
            .font(font)
        
            // Text + Image
            .opacity(foregroundOpacity)
    }
}

// MARK:- Preview
struct VPrimaryButtonContentView_Previews: PreviewProvider {
    static var previews: some View {
        VGenericButtonContentView(
            foregroundColor: VPrimaryButtonModelFilled.Colors().foreground.enabled,
            foregroundOpacity: VPrimaryButtonModelFilled.Colors().foreground.pressedOpacity,
            font: VPrimaryButtonModelFilled.Fonts().title,
            content: { Text("Press") }
        )
    }
}
