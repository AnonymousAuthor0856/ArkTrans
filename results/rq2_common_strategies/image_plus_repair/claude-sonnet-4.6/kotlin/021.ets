import { common } from '@kit.AbilityKit';

interface KanbanColumn {
  title: string;
  tasks: string[];
}

@Entry
@Component
struct Index {
  @State notificationsEnabled: boolean = true;

  private columns: KanbanColumn[] = [
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
      .justifyContent(FlexAlign.Center)
      .padding({ top: 16, bottom: 16 })
      .backgroundColor('#F3F4F6')

      // Content
      Column({ space: 16 }) {
        // Notifications Row
        Row() {
          Text('Notifications')
            .fontSize(18)
            .fontWeight(FontWeight.Medium)
            .fontColor('#1E1E1E')

          Toggle({ type: ToggleType.Switch, isOn: this.notificationsEnabled })
            .selectedColor('#2563EB')
            .onChange((isOn: boolean) => {
              this.notificationsEnabled = isOn;
            })
            .width(60)
            .height(32)
        }
        .width('100%')
        .justifyContent(FlexAlign.SpaceBetween)
        .alignItems(VerticalAlign.Center)

        // Kanban Columns - Horizontal Scroll
        Scroll() {
          Row({ space: 12 }) {
            ForEach(this.columns, (col: KanbanColumn) => {
              Column({ space: 8 }) {
                Text(col.title)
                  .fontSize(18)
                  .fontWeight(FontWeight.Medium)
                  .fontColor('#2563EB')
                  .width('100%')

                ForEach(col.tasks, (task: string) => {
                  Row() {
                    Text(task)
                      .fontSize(14)
                      .fontWeight(FontWeight.Normal)
                      .fontColor('#1E1E1E')
                      .padding({ left: 12, right: 12, top: 8, bottom: 8 })
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
              .height(400)
            })
          }
          .padding({ bottom: 8 })
        }
        .scrollable(ScrollDirection.Horizontal)
        .scrollBar(BarState.Off)
        .width('100%')

        // Task Completion
        Text('Task Completion')
          .fontSize(18)
          .fontWeight(FontWeight.Medium)
          .fontColor('#1E1E1E')
          .width('100%')

        // Progress Bar
        Stack({ alignContent: Alignment.Start }) {
          Row()
            .width('100%')
            .height(8)
            .backgroundColor('#E5E7EB')
            .borderRadius(4)

          Row()
            .width('65%')
            .height(8)
            .backgroundColor('#2563EB')
            .borderRadius(4)
        }
        .width('100%')
        .height(8)
      }
      .padding(16)
      .layoutWeight(1)
      .alignItems(HorizontalAlign.Start)
    }
    .width('100%')
    .height('100%')
    .backgroundColor('#F3F4F6')
  }
}