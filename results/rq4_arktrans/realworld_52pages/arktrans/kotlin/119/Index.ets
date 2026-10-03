@Entry
@Component
struct Index {
  @State habits: Habit[] = [
    { title: 'Morning Run', sub: '8:00 reminder', streak: 20, done: false },
    { title: 'Read 30 Minutes', sub: '8:00 reminder', streak: 24, done: true },
    { title: 'Meditate', sub: '', streak: 22, done: false },
    { title: 'Drink 8 Glasses of ...', sub: '', streak: 6, done: true },
    { title: 'Journal', sub: '8:00 reminder', streak: 9, done: true },
    { title: 'Weekend Hiking', sub: '', streak: 29, done: true }
  ]

  build() {
    Column() {
      // Header Section
      Column({ space: 8 }) {
        Text('Habits')
          .fontSize(36)
          .fontWeight(FontWeight.Bold)
          .fontColor('#1C1B1F')
        
        Text('4/6 completed')
          .fontSize(16)
          .fontColor('#79747E')
      }
      .width('100%')
      .padding({ left: 24, top: 60, bottom: 24 })

      // List Section
      List({ space: 16 }) {
        ForEach(this.habits, (item: Habit) => {
          ListItem() {
            Row() {
              // Checkbox / Status Icon
              Stack({ alignContent: Alignment.Center }) {
                if (item.done) {
                  Image($r('app.media.startIcon')) // Using available resource as placeholder for checkmark
                    .width(24)
                    .height(24)
                    .objectFit(ImageFit.Contain)
                    .fillColor('#FFFFFF')
                } else {
                  Circle()
                    .width(24)
                    .height(24)
                    .borderWidth(2)
                    .borderColor('#938F99')
                }
              }
              .width(40)
              .height(40)
              .backgroundColor(item.done ? '#6750A4' : 'Transparent')

              // Text Content
              Column({ space: 4 }) {
                Text(item.title)
                  .fontSize(20)
                  .fontWeight(FontWeight.Medium)
                  .fontColor('#1C1B1F')
                  .maxLines(1)
                  .textOverflow({ overflow: TextOverflow.Ellipsis })
                
                if (item.sub !== '') {
                  Text(item.sub)
                    .fontSize(14)
                    .fontColor('#79747E')
                }
              }
              .layoutWeight(1)
              .alignItems(HorizontalAlign.Start)

              // Streak Counter
              Row({ space: 4 }) {
                Text(item.streak.toString())
                  .fontSize(18)
                  .fontWeight(FontWeight.Medium)
                  .fontColor('#49454F')
                Text('🔥')
                  .fontSize(18)
              }

              // Info Button
              Row({ space: 0 }) {
                Text('i')
                  .fontSize(16)
                  .fontWeight(FontWeight.Bold)
                  .fontColor('#6750A4')
              }
              .width(40)
              .height(40)
              .justifyContent(FlexAlign.Center)
              .alignItems(VerticalAlign.Center)
              .backgroundColor('#EADDFF')
              .borderRadius(20)
            }
            .width('100%')
            .padding({ left: 24, right: 24 })
            .alignItems(VerticalAlign.Center)
          }
        }, (item: Habit) => item.title)
      }
      .width('100%')
      .layoutWeight(1)
      .listDirection(Axis.Vertical)
      .padding({ top: 16, bottom: 16 })

      // Floating Action Button
      Row({ space: 0 }) {
        Text('⭐')
          .fontSize(24)
      }
      .width(56)
      .height(56)
      .justifyContent(FlexAlign.Center)
      .alignItems(VerticalAlign.Center)
      .backgroundColor('#EADDFF')
      .borderRadius(16)
      .shadow({ radius: 8, color: '#1F000000', offsetY: 4 })
      .position({ x: 'auto', y: 'auto' })
      .margin({ right: 24, bottom: 24 })
    }
    .width('100%')
    .height('100%')
    .backgroundColor('#FDF8FD')
  }
}

interface Habit {
  title: string;
  sub: string;
  streak: number;
  done: boolean;
}