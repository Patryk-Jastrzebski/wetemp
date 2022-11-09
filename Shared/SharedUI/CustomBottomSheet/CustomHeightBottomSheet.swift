import SwiftUI
import Introspect

enum DragLimitType {
    case bottom
    case top
    case all
    case none
}

struct CustomHeightBottomSheet<HeaderContent: View,
                               ScrollViewContent: View,
                               StaticContent: View>: View {
    
    @StateObject var viewModel: CustomHeightBottomSheetViewModel
    @Binding var showSheet: Bool
    var opacity: Double
    @Binding var detents: [CustomHeightDetent]
    var backgroundColor: Color
    let header: HeaderContent
    let scrollViewContent: ScrollViewContent
    let staticContent: StaticContent
    let shadowRadius: CGFloat
    let coversParentView: Bool
    
    init(detents: Binding<[CustomHeightDetent]>,
         showSheet: Binding<Bool>,
         backgroundColor: Color,
         dragLimitType: DragLimitType = .none,
         shadowRadius: CGFloat = .zero,
         coversParentView: Bool = false,
         opacity: Double = 1,
         @ViewBuilder header: () -> HeaderContent,
         @ViewBuilder scrollViewContent: () -> ScrollViewContent,
         @ViewBuilder staticContent: () -> StaticContent) {
        _viewModel = StateObject(wrappedValue: CustomHeightBottomSheetViewModel(isPresented: showSheet.wrappedValue,
                                                                                detents: detents.wrappedValue,
                                                                                dragLimitType: dragLimitType))
        _showSheet = showSheet
        _detents = detents
        self.shadowRadius = shadowRadius
        self.backgroundColor = backgroundColor
        self.coversParentView = coversParentView
        self.opacity = opacity
        self.header = header()
        self.scrollViewContent = scrollViewContent()
        self.staticContent = staticContent()
    }
    
    var body: some View {
        VStack(alignment: .center) {
            Spacer()
            VStack(alignment: .leading, spacing: 0) {
                header
                    .frame(maxWidth: .infinity)
                    .gesture(DragGesture(minimumDistance: 2, coordinateSpace: .named("screen"))
                        .onChanged { gesture in
                            Task {
                                viewModel.handleOnChangeDragGesture(gesture.translation.height)
                            }
                        }
                        .onEnded { endGesture in
                            Task {
                                viewModel.handleOnEndDragGesture(endGesture)
                            }
                        })
                ZStack(alignment: .top) {
                    staticContent
                        .gesture(DragGesture(minimumDistance: 2, coordinateSpace: .named("screen"))
                            .onChanged { gesture in
                                Task {
                                    viewModel.handleOnChangeDragGesture(gesture.translation.height)
                                }
                            }
                            .onEnded { endGesture in
                                Task {
                                    viewModel.handleOnEndDragGesture(endGesture)
                                }
                            }
                        )
                    VStack(alignment: .leading, spacing: 0) {
                        ScrollView(.vertical, showsIndicators: false) {
                            VStack(alignment: .leading, spacing: 0) {
                                scrollViewContent
                            }
                        }
                        .introspectScrollView {
                            viewModel.simultaneouslyScrollViewHandler.register(scrollView: $0, allSheetStates: viewModel.detents)
                        }
                    }
                }
            }
            .background(
                backgroundColor
                    .cornerRadius(16)
                    .shadow(radius: shadowRadius)
                    .gesture(DragGesture(minimumDistance: 2, coordinateSpace: .named("screen"))
                        .onChanged { gesture in
                            Task {
                                viewModel.handleOnChangeDragGesture(gesture.translation.height)
                            }
                        }
                        .onEnded { endGesture in
                            Task {
                                viewModel.handleOnEndDragGesture(endGesture)
                            }
                        }
                    )
            )
            .frame(width: nil, height: viewModel.dragOffset.height, alignment: .top)
            .animation(.interpolatingSpring(stiffness: 100, damping: 15), value: viewModel.dragOffset.height)
        }
        .background(
            VStack(alignment: .center, spacing: 0, content: {
                if coversParentView,
                   showSheet {
                    Color.black.opacity(0.3)
                        .ignoresSafeArea()
                        .gesture(DragGesture(minimumDistance: 2, coordinateSpace: .named("screen"))
                            .onChanged { gesture in
                                Task {
                                    viewModel.handleOnChangeDragGesture(gesture.translation.height)
                                }
                            }
                            .onEnded { endGesture in
                                Task {
                                    viewModel.handleOnEndDragGesture(endGesture)
                                }
                            }
                        )
                        .onTapGesture {
                            showSheet = false
                        }
                }
            })
            .opacity(showSheet ? 1 : 0)
        )
        .animation(.interpolatingSpring(stiffness: 100, damping: 15), value: showSheet)
        .onChange(of: detents, perform: { newValue in
            viewModel.detents = newValue
        })
        .onChange(of: showSheet, perform: { newValue in
            viewModel.isPresented = newValue
        })
        .onChange(of: viewModel.isPresented, perform: { newValue in
            showSheet = newValue
        })
        .edgesIgnoringSafeArea(.bottom)
        .coordinateSpace(name: "screen")
        .transaction { transaction in
            if !viewModel.allowsAnimation {
                transaction.animation = nil
            }
        }
        .opacity(opacity)
    }
}
