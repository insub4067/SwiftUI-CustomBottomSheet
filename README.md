# SwiftUI-CustomBottomSheet

## 👀 What
순수 SwiftUI 만 사용해서 Transition, Animation 등을 구현하였습니다.  
DragGesture 을 사용했습니다.

## Sample Code
```
struct ContentView: View {
    
    @State private var isShowBottomSheet = false
    
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
```

## 📱 예시 화면
<img src="https://user-images.githubusercontent.com/85481204/236637189-cf4daf60-2949-472a-b605-86682d8cd6cb.gif" width="250">
