@Entry
@Component
struct Index {
  @State progress: number = 0.3

  build() {
    Stack({ alignContent: Alignment.Top }) {
      Column({ space: 20 }) {
        Image($r('app.media.startIcon'))
          .width(72)
          .height(72)
          .fillColor('#3B82F6')

        Text(`${Math.floor(this.progress * 100)}%`)
          .fontSize(40)
          .fontColor('#111827')

        Progress({ value: this.progress, total: 1, type: ProgressType.Linear })
          .width('80%')
          .height(14)
          .color('#3B82F6')
          .backgroundColor('#FFFFFF')
          .borderRadius(7)

        Button() {
          Text('Simulate Charge')
            .fontColor('#FFFFFF')
        }
        .onClick(() => {
          if (this.progress < 1) {
            this.progress += 0.1
            if (this.progress > 1) {
              this.progress = 1
            }
          }
        })
        .backgroundColor('#6B7280')
        .borderRadius(999)

        Text(this.progress < 1 ? 'Charging...' : 'Fully Charged!')
          .fontSize(24)
          .fontColor(this.progress < 1 ? '#3B82F6' : '#6B7280')
      }
      .alignItems(HorizontalAlign.Center)
      .width('100%')
      .height('100%')
      .padding(14)

      Row() {
        Text('Charging Progress')
          .fontSize(40)
          .fontColor('#111827')
        
        Blank()

        Image($r('app.media.startIcon'))
          .width(24)
          .height(24)
          .fillColor('#3B82F6')
          .margin({ start: 8 })

        Button() {
          Image($r('app.media.startIcon'))
            .width(24)
            .height(24)
            .fillColor('#F59E0B')
        }
        .backgroundColor('transparent')
      }
      .width('100%')
      .height(56)
      .padding(16)
      .backgroundColor('#FFFFFF')
    }
    .width('100%')
    .height('100%')
    .backgroundColor('#F5F5F4')
  }
}