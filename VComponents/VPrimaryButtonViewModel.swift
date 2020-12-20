//
//  VPrimaryButtonViewModel.swift
//  VComponents
//
//  Created by Vakhtang Kontridze on 19.12.20.
//

import SwiftUI

// MARK:- V Primary Button ViewModel
public struct VPrimaryButtonViewModel {
    // MARK: Properties
    public let layout: Layout
    public let colors: Colors
    public let fonts: Fonts
    
    // MARK: Initializers
    public init(layout: Layout, colors: Colors, fonts: Fonts) {
        self.layout = layout
        self.colors = colors
        self.fonts = fonts
    }
    
    public init() {
        self.init(
            layout: .init(),
            colors: .init(),
            fonts: .init()
        )
    }
}

// MARK:- Layout
extension VPrimaryButtonViewModel {
    public struct Layout {
        // MARK: Properties
        public let common: Common
        public let fixed: Fixed
        
        // MARK: Initializers
        public init(common: Common, fixed: Fixed) {
            self.common = common
            self.fixed = fixed
        }
        
        public init() {
            self.init(
                common: .init(),
                fixed: .init()
            )
        }
    }
    
    public struct Common {
        // MARK: Properties
        public let height: CGFloat
        public let cornerRadius: CGFloat
        public let contentInset: CGFloat
        
        // MARK: Initializers
        public init(height: CGFloat, cornerRadius: CGFloat, contentInset: CGFloat) {
            self.height = height
            self.cornerRadius = cornerRadius
            self.contentInset = contentInset
        }
        
        public init() {
            self.init(
                height: 50,
                cornerRadius: 20,
                contentInset: 15
            )
        }
    }
    
    public struct Fixed {
        // MARK: Properties
        public let width: CGFloat
        
        // MARK: Initializers
        public init(width: CGFloat) {
            self.width = width
        }
        
        public init() {
            self.init(
                width: 300
            )
        }
    }
}

// MARK:- Colors
extension VPrimaryButtonViewModel {
    public struct Colors {
        // MARK: Properties
        public let foreground: StateColors
        public let background: StateColors
        
        // MARK: Initializers
        public init(foreground: StateColors, background: StateColors) {
            self.foreground = foreground
            self.background = background
        }
        
        public init() {
            self.init(
                foreground: .init(
                    enabled: ColorBook.PrimaryButton.Text.enabled,
                    pressed: ColorBook.PrimaryButton.Text.pressed,
                    disabled: ColorBook.PrimaryButton.Text.disabled,
                    loading: ColorBook.PrimaryButton.Text.loading
                ),
                background: .init(
                    enabled: ColorBook.PrimaryButton.Fill.enabled,
                    pressed: ColorBook.PrimaryButton.Fill.pressed,
                    disabled: ColorBook.PrimaryButton.Fill.disabled,
                    loading: ColorBook.PrimaryButton.Fill.loading
                )
            )
        }
    }
}

extension VPrimaryButtonViewModel.Colors {
    public struct StateColors {
        // MARK: Properties
        public let enabled: Color
        public let pressed: Color
        public let disabled: Color
        public let loading: Color
        
        // MARK: Initializers
        public init(enabled: Color, pressed: Color, disabled: Color, loading: Color) {
            self.enabled = enabled
            self.pressed = pressed
            self.disabled = disabled
            self.loading = loading
        }
    }
}

// MARK:- Fonts
extension VPrimaryButtonViewModel {
    public struct Fonts {
        // MARK: Properties
        public let title: Font
        
        // MARK: Initializers
        public init(title: Font) {
            self.title = title
        }
        
        public init() {
            self.init(
                title: FontBook.buttonLarge
            )
        }
    }
}

// MARK:- Mapping
extension VPrimaryButtonViewModel.Colors {
    static func foreground(state: VPrimaryButtonActualState, vm: VPrimaryButtonViewModel) -> Color {
        switch state {
        case .enabled: return vm.colors.foreground.enabled
        case .pressed: return vm.colors.foreground.pressed
        case .disabled: return vm.colors.foreground.disabled
        case .loading: return vm.colors.foreground.loading
        }
    }

    static func background(state: VPrimaryButtonActualState, vm: VPrimaryButtonViewModel) -> Color {
        switch state {
        case .enabled: return vm.colors.background.enabled
        case .pressed: return vm.colors.background.pressed
        case .disabled: return vm.colors.background.disabled
        case .loading: return vm.colors.background.loading
        }
    }
}