interface Medicine {
  name: string
  time: string
}

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
    Stack({ alignContent: Alignment.BottomEnd }) {
      Column() {
        Column({ space: 16 }) {
          Text('Medicine Reminder')
            .fontColor('#111827')
            .fontSize(28)
            .fontWeight(FontWeight.Bold)
            .textAlign(TextAlign.Center)
            .width('100%')

          Scroll() {
            Column({ space: 16 }) {
              ForEach(this.medicines, (item: Medicine) => {
                this.MedicineItem(item)
              }, (item: Medicine) => item.name)
            }
            .padding({ left: 24, right: 24, bottom: 56 })
          }.layoutWeight(1).width('100%')

          Blank()

          Button('Mark All Taken')
            .backgroundColor('#374151')
            .fontColor('#FFFFFF')
            .borderRadius(20)
            .height(56)
            .width('80%')
            .margin({ bottom: 8 })
        }
        .width('100%')
        .height('100%')
        .padding({ top: 60, left: 24, right: 24 })
        .backgroundColor('#F3F4F6')
      }

      Column() {
        Blank()
        Row({ space: 24 }) {
          Text('Today').fontColor('#111827').fontSize(16).fontWeight(FontWeight.Medium)
          Blank()
          Text('History').fontColor('#1F2937').fontSize(16)
          Blank()
          Text('Profile').fontColor('#1F2937').fontSize(16)
        }
        .width('100%')
        .height(56)
        .justifyContent(FlexAlign.SpaceAround)
        .alignItems(VerticalAlign.Center)
        .backgroundColor('#FFFFFF')
        .shadow({ radius: 10, color: '#0000001A', offsetY: -2 })
      }

      Button('+')
        .type(ButtonType.Circle)
        .backgroundColor('#111827')
        .fontColor('#FFFFFF')
        .fontSize(32)
        .width(56)
        .height(56)
        .margin(12)
    }.width('100%').height('100%')
  }

  @Builder
  MedicineItem(medicine: Medicine) {
    Row() {
      Column({ space: 4 }) {
        Text(medicine.name)
          .fontColor('#1F2937')
          .fontSize(18)
          .fontWeight(FontWeight.Medium)
        Text(medicine.time)
          .fontColor('#4B5563')
          .fontSize(14)
      }
      .alignItems(HorizontalAlign.Start)
      .justifyContent(FlexAlign.Start)
      .layoutWeight(1)

      Circle()
        .width(24)
        .height(24)
        .fill('#111827')
    }
    .width('100%')
    .padding(20)
    .backgroundColor('#FFFFFF')
    .borderRadius(16)
    .shadow({ radius: 8, color: '#0000000D', offsetY: 2 })
  }
}