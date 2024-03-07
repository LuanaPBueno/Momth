import SwiftUI

struct MomView: View {
    @State private var name: String = UserDefaults.standard.string(forKey: "name") ?? ""
    @State private var idade: String = UserDefaults.standard.string(forKey: "name") ?? ""
    @State private var email: String = UserDefaults.standard.string(forKey: "name") ?? ""
    @State private var senha: String = UserDefaults.standard.string(forKey: "name") ?? ""
    @State private var isFocused: Bool = false
    @State private var bio: String = UserDefaults.standard.string(forKey: "bio") ?? ""
    
    @State private var profileImage: UIImage? = {
        guard let imageData = UserDefaults.standard.data(forKey: "profileImage") else {
            return nil
        }
        return UIImage(data: imageData)
    }()
    @State private var textWidth: CGFloat = 0
    @State private var isImagePickerPresented: Bool = false
    
    var body: some View {
        ZStack{
            Image("background3")
                .resizable()
                .scaledToFill()
                .ignoresSafeArea()
            VStack {
                VStack(spacing: 20) {
                    Text(" ")
                    Text(" ")
                    Button(action: {
                        self.isImagePickerPresented = true
                    }) {
                        profileImageIcon
                    }
                    .sheet(isPresented: $isImagePickerPresented) {
                        ImagePicker(selectedImage: self.$profileImage)
                    }
                    
                    VStack {
                        VStack {
                            Group{
                                TextField("First Name", text: $name)
                                    .foregroundColor(.primary)
                                    .frame(width: 150, alignment: .center)
                                    .multilineTextAlignment(.center)
                                    .padding(EdgeInsets(top: 10, leading: 5, bottom: 10, trailing: 5))
                                    .background(Color("ColorGreen"))
                                    .cornerRadius(16)
                                    .position(x: 200, y: -7)
                            }
                              
                        }
                    }
                    Spacer()
                    
                    TextField("age", text: $idade)
                        .padding(EdgeInsets(top: 8, leading: 15, bottom: 8, trailing: 15))
                        .background(Color.gray)
                        .cornerRadius(10)
                        .padding(.horizontal, 30)
                    
                    
                    TextField("email", text: $email)
                        .padding(EdgeInsets(top: 8, leading: 20, bottom: 8, trailing: 15))
                        .background(Color.gray)
                        .cornerRadius(10)
                        .padding(.horizontal, 30)
                    
                    SecureField("password", text: $senha)
                        .padding(EdgeInsets(top: 8, leading: 15, bottom: 8, trailing: 15))
                        .background(Color.gray)
                        .cornerRadius(10)
                        .padding(.horizontal, 30)
                       
                    
                    
                    Button(action: {
                        saveProfile()
                    }) {
                        Text("Save")
                            .padding()
                            .background(Color("ColorGreen"))
                            .foregroundColor(.white)
                            .cornerRadius(10)
                    }
                    .padding(.bottom, 150)
                }
                Spacer()
            }
            .navigationTitle("Perfil")
            .onDisappear {
                saveProfile()
            }
        }
        .navigationBarHidden(true)
    }
        private func saveProfile() {
            UserDefaults.standard.set(name, forKey: "name")
            UserDefaults.standard.set(bio, forKey: "bio")
            
            if let image = profileImage, let imageData = image.jpegData(compressionQuality: 0.5) {
                UserDefaults.standard.set(imageData, forKey: "profileImage")
            } else {
                UserDefaults.standard.removeObject(forKey: "profileImage")
            }
        }
    
    
    var profileImageIcon: some View {
        ZStack{
            
            Circle()
                .foregroundColor(Color("ColorGreen"))
                .frame(width: 170, height: 170,alignment: .center)
                .padding(.top,50)
            if let profileImage {
                Image(uiImage: profileImage)
                    .resizable()
                    .scaledToFill()
                    .frame(width: 150, height: 150)
                    .clipShape(Circle())
                    .shadow(radius: 10)
                    .padding(.top,50)

            }
        }
    }
}



struct ImagePicker: UIViewControllerRepresentable {
    @Binding var selectedImage: UIImage?
    @Environment(\.presentationMode) var presentationMode

    func makeUIViewController(context: Context) -> UIImagePickerController {
        let imagePicker = UIImagePickerController()
        imagePicker.delegate = context.coordinator
        return imagePicker
    }

    func updateUIViewController(_ uiViewController: UIImagePickerController, context: Context) {}

    func makeCoordinator() -> Coordinator {
        Coordinator(parent: self)
    }

    class Coordinator: NSObject, UINavigationControllerDelegate, UIImagePickerControllerDelegate {
        let parent: ImagePicker

        init(parent: ImagePicker) {
            self.parent = parent
        }

        func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
            if let uiImage = info[.originalImage] as? UIImage {
                parent.selectedImage = uiImage
            }

            parent.presentationMode.wrappedValue.dismiss()
        }
    }
}


struct MomView_Previews: PreviewProvider {
    static var previews: some View {
        MomView()
    }
}
