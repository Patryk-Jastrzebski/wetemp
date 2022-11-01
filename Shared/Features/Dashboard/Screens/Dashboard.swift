//
//  Dashboard.swift
//  wetemp
//
//  Created by Patryk Jastrzębski on 01/11/2022.
//

import SwiftUI

struct Dashboard: View {
    @State var sheet: Bool = true
    @State var offset: CGFloat = 0
    var body: some View {
        ZStack {
            Gradients.dayBackgroundGradient
                .ignoresSafeArea()
            VStack(spacing: 5) {
                temperature
                temperatureDescription
                Spacer()
            }
            GeometryReader { reader in
                VStack {
                    BottomSheet()
                        .offset(y: reader.frame(in: .global).height - 200)
                        .offset(y: offset)
                        .gesture(DragGesture().onChanged({
                            value in
                            withAnimation {
                                if value.startLocation.y > reader.frame(in: .global).minX {
                                    offset = value.translation.height
                                }
                                
                                if value.startLocation.y < reader.frame(in: .global).minX {
                                    offset = (-reader.frame(in: .global).height + 200) + value.translation.height
                                }
                            }
                        }).onEnded({ value in
                            withAnimation {
                                if value.startLocation.y > reader.frame(in: .global).midX {
                                    if -value.translation.height > reader.frame(in: .global).midX {
                                        offset = (-reader.frame(in: .global).height + 200)
                                        return
                                    }
                                    offset = 0
                                }
                                
                                if value.startLocation.y < reader.frame(in: .global).midX {
                                    if value.translation.height < reader.frame(in: .global).midX {
                                        offset = (-reader.frame(in: .global).height + 200)
                                        return
                                    }
                                    offset = 0
                                }
                            }
                        }))
                }
            }
            .ignoresSafeArea(.all, edges: .bottom)
        }
        .foregroundColor(.white)
    }
}

//struct Dashboard_Previews: PreviewProvider {
//    static var previews: some View {
//        Dashboard()
//    }
//}

extension Dashboard {
    private var temperature: some View {
        VStack(spacing: 0) {
            Image("sun")
            Text("8°")
                .font(.system(size: 88))
                .fontWeight(.medium)
            
                .padding(.top, -80)
        }
    }
    
    private var temperatureDescription: some View {
        VStack(spacing: 5) {
            Text("Katowice")
                .font(.system(size: 24))
                .fontWeight(.bold)
            Text("tue., 1.11")
                .font(.system(size: 20))
                .fontWeight(.bold)
            Text("little windy today, dress warmly")
                .font(.system(size: 18))
                .fontWeight(.semibold)
        }
    }
}

struct BottomSheet: View {
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
            
        }
    }
}

struct BlurView: UIViewRepresentable {
    let style: UIBlurEffect.Style
    
    func updateUIView(_ uiView: UIViewType, context: Context) {
        
    }

    func makeUIView(context: Context) -> some UIVisualEffectView {
        let view = UIVisualEffectView(effect: UIBlurEffect(style: style))
        return view
    }
}
