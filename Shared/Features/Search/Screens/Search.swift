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
    @AppStorage(AppStorageVariables.stationId) var stationId = 1
    
    let action: SimpleAction

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
        .task {
            await viewModel.fetch()
        }
        .navigationBarBackButtonHidden(true)
    }
}

struct Search_Previews: PreviewProvider {
    static var previews: some View {
        Search(action: {})
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
            searchTextfield
            stationList
        }
    }
    
    private var stationList: some View {
        VStack {
            ScrollView(.vertical) {
                LazyVStack {
                    ForEach(viewModel.stations.filter({ viewModel.searchPhrase.isEmpty ? true : $0.name.contains(viewModel.searchPhrase)}), id: \.uuid) { station in
                        Button {
                            stationId = station.id
                            action()
                            dismiss()
                        } label: {
                            HStack {
                                VStack(alignment: .leading) {
                                    Text(station.name)
                                        .font(.system(size: 24, weight: .bold))
                                    Text(station.localization)
                                        .font(.system(size: 20))
                                }
                                .padding(.leading)
                                Spacer()
                            }
                            .foregroundColor(.white)
                            .frame(maxWidth: .infinity)
                            .frame(height: 75)
                            .background(.blue)
                            .cornerRadius(10)
                            .padding(.horizontal)
                        }
                    }
                    .animation(.default, value: viewModel.searchPhrase)
                }
            }
        }
    }
    
    private var searchTextfield: some View {
        HStack {
            Image(systemName: "magnifyingglass")
            TextField("", text: $viewModel.searchPhrase).placeholder(when: viewModel.searchPhrase.isEmpty) {
                Text("Search").opacity(0.5)
            }
            .autocorrectionDisabled()
            .textInputAutocapitalization(.never)
            .frame(height: 30)
            .padding(.leading, 5)
            .background(.white.opacity(0.2))
            .cornerRadius(5)
        }
        .padding()
        .foregroundColor(.white)
    }
    
    private var title: some View {
        Text("find more stations")
            .font(.system(size: 24, weight: .semibold))
            .foregroundColor(.white)
    }
}

extension View {
    func placeholder<Content: View>(
        when shouldShow: Bool,
        alignment: Alignment = .leading,
        @ViewBuilder placeholder: () -> Content) -> some View {

        ZStack(alignment: alignment) {
            placeholder().opacity(shouldShow ? 1 : 0)
            self
        }
    }
}
