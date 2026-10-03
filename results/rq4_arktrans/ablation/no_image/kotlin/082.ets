@Entry
@Component
struct Index {
  @State checked: boolean = false

  build() {
    Stack({ alignContent: Alignment.Top }) {
      Column({ space: 0 }) {
        Blank().height(16)

        // WelcomeSection
        Column({ space: 0 }) {
          Text('Hello, Alex')
            .fontSize(32)
            .fontWeight(FontWeight.Bold)
            .fontColor(Color.Black)
          Blank().height(8)
          Text('You have 5 incomplete tasks today.')
            .fontSize(16)
            .fontColor(Color.Gray)
        }

        Blank().height(32)

        // CategorySelector
        List({ space: 12 }) {
          ListItem() {
            Stack({ alignContent: Alignment.Center }) {
              Text('category')
                .fontColor('#FFFFFF')
                .fontWeight(FontWeight.Medium)
            }
            .backgroundColor('#E0E0E0')
            .borderRadius(50)
            .padding({ left: 24, right: 24, top: 12, bottom: 12 })
          }
          ListItem() {
            Stack({ alignContent: Alignment.Center }) {
              Text('Work')
                .fontColor('#FFFFFF')
                .fontWeight(FontWeight.Medium)
            }
            .backgroundColor('#6750A4')
            .borderRadius(50)
            .padding({ left: 24, right: 24, top: 12, bottom: 12 })
          }
          ListItem() {
            Stack({ alignContent: Alignment.Center }) {
              Text('Personal')
                .fontColor('#FFFFFF')
                .fontWeight(FontWeight.Medium)
            }
            .backgroundColor('#9FA8DA')
            .borderRadius(50)
            .padding({ left: 24, right: 24, top: 12, bottom: 12 })
          }
        }
        .width('100%')
        .listDirection(Axis.Horizontal)

        Blank().height(24)

        // RecentTasksList
        Column({ space: 0 }) {
          Text('Recent Tasks')
            .fontSize(20)
            .fontWeight(FontWeight.Bold)
            .padding({ bottom: 16 })

          List({ space: 16 }) {
            // TaskItem 1
            ListItem() {
              this.TaskItemCard('Team Meeting', '10:00 AM - 11:30 AM', 'Work', '#E3F2FD', '#1565C0', true)
            }
            // TaskItem 2
            ListItem() {
              this.TaskItemCard('Design Review', '02:00 PM - 03:00 PM', 'Design', '#F3E5F5', '#7B1FA2', false)
            }
            // TaskItem 3
            ListItem() {
              this.TaskItemCard('Grocery Shopping', '05:30 PM', 'Personal', '#E8F5E9', '#2E7D32', false)
            }
            // TaskItem 4
            ListItem() {
              this.TaskItemCard('Read Documentation', '08:00 PM', 'Study', '#FFF3E0', '#EF6C00', false)
            }
            
            ListItem() {
              Column() {
                Blank().height(80)
              }
            }
          }.width('100%')
        }
      }
      .width('100%')
      .height('100%')
      .padding({ left: 24, right: 24 })

      // TopHeader
      Row({ space: 0 }) {
        Button() {
          Image($r('app.media.startIcon'))
            .width(24)
            .height(24)
            .fillColor(Color.Black)
        }
        .type(ButtonType.Circle)
        .backgroundColor('#F5F5F5')
        .width(48)
        .height(48)

        Blank()

        Button() {
          Image($r('app.media.startIcon'))
            .width(24)
            .height(24)
            .fillColor(Color.Black)
        }
        .type(ButtonType.Circle)
        .backgroundColor('#F5F5F5')
        .width(48)
        .height(48)
      }
      .alignItems(VerticalAlign.Center)
      .width('100%')
      .padding({ top: 48, left: 24, right: 24, bottom: 16 })

      // FloatingActionButton
      Button() {
        Image($r('app.media.startIcon'))
          .width(24)
          .height(24)
          .fillColor(Color.White)
      }
      .type(ButtonType.Circle)
      .backgroundColor('#111111')
      .width(56)
      .height(56)
      .position({ x: 'calc(100% - 80vp)', y: 'calc(100% - 80vp)' })
    }
    .width('100%')
    .height('100%')
  }

  @Builder
  TaskItemCard(title: string, time: string, tag: string, tagColor: string, tagTextColor: string, isChecked: boolean) {
    Column() {
      Row({ space: 0 }) {
        Stack({ alignContent: Alignment.Center }) {
          Image($r('app.media.startIcon'))
            .width(24)
            .height(24)
            .fillColor(Color.Black)
        }
        .backgroundColor(Color.White)
        .borderRadius(14)
        .width(48)
        .height(48)

        Blank().width(16)

        Column({ space: 0 }) {
          Text(title)
            .fontSize(16)
            .fontWeight(FontWeight.Bold)
            .fontColor(isChecked ? Color.Gray : Color.Black)
          
          Blank().height(4)

          Row({ space: 0 }) {
            Text(time)
              .fontSize(12)
              .fontColor(Color.Gray)
            
            Blank().width(8)

            Stack({ alignContent: Alignment.Center }) {
              Text(tag)
                .fontSize(10)
                .fontWeight(FontWeight.Bold)
                .fontColor(tagTextColor)
            }
            .backgroundColor(tagColor)
            .borderRadius(4)
            .padding({ left: 6, right: 6, top: 2, bottom: 2 })
          }
          .alignItems(VerticalAlign.Center)
        }
        .layoutWeight(1)

        Checkbox({ name: 'task', group: 'group1' })
          .checked(isChecked)
          .onChange((isCheck: boolean) => {
            // Handle check change if needed
          })
      }
      .alignItems(VerticalAlign.Center)
      .padding(20)
      .width('100%')
    }
    .backgroundColor('#FFFFFF')
    .borderRadius(12)
    .shadow({ radius: 4, color: '#1A000000' })
  }
}