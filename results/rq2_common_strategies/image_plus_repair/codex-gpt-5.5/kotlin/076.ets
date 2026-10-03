@Entry
@Component
struct MainPage {
  @State selectedScene: string = 'Home'
  @State lampOn: boolean = true
  @State thermostatOn: boolean = true
  @State lockOn: boolean = false
  @State routerOn: boolean = true

  @Builder
  private iconGlyph(glyph: string, color: string, size: number = 24) {
    Text(glyph)
      .fontSize(size)
      .fontColor(color)
      .fontWeight(FontWeight.Bold)
      .textAlign(TextAlign.Center)
  }

  @Builder
  private sceneButton(label: string, glyph: string) {
    Row({ space: 10 }) {
      this.iconGlyph(glyph, this.selectedScene === label ? '#FFFFFF' : '#000000', 22)
      Text(label)
        .fontSize(18)
        .fontColor(this.selectedScene === label ? '#FFFFFF' : '#000000')
        .fontWeight(FontWeight.Medium)
    }
    .height(64)
    .padding({ left: 22, right: 22 })
    .borderRadius(34)
    .backgroundColor(this.selectedScene === label ? '#212121' : '#FFFFFF')
    .justifyContent(FlexAlign.Center)
    .onClick(() => {
      this.selectedScene = label
    })
  }

  @Builder
  private deviceCard(
    name: string,
    glyph: string,
    accent: string,
    enabled: boolean,
    onChange: (value: boolean) => void
  ) {
    Column() {
      Row() {
        Stack() {
          Circle()
            .width(80)
            .height(80)
            .fill(enabled ? this.withAlpha(accent, '18') : '#F0F0F0')
          this.iconGlyph(glyph, enabled ? accent : '#8B8B8B', 34)
        }
        .width(80)
        .height(80)
      }
      .width('100%')
      .justifyContent(FlexAlign.Start)

      Blank()
        .layoutWeight(1)

      Text(name)
        .fontSize(19)
        .fontColor('#111111')
        .fontWeight(FontWeight.Bold)
        .maxLines(1)

      Text(enabled ? 'On' : 'Off')
        .margin({ top: 6 })
        .fontSize(16)
        .fontColor(enabled ? accent : '#909090')
        .fontWeight(FontWeight.Medium)

      Row() {
        Toggle({ type: ToggleType.Switch, isOn: enabled })
          .width(52)
          .height(32)
          .selectedColor(accent)
          .switchPointColor('#FFFFFF')
          .onChange((value: boolean) => {
            onChange(value)
          })
      }
      .width('100%')
      .margin({ top: 12 })
      .justifyContent(FlexAlign.End)
    }
    .width('100%')
    .height(255)
    .padding(18)
    .backgroundColor('#FFFFFF')
    .borderRadius(20)
    .shadow({
      radius: 7,
      color: '#18000000',
      offsetX: 0,
      offsetY: 2
    })
  }

  private withAlpha(color: string, alpha: string): string {
    return color + alpha
  }

  build() {
    Scroll() {
      Column() {
        Row() {
          Column() {
            Text('Good Morning,')
              .fontSize(31)
              .fontColor('#8C8C8C')
              .fontWeight(FontWeight.Medium)
            Text('Alex Johnson')
              .margin({ top: 6 })
              .fontSize(46)
              .fontColor('#000000')
              .fontWeight(FontWeight.Bold)
          }
          .alignItems(HorizontalAlign.Start)

          Blank()
            .layoutWeight(1)

          Stack() {
            Circle()
              .width(96)
              .height(96)
              .fill('#FFFFFF')
            this.iconGlyph('●', '#000000', 26)
            this.iconGlyph('⌣', '#000000', 46)
          }
          .width(96)
          .height(96)
          .alignContent(Alignment.Center)
        }
        .width('100%')
        .alignItems(VerticalAlign.Center)

        Row() {
          Column() {
            Text('Energy Usage')
              .fontSize(28)
              .fontColor('#DCDCF3')
            Text('28.5 kWh')
              .margin({ top: 10 })
              .fontSize(58)
              .fontColor('#FFFFFF')
              .fontWeight(FontWeight.Bold)
            Text('Today')
              .margin({ top: 8 })
              .fontSize(25)
              .fontColor('#BFC0ED')
          }
          .alignItems(HorizontalAlign.Start)

          Blank()
            .layoutWeight(1)

          Stack() {
            Circle()
              .width(112)
              .height(112)
              .fill('#FFFFFF33')
            this.iconGlyph('♟', '#FFFFFF', 43)
          }
          .width(112)
          .height(112)
          .alignContent(Alignment.Center)
        }
        .width('100%')
        .padding({ left: 48, right: 48 })
        .height(268)
        .margin({ top: 70 })
        .borderRadius(48)
        .backgroundColor('#5E60CE')
        .shadow({
          radius: 22,
          color: '#39000000',
          offsetX: 0,
          offsetY: 10
        })

        Text('Scenes')
          .margin({ top: 66 })
          .fontSize(39)
          .fontColor('#000000')
          .fontWeight(FontWeight.Bold)
          .alignSelf(ItemAlign.Start)

        Row({ space: 22 }) {
          this.sceneButton('Home', '⌂')
          this.sceneButton('Away', '▣')
          this.sceneButton('Sleep', '★')
        }
        .width('100%')
        .margin({ top: 30 })
        .justifyContent(FlexAlign.Start)

        Text('Devices')
          .margin({ top: 70 })
          .fontSize(39)
          .fontColor('#000000')
          .fontWeight(FontWeight.Bold)
          .alignSelf(ItemAlign.Start)

        Row({ space: 28 }) {
          Column({ space: 28 }) {
            this.deviceCard('Smart Lamp', '★', '#FFC107', this.lampOn, (value: boolean) => {
              this.lampOn = value
            })
            this.deviceCard('Thermostat', '≡', '#FF7043', this.thermostatOn, (value: boolean) => {
              this.thermostatOn = value
            })
          }
          .layoutWeight(1)

          Column({ space: 28 }) {
            this.deviceCard('Main Lock', '▣', '#4CAF50', this.lockOn, (value: boolean) => {
              this.lockOn = value
            })
            this.deviceCard('Wi-Fi Router', '⚙', '#2196F3', this.routerOn, (value: boolean) => {
              this.routerOn = value
            })
          }
          .layoutWeight(1)
        }
        .width('100%')
        .margin({ top: 30 })
      }
      .width('100%')
      .padding({ left: 48, right: 48, top: 52, bottom: 50 })
    }
    .width('100%')
    .height('100%')
    .backgroundColor('#F4F6F8')
    .scrollBar(BarState.Off)
  }
}
