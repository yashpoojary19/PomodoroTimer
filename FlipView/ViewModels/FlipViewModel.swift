
import SwiftUI

class FlipViewModel: ObservableObject, Identifiable {

    var text: String? {
        didSet { updateTexts(old: oldValue, new: text) }
    }

    @Published var newValue: String?
    @Published var oldValue: String?

    @Published var animateBottom: Bool = false

    func updateTexts(old: String?, new: String?) {
        guard old != new else { return }
        oldValue = old
        animateBottom = false

        withAnimation(Animation.easeIn(duration: 0.15)) { [weak self] in
            self?.newValue = new
            self?.animateBottom = true
        }


    }

}
