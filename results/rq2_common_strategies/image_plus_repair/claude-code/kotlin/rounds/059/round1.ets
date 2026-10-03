@Entry
@Component
struct Index {
  private medicines: Medicine[] = [
    { id: 1, name: 'Vitamin C', time: '08:00 AM' },
    { id: 2, name: 'Aspirin', time: '12:30 PM' },
    { id: 3, name: 'Insulin', time: '06:00 PM' },
    { id: 4, name: 'Melatonin', time: '10:00 PM' }
  ]

  build() {
    Stack() {
      Column() {
        Text('Medicine Reminder')
          .fontSize(56)
          .fontWeight(FontWeight.Bold)
          .fontColor('#111827')
          .width('100%')
          .margin({ top: 40, bottom: 20, left: 20, right: 20 })

        List({ space: 24 }) {
          ForEach(this.medicines, (item: Medicine) => {
            ListItem() {
              MedicineItemComponent({ medicine: item })
            }
          }, (item: Medicine) => item.id.toString())
        }
        .width('100%')
        .padding({ left: 20, right: 20 })
        .layoutWeight(1)

        Row() {
          Text('Today')
            .fontSize(32)
            .fontWeight(FontWeight.Medium)
            .fontColor('#111827')
          Text('History')
            .fontSize(32)
            .fontWeight(FontWeight.Medium)
            .fontColor('#1F2937')
          Text('Profile')
            .fontSize(32)
            .fontWeight(FontWeight.Medium)
            .fontColor('#1F2937')
        }
        .width('100%')
        .justifyContent(FlexAlign.SpaceBetween)
        .padding({ left: 32, right: 32, top: 28, bottom: 28 })
        .backgroundColor('#E5E7EB')
      }
      .width('100%')
      .height('100%')
      .linearGradient({
        direction: GradientDirection.Bottom,
        colors: [['#E5E7EB', 0.0], ['#FFFFFF', 1.0]]
      })

      Column() {
        Row() {
          Stack() {
            Circle({ width: 100, height: 100 })
              .fill('#1F2937')
            Text('+')
              .fontSize(52)
              .fontColor('#FFFFFF')
              .fontWeight(FontWeight.Bold)
          }
          .width(100)
          .height(100)
          .shadow({
            radius: 16,
            color: 'rgba(0, 0, 0, 0.25)',
            offsetY: 8
          })
        }
        .width('100%')
        .justifyContent(FlexAlign.End)
        .padding({ right: 24 })
        .margin({ bottom: 110 })
      }
      .width('100%')
      .height('100%')
      .alignContent(Alignment.Bottom)
    }
    .width('100%')
    .height('100%')
  }
}

interface Medicine {
  id: number;
  name: string;
  time: string;
}

@Component
struct MedicineItemComponent {
  @ObjectLink medicine: Medicine

  build() {
    Row() {
      Column({ space: 8 }) {
        Text(this.medicine.name)
          .fontSize(38)
          .fontWeight(FontWeight.Medium)
          .fontColor('#1F2937')
        Text(this.medicine.time)
          .fontSize(30)
          .fontWeight(FontWeight.Normal)
          .fontColor('#1F2937')
      }
      .alignItems(HorizontalAlign.Start)
      .layoutWeight(1)

      Circle({ width: 32, height: 32 })
        .fill('#111827')
    }
    .width('100%')
    .justifyContent(FlexAlign.SpaceBetween)
    .alignItems(VerticalAlign.Center)
    .padding(24)
    .backgroundColor('#FFFFFF')
    .borderRadius(28)
    .border({ width: 2, color: '#D1D5DB' })
  }
}
