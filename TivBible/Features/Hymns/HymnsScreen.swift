//
//  HymnsScreen.swift
//  TivBible
//
//  Created by Isaac Iniongun on 02/07/2023.
//

import SwiftUI

struct HymnsScreen: View {
    @EnvironmentObject private var preferenceStore: PreferenceStore
    @StateObject private var viewModel = HymnsViewModel()
    @State private var selectedHymn: Hymn?
    
    var body: some View {
        NavigationStack {
            ZStack {
                if viewModel.filteredHymns.isNotEmpty {
                    List(viewModel.filteredHymns) { hymn in
                        HStack(alignment: .top) {
                            Text("\(hymn.number).")
                                .font(preferenceStore.font(size: 18))
                                .fontWeight(.bold)
                            
                            VStack(alignment: .leading) {
                                Text(hymn.title.trimmingCharacters(in: .illegalCharacters))
                                    .font(preferenceStore.font(size: 16))
                                    .fontWeight(.semibold)
                                    .padding(.top, 1)
                                
                                Text((hymn.versesText).trimmingCharacters(in: .whitespacesAndNewlines))
                                    .font(preferenceStore.font())
                                    .lineLimit(3)
                            }
                        }
                        .onTapGesture {
                            selectedHymn = hymn
                        }
                    }
                    .scrollIndicators(.never)
                    .listStyle(.plain)
                } else {
                    EmptyStateView(message: "No Hymns")
                }
            }
            .onAppear {
                viewModel.getHymns()
            }
            .navigationTitle("Atsam a Ikyenge")
            .navigationBarTitleDisplayMode(.inline)
            .searchable(text: $viewModel.searchText, prompt: "Search")
            .autocorrectionDisabled()
            .textInputAutocapitalization(.never)
            .font(preferenceStore.font(size: 15))
            .onSubmit(of: .search) {
                viewModel.search()
            }
            .onChange(of: viewModel.searchText) {
                viewModel.search()
            }
            .fullScreenCover(item: $selectedHymn) { hymn in
                HymnDetailView(hymn: hymn)
            }
        }
    }
}
