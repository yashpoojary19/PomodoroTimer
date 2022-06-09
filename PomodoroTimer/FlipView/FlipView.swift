//
//  PomodoroViewModel.swift
//  PomodoroTimer
//
//  Created by Yash Poojary on 05/06/22.
//




import SwiftUI

struct FlipView: View {

    init(viewModel: FlipViewModel, pomodoroViewModel: PomodoroViewModel) {
        self.viewModel = viewModel
        self.pomodoroViewModel = pomodoroViewModel
    }

    @ObservedObject var viewModel: FlipViewModel
    @ObservedObject var pomodoroViewModel: PomodoroViewModel

    var body: some View {
        VStack(spacing: 0) {

            SingleFlipView(text: viewModel.newValue ?? "", viewModel: pomodoroViewModel)
                    .rotation3DEffect(.init(degrees: self.viewModel.animateBottom ? .zero : 90),
                                      axis: (1, 0, 0),
                                      anchor: .top,
                                      perspective: 0.5)
           
        }
            .fixedSize()
    }

}
