//
//  File.swift
//  
//
//  Created by 최진용 on 2023/04/16.
//

import SwiftUI


struct MenuRow: View {
    let title: String
    let description: String
    let image: String
    
    var icon: some View {
        Image(image)
            .frame(width: 50)
            .font(Font.system(size: 40))
            .foregroundColor(.accentColor)
    }
    
    var text: some View {
        VStack(alignment: .leading) {
            Text(title)
                .font(.title3)
                .fontWeight(.bold)
                .padding(.bottom, 2)
            Text(description)
                .foregroundColor(.secondary)
                .fixedSize(horizontal: false, vertical: true)
        }.padding(10)
    }
    
    var body: some View {
        HStack {
            icon
            text
        }
    }
}
//
//struct MenuView_Preview: PreviewProvider {
//    static var previews: some View {
//
//    }
//}
