
import AutoLayoutSugar
import UIKit

// MARK: - HistoryVC

final class CreateScheduleVC: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = L10n.CreateSchedule.title
        navigationController?.navigationBar.prefersLargeTitles = false
    }
}
