//
//  DataEntryCell.swift
//  Elements
//
//  Created by Mikael Weiss on 4/14/21.
//

import Foundation
import SwiftUI

struct DataEntryCell: View {
    
    enum DataEntryType {
        case textEntry
        case selection
    }
    
    enum DataEntryViewState {
        case error
        case normal
    }
    
    @State private var isTyping = false
    
    private let title: String
    private let infoMessage: String?
    private let text: String
    private let attributedText: Text?
    private let image: Image?
    private let tintColor: Color
    private let state: DataEntryViewState
    private let type: DataEntryType
    private let isRequired: Bool
    private let onTextChanged: (String) -> Void
    private let onCommit: () -> Void
    private let onSelectionTap: () -> Void
    
    init(title: String,
         infoMessage: String? = nil,
         text: String,
         attributedText: Text? = nil,
         image: Image? = nil,
         tintColor: Color = .appTintColor,
         state: DataEntryViewState = .normal,
         type: DataEntryType = .textEntry,
         isRequired: Bool = false,
         onTextChanged: @escaping (String) -> Void = { _ in },
         onCommit: @escaping () -> Void = {},
         onSelectionTap: @escaping () -> Void = {}) {
        
        self.title = title
        self.infoMessage = infoMessage
        self.text = text
        self.attributedText = attributedText
        self.image = image
        self.tintColor = tintColor
        self.state = state
        self.type = type
        self.isRequired = isRequired
        self.onTextChanged = onTextChanged
        self.onCommit = onCommit
        self.onSelectionTap = onSelectionTap
    }
    
    // Have the Init contain a function that returns "DataEntryCellValues" (a class)
    
    private func onTap() {
        if type == .selection {
            onSelectionTap()
        } else {
            isTyping = true
        }
    }
    
    private func onImageTap() {
        if image == nil && isTyping {
            onTextChanged("")
        }
    }
    
    private var imageToUse: Image? {
        if type == .selection { return Image("chevron.down") }
        if let image = image { return image }
        if isTyping == true {
            return Image("xmark.circle.fill")
        } else {
            if isRequired == true && state == .error {
                return Image("exclamationmark.circle.fill")
            }
        }
        return nil
    }
    
    private var attributedTextToUse: Text? {
        if text != "" { return attributedText }
        return nil
    }
    
    private var tintColorToUse: Color {
        if state == .error { return .appErrorColor }
        if isTyping, isRequired, text == "" { return .appErrorColor }
        if isTyping, state == .normal { return tintColor }
        return .standardGray
    }
    
    private var infoMessageToUse: Text? {
        if let message = infoMessage, message.isEmpty == false {
            let textView = Text(message).font(.system(size: 12, weight: .semibold))
            if state == .error { return textView }
            if isTyping, isRequired, text == "" { return textView }
            if !isTyping, state == .error, isRequired == true, text == "" { return textView }
            return nil
        }
        return nil
    }
    
    private var requiredTextToUse: Text? {
        if !isTyping, isRequired, text == "" {
            return Text("Required")
        }
        return nil
    }
    private var titleFontSizeToUse: CGFloat {
        if !isTyping && text == "" {
            return 18
        }
        return 12
    }
    private var titleFontWeightToUse: Font.Weight {
        if !isTyping && text == "" {
            return .regular
        }
        return .medium
    }
    
    private struct OffSet {
        let x: CGFloat
        let y: CGFloat
    }
    
    private var showSmallTitle: Bool {
        isTyping || (!isTyping && text != "")
    }
    
    private var titleOffsetToUse: OffSet {
        if showSmallTitle {
            return OffSet(x: 16, y: -33)
        }
        return OffSet(x: 16, y: 0)
    }
    
    private var smallTitlePaddingWidthToUse: CGFloat {
        title.widthOfString(usingFont: .systemFont(ofSize: 12)) + 8
    }
    
    var body: some View {
        let binding = Binding(get: { text }, set: { onTextChanged($0) })
        
        VStack(alignment: .leading) {
            // + info message
            ZStack(alignment: .leading) {
                // Text field, border, title
                
                VStack {
                    Rectangle()
                        .frame(width: showSmallTitle ? smallTitlePaddingWidthToUse : 0)
                        .frame(height: 4)
                        .foregroundColor(.white)
                    
                    Spacer()
                }
                .frame(width: smallTitlePaddingWidthToUse)
                .offset(y: -2)
                .padding(.leading, titleOffsetToUse.x - 4)
                .zIndex(1)
                
                HStack {
                    // Text Field and Image View
                    attributedTextToUse
                    LegacyTextField(text: binding, isFirstResponder: $isTyping, onCommit: onCommit) {
                        $0.tintColor = UIColor(tintColorToUse)
                    }
                    if image == nil, !isTyping {
                        imageToUse
                    } else {
                        Button(action: onImageTap, label: {
                            imageToUse
                        })
                    }
                }
                .padding(.horizontal, 16)
                
                // The border view
                .overlay(
                    RoundedRectangle(cornerRadius: 5, style: .continuous)
                        .stroke(tintColorToUse, lineWidth: 1)
                )
                .frame(height: 64)
                .zIndex(0)
                
                // Title View
                VStack(alignment: .leading) {
                    Text(title)
                        .animatableSystemFont(size: titleFontSizeToUse, weight: titleFontWeightToUse)
                    
                    requiredTextToUse
                        .font(.system(size: 13, weight: .regular))
                        .opacity(0.6)
                        .transition(.modifier(active: OffsetModifier(y: -31),
                                              identity: OffsetModifier(y: 0))
                                        .combined(with: .opacity))
                }
                .offset(y: titleOffsetToUse.y)
                .padding(.leading, titleOffsetToUse.x)
                .zIndex(1)
            }
            
            // Info message view
            if infoMessageToUse != nil {
                infoMessageToUse
                    .padding(.leading, 6)
                    .transition(.modifier(active: OffsetModifier(y: -15),
                                          identity: OffsetModifier(y: 0))
                                .combined(with: .opacity))
            }
        }
        .foregroundColor(tintColorToUse)
        .padding(.bottom, 24)
        .onTapGesture { onTap() }
        .animation(.spring(response: 0.4, dampingFraction: 0.9, blendDuration: 0.05))
    }
}

/// Used for transitions
private struct OffsetModifier: ViewModifier {
    let x: CGFloat
    let y: CGFloat
    
    init(x: CGFloat = 0, y: CGFloat = 0) {
        self.x = x
        self.y = y
    }
    
    func body(content: Content) -> some View {
        content
            .offset(x: x, y: y)
    }
}

struct PreviewableDataEntryCell: View {
    @State private var text1 = "Some Input"
    @State private var text2 = ""
    @State private var text3 = ""
    @State private var isRequired = false
    @State private var isInError = true
    
    var body: some View {
        ScrollView {
            VStack(spacing: 0) {
                DataEntryCell(title: "Some title", text: text1, isRequired: true, onTextChanged: { text1 = $0 })
                    .padding(.horizontal)
                DataEntryCell(title: "Some title", infoMessage: "Try this format: mm/dd/yyyy", text: text2, state: isInError ? .error : .normal, isRequired: isRequired, onTextChanged: { text2 = $0 })
                    .padding(.horizontal)
                Button("isRequired", action: { isRequired.toggle() })
                Button("isInError", action: {  isInError.toggle() })
                
                ForEach(1..<15) { _ in
                    DataEntryCell(title: "Some title", text: text3, onTextChanged: { text3 = $0 })
                        .padding(.horizontal)
                }
            }
        }
        .navigationTitle("asdf")
        .navigationBarTitle("Test")
    }
}

struct DataEntryCell_Previews: PreviewProvider {
    static var previews: some View {
        PreviewableDataEntryCell()
    }
}

// https://stackoverflow.com/a/59059359/6842785

struct LegacyTextField: UIViewRepresentable {
    @Binding var isFirstResponder: Bool
    @Binding var text: String
    private var onCommit: () -> Void
    
    private var configuration = { (view: UITextField) in }
    
    init(text: Binding<String>,
         isFirstResponder: Binding<Bool>,
         onCommit: @escaping () -> Void,
         configuration: @escaping (UITextField) -> Void = { _ in }) {
        
        self._isFirstResponder = isFirstResponder
        self._text = text
        self.onCommit = onCommit
        self.configuration = configuration
    }
    
    func makeUIView(context: Context) -> UITextField {
        let view = UITextField()
        view.addTarget(context.coordinator, action: #selector(Coordinator.textViewDidChange), for: .editingChanged)
        view.delegate = context.coordinator
        return view
    }
    
    func updateUIView(_ uiView: UITextField, context: Context) {
        uiView.text = text
        switch isFirstResponder {
        case true: uiView.becomeFirstResponder()
        case false: uiView.resignFirstResponder()
        }
        configuration(uiView)
    }
    
    func makeCoordinator() -> Coordinator {
        Coordinator($text, isFirstResponder: $isFirstResponder, onCommit: onCommit)
    }
    
    class Coordinator: NSObject, UITextFieldDelegate {
        var text: Binding<String>
        var isFirstResponder: Binding<Bool>
        var onCommit: () -> Void
        
        init(_ text: Binding<String>,
             isFirstResponder: Binding<Bool>,
             onCommit: @escaping () -> Void) {
            
            self.text = text
            self.isFirstResponder = isFirstResponder
            self.onCommit = onCommit
        }
        
        @objc func textViewDidChange(_ textField: UITextField) {
            text.wrappedValue = textField.text ?? ""
        }
        
        func textFieldDidBeginEditing(_ textField: UITextField) {
            isFirstResponder.wrappedValue = true
        }
        
        func textFieldDidEndEditing(_ textField: UITextField) {
            isFirstResponder.wrappedValue = false
        }
        
        func textFieldShouldReturn(_ textField: UITextField) -> Bool {
            onCommit()
            return true
        }
    }
}
