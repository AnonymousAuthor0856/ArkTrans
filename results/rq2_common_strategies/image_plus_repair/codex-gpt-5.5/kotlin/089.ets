@Entry
@Component
struct CryoGenMonitor {
  @State isLocked: boolean = true

  private readonly dark: string = '#212121'
  private readonly grey: string = '#757575'
  private readonly blue: string = '#0066CC'
  private readonly red: string = '#D32F2F'
  private readonly green: string = '#388E3C'
  private readonly surface: string = '#F5F5F5'

  build() {
    Column() {
      Row() {
        Column({ space: 2 }) {
          Text('UNIT-04')
            .fontSize(12)
            .fontWeight(FontWeight.Bold)
            .fontColor(this.grey)
          Text('CryoGen Monitor')
            .fontSize(20)
            .fontWeight(FontWeight.Bold)
            .fontColor(this.dark)
        }
        Blank()
        Text('⚙')
          .fontSize(27)
          .fontColor(this.dark)
          .width(42)
          .textAlign(TextAlign.Center)
      }
      .width('100%')
      .height(56)
      .margin({ top: 24, bottom: 12 })

      Scroll() {
        Column() {
          Row() {
            Text('✓')
              .fontSize(17)
              .fontWeight(FontWeight.Bold)
              .margin({ right: 10 })
              .fontColor(this.green)
            Text('SYSTEM NOMINAL')
              .fontSize(12)
              .fontWeight(FontWeight.Bold)
              .fontColor(this.green)
          }
          .height(36)
          .padding({ left: 14, right: 14 })
          .border({ width: 1, color: '#80B886', radius: 22 })
          .alignSelf(ItemAlign.Start)

          Column({ space: 15 }) {
            Text('CORE TEMPERATURE')
              .fontSize(12)
              .fontWeight(FontWeight.Medium)
              .fontColor(this.grey)
            Row() {
              Text('-184.2')
                .fontSize(64)
                .fontWeight(FontWeight.Lighter)
                .fontColor(this.dark)
              Text('°C')
                .fontSize(24)
                .fontColor(this.grey)
                .margin({ left: 4, bottom: 12 })
            }
            .alignItems(VerticalAlign.Bottom)
          }
          .width('100%')
          .margin({ top: 32, bottom: 48 })
          .alignItems(HorizontalAlign.Start)

          Column({ space: 12 }) {
            Row({ space: 12 }) {
              this.sensorCard('ⓘ', '1.02', 'Bar', 'PRESSURE', false)
              this.sensorCard('▲', '19.5', '%', 'O2 LEVEL', true)
            }
            .width('100%')
            .height(112)
            Row({ space: 12 }) {
              this.sensorCard('⚒', 'Stable', 'AC', 'POWER', false)
              this.sensorCard('↻', '88', '%', 'LIQUID N2', false)
            }
            .width('100%')
            .height(112)
          }
          .width('100%')
        }
        .width('100%')
        .padding({ top: 16 })
      }
      .layoutWeight(1)
      .scrollBar(BarState.Off)

      Row() {
        Column({ space: 8 }) {
          Text('MANUAL OVERRIDE')
            .fontSize(10)
            .fontWeight(FontWeight.Bold)
            .fontColor(this.grey)
          Text(this.isLocked ? 'LOCKED' : 'ACTIVE')
            .fontSize(14)
            .fontWeight(FontWeight.Bold)
            .fontColor(this.isLocked ? this.dark : this.red)
        }
        Blank()
        Toggle({ type: ToggleType.Switch, isOn: !this.isLocked })
          .selectedColor(this.red)
          .switchPointColor('#FFFFFF')
          .width(76)
          .onChange((value: boolean) => {
            this.isLocked = !value
          })
      }
      .width('100%')
      .height(98)
      .padding({ left: 24, right: 24, top: 24, bottom: 24 })
      .backgroundColor('#EEF5FC')
      .shadow({ radius: 12, color: '#18000000', offsetY: -3 })
    }
    .width('100%')
    .height('100%')
    .padding({ left: 24, right: 24 })
    .backgroundColor('#FFFFFF')
  }

  @Builder
  private sensorCard(icon: string, value: string, unit: string, title: string, warning: boolean) {
    Column() {
      Row() {
        Text(icon)
          .fontSize(20)
          .fontWeight(FontWeight.Bold)
          .fontColor(warning ? this.red : this.blue)
        Blank()
        if (warning) {
          Circle()
            .width(6)
            .height(6)
            .fill(this.red)
        }
      }
      .width('100%')

      Blank()
      Column({ space: 8 }) {
        Text(value)
          .fontSize(20)
          .fontWeight(FontWeight.Bold)
          .fontColor(this.dark)
        Text(`${unit}  ${title}`)
          .fontSize(10)
          .fontWeight(FontWeight.Bold)
          .fontColor(this.grey)
      }
      .width('100%')
      .alignItems(HorizontalAlign.Start)
    }
    .layoutWeight(1)
    .height('100%')
    .padding(16)
    .backgroundColor(this.surface)
    .borderRadius(12)
    .alignItems(HorizontalAlign.Start)
  }
}
