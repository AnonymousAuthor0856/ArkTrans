@Entry
@Component
struct Index {
  @State notificationsEnabled: boolean = false

  build() {
    Stack() {
      Column() {
        Text('Project Timeline')
          .padding({ top: 4 })
          .backgroundColor('#FFF1F5F9')
          .padding({ top: 12, bottom: 12 })
          .width('100%')
          .fontColor('#FF1E1E1E')
          .fontSize(26)

        Column() {
          Row() {
            Text('Notifications')
              .fontColor('#FF1E1E1E')
              .fontSize(18)
            Blank()
            Toggle({ value: this.notificationsEnabled, option: [true, false] })
              .onChange((value: boolean) => {
                this.notificationsEnabled = value
              })
          }

          Scroll() {
            Column() {
              ForEach([
                { name: 'Task 1', progress: 0.5 },
                { name: 'Task 2', progress: 0.8 }
              ], (item: { name: string, progress: number }) => {
                Column() {
                  Text(item.name)
                    .fontColor('#FF38BDF8')
                    .fontSize(18)
                  Progress({ value: item.progress * 100, total: 100, type: ProgressType.Linear })
                    .width('100%')
                    .height(8)
                    .color('#FF6366F1')
                    .trackColor('#FFE2E8F0')
                }
                .alignItems(HorizontalAlign.Start)
                .padding(12)
                .borderRadius(16)
                .backgroundColor('#FFFFFF')
                .shadow({ radius: 4, color: '#1F000000' })
                .width('100%')
              })
            }
          }

          Button() {
            Text('Add Task')
              .width('100%')
              .height('100%')
              .fontColor('#FFFFFFFF')
              .fontSize(18)
          }
          .borderRadius(16)
          .backgroundColor('#FF38BDF8')
          .height(52)

          LinearGradient({
            colors: [['#FFFFFF', 0], ['#FFF1F5F9', 0.5], ['#FFFFFF', 1]],
            angle: 90
          })
          .width('100%')
          .height(100)
        }
        .padding(16)
        .layoutWeight(1)
      }
      .width('100%')
      .height('100%')
      .backgroundColor('#FFF1F5F9')
    }.width('100%').height('100%')
  }
}