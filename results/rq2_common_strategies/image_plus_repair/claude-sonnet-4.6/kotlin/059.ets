// Medicine Reminder - ArkTS

class Medicine {
  id: number = 0
  name: string = ''
  time: string = ''

  constructor(id: number, name: string, time: string) {
    this.id = id
    this.name = name
    this.time = time
  }
}

const medicines: Medicine[] = [
  new Medicine(1, 'Vitamin C', '08:00 AM'),
  new Medicine(2, 'Aspirin', '12:30 PM'),
  new Medicine(3, 'Insulin', '06:00 PM'),
  new Medicine(4, 'Melatonin', '10:00 PM')
]

@Component
struct MedicineItem {
  medicine: Medicine = new Medicine(0, '', '')

  build() {
    Row() {
      Column() {
        Text(this.medicine.name)
          .fontSize(16)
          .fontWeight(FontWeight.Medium)
          .fontColor('#1F2937')
        Text(this.medicine.time)
          .fontSize(14)
          .fontColor('#1F2937')
      }
      .alignItems(HorizontalAlign.Start)
      .layoutWeight(1)

      Circle({ width: 16, height: 16 })
        .fill('#111827')
    }
    .width('100%')
    .backgroundColor('#FFFFFF')
    .borderRadius(12)
    .border({ width: 1, color: '#D1D5DB' })
    .padding(12)
    .justifyContent(FlexAlign.SpaceBetween)
    .alignItems(VerticalAlign.Center)
  }
}

@Component
struct MedicineList {
  build() {
    List({ space: 12 }) {
      ForEach(medicines, (m: Medicine) => {
        ListItem() {
          MedicineItem({ medicine: m })
        }
      }, (m: Medicine) => m.id.toString())
    }
    .width('100%')
    .layoutWeight(1)
  }
}

@Entry
@Component
struct RootScreen {
  build() {
    Stack({ alignContent: Alignment.BottomEnd }) {
      Column() {
        Column() {
          Text('Medicine Reminder')
            .fontSize(28)
            .fontWeight(FontWeight.Bold)
            .fontColor('#111827')
            .margin({ bottom: 12 })

          MedicineList()

          Button('Mark All Taken')
            .width('80%')
            .height(48)
            .borderRadius(16)
            .backgroundColor('#374151')
            .fontColor('#FFFFFF')
            .fontSize(16)
            .fontWeight(FontWeight.Medium)
            .margin({ top: 12 })
        }
        .width('100%')
        .layoutWeight(1)
        .padding(16)
        .alignItems(HorizontalAlign.Center)
        .linearGradient({
          direction: GradientDirection.Bottom,
          colors: [['#E5E7EB', 0.0], ['#FFFFFF', 1.0]]
        })

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
        .backgroundColor('#FFFFFF')
        .justifyContent(FlexAlign.SpaceBetween)
        .padding({ left: 16, right: 16 })
      }
      .width('100%')
      .height('100%')
      .backgroundColor('#F9FAFB')

      Button('+')
        .width(56)
        .height(56)
        .borderRadius(28)
        .backgroundColor('#111827')
        .fontColor('#FFFFFF')
        .fontSize(28)
        .margin({ right: 16, bottom: 72 })
    }
    .width('100%')
    .height('100%')
  }
}