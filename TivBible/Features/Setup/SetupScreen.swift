//
//  SetupScreen.swift
//  TivBible
//
//  Created by Isaac Iniongun on 12/06/2023.
//

import SwiftUI
import SwiftData

struct SetupScreen: View {
    
    @StateObject private var viewModel = SetupViewModel()
    @State private var progress = 0.0
    private let timer = Timer.publish(every: 0.1, on: .main, in: .common).autoconnect()
    private let maxProgress = 100.0
    
    var body: some View {
        VStack {
            Spacer()
            
            VStack(spacing: 15) {
                Text("The Holy Bible")
                    .font(.gentiumPlus(.bold, size: 22))
                
                Text("in")
                    .font(.gentiumPlus(.regular))
                
                Text("Tiv Language")
                    .font(.gentiumPlus(.bold, size: 22))
            }
            
            Spacer()
            
            ProgressView(value: progress, total: maxProgress) {
                Text("setup in progress")
                    .font(.gentiumPlus(.regular))
                    .centerHorizontally()
            }
            .tint(.label)
            .visible(viewModel.dbInitializationInProgress)
            .onReceive(timer) { _ in
                if progress < maxProgress {
                    progress += 2
                }
                
                if progress >= maxProgress  {
                    progress = 0
                }
            }
        }
        .task {
            await viewModel.initializeDB()
        }
    }
}

#Preview {
    SetupScreen()
}
