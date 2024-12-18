protocol TasksStorageProtocol {
    func loadTasks() -> [TaskProtocol]
    func saveTasks(_ tasks: [TaskProtocol])
}

class TasksStorage: TasksStorageProtocol {
    func loadTasks() -> [any TaskProtocol] {
        let testTasks: [TaskProtocol] = [
            Task(title: "Купить хлеб", type: .normal, status: .planned),
            Task(title: "Помыть кота", type: .normal, status: .planned),
            Task(title: "Отдать долг", type: .important, status: .completed),
            Task(title: "Сделать покушать", type: .important, status: .planned),
            Task(title: "Помыть кота", type: .important, status: .planned),
        ]
        return testTasks
    }

    func saveTasks(_ tasks: [any TaskProtocol]) {}
}
