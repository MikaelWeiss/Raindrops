//
//  DecimalEntryCell.swift
//  Raindrop
//
//  Created by Mikael Weiss on 5/8/21.
//

import SwiftUI

struct DecimalEntryCell: View {
    let currencySymbol = Locale.current.currencySymbol ?? "$"
    @State private var state: DataEntryCellState = .normal
    private let givenState: DataEntryCellState
    private let value: Decimal?
    private let onValueChanged: (Decimal?) -> Void
    private let info: DataEntryCellInfo
    
    init(value: Decimal? = nil,
         state: DataEntryCellState = .normal,
         info: DataEntryCellInfo = DataEntryCellInfo(),
         onValueChanged: @escaping (Decimal?) -> Void = { _ in }) {
        self.value = value
        self.givenState = state
        self.info = info
        self.onValueChanged = onValueChanged
    }
    
    private var textToUse: String {
        NumberFormatter.decimal.string(for: value) ?? ""
    }
    
    private var stateToUse: DataEntryCellState {
        givenState == .error ? .error : state
    }
    
    var body: some View {
        DataEntryCell(
            text: textToUse,
            onTextChanged: onTextChanged,
            state: state,
            attributedText: Text(currencySymbol),
            info: info)
    }
    
    private func onTextChanged(_ inputText: String) {
        let num = NumberFormatter.decimal.number(from: inputText)
        onValueChanged(num?.decimalValue)
//        if num == nil, value != nil {
//            state = .error
//        } else {
//            state = .normal
//        }
    }
}

struct DecimalEntryCell_Previews: PreviewProvider {
    @State private static var value: Decimal? = 5
    
    static var previews: some View {
        DecimalEntryCell(value: value, onValueChanged: { value = $0 })
    }
}

extension NumberFormatter {
    class var decimal: NumberFormatter {
        let numberFormatter = NumberFormatter()
        numberFormatter.locale = Locale.current
        numberFormatter.numberStyle = .decimal
        numberFormatter.minimumFractionDigits = 0
        numberFormatter.maximumFractionDigits = 2
        return numberFormatter
    }
}
