import SwiftUI
import CodableExtensions

struct Home2View: View {
    
    @State var currentDate: Date = Date()
    @State var showAddOptions: Bool = false
    @State var showAddTaskPopup: Bool = false
    @State var showAddRoutinePopup: Bool = false
    @State var showAddEventPopup: Bool = false
    @State var taskTitle: String = ""
    @State var taskTime: Date = Date()
 
    
    var body: some View {
        VStack {
            ZStack {
                Image("Fundo2")
                    .resizable()
                    .ignoresSafeArea(.all)
                    .scaledToFill()
                
                VStack {
                    Text(" ")
                    Text(" ")
                    CustomDatePicker(currentDate: $currentDate)
                    Spacer()
                }
                .padding(.vertical)
                .safeAreaInset(edge: .bottom) {
                    HStack {
                        Spacer()
                        VStack {
                            Button(action: {
                                showAddTaskPopup.toggle()
                            }) {
                                Image(systemName: "plus")
                                    .frame(width: 40, height: 40)
                                    .background(Color("ColorGreen2"), in: Capsule())
                            }
                            Text(" ")
                            Text(" ")
                                .font(.title3)
                        }
                        Spacer()
                    }
                    .padding(.horizontal)
                    .padding(.top, 15)
                    .foregroundColor(.white)
                    .popover(isPresented: $showAddTaskPopup, arrowEdge: .bottom) {
                        VStack {
                            TextField("Nome da Tarefa", text: $taskTitle)
                                .padding()
                            DatePicker("Data e Hora", selection: $taskTime, displayedComponents: [.date, .hourAndMinute])
                                .padding()
                            Button("Adicionar Tarefa") {
                                
                                let newTask = Task(title: taskTitle, time: taskTime)
                                
                                var wasFound = false
                                
                                for index in tasks.indices {
                                    if Calendar.current.isDate(currentDate, inSameDayAs: tasks[index].taskDate) {
                                        tasks[index].task.append(newTask)
                                        wasFound = true
                                    }
                                }
                                
                                if !wasFound {
                                    let newTaskMetaData = TaskMetaData(task: [newTask], taskDate: taskTime)
                                    tasks.append(newTaskMetaData)
                                }
                                
                                try? tasks.save(in: "tasks")
                                
                                currentDate = taskTime
                                showAddTaskPopup.toggle()
                            }
                            .padding()
                        }
                    }
                }
            }
        }
        .navigationBarHidden(true)
    }
}
