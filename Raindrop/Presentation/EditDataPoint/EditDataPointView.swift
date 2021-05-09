//
//  EditDataPointView.swift
//  Raindrop
//
//  Created by Mikael Weiss on 5/4/21.
//  Copyright © 2021 ___ORGANIZATIONNAME___. All rights reserved.
//

import SwiftUI

struct EditDataPointView: View {
    @ObservedObject private var viewModel: EditDataPoint.ViewModel
    private let interactor: EditDataPointRequesting?
    
    init(interactor: EditDataPointRequesting?, viewModel: EditDataPoint.ViewModel) {
        self.interactor = interactor
        self.viewModel = viewModel
    }
    
    // MARK: - View Lifecycle
    var body: some View {
        ScrollView {
            VStack {
                RoundedRectangle(cornerRadius: 16, style: .continuous)
                    .frame(height: 56)
            }
            .padding(.horizontal)
        }
    }
}

// MARK: - Inputing

extension EditDataPointView {
}

struct EditDataPoint_Previews: PreviewProvider {
    
    private static var viewModel: EditDataPoint.ViewModel {
        let viewModel = EditDataPoint.ViewModel()
        return viewModel
    }
    
    static var previews: some View {
        EditDataPointView(interactor: nil, viewModel: viewModel)
    }
}
