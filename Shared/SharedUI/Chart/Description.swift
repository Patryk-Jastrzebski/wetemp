//
//  Description.swift
//  wetemp
//
//  Created by Patryk Jastrzębski on 09/11/2022.
//

import SwiftUI

struct Description: View {
    let title: String
    let description: String
    var body: some View {
        VStack(alignment: .leading, spacing: 5) {
            Text(title)
                .fontWeight(.semibold)
                .font(.system(size: 22))
            Text(description)
                .font(.system(size: 16))
                .fontWeight(.regular)
                .background(.white)
                .cornerRadius(8, antialiased: true)
                .foregroundColor(.secondary)
        }
        .padding(.horizontal, -10)
    }
}

struct Description_Previews: PreviewProvider {
    static var previews: some View {
        Description(title: "Title", description: "llllowjdnviwnrjiv iwr vi erj iviejr vierij vieriv eri ive ruv ier viueiur ierrviue riuverivieurv ieiruviuveriuv iuerviu eruiv iueriuv iuer viieruviueriv eriuv")
    }
}
