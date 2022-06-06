import SwiftUI

struct ClockView: View {
    
    let viewModel = PomodoroViewModel()
    
    var body: some View {
        HStack(spacing: 0) {
            HStack(spacing: 5) {
             
                    FlipView(viewModel: viewModel.flipViewModels[0])
                    FlipView(viewModel: viewModel.flipViewModels[1])
                    Text(":")
                        .foregroundColor(Color("timerStringColor"))
                        .font(Font.custom("RobotoMono-Bold", size: 35))
    
            }
            HStack(spacing: 5) {
                FlipView(viewModel: viewModel.flipViewModels[2])
                FlipView(viewModel: viewModel.flipViewModels[3])
                Text(":")
                    .foregroundColor(Color("timerStringColor"))
                    .font(Font.custom("RobotoMono-Bold", size: 35))
            }
            HStack(spacing: 5) {
                FlipView(viewModel: viewModel.flipViewModels[4])
                FlipView(viewModel: viewModel.flipViewModels[5])
            }
        }
  
        
    }
    
    
}
