@Entry
@Component
struct KanbanBoard {
  @State notificationsEnabled: boolean = true

  build() {
    Column() {
      // === Header ===
      Text('Kanban Board')
        .fontSize(28)
        .fontWeight(FontWeight.Bold)
        .fontColor('#1E1E1E')
        .textAlign(TextAlign.Center)
        .width('100%')
        .margin({ bottom: 16 })

      // === Notifications Row ===
      Row() {
        Text('Notifications')
          .fontSize(18)
          .fontWeight(FontWeight.Medium)
          .fontColor('#1E1E1E')
        
        Blank()
        
        Toggle({ type: ToggleType.Switch, isOn: this.notificationsEnabled })
          .onChange((isOn: boolean) => {
            this.notificationsEnabled = isOn
          })
          .selectedColor('#2563EB')
      }
      .width('100%')
      .margin({ bottom: 16 })

      // === Kanban Columns (LazyRow equivalent) ===
      Row() {
        // Column 1: To Do
        Column() {
          Text('To Do')
            .fontSize(18)
            .fontWeight(FontWeight.Medium)
            .fontColor('#2563EB')
            .margin({ bottom: 8 })
          
          Column({ space: 8 }) {
            Text('Write report')
              .fontSize(14)
              .fontColor('#1E1E1E')
              .backgroundColor('#E5E7EB')
              .borderRadius(10)
              .padding({ left: 16, right: 16, top: 8, bottom: 8 })
            
            Text('Design mockup')
              .fontSize(14)
              .fontColor('#1E1E1E')
              .backgroundColor('#E5E7EB')
              .borderRadius(10)
              .padding({ left: 16, right: 16, top: 8, bottom: 8 })
          }
        }
        .width(220)
        .height('100%')
        .backgroundColor('#FFF')
        .borderRadius(14)
        .shadow({ radius: 8, color: '#29000000', offsetY: 4 })
        .padding(12)

        // Column 2: In Progress
        Column() {
          Text('In Progress')
            .fontSize(18)
            .fontWeight(FontWeight.Medium)
            .fontColor('#2563EB')
            .margin({ bottom: 8 })
          
          Column({ space: 8 }) {
            Text('Implement feature X')
              .fontSize(14)
              .fontColor('#1E1E1E')
              .backgroundColor('#E5E7EB')
              .borderRadius(10)
              .padding({ left: 16, right: 16, top: 8, bottom: 8 })
            
            Text('Fix layout bug')
              .fontSize(14)
              .fontColor('#1E1E1E')
              .backgroundColor('#E5E7EB')
              .borderRadius(10)
              .padding({ left: 16, right: 16, top: 8, bottom: 8 })
          }
        }
        .width(220)
        .height('100%')
        .backgroundColor('#FFF')
        .borderRadius(14)
        .shadow({ radius: 8, color: '#29000000', offsetY: 4 })
        .padding(12)
        
        // Column 3: Done (Hidden in screenshot but present in code logic, added for completeness if needed, 
        // but strictly following screenshot which cuts off after In Progress. 
        // However, to be safe and match "Implement every child", I will include the structure 
        // but since the screenshot shows a horizontal scroll context, I'll stick to the visible ones 
        // or add the third one if it fits the flow. The prompt says "reproduce layout... from screenshot".
        // The screenshot shows "To Do" and "In Progress". I will implement these two clearly.)
      }
      .width('100%')
      .layoutWeight(1)
      .margin({ bottom: 16 })

      // === Task Completion Section ===
      Column() {
        Text('Task Completion')
          .fontSize(18)
          .fontWeight(FontWeight.Medium)
          .fontColor('#1E1E1E')
          .margin({ bottom: 8 })
        
        Progress({ value: 65, total: 100, type: ProgressType.Linear })
          .width('100%')
          .height(8)
          .color('#2563EB')
          .backgroundColor('#E5E7EB')
      }
    }
    .width('100%')
    .height('100%')
    .padding(16)
    .backgroundColor('#F3F4F6')
  }
}