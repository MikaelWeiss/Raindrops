//
//  EditDataPointView.swift
//  Raindrop
//
//  Created by Mikael Weiss on 6/15/21.
//  Copyright © 2021 ___ORGANIZATIONNAME___. All rights reserved.
//

import SwiftUI

extension EditDataPoint {
    
    struct ContentView: View {
        typealias Theme = EditDataPoint.Theme
        @ObservedObject var viewModel: ViewModel
        let interactor: EditDataPointInteracting
        
        var body: some View {
            ScrollView {
                DataEntryCell(
                    title: Theme.textFieldTitle,
                    infoMessage: viewModel.textFieldInfoMessage,
                    text: viewModel.text,
                    attributedText: Theme.currencySymbol,
                    state: viewModel.textFieldState,
                    onTextChanged: interactor.updateText)
            }
            .navigationTitle(Theme.sceneTitle)
            .navigationBarItems(leading: cancelButton, trailing: saveButton)
            .navigationBarBackButtonHidden(true)
            .accentColor(Theme.tintColor)
            .errorSheet($viewModel.error)
        }
        
        var cancelButton: some View {
            Button(action: interactor.dismiss) {
                Text(Theme.backButtonTitle)
                    .accentColor(Theme.tintColor)
            }
        }
        
        var saveButton: some View {
            Button(action: interactor.save) {
                Text(Theme.saveButtonTitle)
                    .accentColor(Theme.tintColor)
            }.disabled(!viewModel.canSave)
        }
    }
}

// MARK: - Previews

struct EditDataPoint_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            EditDataPoint.Scene().view(preview: true, isPresented: .constant(true))
        }
    }
}
