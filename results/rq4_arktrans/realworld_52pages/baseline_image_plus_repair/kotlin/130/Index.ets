import { BusinessError } from '@kit.BasicServicesKit';
import { common, UIAbility, Want } from '@kit.AbilityKit';
import { window } from '@kit.ArkUI';

@Entry
@Component
struct TodoApp {
  @State todoList: TodoItem[] = [
    new TodoItem(1, "Buy groceries", Priority.HIGH, "Milk, eggs, bread, and vegetables for the week"),
    new TodoItem(2, "Finish report", Priority.HIGH, "Complete the quarterly report for the team meeting"),
    new TodoItem(3, "Call dentist", Priority.MEDIUM, "Schedule a checkup appointment for next month"),
    new TodoItem(4, "Read a book", Priority.LOW, "Finish reading Clean Code by Robert C. Martin"),
    new TodoItem(5, "Plan weekend trip", Priority.MEDIUM, "Research hotels and activities for the getaway"),
    new TodoItem(6, "Organize desk", Priority.LOW, "Clean and organize the home office workspace")
  ];

  build() {
    Column() {
      // Top Bar
      Row() {
        Text("ToDo List")
          .fontSize(28)
          .fontWeight(FontWeight.Bold)
          .fontColor(Color.White)
          .margin({ left: 16 })

        Blank()

        // Search Icon (Placeholder)
        Image($r('app.media.search')) 
          .width(24)
          .height(24)
          .fillColor(Color.White)
          .margin({ right: 16 })
        
        // More Icon (Placeholder)
        Image($r('app.media.more_vert')) 
          .width(24)
          .height(24)
          .fillColor(Color.White)
          .margin({ right: 16 })
      }
      .width('100%')
      .height(70)
      .backgroundColor('#6750A4') // Material You Primary Purple
      .justifyContent(FlexAlign.SpaceBetween)
      .alignItems(VerticalAlign.Center)

      // Content Area
      Scroll() {
        Grid() {
          ForEach(this.todoList, (item: TodoItem) => {
            GridItem() {
              TodoCard({ item: item })
            }
          }, (item: TodoItem) => item.id.toString())
        }
        .columnsTemplate('1fr 1fr')
        .rowsGap(12)
        .columnsGap(12)
        .padding(12)
      }
      .layoutWeight(1)
      .backgroundColor('#F5F5F5') // Light background

      // Floating Action Button
      RelativeContainer() {
        Row() {
          Image($r('app.media.add'))
            .width(32)
            .height(32)
            .fillColor(Color.White)
        }
        .width(56)
        .height(56)
        .borderRadius(16)
        .backgroundColor('#6750A4')
        .shadow({ radius: 8, color: '#33000000', offsetY: 4 })
        .position({ right: 16, bottom: 16 })
      }
      .width('100%')
      .height(80)
    }
    .width('100%')
    .height('100%')
  }
}

enum Priority {
  HIGH,
  MEDIUM,
  LOW
}

class TodoItem {
  id: number;
  title: string;
  priority: Priority;
  description: string;

  constructor(id: number, title: string, priority: Priority, description: string) {
    this.id = id;
    this.title = title;
    this.priority = priority;
    this.description = description;
  }
}

@Component
struct TodoCard {
  @ObjectLink item: TodoItem;

  build() {
    Column() {
      // Priority Dot
      Row() {
        Circle()
          .width(16)
          .height(16)
          .fill(this.getPriorityColor())
      }
      .width('100%')
      .justifyContent(FlexAlign.End)
      .margin({ bottom: 8 })

      // Title
      Text(this.item.title)
        .fontSize(24)
        .fontWeight(FontWeight.Bold)
        .fontColor('#1C1B1F')
        .maxLines(2)
        .textOverflow({ overflow: TextOverflow.Ellipsis })
        .margin({ bottom: 8 })

      // Description
      Text(this.item.description)
        .fontSize(16)
        .fontColor('#49454F')
        .lineHeight(24)
        .maxLines(4)
        .textOverflow({ overflow: TextOverflow.Ellipsis })
    }
    .width('100%')
    .padding(16)
    .backgroundColor('#E6E1EB') // Light purple tint card background
    .borderRadius(16)
    .shadow({ radius: 2, color: '#1A000000', offsetY: 2 })
  }

  getPriorityColor(): ResourceColor {
    switch (this.item.priority) {
      case Priority.HIGH:
        return '#FF4646'; // Red
      case Priority.MEDIUM:
        return '#FFC114'; // Yellow/Orange
      case Priority.LOW:
        return '#00C980'; // Green
      default:
        return '#9E9E9E';
    }
  }
}