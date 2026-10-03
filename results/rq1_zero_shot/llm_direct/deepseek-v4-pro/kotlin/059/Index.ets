@Entry
@Component
struct MedicineReminderApp {
  @State medicines: Medicine[] = [
    { id: 1, name: "Vitamin C", time: "08:00 AM" },
    { id: 2, name: "Aspirin", time: "12:30 PM" },
    { id: 3, name: "Insulin", time: "06:00 PM" },
    { id: 4, name: "Melatonin", time: "10:00 PM" }
  ];

  build() {
    Stack() {
      Column() {
        // Header
        Column() {
          Text('Medicine Reminder')
            .fontSize(28)
            .fontWeight(FontWeight.Bold)
            .fontColor('#111827')
            .margin({ top: 24, bottom: 16 })
        }
        .width('100%')
        .alignItems(HorizontalAlign.Center)

        // Medicine List
        List({ space: 12 }) {
          ForEach(this.medicines, (item: Medicine) => {
            ListItem() {
              Row() {
                Column() {
                  Text(item.name)
                    .fontSize(16)
                    .fontWeight(FontWeight.Medium)
                    .fontColor('#1F2937')
                  Text(item.time)
                    .fontSize(14)
                    .fontColor('#1F2937')
                    .margin({ top: 4 })
                }
                .alignItems(HorizontalAlign.Start)

                Blank()
                  .width(16)
                  .height(16)
                  .backgroundColor('#111827')
                  .borderRadius(8)
              }
              .width('100%')
              .justifyContent(FlexAlign.SpaceBetween)
              .alignItems(VerticalAlign.Center)
            }
            .padding(12)
            .backgroundColor('#FFFFFF')
            .borderRadius(12)
            .border({ width: 1, color: '#D1D5DB' })
          })
        }
        .layoutWeight(1)
        .width('100%')
        .padding({ left: 16, right: 16, top: 8, bottom: 16 })

        // Mark All Taken Button
        Button('Mark All Taken')
          .width('80%')
          .height(48)
          .fontSize(16)
          .fontWeight(FontWeight.Medium)
          .fontColor('#FFFFFF')
          .backgroundColor('#374151')
          .borderRadius(16)
          .margin({ bottom: 16 })
      }
      .width('100%')
      .height('100%')
      .linearGradient({
        angle: 180,
        colors: [['#E5E7EB', 0.0], ['#FFFFFF', 1.0]]
      })

      // Floating Action Button
      Button('+')
        .width(56)
        .height(56)
        .fontSize(28)
        .fontWeight(FontWeight.Bold)
        .fontColor('#FFFFFF')
        .backgroundColor('#111827')
        .borderRadius(28)
        .position({ x: '85%', y: '82%' })

      // Bottom App Bar
      Row() {
        Text('Today')
          .fontSize(16)
          .fontWeight(FontWeight.Medium)
          .fontColor('#111827')
        Text('History')
          .fontSize(16)
          .fontWeight(FontWeight.Medium)
          .fontColor('#1F2937')
        Text('Profile')
          .fontSize(16)
          .fontWeight(FontWeight.Medium)
          .fontColor('#1F2937')
      }
      .width('100%')
      .height(56)
      .padding({ left: 16, right: 16 })
      .justifyContent(FlexAlign.SpaceBetween)
      .alignItems(VerticalAlign.Center)
      .backgroundColor('#FFFFFF')
      .position({ x: 0, y: '94%' })
    }
    .width('100%')
    .height('100%')
    .backgroundColor('#F9FAFB')
  }
}

interface Medicine {
  id: number;
  name: string;
  time: string;
}