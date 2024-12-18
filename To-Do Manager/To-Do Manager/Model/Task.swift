enum TaskProperty {
    case normal, important
}

enum TaskStatus {
    case planned, completed
}

protocol TaskProtocol {
    var title: String { get set }
    var type: TaskProperty { get set }
    var status: TaskStatus { get set }
}

struct Task: TaskProtocol {
    var title: String
    var type: TaskProperty
    var status: TaskStatus
}
