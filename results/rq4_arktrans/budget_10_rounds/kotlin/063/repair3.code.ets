@Entry
@Component
struct Index {
  @State progress: number = 0.45

  build() {
    Stack({ alignContent: Alignment.Top }) {
      Column({ space: 20 }) {
        Image($r('app.media.startIcon'))
          .width(72)
          .height(72)
          .objectFit(ImageFit.Contain)
          .backgroundColor('#3B82F6')

        Text(`${Math.round(this.progress * 100)}%`)
          .fontSize(40)
          .fontWeight(FontWeight.Bold)
          .fontColor('#111827')

        Progress({ value: this.progress, total: 1, type: ProgressType.Linear })
          .width('80%')
          .height(14)
          .color('#3B82F6')
          .trackColor('#FFFFFF')
          .borderRadius(7)
          .border({ width: 1, color: '#D1D5DB', radius: 7 })

        Button('Simulate Charge')
          .type(ButtonType.Capsule)
          .backgroundColor('#22C55E')
          .fontColor('#FFFFFF')
          .fontSize(18)
          .width('60%')
          .height(50)
          .onClick(() => {
            if (this.progress < 1) {
              this.progress += 0.1
            }
          })

        Text(this.progress < 1 ? 'Charging...' : 'Fully Charged!')
          .fontSize(24)
          .fontColor(this.progress < 1 ? '#3B82F6' : '#22C55E')
          .fontWeight(FontWeight.Medium)
      }
      .alignItems(HorizontalAlign.Center)
      .justifyContent(FlexAlign.Start)
      .width('100%')
      .height('100%')
      .padding({ top: 100, left: 14, right: 14 })

      Row() {
        Image($r('app.media.startIcon'))
          .width(24)
          .height(24)
          .objectFit(ImageFit.Contain)
          .backgroundColor('#3B82F6')
          .margin({ end: 16 })

        Text('Charging Progress')
          .fontSize(24)
          .fontWeight(FontWeight.Bold)
          .fontColor('#111827')
          .layoutWeight(1)
          .textAlign(TextAlign.Center)

        Image($r('app.media.startIcon'))
          .width(24)
          .height(24)
          .objectFit(ImageFit.Contain)
          .backgroundColor('#F59E0B')
          .margin({ start: 16 })
      }
      .width('100%')
      .height(56)
      .padding({ left: 16, right: 16 })
      .position({ x: 0, y: 0 })
    }
    .width('100%')
    .height('100%')
    .backgroundColor('#F5F5F4')
  }
}