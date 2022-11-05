//
//  ContentView.swift
//  wetemp
//
//  Created by Patryk Jastrzębski on 01/11/2022.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        ZStack {
            BottomSheet { Dashboard() }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
