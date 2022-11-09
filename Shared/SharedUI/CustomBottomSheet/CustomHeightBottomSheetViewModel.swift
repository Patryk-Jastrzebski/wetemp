import Combine
import SwiftUI

class CustomHeightBottomSheetViewModel: ObservableObject {
    @Published var dragOffset = CGSize(width: 0, height: 0)
    @Published var detents: [CustomHeightDetent] = []
    @Published var currentSnapValue: CustomHeightDetent?
    @Published var isPresented = false
    
    @Published var allowsAnimation = false
    
    private(set) var cancellables: Set<AnyCancellable> = []
    var simultaneouslyScrollViewHandler = CustomHeightBottomSheetHandler()
    var dragLimitType: DragLimitType
    // MARK: - Init
    init(isPresented: Bool,
         detents: [CustomHeightDetent] = [],
         dragLimitType: DragLimitType = .none) {
        
        self.dragLimitType = dragLimitType
        self.isPresented = isPresented
        self.detents = detents
        setupBindings()
    }
    
    // MARK: - Bindings
    fileprivate func setupBindings() {
        $isPresented
            .filter({ $0 == true })
            .removeDuplicates()
            .debounce(for: .seconds(1), scheduler: RunLoop.main)
            .assign(to: &$allowsAnimation)
        
        $isPresented
            .removeDuplicates()
            .sink { [weak self] value in
                if !value {
                    self?.hideSheet()
                } else {
                    self?.showLowestSheet()
                }
            }
            .store(in: &cancellables)
        
        simultaneouslyScrollViewHandler.viewOffsetPublisher
            .sink { [weak self] value in
                self?.handleOnChangeDragGestureWithTask(value)
            }
            .store(in: &cancellables)
        
        simultaneouslyScrollViewHandler.panEndDraggingPublisher
            .sink { [weak self] value in
                self?.handleOnEndDragGesture(value)
            }
            .store(in: &cancellables)
        
        $currentSnapValue
            .sink { [weak self] position in
                self?.simultaneouslyScrollViewHandler.currentSheetState = position
            }
            .store(in: &cancellables)
        
        $detents
            .combineLatest($isPresented)
            .sink { [weak self] detents, isPresented in
                if isPresented {
                    self?.showLowestSheet()
                }
            }
            .store(in: &cancellables)
    }
    
    // MARK: - Bottom Sheet Methods
    func hideSheet() {
        Task {
            await hideSheetWithTask()
        }
    }
    
    @MainActor func hideSheetWithTask() async {
        self.currentSnapValue = CustomHeightDetent.zero
        bottomSheetSnapToPosition(CustomHeightDetent.zero)
    }
    
    func showLowestSheet() {
        Task {
            await showLowestSheetWithTask()
        }
    }
    
    @MainActor func showLowestSheetWithTask() async {
        if let detent = detents.filter({ $0 != .zero }).sorted(by: { $0.height < $1.height }).first {
            currentSnapValue = detent
            bottomSheetSnapToPosition(detent)
        }
    }
    
    func handleOnChangeDragGestureWithTask(_ gesture: Double) {
        Task {
            await handleOnChangeDragGesture(gesture)
        }
    }
    
    @MainActor func handleOnChangeDragGesture(_ gesture: Double)  {
        if let addedValue = currentSnapValue?.height {
            let value = addedValue - gesture
            guard value >= 0,
                  value < 5000 else { return }
            switch dragLimitType {
            case .bottom:
                if value >= Double(detents.first?.height ?? 0) {
                    dragOffset.height = value
                }
            case .top:
                if value <= Double(detents.last?.height ?? 0) {
                    dragOffset.height = value
                }
            case .all:
                if value >= Double(detents.first?.height ?? 0),
                   value <= Double(detents.last?.height ?? 0) {
                    dragOffset.height = value
                }
            case .none:
                dragOffset.height = value
            }
        }
    }
    
    @MainActor func handleOnEndDragGesture(_ endGesture: _ChangedGesture<DragGesture>.Value) {
        if let addedValue = currentSnapValue?.height {
            let predictedHeight = addedValue - endGesture.predictedEndTranslation.height
            
            let snapPosition = detents
                .sorted(by: { $0.calculateDistance(to: predictedHeight) < $1.calculateDistance(to: predictedHeight) })
                .first
            
            bottomSheetSnapToPosition(snapPosition)
        }
    }
    
    fileprivate func calculateDistanceToDetent(detent: CustomHeightDetent,
                                               predictedHeight: CGFloat) -> CGFloat {
        return abs(detent.height - predictedHeight)
    }
    
    @MainActor func bottomSheetSnapToPosition(_ position: CustomHeightDetent?) {
        dragOffset.height = position?.height ?? 0
        currentSnapValue = position
        
        if position == .zero {
            isPresented = false
        }
    }
    
    func handleOnEndDragGesture(_ double: Double) {
        let predictedHeight = dragOffset.height - double
        let snapPosition = detents
            .sorted(by: { $0.calculateDistance(to: predictedHeight) < $1.calculateDistance(to: predictedHeight) })
            .first
        
        Task {
            await bottomSheetSnapToPosition(snapPosition)
        }
    }
}
