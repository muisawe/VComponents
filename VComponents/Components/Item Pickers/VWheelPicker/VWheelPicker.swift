//
//  VWheelPicker.swift
//  VComponents
//
//  Created by Vakhtang Kontridze on 1/19/21.
//

import SwiftUI

// MARK:- V Wheel Picker
/// Item picker component that selects from a set of mutually exclusive values, and displays their representative content in a scrollable wheel
///
/// Component ca be initialized with data, VPickableItem, or VPickableTitledItem
///
/// Model, state, title, and description can be passed as parameters
///
/// # Usage Example #
///
/// ```
/// enum PickerRow: Int, VPickableTitledItem {
///     case red, green, blue
///
///     var pickerTitle: String {
///         switch self {
///         case .red: return "Red"
///         case .green: return "Green"
///         case .blue: return "Blue"
///         }
///     }
/// }
///
/// @State var selection: PickerRow = .red
///
/// var body: some View {
///     VWheelPicker(
///         selection: $selection,
///         title: "Lorem ipsum dolor sit amet",
///         description: "Lorem ipsum dolor sit amet, consectetur adipiscing elit"
///     )
/// }
/// ```
///
public struct VWheelPicker<Data, Content>: View
    where
        Data: RandomAccessCollection,
        Data.Index == Int,
        Content: View
{
    // MARK: Properties
    private let model: VWheelPickerModel
    
    @Binding private var selectedIndex: Int
    private let state: VWheelPickerState
    
    private let title: String?
    private let description: String?
    
    private let data: Data
    private let content: (Data.Element) -> Content
    
    @State private var rowWidth: CGFloat = .zero
    
    // MARK: Initializers
    public init(
        model: VWheelPickerModel = .init(),
        selectedIndex: Binding<Int>,
        state: VWheelPickerState = .enabled,
        title: String? = nil,
        description: String? = nil,
        data: Data,
        @ViewBuilder content: @escaping (Data.Element) -> Content
    ) {
        self.model = model
        self._selectedIndex = selectedIndex
        self.state = state
        self.title = title
        self.description = description
        self.data = data
        self.content = content
    }

    public init(
        model: VWheelPickerModel = .init(),
        selectedIndex: Binding<Int>,
        state: VWheelPickerState = .enabled,
        title: String? = nil,
        description: String? = nil,
        titles: [String]
    )
        where
            Data == Array<String>,
            Content == VBaseTitle
    {
        self.init(
            model: model,
            selectedIndex: selectedIndex,
            state: state,
            title: title,
            description: description,
            data: titles,
            content: { title in
                VBaseTitle(
                    title: title,
                    color: model.colors.textColor(for: state),
                    font: model.fonts.rows,
                    type: .oneLine
                )
            }
        )
    }

    public init<Item>(
        model: VWheelPickerModel = .init(),
        selection: Binding<Item>,
        state: VWheelPickerState = .enabled,
        title: String? = nil,
        description: String? = nil,
        @ViewBuilder content: @escaping (Item) -> Content
    )
        where
            Data == Array<Item>,
            Item: VPickableItem
    {
        self.init(
            model: model,
            selectedIndex: .init(
                get: { selection.wrappedValue.rawValue },
                set: { selection.wrappedValue = Item(rawValue: $0)! }
            ),
            state: state,
            title: title,
            description: description,
            data: .init(Item.allCases),
            content: content
        )
    }

    public init<Item>(
        model: VWheelPickerModel = .init(),
        selection: Binding<Item>,
        state: VWheelPickerState = .enabled,
        title: String? = nil,
        description: String? = nil
    )
        where
            Data == Array<Item>,
            Content == VBaseTitle,
            Item: VPickableTitledItem
    {
        self.init(
            model: model,
            selectedIndex: .init(
                get: { selection.wrappedValue.rawValue },
                set: { selection.wrappedValue = Item(rawValue: $0)! }
            ),
            state: state,
            title: title,
            description: description,
            data: .init(Item.allCases),
            content: { item in
                VBaseTitle(
                    title: item.pickerTitle,
                    color: model.colors.textColor(for: state),
                    font: model.fonts.rows,
                    type: .oneLine
                )
            }
        )
    }
}

// MARK:- Body
extension VWheelPicker {
    public var body: some View {
        VStack(alignment: .leading, spacing: model.layout.titleSpacing, content: {
            titleView
            pickerView
            descriptionView
        })
    }
    
    private var pickerView: some View {
        Picker(selection: $selectedIndex, label: EmptyView(), content: {
            ForEach(0..<data.count, content: { i in
                content(data[i])
                    .tag(i)
            })
        })
            .pickerStyle(WheelPickerStyle())
            .labelsHidden()
            
            .disabled(!state.isEnabled) // Luckily, doesn't affect colors
            .opacity(model.colors.foregroundOpacity(state: state))
            
            .background(model.colors.backgroundColor(for: state).cornerRadius(model.layout.cornerRadius))
    }
    
    @ViewBuilder private var titleView: some View {
        if let title = title, !title.isEmpty {
            VBaseTitle(
                title: title,
                color: model.colors.titleColor(for: state),
                font: model.fonts.title,
                type: .oneLine
            )
                .padding(.horizontal, model.layout.titlePaddingHor)
                .opacity(model.colors.foregroundOpacity(state: state))
        }
    }
    
    @ViewBuilder private var descriptionView: some View {
        if let description = description, !description.isEmpty {
            VBaseTitle(
                title: description,
                color: model.colors.descriptionColor(for: state),
                font: model.fonts.description,
                type: .multiLine(limit: nil, alignment: .leading)
            )
                .padding(.horizontal, model.layout.titlePaddingHor)
                .opacity(model.colors.foregroundOpacity(state: state))
        }
    }
}

// MARK:- Preview
struct VWheelPicker_Previews: PreviewProvider {
    @State private static var selection: VSegmentedPicker_Previews.PickerRow = .red

    static var previews: some View {
        VWheelPicker(
            selection: $selection,
            title: "Lorem ipsum dolor sit amet",
            description: "Lorem ipsum dolor sit amet, consectetur adipiscing elit"
        )
            .padding(20)
    }
}