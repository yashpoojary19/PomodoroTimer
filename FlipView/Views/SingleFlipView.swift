import SwiftUI

struct SingleFlipView: View {
    
    init(text: String) {
        self.text = text
    }
    
    // MARK: - Private
    
    private let text: String
    
    var body: some View {
        Text(text)
//            .font(.system(size: 20))
//            .fontWeight(.heavy)
//            .foregroundColor(.black)
//            .frame(width: 20, height: 50)
            .frame(maxWidth: 20)
            .foregroundColor(Color("timerStringColor"))
            .font(Font.custom("RobotoMono-Bold", size: 35))
            .lineLimit(1)
            .minimumScaleFactor(0.5)

    }
    
}
