//
//  PomodoroViewModel.swift
//  PomodoroTimer
//
//  Created by Yash Poojary on 05/06/22.
//



import SwiftUI

struct SingleFlipView: View {
    
    @ObservedObject var viewModel: PomodoroViewModel
    
    init(text: String, viewModel: PomodoroViewModel) {
        self.text = text
        self.viewModel = viewModel
    }
    
    // MARK: - Private
    
    private let text: String
    
    var body: some View {

        Text(text)
            .frame(maxWidth: 20)
            .foregroundColor(Color("timerStringColor"))
            .font(Font.custom("RobotoMono-Bold", size: viewModel.showOnlyMinutesAndSeconds ? 35 : 25))


    }
    
}
