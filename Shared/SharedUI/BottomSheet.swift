//
//  BottomSheet.swift
//  wetemp
//
//  Created by Patryk Jastrzębski on 02/11/2022.
//

import SwiftUI


struct BottomSheet<Content: View>: View {
    @State var offset: CGFloat = 0
    let content: () -> Content
    var body: some View {
        ZStack {
            content()
            GeometryReader { reader in
                VStack {
                    BottomSheetContent()
                        .offset(y: reader.frame(in: .global).height - 200)
                        .offset(y: offset)
                        .gesture(DragGesture().onChanged({ value in
                            withAnimation {
                                if value.startLocation.y > reader.frame(in: .global).midX {
                                    if value.translation.height < 0 && offset > (-reader.frame(in: .global).height + 300) {
                                        offset = value.translation.height
                                    }
                                }
                                
                                if value.startLocation.y < reader.frame(in: .global).midX {
                                    if value.translation.height > 0 && offset < 0 {
                                        offset = (-reader.frame(in: .global).height + 300) + value.translation.height
                                    }
                                }
                            }
                        }).onEnded({ value in
                            withAnimation {
                                if value.startLocation.y > reader.frame(in: .global).midX {
                                    if -value.translation.height > reader.frame(in: .global).midX {
                                        offset = (-reader.frame(in: .global).height + 300)
                                        return
                                    }
                                    offset = 0
                                }
                                
                                if value.startLocation.y < reader.frame(in: .global).midX {
                                    if value.translation.height < reader.frame(in: .global).midX {
                                        offset = (-reader.frame(in: .global).height + 300)
                                        return
                                    }
                                    offset = 0
                                }
                            }
                        }))
                }
            }
            .ignoresSafeArea(.all, edges: .bottom)}
    }
}

struct BottomSheetContent: View {
    var body: some View {
        VStack {
            Capsule()
                .fill(Color.gray.opacity(0.5))
                .frame(width: 50, height: 5)
                .padding(.top)
                .padding(.bottom, 5)
            HStack {
                Spacer()
            }
            Spacer()
                .frame(height: 1000)
            
        }
        .background(BlurView(style: .systemMaterial))
        .cornerRadius(15)
        
        ScrollView(.vertical, showsIndicators: false) {
            // TODO: Add content
        }
    }
}
