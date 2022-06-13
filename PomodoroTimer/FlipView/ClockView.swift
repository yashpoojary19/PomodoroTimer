//
//  PomodoroViewModel.swift
//  PomodoroTimer
//
//  Created by Yash Poojary on 05/06/22.
//




import SwiftUI

struct ClockView: View {
    
    @ObservedObject var viewModel: PomodoroViewModel
    
    
    var body: some View {
        HStack(spacing: 4) {
            
            if !viewModel.showOnlyMinutesAndSeconds {
                HStack(spacing: 4) {
                        
                    FlipView(viewModel: viewModel.flipViewModels[0], pomodoroViewModel: viewModel)
                    FlipView(viewModel: viewModel.flipViewModels[1], pomodoroViewModel: viewModel)
                        Text(":")
                            .foregroundColor(Color("timerStringColor"))
                            .font(Font.custom("RobotoMono-Bold", size: viewModel.showOnlyMinutesAndSeconds ? 35 : 25))
        
                }
            }
            HStack(spacing: 4) {
                FlipView(viewModel: viewModel.flipViewModels[2], pomodoroViewModel: viewModel)
                FlipView(viewModel: viewModel.flipViewModels[3], pomodoroViewModel: viewModel)
                Text(":")
                    .foregroundColor(Color("timerStringColor"))
                    .font(Font.custom("RobotoMono-Bold", size: viewModel.showOnlyMinutesAndSeconds ? 35 : 25))
            }
            HStack(spacing: 4) {
                FlipView(viewModel: viewModel.flipViewModels[4], pomodoroViewModel: viewModel)
                FlipView(viewModel: viewModel.flipViewModels[5], pomodoroViewModel: viewModel)
            }
        }

        
  
        
    }
    
    
}
