//
//  VCircularButton.swift
//  VComponents
//
//  Created by Vakhtang Kontridze on 19.12.20.
//

import SwiftUI

// MARK:- V Circular Button
public struct VCircularButton<Content>: View where Content: View {
    // MARK: Properties
    private let viewModel: VCircularButtonViewModel
    
    private let state: VCircularButtonState
    
    private let action: () -> Void
    
    private let content: () -> Content

    // MARK: Initializers
    public init(
        viewModel: VCircularButtonViewModel = .init(),
        state: VCircularButtonState,
        action: @escaping () -> Void,
        @ViewBuilder content: @escaping () -> Content
    ) {
        self.viewModel = viewModel
        self.state = state
        self.action = action
        self.content = content
    }
}

// MARK:- Body
public extension VCircularButton {
    var body: some View {
        Button(action: action, label: content)
            .disabled(!state.isEnabled)
            .buttonStyle(VCircularButtonStyle(state: state, viewModel: viewModel))
    }
}

// MARK:- Preview
struct VCircularButton_Previews: PreviewProvider {
    static var previews: some View {
        VCircularButton(state: .enabled, action: {}, content: {
            Image(systemName: "swift")
                .resizable()
                .frame(size: .init(width: 20, height: 20))
                .foregroundColor(.white)
        })
    }
}