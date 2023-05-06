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
        VStack {
            Text("Tap Me")
                .onTapGesture {
                    withAnimation {
                        isShowBottomSheet = true
                    }
                }
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .blur(radius: isShowBottomSheet ? 10 : 0)
        .overlay { Background() }
        .overlay(alignment: .bottom, content: BottomSheet)
        .edgesIgnoringSafeArea(.bottom)
        .onChange(of: isShowBottomSheet, perform: didChage(_:))
    }
}

// MARK: - BottomSheet
private extension ContentView {
    
    func Background() -> some View {
        Color.black
            .opacity(0.76)
            .onTapGesture {
                withAnimation { isShowBottomSheet = false }
            }
            .ignoresSafeArea()
            .isShow(isShowBottomSheet)
    }
    
    @ViewBuilder
    func BottomSheet() -> some View {
        BottonSheetContent()
            .padding(.horizontal, 16)
            .frame(maxWidth: .infinity)
            .padding(.bottom, Helper.safeAreaBottomInset)
            .padding(.bottom, 50)
            .background(Color.white)
            .cornerRadius(24, corners: [.topLeft, .topRight])
            .offset(y: 50)
            .offset(y: draggedY)
            .gesture(
                DragGesture()
                    .onChanged(didDrag(_:))
                    .onEnded(endDrag(_:))
            )
            .transition(.move(edge: .bottom))
            .animation(.easeIn, value: isShowBottomSheet)
            .isShow(isShowBottomSheet)
    }
    
    @ViewBuilder
    func BottonSheetContent() -> some View {
        VStack(alignment: .leading, spacing: 4) {
            RoundedRectangle(cornerRadius: 100)
                .frame(width: 48, height: 4)
                .foregroundColor(.gray)
                .padding(.top, 12)
                .padding(.bottom, 8)
                .frame(maxWidth: .infinity)
            Text("Title")
                .font(.title)
                .padding(.leading, 4)
                .padding(.vertical, 4)
            Text("- Content")
                .font(.caption)
            Text("- Content")
                .font(.caption)
            Text("- Content")
                .font(.caption)
            Text("- Content")
                .font(.caption)
            Text("- Content")
                .font(.caption)
            Text("- Content")
                .font(.caption)
        }
    }
}

// MARK: - Bottom Sheet Drag Gesture
private extension ContentView {
    func didDrag(_ value: DragGesture.Value) {
        guard value.translation.height > -50 else { return }
        withAnimation { draggedY = value.translation.height }
    }
    
    func endDrag(_ value: DragGesture.Value) {
        let hasDragEnough = (value.translation.height > 100)
        
        if hasDragEnough { withAnimation { isShowBottomSheet = false } }
        else { withAnimation { draggedY = .zero } }
    }
    
    func didChage(_ value: Bool) {
        guard !value else { return }
        withAnimation { self.draggedY = .zero }
    }
}

extension View {
    
    @ViewBuilder
    func isShow(_ state: Bool) -> some View {
        if state {
            self
        }
    }
    
    @ViewBuilder
    func cornerRadius(_ radius: CGFloat, corners: UIRectCorner) -> some View {
        clipShape( RoundedCorner(radius: radius, corners: corners) )
    }
}

struct Helper {
    static var safeAreaBottomInset: CGFloat {
        let keyWindow = UIApplication.shared.connectedScenes
            .filter { $0.activationState == .foregroundActive }
            .map { $0 as? UIWindowScene }
            .compactMap { $0 }
            .first?.windows
            .filter { $0.isKeyWindow }.first

        return (keyWindow?.safeAreaInsets.bottom) ?? 34
    }
    
    static var safeAreaTopInset: CGFloat {
        let keyWindow = UIApplication.shared.connectedScenes
            .filter { $0.activationState == .foregroundActive }
            .map { $0 as? UIWindowScene }
            .compactMap { $0 }
            .first?.windows
            .filter { $0.isKeyWindow }.first

        return (keyWindow?.safeAreaInsets.top) ?? 34
    }
}

struct RoundedCorner: Shape {

    var radius: CGFloat = .infinity
    var corners: UIRectCorner = .allCorners

    func path(in rect: CGRect) -> Path {
        let path = UIBezierPath(roundedRect: rect, byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius))
        return Path(path.cgPath)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        VStack {
            ContentView()
        }
    }
}
