import SwiftUI

struct ClockView: View {
    
    @ObservedObject var viewModel: PomodoroViewModel
    
    var body: some View {
        HStack(spacing: 0) {
            
            if !viewModel.showOnlyMinutesAndSeconds {
                HStack(spacing: 0) {
                        
                        FlipView(viewModel: viewModel.flipViewModels[0])
                        FlipView(viewModel: viewModel.flipViewModels[1])
                        Text(":")
                            .foregroundColor(Color("timerStringColor"))
                            .font(Font.custom("RobotoMono-Bold", size: 35))
        
                }
            }
            HStack(spacing: 0) {
                FlipView(viewModel: viewModel.flipViewModels[2])
                FlipView(viewModel: viewModel.flipViewModels[3])
                Text(":")
                    .foregroundColor(Color("timerStringColor"))
                    .font(Font.custom("RobotoMono-Bold", size: 35))
            }
            HStack(spacing: 0) {
                FlipView(viewModel: viewModel.flipViewModels[4])
                FlipView(viewModel: viewModel.flipViewModels[5])
            }
        }
//        .scaleEffect(!viewModel.showOnlyMinutesAndSeconds ? 0.7 : 1)
        
  
        
    }
    
    
}
