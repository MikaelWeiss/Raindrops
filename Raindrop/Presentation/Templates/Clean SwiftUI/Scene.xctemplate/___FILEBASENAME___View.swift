//
//  ___FILENAME___
//  ___PROJECTNAME___
//
//  Created by ___FULLUSERNAME___ on ___DATE___.
//  Copyright © ___YEAR___ ___ORGANIZATIONNAME___. All rights reserved.
//

import SwiftUI

extension ___VARIABLE_sceneName___ {
    
    struct ContentView: View {
        typealias Theme = ___VARIABLE_sceneName___.Theme
        @ObservedObject var viewModel: ViewModel
        let interactor: ___VARIABLE_sceneName___Interacting
        
        var text: Binding<String> {
            Binding(get: { viewModel.text }, set: interactor.updateText)
        }
        
        var body: some View {
            ScrollView {
                TextField("Hallo", text: text)
                    .padding()
                    .overlay(
                        RoundedRectangle(cornerRadius: 15, style: .continuous)
                            .stroke(lineWidth: 2)
                            .fill(Theme.tintColor)
                    )
                    .padding()
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

struct ___VARIABLE_sceneName____Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            ___VARIABLE_sceneName___.Scene().view(preview: true, isPresented: .constant(true))
        }
    }
}
