@Entry
@Component
struct Index {
  @State targetTemp: number = 72
  @State isActive: boolean = false

  build() {
    Stack({ alignContent: Alignment.Center }) {
      Column() {
        // HeaderSection
        Row({ space: 0 }) {
          Button() {
            Image($r('app.media.startIcon'))
              .width(24)
              .height(24)
              .objectFit(ImageFit.Contain)
          }
          .backgroundColor(Color.Transparent)
          .borderRadius(8)

          Column({ space: 4 }) {
            Text('LIVING ROOM')
              .fontSize(14)
              .fontWeight(FontWeight.Bold)
              .fontColor('#757575')
              .letterSpacing(2)
            Text('Connected')
              .fontSize(12)
              .fontColor('#6200EE')
          }.alignItems(HorizontalAlign.Center)

          Button() {
            Image($r('app.media.startIcon'))
              .width(24)
              .height(24)
              .objectFit(ImageFit.Contain)
          }
          .backgroundColor(Color.Transparent)
          .borderRadius(8)
        }
        .justifyContent(FlexAlign.SpaceBetween)
        .alignItems(VerticalAlign.Center)
        .width('100%')
        .padding({ top: 16 })

        Blank().height(40)

        // TemperatureDialSection
        Column({ space: 0 }) {
          Stack({ alignContent: Alignment.Center }) {
            // Placeholder for Dial Canvas
            Circle()
              .width(240)
              .height(240)
              .fill(Color.Transparent)
            
            // Placeholder for Progress Arc
            Circle()
              .width(240)
              .height(240)
              .fill(Color.Transparent)

            Column({ space: 8 }) {
              Text(`${this.targetTemp}°`)
                .fontSize(36)
                .fontWeight(FontWeight.Bold)
                .fontColor(this.isActive ? '#000000' : '#757575')
              
              Text(this.isActive ? "COOLING" : "OFF")
                .fontSize(16)
                .fontWeight(FontWeight.Medium)
                .fontColor('#757575')
            }.alignItems(HorizontalAlign.Center)
          }
          .width(280)
          .height(280)

          Blank().height(32)

          Row({ space: 32 }) {
            // Down Button
            Stack({ alignContent: Alignment.Center }) {
              Image($r('app.media.startIcon'))
                .width(28)
                .height(28)
                .objectFit(ImageFit.Contain)
                .opacity(this.isActive ? 1.0 : 0.5)
            }
            .width(56)
            .height(56)
            .borderRadius(28)
            .backgroundColor(this.isActive ? '#F5F5F5' : '#F9F9F9')
            .border({ width: 1, color: this.isActive ? Color.Transparent : '#EEEEEE', radius: 28 })
            .onClick(() => {
              if (this.isActive) {
                this.targetTemp -= 0.5
              }
            })

            // Switch
            Toggle({ type: ToggleType.Switch, isOn: this.isActive })
              .onChange((isOn: boolean) => {
                this.isActive = isOn
              })

            // Up Button
            Stack({ alignContent: Alignment.Center }) {
              Image($r('app.media.startIcon'))
                .width(28)
                .height(28)
                .objectFit(ImageFit.Contain)
                .opacity(this.isActive ? 1.0 : 0.5)
            }
            .width(56)
            .height(56)
            .borderRadius(28)
            .backgroundColor(this.isActive ? '#F5F5F5' : '#F9F9F9')
            .border({ width: 1, color: this.isActive ? Color.Transparent : '#EEEEEE', radius: 28 })
            .onClick(() => {
              if (this.isActive) {
                this.targetTemp += 0.5
              }
            })
          }
          .alignItems(VerticalAlign.Center)
        }
        .alignItems(HorizontalAlign.Center)

        Blank().height(40)

        // ControlGridSection
        Column({ space: 0 }) {
          Text('QUICK ACTIONS')
            .fontSize(12)
            .fontWeight(FontWeight.Bold)
            .fontColor('#757575')
            .padding({ bottom: 16 })

          Row({ space: 16 }) {
            // Card 1: Fan Speed
            Column() {
              Column({ space: 8 }) {
                Image($r('app.media.startIcon'))
                  .width(24)
                  .height(24)
                  .objectFit(ImageFit.Contain)
                
                Column({ space: 4 }) {
                  Text('Fan Speed')
                    .fontSize(14)
                    .fontWeight(FontWeight.Medium)
                    .fontColor(this.isActive ? '#FFFFFF' : '#000000')
                  Text('Auto')
                    .fontSize(12)
                    .fontColor('#757575')
                }
              }
              .alignItems(HorizontalAlign.Start)
              .width('100%')
              .layoutWeight(1)
            }
            .width('100%')
            .height(100)
            .padding(16)
            .backgroundColor('#FFFFFF')
            .borderRadius(12)
            .shadow({ radius: 4, color: '#1A000000' })
            .layoutWeight(1)

            // Card 2: Eco Mode
            Column() {
              Column({ space: 8 }) {
                Image($r('app.media.startIcon'))
                  .width(24)
                  .height(24)
                  .objectFit(ImageFit.Contain)
                
                Column({ space: 4 }) {
                  Text('Eco Mode')
                    .fontSize(14)
                    .fontWeight(FontWeight.Medium)
                    .fontColor(true ? '#FFFFFF' : '#000000') // Simulating isActive=true for this card as per skeleton
                  Text('On')
                    .fontSize(12)
                    .fontColor('#757575')
                }
              }
              .alignItems(HorizontalAlign.Start)
              .width('100%')
              .layoutWeight(1)
            }
            .width('100%')
            .height(100)
            .padding(16)
            .backgroundColor('#000000') // Active state background
            .borderRadius(12)
            .shadow({ radius: 4, color: '#1A000000' })
            .layoutWeight(1)
          }
          .width('100%')

          Blank().height(16)

          Row({ space: 16 }) {
            // Card 3: Timer
            Column() {
              Column({ space: 8 }) {
                Image($r('app.media.startIcon'))
                  .width(24)
                  .height(24)
                  .objectFit(ImageFit.Contain)
                
                Column({ space: 4 }) {
                  Text('Timer')
                    .fontSize(14)
                    .fontWeight(FontWeight.Medium)
                    .fontColor(this.isActive ? '#FFFFFF' : '#000000')
                  Text('Set 2h')
                    .fontSize(12)
                    .fontColor('#757575')
                }
              }
              .alignItems(HorizontalAlign.Start)
              .width('100%')
              .layoutWeight(1)
            }
            .width('100%')
            .height(100)
            .padding(16)
            .backgroundColor('#FFFFFF')
            .borderRadius(12)
            .shadow({ radius: 4, color: '#1A000000' })
            .layoutWeight(1)

            // Card 4: Away
            Column() {
              Column({ space: 8 }) {
                Image($r('app.media.startIcon'))
                  .width(24)
                  .height(24)
                  .objectFit(ImageFit.Contain)
                
                Column({ space: 4 }) {
                  Text('Away')
                    .fontSize(14)
                    .fontWeight(FontWeight.Medium)
                    .fontColor(this.isActive ? '#FFFFFF' : '#000000')
                  Text('Off')
                    .fontSize(12)
                    .fontColor('#757575')
                }
              }
              .alignItems(HorizontalAlign.Start)
              .width('100%')
              .layoutWeight(1)
            }
            .width('100%')
            .height(100)
            .padding(16)
            .backgroundColor('#FFFFFF')
            .borderRadius(12)
            .shadow({ radius: 4, color: '#1A000000' })
            .layoutWeight(1)
          }
          .width('100%')
        }
        .width('100%')
      }
      .alignItems(HorizontalAlign.Center)
      .width('100%')
      .height('100%')
      .padding(24)
      .backgroundColor('#FFFFFF')
    }
    .width('100%')
    .height('100%')
  }
}