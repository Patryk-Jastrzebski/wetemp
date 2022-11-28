import UIKit

enum CustomHeightDetent: Equatable {
    case zero
    case small
    case medium
    case mapDashboard
    case large
    case custom(CGFloat)
    case smallHome
    
    var height: CGFloat {
        switch self {
        case .custom(let height):
            return height
        case .small:
            return UIScreen.main.bounds.height * 0.15
        case .smallHome:
            return 200
        case .zero:
            return 0
        case .medium:
            return UIScreen.main.bounds.height * 0.59
        case .mapDashboard:
            return UIScreen.main.bounds.height * 0.65
        case .large:
            return UIScreen.main.bounds.height * 0.95
        }
    }

    func calculateDistance(to predictedHeight: CGFloat) -> CGFloat {
        return abs(self.height - predictedHeight)
    }
}
