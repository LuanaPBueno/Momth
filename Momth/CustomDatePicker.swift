import SwiftUI

struct CustomDatePicker: View {
    @Binding var currentDate: Date
    @State private var shouldReloadView = false
    @State var currentMonth: Int = 0
    var hasPlannedItem = false
    @State private var shouldRefresh = false
    var todaysTask: TaskMetaData? {
        return tasks.first(where: { task in
            return isSameDay(date1: task.taskDate, date2: currentDate)
        })
    }
    var body: some View {
        VStack(spacing: 35){
            
            let days: [String] = ["Sun", "Mon", "Tue", "Wed", "Thu", "Fri", "Sat"]
            let columns = Array(repeating: GridItem(.flexible()), count: 7)
            ZStack{
                Image("FundoHome")
                    .resizable()
                    .ignoresSafeArea(.all)
                VStack{
                    HStack(spacing: 50){
                        VStack(spacing: 0) {
                            Text(" ")
                            Text(" ")
                            Text(extraDate()[0])
                                .font(.caption)
                                .fontWeight(.semibold)
                            Text(extraDate()[1])
                                .font(.title.bold())
                            
                        }
                        
                        Spacer(minLength: 0)
                        
                        Button {
                            withAnimation{
                                currentMonth -= 1
                                
                            }
                        } label: {
                            Image(systemName: "chevron.left")
                                .font(.title2)
                                .foregroundColor(.green)
                        }
                        
                        Button {
                            withAnimation{
                                currentMonth += 1
                                
                            }
                        } label: {
                            Image(systemName: "chevron.right")
                                .font(.title2)
                                .foregroundColor(.green)
                        }
                        
                    }
                    .padding(.horizontal)
                    HStack(spacing: 0){
                        ForEach(days, id: \.self){day in
                            Text(day)
                                .font(.callout)
                                .fontWeight(.semibold)
                                .frame(maxWidth: .infinity)
                        }
                        
                    }
                    LazyVGrid(columns: columns,spacing: 1){
                        
                        ForEach(extractDate()){value in
                            CardView(value: value)
                                .background(
                                    Capsule()
                                        .fill(Color("ColorYellow"))
                                        .padding(.horizontal, 8)
                                        .opacity(isSameDay(date1: value.date, date2: currentDate) ? 1 : 0)
                                )
                                .onTapGesture {
                                    currentDate = value.date
                                }
                            
                        }
                    }
                    
                }
                
            }
            
            ScrollView(.vertical, showsIndicators: false) {
                VStack(spacing: 15) {
                    if let todaysTask = todaysTask {
                        ForEach(todaysTask.task) { task in
                            ZStack{
                                VStack(alignment: .leading, spacing: 10) {
                                    Text(task.time.addingTimeInterval(CGFloat.random(in: 0...5000)), style: .time)
                                    Text(task.title)
                                        .font(.title2.bold())
                                }
                                .padding(.vertical,10)
                                .padding(.horizontal,10)
                                .frame(maxWidth: 360, alignment: .leading)
                                .background(
                                    Color(.white)
                                        .opacity(0.5)
                                        .cornerRadius(10)
                                )
                                HStack {
                                    Spacer()
                                    Button(action: {
                                        removeTask(task)
                                        currentDate = .now
                                    }, label: {
                                        Image(systemName: "trash")
                                            .foregroundColor(.red)
                                        Text(" ")
                                        Text(" ")
                                    })
                                }
                            }
                        }
                    }

                    if todaysTask == nil {
                        Text("Nothing planned today")
                            .padding()
                            .frame(maxWidth: .infinity)
                    }
                }
            }
            
        }
        .id(shouldRefresh)
        .onChange(of: currentMonth) { newValue in
            currentDate = getCurrentMonth()
            shouldReloadView.toggle()
        }
    }
    
    @ViewBuilder
    func CardView(value: DateValue)->some View{
        VStack{
            if value.day != -1 {
                let hasTask = tasks.contains { task in
                    return isSameDay(date1: task.taskDate, date2: value.date)
                }
                
                let hasItem = hasTask
                
                Text("\(value.day)")
                    .font(.title3.bold())
                    .foregroundColor(isSameDay(date1: value.date, date2: currentDate) ? .white : .primary)
                    .frame(maxWidth: .infinity)
                
                Spacer()
                
                if hasItem {
                    Circle()
                        .fill(isSameDay(date1: value.date, date2: currentDate) ? .white : Color(.yellow))
                        .frame(width: 8, height: 8)
                }
            }
        }
        .padding(.vertical, 10)
        .frame(height: 60, alignment: .top)
    }
    
    func removeTask(_ taskToRemove: Task) {
        for index in tasks.indices {
            if let taskIndex = tasks[index].task.firstIndex(where: { $0.title == taskToRemove.title && $0.time == taskToRemove.time }) {
                tasks[index].task.remove(at: taskIndex)
                try? tasks.save(in: "tasks")
                shouldRefresh.toggle()
                break
            }
        }
    }

        
       
        
    
    func isSameDay(date1: Date, date2: Date)->Bool{
        let calendar = Calendar.current
        
        return calendar.isDate(date1, inSameDayAs: date2)
    }
    
    func extraDate()->[String]{
        let formatter = DateFormatter()
        formatter.dateFormat = "YYYY MMMM"
        
        let date = formatter.string(from: currentDate)
        
        return date.components(separatedBy: " ")
    }
    
    func getCurrentMonth() -> Date{
        
        let calendar = Calendar.current
        
        guard let currentMonth = calendar.date(byAdding: .month, value: self.currentMonth, to: Date()) else {
            return Date()
        }
        return currentMonth
    }
    
    func extractDate() -> [DateValue] {
        let calendar = Calendar.current
        let currentMonth = getCurrentMonth()
        
        
        var days =  currentMonth.getAllDates().compactMap { date -> DateValue in
            
            let day = calendar.component(.day, from: date)
            return DateValue(day: day, date: date)
        }
        
        let firstWeekday = calendar.component(.weekday, from: days.first?.date ?? Date())
        
        for _ in 0..<firstWeekday - 1{
            days.insert(DateValue(day: -1, date: Date()), at: 0)
        }
        
        return days
    }
}

struct CustomDatePicker_Previews: PreviewProvider{
    static var previews: some View{
        CustomDatePicker(currentDate: .constant(Date()))
    }
}

extension Date{
    func getAllDates() -> [Date] {
        let calendar = Calendar.current
        
        let startDate = calendar.date(from: Calendar.current.dateComponents([.year, .month], from: self))!
        
        let range = calendar.range(of: .day, in: .month, for: self)!
        
        return range.compactMap { day -> Date in
            return calendar.date(byAdding: .day, value: day - 1 ,  to: startDate)!
        }
    }
}


//https://www.youtube.com/watch?v=UZI2dvLoPr8
