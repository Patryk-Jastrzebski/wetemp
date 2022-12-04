//
//  Search.swift
//  wetemp
//
//  Created by Patryk Jastrzębski on 04/12/2022.
//

import SwiftUI

struct Search: View {
    @Environment(\.dismiss) var dismiss
    @StateObject var viewModel = SearchViewModel()

    var body: some View {
        ZStack {
            background
            content
        }
        .toolbar {
            ToolbarItem(placement: .navigationBarLeading) {
                backButton
            }
            
            ToolbarItem(placement: .principal) {
                title
            }
        }
        .onLoad {
            viewModel.fetch()
        }
        .navigationBarBackButtonHidden(true)
    }
}

struct Search_Previews: PreviewProvider {
    static var previews: some View {
        Search()
    }
}

private extension Search {
    private var background: some View {
        Gradients.dayBackgroundGradient
            .ignoresSafeArea(.all)
    }
    
    private var backButton: some View {
        VStack {
            HStack {
                Button {
                    dismiss()
                } label: {
                    Image(systemName: "chevron.backward")
                        .foregroundColor(.white)
                }
                Spacer()
            }
            Spacer()
        }
        .padding()
    }
    
    private var content: some View {
        VStack {
            stationList
        }
    }
    
    private var stationList: some View {
        VStack {
            List {
                ForEach(viewModel.stations, id: \.id) { station in
                    Text(station.localization)
                }
                .listRowSeparator(.hidden)
            }
            .searchable(text: $viewModel.searchPhrase, placement: .navigationBarDrawer(displayMode: .always))
            .scrollContentBackground(.hidden)
            .listStyle(.insetGrouped)
        }
    }
    
    private var title: some View {
        Text("find more stations")
            .font(.system(size: 24, weight: .semibold))
            .foregroundColor(.white)
    }
}
