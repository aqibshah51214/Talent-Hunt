//
//  CheckboxView.swift
//  Talent-Hunt
//
//  Created by MacBook Pro on 11/03/2025.
//

import SwiftUI

struct CheckboxView: View {
    @Binding var SelectedText:Bool
  
    var text:String
    var foregroundColor:Color = Color.black
    var body: some View {
        HStack(spacing:2){
            Image(systemName:SelectedText ? "checkmark.square" : "rectangle")
                .foregroundColor(foregroundColor)
                .onTapGesture {
                   
                    SelectedText.toggle()
                }
            Text(text)
                .foregroundColor(foregroundColor)
                .bold()
        
    }
}
}

//struct CheckboxView_Previews: PreviewProvider {
//    static var previews: some View {
//        CheckboxView()
//    }
//}
