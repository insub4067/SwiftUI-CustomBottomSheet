//
//  ContentView.swift
//  TEST
//
//  Created by insub on 2023/05/06.
//

import SwiftUI

struct ContentView: View {
    
    @State private var isShowBottomSheet = false
    @State private var draggedY: CGFloat = .zero
    
    var body: some View {
     
        BottomSheetView(isShowBottomSheet: $isShowBottomSheet) {
            VStack {
                Text("Tap Me")
                    .onTapGesture {
                        withAnimation {
                            isShowBottomSheet = true
                        }
                    }
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        VStack {
            ContentView()
        }
    }
}
