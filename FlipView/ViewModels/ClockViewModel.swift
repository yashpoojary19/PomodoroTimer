import Foundation


class ClockViewModel {

    init() {
//        setupTimer()
    }

    private(set) lazy var flipViewModels = { (0...5).map { _ in FlipViewModel() } }()

   
    var date = Date(timeIntervalSince1970: 60.0 * 60.0)
    
    
    private func setupTimer() {

        

            Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true) { (Timer) in
                let currentCalendar = Calendar.current
                self.date  = currentCalendar.date(byAdding: .second, value: -1, to: self.date)!
                let formatter = DateFormatter()
                formatter.timeZone = TimeZone(abbreviation: "UTC")
                formatter.dateFormat = "HHmmss"
                let new = formatter.string(from: self.date)
                self.setTimeInViewModels(time: new)
               }
            
        }

    private func setTimeInViewModels(time: String) {
        zip(time, flipViewModels).forEach { number, viewModel in
            viewModel.text = "\(number)"
        }
    }

    

}
