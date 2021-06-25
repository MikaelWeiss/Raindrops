//
//  ViewDataPointsOverviewView.swift
//  Raindrop
//
//  Created by Mikael Weiss on 6/16/21.
//  Copyright © 2021 ___ORGANIZATIONNAME___. All rights reserved.
//

import SwiftUI

extension ViewDataPointsOverview {
    
    struct ContentView: View {
        typealias Theme = ViewDataPointsOverview.Theme
        @ObservedObject var viewModel: ViewModel
        let interactor: ViewDataPointsOverviewInteracting
        
        var text: Binding<String> {
            Binding(get: { viewModel.text }, set: interactor.updateText)
        }
        
        var body: some View {
            ZStack {
                ScrollView {
                    VStack(spacing: 5) {
                        ViewDataPointsOverview.TotalRow(title: "Total:", value: "$5,000")
                        
                        ViewDataPointsOverview.DataPointsList()
                    }
                }
                
                VStack {
                    Spacer()
                    StandardButton(title: "Update", action: {})
                        .padding(.horizontal, 42)
                }
            }
            .navigationTitle(Theme.sceneTitle)
            .accentColor(Theme.tintColor)
            .errorSheet($viewModel.error)
        }
    }
    
    // MARK: - Subviews
    
    private struct TotalRow: View {
        let title: String
        let value: String
        
        var body: some View {
            HStack(spacing: 0) {
                Text(title)
                    .font(.system(.largeTitle, design: .rounded))
                    .fontWeight(.medium)
                Spacer()
                Text(value)
                    .font(.system(.title, design: .rounded))
                    .fontWeight(.regular)
            }
            .padding(.horizontal, 25)
            .frame(height: 56)
            .cardify()
            .padding()
        }
    }
    
    private struct GraphRow: View {
        var body: some View {
            Text("Graphs!")
        }
    }
    
    private struct DataPointsList: View {
        var body: some View {
            VStack(spacing: 0) {
                ForEach(0..<15) { index in
                    ViewDataPointsOverview.ValueRow(
                        title: "Shopping",
                        dateAndCategory: "Jan, 5 21, Category",
                        value: "$400",
                        valueIncreased: true,
                        showSeperatorLine: index != 14)
                }
            }
            .cardify()
            .padding(.horizontal)
        }
    }
    
    private struct ValueRow: View {
        let title: String
        let dateAndCategory: String
        let value: String
        let valueIncreased: Bool
        let showSeperatorLine: Bool
        
        var body: some View {
            HStack(spacing: 0) {
                VStack(alignment: .leading, spacing: 0) {
                    Text(title)
                        .font(.system(.title2, design: .rounded))
                        .foregroundColor(Color.appGrayLight)
                    Spacer(minLength: 2)
                    Text(dateAndCategory)
                        .font(.system(.subheadline, design: .rounded))
                        .fontWeight(.semibold)
                }.frame(maxWidth: .infinity, alignment: .leading)
                Text(value)
                    .font(.system(.title2, design: .rounded))
                    .foregroundColor(valueIncreased ? .green : .red)
            }
            .padding()
            if showSeperatorLine {
                Color.appGrayMedium
                    .frame(maxHeight: 2)
                    .padding(.horizontal)
            }
        }
    }
}

private extension View {
    func cardify() -> some View {
        self
            .background(
                RoundedRectangle(cornerRadius: 36, style: .continuous)
                    .fill(Color.appGrayDark)
            )
    }
}

// MARK: - Previews

struct ViewDataPointsOverview_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            ViewDataPointsOverview.Scene().view(preview: true, isPresented: .constant(true))
        }
    }
}
