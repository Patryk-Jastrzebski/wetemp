import UIKit
import Combine

class CustomHeightBottomSheetHandler: NSObject {
    private weak var scrollingScrollView: UIScrollView?
    private let viewOffsetSubject = PassthroughSubject<Double, Never>()
    private let panEndDraggingSubject = PassthroughSubject<Double, Never>()
    var currentSheetState: CustomHeightDetent?
    var allSheetStates: [CustomHeightDetent] = []
    
    var viewOffsetPublisher: AnyPublisher<Double, Never> {
        viewOffsetSubject.eraseToAnyPublisher()
    }
    
    var panEndDraggingPublisher: AnyPublisher<Double, Never> {
        panEndDraggingSubject.eraseToAnyPublisher()
    }
    
    func register(scrollView: UIScrollView, allSheetStates: [CustomHeightDetent]) {
        guard scrollingScrollView == nil else { return }
        self.allSheetStates = allSheetStates
        scrollView.alwaysBounceVertical = false
        scrollView.delegate = self
        
        let scrollViewPanGesture = UIPanGestureRecognizer(target: self, action: #selector(onPan(_:)))
        scrollViewPanGesture.delegate = self
        scrollView.addGestureRecognizer(scrollViewPanGesture)
        
        scrollingScrollView = scrollView
    }
    
    @objc func onPan(_ gestureRecognizer: UIPanGestureRecognizer) {
        viewOffsetSubject.send(gestureRecognizer.translation(in: nil).y)
        
        if gestureRecognizer.state == UIGestureRecognizer.State.ended {
            let yVelocity = gestureRecognizer.velocity(in: nil).y
            panEndDraggingSubject.send(yVelocity)
        }
    }
}

extension CustomHeightBottomSheetHandler: UIScrollViewDelegate, UIGestureRecognizerDelegate {
    func gestureRecognizerShouldBegin(_ gestureRecognizer: UIGestureRecognizer) -> Bool {
        guard let pan = gestureRecognizer as? UIPanGestureRecognizer else {
            return false
        }
        
        if currentSheetState == allSheetStates.sorted(by: { $0.height > $1.height }).first {
            if scrollingScrollView?.contentOffset.y == 0 {
                return pan.translation(in: nil).y > 0
            } else {
                return false
            }
        } else {
            if scrollingScrollView?.contentOffset.y == 0 {
                return true
            } else {
                return pan.translation(in: nil).y < 0
            }
        }
    }
}
