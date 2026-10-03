import { router } from '@kit.ArkUI';

interface KanbanColumnData {
  title: string;
  tasks: string[];
}

@Entry
@Component
struct RootScreen {
  @State notificationsEnabled: boolean = true;

  private columns: KanbanColumnData[] = [
    { title: 'To Do', tasks: ['Write report', 'Design mockup'] },
    { title: 'In Progress', tasks: ['Implement feature X', 'Fix layout bug'] },
    { title: 'Done', tasks: ['Team sync', 'Client feedback'] }
  ];

  build() {
    Column() {
      // Top Bar
      Row() {
        Text('Kanban Board')
          .fontSize(28)
          .fontWeight(FontWeight.Bold)
          .fontColor('#1E1E1E')
      }
      .width('100%')
      .height(56)
      .backgroundColor('#F3F4F6')
      .justifyContent(FlexAlign.Center)
      .alignItems(VerticalAlign.Center)

      // Content
      Column() {
        // Notifications Row
        Row() {
          Text('Notifications')
            .fontSize(18)
            .fontWeight(FontWeight.Medium)
            .fontColor('#1E1E1E')

          Toggle({ type: ToggleType.Switch, isOn: this.notificationsEnabled })
            .onChange((isOn: boolean) => {
              this.notificationsEnabled = isOn;
            })
            .selectedColor('#2563EB')
        }
        .width('100%')
        .justifyContent(FlexAlign.SpaceBetween)
        .alignItems(VerticalAlign.Center)
        .margin({ bottom: 16 })

        // Kanban Columns - Horizontal Scroll
        Scroll() {
          Row({ space: 12 }) {
            ForEach(this.columns, (col: KanbanColumnData) => {
              Column({ space: 8 }) {
                Text(col.title)
                  .fontSize(18)
                  .fontWeight(FontWeight.Medium)
                  .fontColor('#2563EB')
                  .margin({ bottom: 4 })

                ForEach(col.tasks, (task: string) => {
                  Row() {
                    Text(task)
                      .fontSize(14)
                      .fontWeight(FontWeight.Normal)
                      .fontColor('#1E1E1E')
                      .padding({ left: 8, right: 8, top: 6, bottom: 6 })
                  }
                  .backgroundColor('#E5E7EB')
                  .borderRadius(10)
                  .width('100%')
                  .alignItems(VerticalAlign.Center)
                })
              }
              .width(220)
              .padding(12)
              .backgroundColor('#FFFFFF')
              .borderRadius(14)
              .shadow({
                radius: 8,
                color: '#29000000',
                offsetX: 0,
                offsetY: 4
              })
              .alignItems(HorizontalAlign.Start)
            })
          }
          .alignItems(VerticalAlign.Top)
        }
        .scrollable(ScrollDirection.Horizontal)
        .width('100%')
        .margin({ bottom: 16 })

        // Task Completion Label
        Text('Task Completion')
          .fontSize(18)
          .fontWeight(FontWeight.Medium)
          .fontColor('#1E1E1E')
          .margin({ bottom: 8 })

        // Progress Bar
        Stack({ alignContent: Alignment.Start }) {
          // Track
          Row()
            .width('100%')
            .height(8)
            .backgroundColor('#E5E7EB')
            .borderRadius(4)

          // Progress
          Row()
            .width('65%')
            .height(8)
            .backgroundColor('#2563EB')
            .borderRadius(4)
        }
        .width('100%')
        .height(8)
      }
      .width('100%')
      .padding(16)
      .layoutWeight(1)
      .alignItems(HorizontalAlign.Start)
    }
    .width('100%')
    .height('100%')
    .backgroundColor('#F3F4F6')
  }
}