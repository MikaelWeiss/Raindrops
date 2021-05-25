//
//  DecimalEntryCell.swift
//  Raindrop
//
//  Created by Mikael Weiss on 5/8/21.
//

import SwiftUI

struct DecimalEntryCell: View {
    @State private var state: DataEntryCellState = .normal
    let value: Decimal?
    let onValueChanged: (Decimal?) -> Void
    let info: DataEntryCellInfo
    
    init(value: Decimal? = nil,
         onValueChanged: @escaping (Decimal?) -> Void = { _ in },
         info: DataEntryCellInfo = DataEntryCellInfo()) {
        self.value = value
        self.onValueChanged = onValueChanged
        self.info = info
    }
    
    private var textToUse: String {
        let value = value ?? .nan
        return NumberFormatter.currency.string(for: value) ?? ""
    }
    
    var body: some View {
        DataEntryCell(
            text: textToUse,
            onTextChanged: onTextChanged,
            state: state,
            info: info)
    }
    
    func onTextChanged(_ inputText: String) {
        let number = NumberFormatter.currency.number(from: inputText)
        onValueChanged(number?.decimalValue)
    }
}

struct DecimalEntryCell_Previews: PreviewProvider {
    @State private static var value: Decimal? = 5
    
    static var previews: some View {
        DecimalEntryCell(value: value, onValueChanged: { value = $0 })
    }
}

extension NumberFormatter {
    class var currency: NumberFormatter {
        let numberFormatter = NumberFormatter()
        numberFormatter.locale = Locale.current
        numberFormatter.numberStyle = .currency
        numberFormatter.minimumFractionDigits = 0
        numberFormatter.maximumFractionDigits = 0
        return numberFormatter
    }
}
