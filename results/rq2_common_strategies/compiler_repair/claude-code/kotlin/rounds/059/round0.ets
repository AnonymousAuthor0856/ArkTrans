@Entry
@Component
struct MedicineReminder {
  private medicines: Medicine[] = [
    { id: 1, name: 'Vitamin C', time: '08:00 AM' },
    { id: 2, name: 'Aspirin', time: '12:30 PM' },
    { id: 3, name: 'Insulin', time: '06:00 PM' },
    { id: 4, name: 'Melatonin', time: '10:00 PM' }
  ]

  @State selectedTab: string = 'Today'

  build() {
    Stack({ alignContent: Alignment.BottomEnd }) {
      Column() {
        Column({ space: 12 }) {
          Text('Medicine Reminder')
            .fontSize(28)
            .fontWeight(FontWeight.Bold)
            .fontColor('#FF111827')

          List({ space: 12 }) {
            ForEach(this.medicines, (item: Medicine) => {
              ListItem() {
                this.MedicineItemBuilder(item)
              }
            }, (item: Medicine) => item.id.toString())
          }
          .width('100%')
          .layoutWeight(1)

          Button('Mark All Taken')
            .width('80%')
            .height(48)
            .fontSize(16)
            .fontWeight(FontWeight.Medium)
            .fontColor('#FFFFFFFF')
            .backgroundColor('#FF374151')
            .borderRadius(16)
            .margin({ bottom: 80 })
        }
        .width('100%')
        .height('100%')
        .padding(16)
        .linearGradient({
          direction: GradientDirection.Bottom,
          colors: [['#FFE5E7EB', 0.0], ['#FFFFFFFF', 1.0]]
        })
      }
      .width('100%')
      .height('100%')
      .backgroundColor('#FFF9FAFB')

      // Bottom App Bar
      Row() {
        Text('Today')
          .fontSize(16)
          .fontWeight(FontWeight.Medium)
          .fontColor(this.selectedTab === 'Today' ? '#FF111827' : '#FF1F2937')
          .onClick(() => { this.selectedTab = 'Today' })

        Text('History')
          .fontSize(16)
          .fontWeight(FontWeight.Medium)
          .fontColor(this.selectedTab === 'History' ? '#FF111827' : '#FF1F2937')
          .onClick(() => { this.selectedTab = 'History' })

        Text('Profile')
          .fontSize(16)
          .fontWeight(FontWeight.Medium)
          .fontColor(this.selectedTab === 'Profile' ? '#FF111827' : '#FF1F2937')
          .onClick(() => { this.selectedTab = 'Profile' })
      }
      .width('100%')
      .height(72)
      .justifyContent(FlexAlign.SpaceAround)
      .alignItems(VerticalAlign.Center)
      .backgroundColor('#FFFFFFFF')
      .shadow({ radius: 8, color: 'rgba(0,0,0,0.14)', offsetY: 4 })

      // Floating Action Button
      Text('+')
        .fontSize(28)
        .fontWeight(FontWeight.Bold)
        .fontColor('#FFFFFFFF')
        .textAlign(TextAlign.Center)
        .width(56)
        .height(56)
        .backgroundColor('#FF111827')
        .borderRadius(28)
        .margin({ right: 16, bottom: 88 })
    }
    .width('100%')
    .height('100%')
  }

  @Builder
  MedicineItemBuilder(medicine: Medicine) {
    Row() {
      Column({ space: 4 }) {
        Text(medicine.name)
          .fontSize(16)
          .fontWeight(FontWeight.Medium)
          .fontColor('#FF1F2937')

        Text(medicine.time)
          .fontSize(14)
          .fontWeight(FontWeight.Normal)
          .fontColor('#FF1F2937')
      }
      .layoutWeight(1)
      .alignItems(HorizontalAlign.Start)

      Circle({ width: 16, height: 16 })
        .fill('#FF111827')
    }
    .width('100%')
    .padding(12)
    .backgroundColor('#FFFFFFFF')
    .borderRadius(12)
    .border({ width: 1, color: '#FFD1D5DB', radius: 12 })
    .alignItems(VerticalAlign.Center)
  }
}

interface Medicine {
  id: number;
  name: string;
  time: string;
}
