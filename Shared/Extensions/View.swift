//
//  View.swift
//  wetemp
//
//  Created by Patryk Jastrzębski on 04/12/2022.
//

import SwiftUI

extension View {
    func onLoad(perform action: (() -> Void)? = nil) -> some View {
        modifier(ViewDidLoadModifier(perform: action))
    }
}
