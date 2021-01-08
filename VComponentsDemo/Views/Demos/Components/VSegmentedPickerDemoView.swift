//
//  VSegmentedPickerDemoView.swift
//  VComponentsDemo
//
//  Created by Vakhtang Kontridze on 1/8/21.
//

import SwiftUI
import VComponents

// MARK:- V Segmented Picker Demo View
struct VSegmentedPickerDemoView: View {
    // MARK: Properties
    static let navigationBarTitle: String = "Segmented Picker"

    @State private var segmentedPickerSelection1: TitleOptions = .red
    @State private var segmentedPickerSelection2: ContentOptions = .red
    @State private var segmentedPickerSelection3: Int = 0
    @State private var segmentedPickerSelection4: TitleOptions = .red
    @State private var segmentedPickerSelection5: TitleOptions = .red
    @State private var segmentedPickerSelection6: TitleOptions = .red
    @State private var segmentedPickerSelection7: TitleOptions = .red
    @State private var segmentedPickerSelection8: TitleOptions = .red
    @State private var segmentedPickerState: VSegmentedPickerState = .enabled
    
    private enum ContentOptions: Int, CaseIterable, VPickerEnumerableOption {
        case red
        case green
        case blue
        
        var pickerSymbol: some View {
            let color: Color = {
                switch self {
                case .red: return .red
                case .green: return .green
                case .blue: return .blue
                }
            }()
            
            return VDemoIconContentView(dimension: 15, color: color)
        }
    }
    
    private enum TitleOptions: Int, CaseIterable, VPickerTitledEnumerableOption {
        case red
        case green
        case blue
        
        var pickerTitle: String {
            switch self {
            case .red: return "Red"
            case .green: return "Green"
            case .blue: return "Blue"
            }
        }
    }
    
    private let noAnimationSegmentedModel: VSegmentedPickerModel = {
        var model: VSegmentedPickerModel = .init()
        model.behavior.selectionAnimation = nil
        return model
    }()
    
    private let noLoweredOpacityWhenPressedModel: VSegmentedPickerModel = {
        var model: VSegmentedPickerModel = .init()
        model.colors.pressedOpacity = 1
        return model
    }()
    
    private let noSmallerIndcatorWhenPressedModel: VSegmentedPickerModel = {
        var model: VSegmentedPickerModel = .init()
        model.layout.indicatorPressedScale = 1
        return model
    }()
    
    private let noLoweredOpacityWhenDisabledModel: VSegmentedPickerModel = {
        var model: VSegmentedPickerModel = .init()
        model.colors.disabledOpacity = 1
        return model
    }()
}

// MARK:- Body
extension VSegmentedPickerDemoView {
    var body: some View {
        BaseDemoView(title: Self.navigationBarTitle, controller: { controller }, content: {
            DemoRowView(type: .titled("Text"), content: {
                VSegmentedPicker(
                    selection: $segmentedPickerSelection1,
                    state: segmentedPickerState
                )
            })
            
            DemoRowView(type: .titled("Image"), content: {
                VSegmentedPicker(
                    selection: $segmentedPickerSelection2,
                    state: segmentedPickerState
                )
            })

            DemoRowView(type: .titled("Image and Text"), content: {
                VSegmentedPicker(
                    selectedIndex: $segmentedPickerSelection3,
                    state: segmentedPickerState,
                    views: ContentOptions.allCases.indices.map { i in
                        HStack(spacing: 5, content: {
                            ContentOptions.allCases[i].pickerSymbol
                            Text(TitleOptions.allCases[i].pickerTitle)
                        })
                    }
                )
            })
            
            DemoRowView(type: .titled("Disabled Row"), content: {
                VSegmentedPicker(
                    selection: $segmentedPickerSelection4,
                    state: segmentedPickerState,
                    disabledIndexes: [1]
                )
            })
            
            DemoRowView(type: .titled("No Animation"), content: {
                VSegmentedPicker(
                    model: noAnimationSegmentedModel,
                    selection: $segmentedPickerSelection5,
                    state: segmentedPickerState
                )
            })
            
            DemoRowView(type: .titled("No Lowered Opacity when Pressed"), content: {
                VSegmentedPicker(
                    model: noLoweredOpacityWhenPressedModel,
                    selection: $segmentedPickerSelection6,
                    state: segmentedPickerState
                )
            })
            
            DemoRowView(type: .titled("No Smaller Indicator when Pressed"), content: {
                VSegmentedPicker(
                    model: noSmallerIndcatorWhenPressedModel,
                    selection: $segmentedPickerSelection7,
                    state: segmentedPickerState
                )
            })
            
            DemoRowView(type: .titled("No Lowered Opacity when Disabled"), content: {
                VSegmentedPicker(
                    model: noLoweredOpacityWhenDisabledModel,
                    selection: $segmentedPickerSelection8,
                    state: segmentedPickerState,
                    disabledIndexes: [1]
                )
            })
        })
    }
    
    private var controller: some View {
        DemoRowView(type: .controller, content: {
            ToggleSettingView(
                isOn: .init(
                    get: { segmentedPickerState == .disabled },
                    set: { segmentedPickerState = $0 ? .disabled : .enabled }
                ),
                title: "Disabled"
            )
        })
    }
}

// MARK:- Preview
struct VSegmentedPickerDemoView_Previews: PreviewProvider {
    static var previews: some View {
        VSegmentedPickerDemoView()
    }
}

struct VDemoIconContentView: View {
    private let dimension: CGFloat
    private let color: Color
    
    init(dimension: CGFloat = 20, color: Color = ColorBook.accent) {
        self.dimension = dimension
        self.color = color
    }
    
    var body: some View {
        Image(systemName: "swift")
            .resizable()
            .frame(dimension: dimension)
            .foregroundColor(color)
    }
}