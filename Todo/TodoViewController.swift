//
//  TodoViewController.swift
//  Todo
//
//  Created by 영현 on 1/9/24.
//
// CRUD 먼저 정확하게 구현하기!

import UIKit

class TodoViewController: UIViewController {
    
    //MARK: Variables in TodoViewController
    
    var todoList: [Todo] = [Todo(id: 0, title: "Swift 문법 살펴보기 📚", isCompleted: false, category: "Swift"),
                            Todo(id: 1, title: "Storyboard 살펴보기 🖥️", isCompleted: false, category: "Swift"),
                            Todo(id: 2, title: "장 보러 다녀오기 🥬", isCompleted: false, category: "Life"),
                            Todo(id: 3, title: "청소기 돌려두기 🧹", isCompleted: false, category: "Life"),
                            Todo(id: 4, title: "빨래하기 👕", isCompleted: false, category: "Life"),
                            Todo(id: 5, title: "우편함 정리하기 📮", isCompleted: false, category: "Life")]
    
    var sections: [String: [Todo]] = [:]
    var userDefault = UserDefaults.standard
    @IBOutlet weak var TodoTableView: UITableView!
    
    //MARK: Functions in TodoViewController
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setSection()
        
        TodoTableView.delegate = self
        TodoTableView.dataSource = self
        print(userDefault.dictionaryRepresentation())
    }
    
    //MARK: Organize Sections
    func setSection() {
        sections = [:]
        
        for todo in todoList {
            if sections[todo.category] == nil {
                sections[todo.category] = [todo]
                userDefault.setValue(todo.title, forKey: "\(todo.id)")
            } else {
                sections[todo.category]?.append(todo)
                userDefault.setValue(todo.title, forKey: "\(todo.id)")
            }
        }
    }

    
    @IBAction func addTodo(_ sender: Any) {
        let alertForAddTodo = UIAlertController(title: "Todo 추가", message: nil, preferredStyle: .alert)
        
        alertForAddTodo.addTextField{ textField in
            textField.placeholder = "내용을 입력하세요."
        }
        alertForAddTodo.addTextField{ textField in
            textField.placeholder = "카테고리를 입력하세요."
        }
        
        let confirmAction = UIAlertAction(title: "추가", style: .default){ [weak self] _ in
            guard let self else { return }
            if let title = alertForAddTodo.textFields?[0].text, !title.isEmpty, let cat = alertForAddTodo.textFields?[1].text, !cat.isEmpty {
                let newItem = Todo(id: (todoList.last?.id ?? -1) + 1, title: title, isCompleted: false, category: cat)
                
                todoList.append(newItem)
                setSection()
                userDefault.set(title, forKey: "\(newItem.id)")
                TodoTableView.reloadData()
            } else {
                let missingTitleAlert = UIAlertController(title: "내용이 모두 입력되지 않았습니다.", message: "빈 칸이 있는지 확인하십시오.", preferredStyle: .alert)
                let confirm = UIAlertAction(title: "확인", style: .default)
                
                missingTitleAlert.addAction(confirm)
                present(missingTitleAlert, animated: true)
            }
        }
        
        let rejectAction = UIAlertAction(title: "취소", style: .cancel)
        
        alertForAddTodo.addAction(confirmAction)
        alertForAddTodo.addAction(rejectAction)
        present(alertForAddTodo, animated: true)
    }
    
    
}

//MARK: TableView Function Extension
extension TodoViewController: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return sections.keys.count
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return Array(sections.keys)[section]
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let category = Array(sections.keys)[section]
        return sections[category]?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = TodoTableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! TodoTableViewCell
        
        let category = Array(sections.keys)[indexPath.section]
        if let todosInSection = sections[category] {
            let todo = todosInSection[indexPath.row]
            cell.todoLabel?.text = todo.title
            cell.isCompletedSwitch?.isOn = todo.isCompleted
        }
        return cell
    }
    
    //MARK: Delete Cell
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            let category = Array(sections.keys)[indexPath.section]
            if var todosInSection = sections[category] {
                let deletedTodo = todosInSection.remove(at: indexPath.row)
                if let indexInTodoList = todoList.firstIndex(where: { $0.id == deletedTodo.id }) {
                    todoList.remove(at: indexInTodoList)
                }
                userDefault.removeObject(forKey: "\(deletedTodo.id)")
                sections[category] = todosInSection
                tableView.deleteRows(at: [indexPath], with: .fade)
                
                if todosInSection.isEmpty {
                    sections.removeValue(forKey: category)
                }
                tableView.reloadData()
            }
        }
    }
    
    //MARK: Modifying Cell
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        let alertForModify = UIAlertController(title: "내용 수정", message: nil, preferredStyle: .alert)
        
        let category = Array(sections.keys)[indexPath.section]
        if let todoInSections = sections[category] {
            let todo = todoInSections[indexPath.row]
            alertForModify.addTextField() { textfield in
                textfield.text = todo.title
            }
            alertForModify.addTextField() { textfield in
                textfield.text = todo.category
            }
        }
        // UIAlertAction, UIAlertController는 ViewController와 생명주기가 같으니... guard let self 구문은 성능 악화를 일으킬 수 있음...
        let confirmModifyAction = UIAlertAction(title: "확인", style: .default) { [weak self] _ in
            guard let self else { return }
            let category = Array(self.sections.keys)[indexPath.section]
            if var todoInSections = self.sections[category], let title = alertForModify.textFields?[0].text, let cat = alertForModify.textFields?[1].text, !title.isEmpty, !cat.isEmpty {
                var todo = todoInSections[indexPath.row]
                todo.title = title
                todo.category = cat
                todoInSections[indexPath.row] = todo
                
                self.sections[category] = todoInSections
                
                userDefault.set(title, forKey: "\(todo.id)")
                setSection()
                TodoTableView.reloadData()
            } else {
                let noticeCannotModify = UIAlertController(title: "수정할 수 없습니다.", message: "빈 칸이 있는지 확인하세요.", preferredStyle: .alert)
                let action = UIAlertAction(title: "확인", style: .default)
                noticeCannotModify.addAction(action)
                present(noticeCannotModify, animated: true)
            }
        }
        let rejectModifyAction = UIAlertAction(title: "취소", style: .cancel)
        alertForModify.addAction(confirmModifyAction)
        alertForModify.addAction(rejectModifyAction)
        present(alertForModify, animated: true)
    }
}

