class VP {
  static readonly Colors = {
    primary: '#FF1E3A8A',
    background: '#FF0F172A',
    surface: '#FF1E293B',
    surfaceVariant: '#FF334155',
    outline: '#FF475569',
    onSurface: '#FFE2E8F0',
    chip: '#FFE8DEF8'
  }
}

@Entry
@Component
struct VideoPlayerRoot {
  build() {
    Column() {
      Text('Video Player')
        .fontSize(18)
        .fontWeight(FontWeight.Medium)
        .fontColor('#FFE2E8F0')
        .height(56)
        .padding({ top: 12, bottom: 12 })

      Row() {
        Text('Video Surface')
          .fontSize(16)
          .fontWeight(FontWeight.Medium)
          .fontColor('#E6E2E8F0')
      }
      .width('100%')
      .height(300)
      .borderRadius(24)
      .backgroundColor(VP.Colors.surfaceVariant)
      .justifyContent(FlexAlign.Center)
      .alignItems(VerticalAlign.Center)
      .margin({ right: 10 })

      Text('Journey through the Skies')
        .fontSize(18)
        .fontWeight(FontWeight.Medium)
        .fontColor('#FFE0E8F0')
        .width('100%')
        .padding({ left: 20, right: 20, top: 10, bottom: 10 })

      Column() {
        Row() {
          Row().layoutWeight(1)
          Row()
            .width(268)
            .height(32)
            .borderRadius(16)
            .backgroundColor(VP.Colors.primary)
          Row()
            .width(6)
            .height(72)
            .borderRadius(3)
            .backgroundColor(VP.Colors.primary)
            .margin({ left: 18 })
          Stack() {
            Row()
              .width(316)
              .height(32)
              .borderRadius(16)
              .backgroundColor(VP.Colors.outline)
            Row()
              .width(12)
              .height(12)
              .borderRadius(6)
              .backgroundColor(VP.Colors.primary)
              .position({ x: 294, y: 10 })
          }
          .width(316)
          .height(32)
          .margin({ left: 18 })
          Row().layoutWeight(1)
        }
        .alignItems(VerticalAlign.Center)

        Row() {
          Text('1:35')
            .fontSize(12)
            .fontWeight(FontWeight.Medium)
            .fontColor('#FFA3AAB5')
            .margin({ left: 10 })
          Text('4:00')
            .fontSize(12)
            .fontWeight(FontWeight.Medium)
            .fontColor('#FFA3AAB5')
            .margin({ right: 10 })
        }
        .width('100%')
        .justifyContent(FlexAlign.SpaceBetween)
        .margin({ top: 10 })
      }
      .alignItems(HorizontalAlign.Start)
      .padding({ left: 24, right: 24, top: 8, bottom: 6 })

      Row() {
        Text('−10s')
          .fontSize(18)
          .fontWeight(FontWeight.Medium)
          .fontColor('#FF1D192B')
          .width(180)
          .height(96)
          .textAlign(TextAlign.Center)
          .borderRadius(18)
          .backgroundColor(VP.Colors.chip)

        Row() {
          Text('▶')
            .fontSize(40)
            .fontWeight(FontWeight.Bold)
            .fontColor('#FFFFFFFF')
        }
        .width(120)
        .height(120)
        .borderRadius(60)
        .backgroundColor(VP.Colors.primary)
        .justifyContent(FlexAlign.Center)
        .alignItems(VerticalAlign.Center)
        .margin({ left: 24 })

        Text('+30s')
          .fontSize(18)
          .fontWeight(FontWeight.Medium)
          .fontColor('#FF1D192B')
          .width(180)
          .height(96)
          .textAlign(TextAlign.Center)
          .borderRadius(18)
          .backgroundColor(VP.Colors.chip)
          .margin({ left: 24 })
      }
      .justifyContent(FlexAlign.Center)
      .alignItems(VerticalAlign.Center)
      .padding({ top: 10, bottom: 10 })

      Text('Fullscreen')
        .fontSize(18)
        .fontWeight(FontWeight.Medium)
        .fontColor('#FF47434E')
        .width(220)
        .height(64)
        .textAlign(TextAlign.Center)
        .borderRadius(12)
        .border({ width: 1, color: VP.Colors.outline })
        .margin({ top: 12 })
    }
    .width('100%')
    .height('100%')
    .backgroundColor(VP.Colors.background)
  }
}