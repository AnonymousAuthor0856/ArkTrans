class VgColors {
  static readonly white: string = '#FFFFFFFF'
  static readonly black: string = '#FF000000'
  static readonly gray: string = '#FF808080'
  static readonly grayStroke: string = '#FFE0E0E0'
  static readonly stepBg: string = '#FFF0F0F0'
}

@Entry
@Component
struct Index {
  build() {
    Column() {
      Row() {
        Column() {
          Text('V60 Guide')
            .fontSize(34)
            .fontWeight(FontWeight.Bold)
            .fontColor(VgColors.black)

          Text('Ethiopia Yirgacheffe')
            .fontSize(16)
            .fontColor(VgColors.gray)
            .margin({ top: 4 })
        }
        .alignItems(HorizontalAlign.Start)

        Blank()

        Text('⚙')
          .fontSize(24)
          .fontColor(VgColors.black)
      }
      .padding({ left: 24, right: 24, top: 30, bottom: 30 })
      .alignItems(VerticalAlign.Top)

      Blank()

      Column() {
        Text('00:45')
          .fontSize(90)
          .fontColor(VgColors.black)
          .maxLines(1)

        Text('Target: 300g')
          .fontSize(18)
          .fontWeight(FontWeight.Medium)
          .fontColor(VgColors.gray)
          .margin({ top: 10 })
      }
      .margin({ top: 10 })

      Blank()

      Row() {
        ParameterItem({ icon: '+', value: '1:15', label: 'Ratio' })

        Blank()

        ParameterItem({ icon: '♥', value: '20g', label: 'Beans' })

        Blank()

        ParameterItem({ icon: '↻', value: '93°C', label: 'Temp' })
      }
      .padding({ left: 30, right: 30 })

      Blank()

      Column() {
        Column() {
          Blank()
        }
        .width('100%')
        .height(1)
        .backgroundColor(VgColors.grayStroke)
      }
      .padding({ left: 24, right: 24, bottom: 20 })

      Column() {
        Text('Brewing Steps')
          .fontSize(19)
          .fontWeight(FontWeight.Bold)
          .fontColor(VgColors.black)
          .margin({ left: 24, bottom: 15 })

        Row() {
          Stack() {
            Text('☑')
              .fontSize(28)
              .fontColor(VgColors.black)
          }
          .width(28)
          .height(28)
          .backgroundColor(VgColors.white)
          .borderRadius(14)

          Column() {
            Blank()
          }
          .layoutWeight(1)
          .height(52)
          .backgroundColor(VgColors.stepBg)
          .borderRadius(10)
          .margin({ left: 16 })
        }
        .padding({ left: 24, right: 24 })
      }
      .alignItems(HorizontalAlign.Start)

      Blank()

      Row() {
        Text('▶')
          .fontSize(18)
          .fontColor(VgColors.white)
        Text('Start Brewing')
          .fontSize(18)
          .fontWeight(FontWeight.Bold)
          .fontColor(VgColors.white)
          .margin({ left: 8 })
      }
      .width('100%')
      .height(60)
      .justifyContent(FlexAlign.Center)
      .backgroundColor(VgColors.black)
      .borderRadius(18)
      .padding({ left: 24, right: 24, bottom: 30 })
    }
    .backgroundColor(VgColors.white)
    .width('100%')
    .height('100%')
  }
}

@Component
struct ParameterItem {
  @Prop icon: string = ''
  @Prop value: string = ''
  @Prop label: string = ''

  build() {
    Column() {
      Stack() {
        Circle({ width: 64, height: 64 })
          .fill('#00000000')
          .border({ width: 1.5, color: VgColors.grayStroke })
        Text(this.icon)
          .fontSize(24)
          .fontColor(VgColors.gray)
      }

      Column() {
        Text(this.value)
          .fontSize(18)
          .fontWeight(FontWeight.Bold)
          .fontColor(VgColors.black)

        Text(this.label)
          .fontSize(13)
          .fontWeight(FontWeight.Medium)
          .fontColor(VgColors.gray)
          .margin({ top: 4 })
      }
      .margin({ top: 12 })
    }
    .width(80)
  }
}