@Entry
@Component
struct Index {
  @State medicines: Medicine[] = [
    { name: 'Vitamin C', time: '08:00 AM' },
    { name: 'Aspirin', time: '12:30 PM' },
    { name: 'Insulin', time: '06:00 PM' },
    { name: 'Melatonin', time: '10:00 PM' }
  ]

  build() {
    Stack({ alignContent: Alignment.Top }) {
      Column({ space: 12 }) {
        Text('Medicine Reminder')
          .fontSize(32)
          .fontWeight(FontWeight.Bold)
          .fontColor('#111827')
          .textAlign(TextAlign.Center)

        List({ space: 12 }) {
          ForEach(this.medicines, (m: Medicine) => {
            ListItem() {
              Row({ space: 0 }) {
                Column({ space: 4 }) {
                  Text(m.name)
                    .fontSize(18)
                    .fontWeight(FontWeight.Medium)
                    .fontColor('#1F2937')
                  Text(m.time)
                    .fontSize(16)
                    .fontColor('#1F2937')
                }
                Blank()
                Stack({ alignContent: Alignment.Center }) {
                  Circle().width(16).height(16).fill('#111827')
                }.width(16).height(16)
              }
              .alignItems(VerticalAlign.Center)
              .width('100%')
              .backgroundColor('#FFFFFF')
              .borderRadius(16)
              .padding(12)
              .border({ width: 1, color: '#E5E7EB', radius: 16 })
            }
          }, (m: Medicine) => m.name + m.time)
        }
        .width('100%')
        .layoutWeight(1)

        Blank().height(12)

        Button() {
          Text('Mark All Taken')
            .fontSize(18)
            .fontWeight(FontWeight.Medium)
            .fontColor('#FFFFFF')
        }
        .height(48)
        .width('80%')
        .backgroundColor('#111827')
        .borderRadius(24)
      }
      .alignItems(HorizontalAlign.Center)
      .width('100%')
      .height('100%')
      .padding(16)
      .linearGradient({
        angle: 90,
        colors: [['#F3F4F6', 0], ['#FFFFFF', 1]]
      })

      Button() {
        Text('+')
          .fontSize(32)
          .fontWeight(FontWeight.Bold)
          .fontColor('#FFFFFF')
      }
      .width(56)
      .height(56)
      .backgroundColor('#111827')
      .borderRadius(28)
      .shadow({ radius: 8, color: '#00000033', offsetX: 0, offsetY: 4 })
      .position({ x: 'auto', y: 'auto' })
      .margin({ right: 24, bottom: 80 })
      .alignSelf(ItemAlign.End)

      Row({ space: 0 }) {
        Text('Today')
          .fontSize(18)
          .fontWeight(FontWeight.Medium)
          .fontColor('#111827')
          .textAlign(TextAlign.Center)
          .layoutWeight(1)
        Text('History')
          .fontSize(18)
          .fontWeight(FontWeight.Medium)
          .fontColor('#1F2937')
          .textAlign(TextAlign.Center)
          .layoutWeight(1)
        Text('Profile')
          .fontSize(18)
          .fontWeight(FontWeight.Medium)
          .fontColor('#1F2937')
          .textAlign(TextAlign.Center)
          .layoutWeight(1)
      }
      .alignItems(VerticalAlign.Center)
      .width('100%')
      .padding({ left: 16, right: 16, top: 16, bottom: 16 })
      .backgroundColor('#F3F4F6')
      .position({ x: 0, y: 'auto' })
      .alignSelf(ItemAlign.Bottom)
    }
    .width('100%')
    .height('100%')
  }
}

interface Medicine {
  name: string;
  time: string;
}