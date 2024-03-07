import SwiftUI

struct SecondView: View {
    @State private var selection = 0
    
    var body: some View {
        ZStack {
            Rectangle()
                .fill(Color.white)
                .opacity(0.5)
                .edgesIgnoringSafeArea(.all)
            
            TabView(selection: $selection) {
                BabyView()
                    .tabItem {
                        Image(systemName: "figure.child")
                           
                    }
                    .tag(1)
                
                HomeView()
                    .tabItem {
                        Image(systemName: "house.fill")
                    }
                    .tag(0)
                
                MomView()
                    .tabItem {
                        Image(systemName: "person.fill")
                    }
                    .tag(2)
            }
        }
    }
}
