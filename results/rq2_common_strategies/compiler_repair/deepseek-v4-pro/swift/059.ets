@Entry
@Component
struct MedicineReminderApp {
  private items: Medicine[] = [
    { id: 1, name: 'Vitamin C', time: '08:00 AM' },
    { id: 2, name: 'Aspirin', time: '12:30 PM' },
    { id: 3, name: 'Insulin', time: '06:00 PM' },
    { id: 4, name: 'Melatonin', time: '10:00 PM' }
  ]

  build() {
    Stack({ alignContent: Alignment.BottomEnd }) {
      // Main content layer
      Column({ space: 12 }) {
        // Title
        Text('Medicine Reminder')
          .fontSize(28)
          .fontWeight(FontWeight.Bold)
          .foregroundColor('#111827')
          .width('100%')
          .textAlign(TextAlign.Center)
          .padding({ top: 16 })

        // Medicine list using List with ListItem
        List({ space: 12 }) {
          ForEach(this.items, (medicine: Medicine) => {
            ListItem() {
              this.buildMedicineItem(medicine)
            }
          })
        }
        .width('100%')
        .layoutWeight(1)

        Blank()

        // "Mark All Taken" button
        Button() {
          Text('Mark All Taken')
            .fontSize(16)
            .fontWeight(FontWeight.Medium)
            .foregroundColor('#FFFFFF')
            .textAlign(TextAlign.Center)
            .width('100%')
            .height(48)
        }
        .width('80%')
        .height(48)
        .backgroundColor('#374151')
        .borderRadius(16)
        .margin({ left: '10%', bottom: 12 })
      }
      .width('100%')
      .height('100%')
      .padding(16)
      .backgroundColor('#F9FAFB')
      .padding({ bottom: 56 }) // space for bottom bar

      // Bottom bar layer
      Column() {
        Row({ space: 0 }) {
          Text('Today')
            .fontSize(16)
            .fontWeight(FontWeight.Medium)
            .foregroundColor('#111827')
            .layoutWeight(1)
            .textAlign(TextAlign.Center)
          Text('History')
            .fontSize(16)
            .fontWeight(FontWeight.Medium)
            .foregroundColor('#1F2937')
            .layoutWeight(1)
            .textAlign(TextAlign.Center)
          Text('Profile')
            .fontSize(16)
            .fontWeight(FontWeight.Medium)
            .foregroundColor('#1F2937')
            .layoutWeight(1)
            .textAlign(TextAlign.Center)
        }
        .width('100%')
        .height(56)
        .padding({ left: 16, right: 16 })
        .backgroundColor('#FFFFFF')
        .shadow({ radius: 8, color: '#24000000', offsetY: 4 })
      }
      .width('100%')
      .position({ x: 0, y: '100%' }) // pinned to bottom

      // FAB
      Button() {
        Text('+')
          .fontSize(28)
          .fontWeight(FontWeight.Bold)
          .foregroundColor('#FFFFFF')
          .textAlign(TextAlign.Center)
          .width(56)
          .height(56)
      }
      .width(56)
      .height(56)
      .backgroundColor('#111827')
      .borderRadius(28)
      .margin({ right: 16, bottom: 72 }) // offset from bottom bar
    }
    .width('100%')
    .height('100%')
  }

  @Builder
  buildMedicineItem(medicine: Medicine) {
    Row({ space: 0 }) {
      // Left side: name and time
      Column({ space: 4 }) {
        Text(medicine.name)
          .fontSize(16)
          .fontWeight(FontWeight.Medium)
          .foregroundColor('#1F2937')
        Text(medicine.time)
          .fontSize(14)
          .foregroundColor('#1F2937')
      }
      .alignItems(HorizontalAlign.Start)
      .layoutWeight(1)

      // Right side: circle indicator
      Column()
        .width(16)
        .height(16)
        .backgroundColor('#111827')
        .borderRadius(8)
        .margin({ left: 12 })
    }
    .padding(12)
    .backgroundColor('#FFFFFF')
    .borderRadius(12)
    .border({ width: 1, color: '#D1D5DB', radius: 12 })
    .width('100%')
  }
}

// Data model
interface Medicine {
  id: number
  name: string
  time: string
}