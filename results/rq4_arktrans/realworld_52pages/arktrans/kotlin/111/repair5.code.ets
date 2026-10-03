@Entry
@Component
struct Index {
  @State title: string = 'Meeting Notes'
  @State description: string = 'Discussed Q3 roadmap...'
  @State timerDisplay: string = '02:15'
  @State reminderDate: string = 'Jul 20, 2026 3:00 PM'

  build() {
    Stack({ alignContent: Alignment.Center }) {
      Column({ space: 0 }) {
        // Header Row
        Row({ space: 0 }) {
          Button() {
            Image($r('app.media.startIcon')).width(24).height(24)
          }.backgroundColor(Color.Transparent).borderRadius(8)
          
          Blank().width(8)
          
          Text('Edit Note')
            .fontWeight(FontWeight.Bold)
            .fontSize(18)
            .fontColor('#000000')
            .layoutWeight(1)
          
          Button() {
            Image($r('app.media.startIcon')).width(24).height(24)
          }.backgroundColor(Color.Transparent).borderRadius(8)
          
          Button() {
            Image($r('app.media.startIcon')).width(24).height(24)
          }.backgroundColor(Color.Transparent).borderRadius(8)
        }
        .alignItems(VerticalAlign.Center)
        .width('100%')
        .padding({ left: 8, top: 16, right: 8 })

        // Scrollable Content Area
        Column({ space: 0 }) {
          TextInput({ placeholder: 'Note title (required)' })
            .text(this.title)
            .onChange((value: string) => { this.title = value })
            .placeholderColor('#000000')
            .placeholderFont({ size: 16, weight: FontWeight.Medium })
            .backgroundColor(Color.Transparent)
            .borderWidth(0)
            .width('100%')
            .margin({ bottom: 10 })

          TextInput({ placeholder: 'Description' })
            .text(this.description)
            .onChange((value: string) => { this.description = value })
            .placeholderColor('#000000')
            .placeholderFont({ size: 12 })
            .backgroundColor(Color.Transparent)
            .borderWidth(0)
            .width('100%')
            .margin({ bottom: 24 })

          Text(this.timerDisplay)
            .fontSize(24)
            .fontColor('#000000')
            .textAlign(TextAlign.Center)
            .margin({ bottom: 16 })

          Button() {
            Image($r('app.media.startIcon'))
              .width(48)
              .height(48)
          }
          .backgroundColor(Color.Transparent)
          .borderRadius(24)
          .margin({ left: '50%' }) // Centering hack for button content
          .translate({ x: -24 })
        }
        .layoutWeight(1)
        .width('100%')
        .padding({ left: 16, right: 16, top: 16, bottom: 16 })

        // Reminder Card
        Column() {
          Row({ space: 0 }) {
            Image($r('app.media.startIcon'))
              .width(24)
              .height(24)
            
            Blank().width(16)
            
            Text(this.reminderDate)
              .fontSize(14)
              .fontColor('#000000')
              .layoutWeight(1)
          }
          .alignItems(VerticalAlign.Center)
          .width('100%')
          .padding({ left: 12, right: 12, top: 8, bottom: 8 })
        }
        .width('100%')
        .backgroundColor('#FFFFFF')
        .borderRadius(12)
        .shadow({ radius: 4, color: '#1A000000', offsetY: 2 })
        .margin({ left: 16, right: 16, bottom: 16 })
      }
      .width('100%')
      .height('100%')

      // Floating Action Button
      Button() {
        Row({ space: 0 }) {
          Image($r('app.media.startIcon'))
            .width(20)
            .height(20)
          
          Blank().width(4)
          
          Text('Save')
            .fontWeight(FontWeight.Medium)
            .fontColor('#000000')
        }
        .alignItems(VerticalAlign.Center)
      }
      .backgroundColor('#F4C2D3')
      .borderRadius(16)
      .shadow({ radius: 6, color: '#3F000000', offsetY: 4 })
      .padding({ left: 12, right: 12, top: 12, bottom: 12 })
      .position({ x: 'calc(100% - 100px)', y: 'calc(100% - 100px)' })
    }
    .width('100%')
    .height('100%')
    .backgroundColor('#FFECEF')
  }
}