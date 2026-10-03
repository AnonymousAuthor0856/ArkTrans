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
        Column() {
          Text('Medicine Reminder')
            .fontSize(48)
            .fontWeight(FontWeight.Bold)
            .fontColor('#111827')
            .width('100%')
            .margin({ top: 48, bottom: 24, left: 16, right: 16 })
        }
        .width('100%')

        List({ space: 24 }) {
          ForEach(this.medicines, (item: Medicine) => {
            ListItem() {
              MedicineItemComponent({ medicine: item })
            }
          }, (item: Medicine) => item.id.toString())
        }
        .width('100%')
        .padding({ left: 16, right: 16 })
        .layoutWeight(1)

        Row() {
          Text('Today')
            .fontSize(28)
            .fontWeight(FontWeight.Medium)
            .fontColor('#111827')
          Text('History')
            .fontSize(28)
            .fontWeight(FontWeight.Medium)
            .fontColor('#1F2937')
          Text('Profile')
            .fontSize(28)
            .fontWeight(FontWeight.Medium)
            .fontColor('#1F2937')
        }
        .width('100%')
        .justifyContent(FlexAlign.SpaceBetween)
        .padding({ left: 32, right: 32, top: 24, bottom: 24 })
        .backgroundColor('#E5E7EB')
      }
      .width('100%')
      .height('100%')
      .linearGradient({
        direction: GradientDirection.Bottom,
        colors: [['#F9FAFB', 0.0], ['#E5E7EB', 1.0]]
      })

      Column() {
        Row() {
          Stack() {
            Circle({ width: 96, height: 96 })
              .fill('#1F2937')
            Text('+')
              .fontSize(48)
              .fontColor('#FFFFFF')
              .fontWeight(FontWeight.Bold)
          }
          .width(96)
          .height(96)
          .shadow({
            radius: 16,
            color: 'rgba(0, 0, 0, 0.2)',
            offsetY: 8
          })
        }
        .width('100%')
        .justifyContent(FlexAlign.End)
        .padding({ right: 24 })
        .margin({ bottom: 100 })
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
      Column() {
        Text(this.medicine.name)
          .fontSize(36)
          .fontWeight(FontWeight.Medium)
          .fontColor('#1F2937')
        Text(this.medicine.time)
          .fontSize(28)
          .fontWeight(FontWeight.Normal)
          .fontColor('#1F2937')
          .margin({ top: 8 })
      }
      .alignItems(HorizontalAlign.Start)

      Stack() {
        Circle({ width: 32, height: 32 })
          .fill('#111827')
      }
      .width(32)
      .height(32)
    }
    .width('100%')
    .justifyContent(FlexAlign.SpaceBetween)
    .alignItems(VerticalAlign.Center)
    .padding(24)
    .backgroundColor('#FFFFFF')
    .borderRadius(24)
    .border({ width: 2, color: '#D1D5DB' })
  }
}
