@Entry
@Component
struct Index {
  @State currentTemp: number = 22
  @State targetTemp: number = 24
  @State isPowerOn: boolean = true
  @State selectedMode: string = 'Cool'

  @Builder
  ModeButton(icon: string, label: string) {
    Column() {
      Text(icon)
        .width(60)
        .height(60)
        .borderRadius(30)
        .backgroundColor(this.selectedMode === label && this.isPowerOn ? Color.Black : (this.isPowerOn ? Color.White : '#F5F5F5'))
        .fontColor(this.selectedMode === label && this.isPowerOn ? Color.White : (this.isPowerOn ? Color.Black : '#D3D3D3'))
        .fontSize(label === 'Cool' ? 32 : 30)
        .fontWeight(FontWeight.Bold)
        .textAlign(TextAlign.Center)
        .border({
          width: this.selectedMode === label && this.isPowerOn ? 0 : 1,
          color: this.selectedMode === label && this.isPowerOn ? Color.Black : '#E0E0E0'
        })
        .onClick(() => {
          if (this.isPowerOn) {
            this.selectedMode = label
          }
        })

      Text(label)
        .fontSize(14)
        .fontWeight(FontWeight.Bold)
        .fontColor(this.isPowerOn ? Color.Gray : '#D3D3D3')
        .margin({ top: 8 })
    }
    .alignItems(HorizontalAlign.Center)
  }

  @Builder
  InfoCard(title: string, value: string, icon: string) {
    Column({ space: 8 }) {
      Text(icon)
        .fontSize(22)
        .fontWeight(FontWeight.Bold)
        .fontColor(Color.Gray)

      Text(value)
        .fontSize(28)
        .fontWeight(FontWeight.Bold)
        .fontColor(Color.Black)
        .margin({ top: 8 })

      Text(title)
        .fontSize(14)
        .fontColor(Color.Gray)
    }
    .alignItems(HorizontalAlign.Start)
    .justifyContent(FlexAlign.Center)
    .layoutWeight(1)
    .height(116)
    .padding(16)
    .backgroundColor('#F9F9F9')
    .borderRadius(16)
    .border({ width: 1, color: '#F0F0F0' })
  }

  build() {
    Column() {
      Row() {
        Text('☰')
          .width(48)
          .height(48)
          .fontSize(32)
          .fontColor(Color.Gray)
          .textAlign(TextAlign.Center)

        Column() {
          Text('LIVING ROOM')
            .fontSize(16)
            .fontWeight(FontWeight.Bold)
            .fontColor(Color.Gray)
            .letterSpacing(2)

          Text(this.isPowerOn ? 'Active' : 'Off')
            .fontSize(14)
            .fontWeight(FontWeight.Bold)
            .fontColor(this.isPowerOn ? '#4CAF50' : '#D3D3D3')
            .margin({ top: 4 })
        }
        .alignItems(HorizontalAlign.Center)

        Text('⚙')
          .width(48)
          .height(48)
          .fontSize(32)
          .fontColor(Color.Gray)
          .textAlign(TextAlign.Center)
      }
      .width('100%')
      .height(120)
      .padding({ left: 48, right: 48, top: 34 })
      .justifyContent(FlexAlign.SpaceBetween)
      .alignItems(VerticalAlign.Center)

      Column() {
        Stack({ alignContent: Alignment.Center }) {
          Column()
            .width(280)
            .height(280)
            .borderRadius(140)
            .backgroundColor(Color.White)
            .border({ width: 1, color: '#EEEEEE' })

          Column() {
            Text(`${this.targetTemp}°`)
              .fontSize(96)
              .fontWeight(200)
              .fontColor(this.isPowerOn ? Color.Black : '#D3D3D3')
              .textAlign(TextAlign.Center)
              .height(116)

            Text(`CURRENT: ${this.currentTemp}°`)
              .fontSize(16)
              .fontColor(Color.Gray)
              .fontWeight(FontWeight.Medium)
              .margin({ top: 6 })
          }
          .alignItems(HorizontalAlign.Center)

          if (this.isPowerOn) {
            Row() {
              Text('⌄')
                .width(48)
                .height(48)
                .borderRadius(24)
                .backgroundColor('#F5F5F5')
                .fontSize(32)
                .fontWeight(FontWeight.Bold)
                .fontColor(Color.Black)
                .textAlign(TextAlign.Center)
                .onClick(() => {
                  this.targetTemp--
                })

              Text('+')
                .width(48)
                .height(48)
                .borderRadius(24)
                .backgroundColor('#F5F5F5')
                .fontSize(32)
                .fontWeight(FontWeight.Regular)
                .fontColor(Color.Black)
                .textAlign(TextAlign.Center)
                .onClick(() => {
                  this.targetTemp++
                })
            }
            .width(240)
            .justifyContent(FlexAlign.SpaceBetween)
            .alignItems(VerticalAlign.Center)
          }
        }
        .width(280)
        .height(280)
        .margin({ top: 0 })

        Column() {
          Text('MODE')
            .fontSize(13)
            .fontWeight(FontWeight.Bold)
            .fontColor(Color.Gray)
            .margin({ bottom: 16 })

          Row({ space: 24 }) {
            this.ModeButton('⌂', 'Auto')
            this.ModeButton('↻', 'Fan')
            this.ModeButton('★', 'Cool')
          }
          .justifyContent(FlexAlign.Center)
          .alignItems(VerticalAlign.Center)
        }
        .width('100%')
        .alignItems(HorizontalAlign.Center)
        .margin({ top: 2 })

        Row({ space: 16 }) {
          this.InfoCard('Humidity', '45%', 'ℹ')
          this.InfoCard('Energy', '⌃')
        }
        .width('100%')
        .padding({ left: 24, right: 24 })
        .margin({ top: 8 })

        Row() {
          Column() {
            Text('Master Power')
              .fontSize(16)
              .fontWeight(FontWeight.Bold)
              .fontColor(Color.Black)

            Text(this.isPowerOn ? 'System is running' : 'System is off')
              .fontSize(13)
              .fontColor(Color.Gray)
              .margin({ top: 4 })
          }
          .alignItems(HorizontalAlign.Start)

          Toggle({ type: ToggleType.Switch, isOn: this.isPowerOn })
            .selectedColor(Color.Black)
            .switchPointColor(Color.White)
            .onChange((value: boolean) => {
              this.isPowerOn = value
            })
        }
        .width('100%')
        .padding({ left: 20, right: 20, top: 16, bottom: 16 })
        .backgroundColor('#F9F9F9')
        .borderRadius(16)
        .justifyContent(FlexAlign.SpaceBetween)
        .alignItems(VerticalAlign.Center)
        .margin({ left: 24, right: 24, top: 16, bottom: 40 })
      }
      .layoutWeight(1)
      .width('100%')
      .alignItems(HorizontalAlign.Center)
      .justifyContent(FlexAlign.SpaceBetween)
    }
    .width('100%')
    .height('100%')
    .backgroundColor(Color.White)
  }
}