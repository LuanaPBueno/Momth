import SwiftUI

struct FirstView: View {
    @State private var email = ""
    @State private var password = ""
    
    var body: some View {
//        NavigationStack{
//            ZStack{
//                Image("background")
//                    .resizable()
//                    .ignoresSafeArea()
//                VStack(spacing: 20) {
//                    Spacer()
//                    Spacer()
//                    TextField("Email", text: $email)
//                        .padding(EdgeInsets(top: 8, leading: 15, bottom: 8, trailing: 15))
//                        .background(Color.white)
//                        .cornerRadius(20)
//                        .padding(.horizontal, 45)
//                    
//                    SecureField("Senha", text: $password)
//                        .padding(EdgeInsets(top: 8, leading: 15, bottom: 8, trailing: 15))
//                        .background(Color.white)
//                        .cornerRadius(20)
//                        .padding(.horizontal,45)
//                  
//                    NavigationLink(destination: SecondView()){
//                        Text("Entrar")
//                            .foregroundColor(.white)
//                            .padding(EdgeInsets(top: 9, leading: 80, bottom: 9, trailing: 80))
//                            .padding(.horizontal,50)
//                            .background(Color("ColorGreen"))
//                            .cornerRadius(20)
//                           
//                            
//                            
//                        
//                    }
//                    HStack{
//                        Text("não possui conta?")
//                            .opacity(0.5)
//                          
//                        Text("Registre-se")
//                            .foregroundColor(.white)
//                            .opacity(0.5)
//                           
//                    }
//                    .padding(.bottom, 210 )
//                    .padding(.vertical, 5)
//                    .edgesIgnoringSafeArea(.all)
//                    
//                }
//            }
//        }
        SecondView()
    }
}

    struct FirstView_Previews: PreviewProvider {
        static var previews: some View {
            FirstView()
        }
    }

