@Entry
@Component
struct Index {
  @State MedicineReminder: string = '0'
  @State m: string = '0'
  @State mName: string = '0'
  @State mTime: string = '0'
  @State MarkAllTaken: string = '0'
  @State plus: string = '0'
  @State Today: string = '0'
  @State History: string = '0'
  @State Profile: string = '0'

  build() {
    Stack({ alignContent: Alignment.Top }) {
      Column({ space: 12 }) {
        Text('Medicine Reminder')
          .fontSize(57)
          .fontColor('#111827')

        List({ space: 12 }) {
          ListItem() {
            Row({ space: 0 }) {
              Column({ space: 4 }) {
                Text(this.mName)
                  .fontSize(16)
                  .fontColor('#1F2937')
                Text(this.mTime)
                  .fontSize(14)
                  .fontColor('#1F2937')
              }
              Stack({ alignContent: Alignment.Center }) {
                Circle({ width: 16, height: 16 })
                  .fill('#111827')
              }.width(16).height(16)
            }
            .alignItems(VerticalAlign.Center)
            .width('100%')
            .backgroundColor('#FFFFFF')
            .borderRadius(8)
            .padding(12)
            .border({ width: 1, color: '#E5E7EB', radius: 8 })
          }
        }
        .width('100%')
        .layoutWeight(1)

        Blank().height(12)

        Button() {
          Text('Mark All Taken')
            .fontSize(16)
        }
        .height(48)
        .width('80%')
        .backgroundColor('#111827')
        .fontColor('#FFFFFF')
        .borderRadius(12)
      }
      .alignItems(HorizontalAlign.Center)
      .width('100%')
      .height('100%')
      .padding(16)
      .linearGradient({
        direction: GradientDirection.Bottom,
        colors: [['#F3F4F6', 0], ['#FFFFFF', 1]]
      })

      Button() {
        Text('+')
          .fontSize(57)
          .fontColor('#FFFFFF')
      }
      .type(ButtonType.Circle)
      .backgroundColor('#111827')
      .position({ x: 'calc(100% - 80px)', y: 'calc(100% - 120px)' })

      Row({ space: 0 }) {
        Text('Today')
          .fontSize(16)
          .fontColor('#111827')
        Text('History')
          .fontSize(16)
          .fontColor('#1F2937')
        Text('Profile')
          .fontSize(16)
          .fontColor('#1F2937')
      }
      .alignItems(VerticalAlign.Center)
      .justifyContent(FlexAlign.SpaceBetween)
      .width('100%')
      .padding({ left: 16, right: 16 })
      .height(56)
      .backgroundColor('#FFFFFF')
      .position({ x: 0, y: 'calc(100% - 56px)' })
    }
    .width('100%')
    .height('100%')
  }
}