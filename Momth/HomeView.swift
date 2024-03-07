import Foundation
import SwiftUI

struct HomeView : View {
    @State private var currentDate = Date()
    @State private var currentMonth: Int = 0
    
    var body: some View {
            VStack{
                Home2View()
                    .frame(maxWidth: .infinity, maxHeight:.infinity, alignment: .top)
                    .padding(.top, -40)
                Spacer()
            }
    }
        
}
