// entry/src/main/ets/viewmodel/TodoViewModel.ets

export enum Priority {
  High,
  Medium,
  Low
}

export interface TodoItem {
  id: number;
  title: string;
  priority: Priority;
  description: string;
}

@Observed
export class TodoViewModel {
  private _todoList: TodoItem[] = [
    { id: 1, title: "Buy groceries", priority: Priority.High, description: "Milk, eggs, bread, and vegetables for the week" },
    { id: 2, title: "Finish report", priority: Priority.High, description: "Complete the quarterly report for the team meeting" },
    { id: 3, title: "Call dentist", priority: Priority.Medium, description: "Schedule a checkup appointment for next month" },
    { id: 4, title: "Read a book", priority: Priority.Low, description: "Finish reading Clean Code by Robert C. Martin" },
    { id: 5, title: "Plan weekend trip", priority: Priority.Medium, description: "Research hotels and activities for the getaway" },
    { id: 6, title: "Organize desk", priority: Priority.Low, description: "Clean and organize the home office workspace" }
  ];

  get todoList(): TodoItem[] {
    return this._todoList;
  }

  addItem(title: string, priority: Priority, description: string): void {
    const newItem: TodoItem = {
      id: Date.now(),
      title: title,
      priority: priority,
      description: description
    };
    this._todoList.unshift(newItem);
  }

  updateItem(id: number, title: string, priority: Priority, description: string): void {
    const index = this._todoList.findIndex(item => item.id === id);
    if (index !== -1) {
      this._todoList[index] = { id, title, priority, description };
    }
  }

  deleteItem(id: number): void {
    this._todoList = this._todoList.filter(item => item.id !== id);
  }

  clearAll(): void {
    this._todoList = [];
  }
}