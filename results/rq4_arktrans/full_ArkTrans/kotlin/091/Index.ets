@Entry
@Component
struct Index {
  @State targetTemp: number = 24
  @State currentTemp: number = 22
  @State isPowerOn: boolean = false
  @State selectedMode: string = 'Cool'

  build() {
    Stack({ alignContent: Alignment.Top }) {
      // === Main Content Column ===
      Column({ space: 0 }) {
        Blank().height(10)

        // === Temperature Dial ===
        Stack({ alignContent: Alignment.Center }) {
          // Background Circle
          Column()
            .width(280).height(280)
            .backgroundColor(Color.White)
            .borderRadius(140)
            .border({ width: 1, color: '#EEEEEE' })

          // Center Texts
          Column({ space: 0 }) {
            Text(`${this.targetTemp}°`)
              .fontSize(96)
              .fontWeight(FontWeight.Normal)
              .fontColor(this.isPowerOn ? Color.Black : '#D3D3D3')
            
            Text(`CURRENT: ${this.currentTemp}°`)
              .fontSize(16)
              .fontColor('#A9A9A9')
          }.alignItems(HorizontalAlign.Center)

          // Decrease Button (Left)
          Stack({ alignContent: Alignment.Start }) {
            Button() {
              Image($r('app.media.startIcon'))
                .width(24).height(24)
                .objectFit(ImageFit.Contain)
                .fillColor('#000000')
            }
            .width(48).height(48)
            .backgroundColor('#F5F5F5')
            .borderRadius(24)
            .onClick(() => { this.targetTemp-- })
          }.width('100%').height('100%').padding(20)

          // Increase Button (Right)
          Stack({ alignContent: Alignment.End }) {
            Button() {
              Image($r('app.media.startIcon'))
                .width(24).height(24)
                .objectFit(ImageFit.Contain)
                .fillColor('#000000')
            }
            .width(48).height(48)
            .backgroundColor('#F5F5F5')
            .borderRadius(24)
            .onClick(() => { this.targetTemp++ })
          }.width('100%').height('100%').padding(20)
        }.width(280).height(280)

        // === Mode Section ===
        Column({ space: 0 }) {
          Text('MODE')
            .fontSize(12)
            .fontWeight(FontWeight.Bold)
            .fontColor('#A9A9A9')
            .margin({ bottom: 16 })

          Row({ space: 12 }) {
            // Auto
            Column({ space: 0 }) {
              Button() {
                Image($r('app.media.startIcon'))
                  .width(24).height(24)
                  .objectFit(ImageFit.Contain)
                  .fillColor(this.selectedMode === 'Auto' ? Color.White : '#000000')
              }
              .width(60).height(60)
              .backgroundColor(this.selectedMode === 'Auto' ? '#000000' : Color.White)
              .borderRadius(30)
              .border({ width: 1, color: '#E0E0E0' })
              .onClick(() => { this.selectedMode = 'Auto' })

              Blank().height(8)
              Text('Auto')
                .fontSize(12)
                .fontColor('#A9A9A9')
            }.alignItems(HorizontalAlign.Center)

            // Fan
            Column({ space: 0 }) {
              Button() {
                Image($r('app.media.startIcon'))
                  .width(24).height(24)
                  .objectFit(ImageFit.Contain)
                  .fillColor(this.selectedMode === 'Fan' ? Color.White : '#000000')
              }
              .width(60).height(60)
              .backgroundColor(this.selectedMode === 'Fan' ? '#000000' : Color.White)
              .borderRadius(30)
              .border({ width: 1, color: '#E0E0E0' })
              .onClick(() => { this.selectedMode = 'Fan' })

              Blank().height(8)
              Text('Fan')
                .fontSize(12)
                .fontColor('#A9A9A9')
            }.alignItems(HorizontalAlign.Center)

            // Cool
            Column({ space: 0 }) {
              Button() {
                Image($r('app.media.startIcon'))
                  .width(24).height(24)
                  .objectFit(ImageFit.Contain)
                  .fillColor(this.selectedMode === 'Cool' ? Color.White : '#000000')
              }
              .width(60).height(60)
              .backgroundColor(this.selectedMode === 'Cool' ? '#000000' : Color.White)
              .borderRadius(30)
              .border({ width: 1, color: '#E0E0E0' })
              .onClick(() => { this.selectedMode = 'Cool' })

              Blank().height(8)
              Text('Cool')
                .fontSize(12)
                .fontColor('#A9A9A9')
            }.alignItems(HorizontalAlign.Center)
          }
        }.alignItems(HorizontalAlign.Center).width('100%')

        // === Info Cards ===
        Row({ space: 16 }) {
          // Humidity Card
          Column() {
            Column({ space: 8 }) {
              Image($r('app.media.startIcon'))
                .width(20).height(20)
                .objectFit(ImageFit.Contain)
                .fillColor('#A9A9A9')
              
              Text('45%')
                .fontSize(24)
                .fontWeight(FontWeight.Bold)
                .fontColor('#000000')
              
              Text('Humidity')
                .fontSize(12)
                .fontColor('#A9A9A9')
            }.padding(16)
          }
          .layoutWeight(1)
          .backgroundColor('#F9F9F9')
          .borderRadius(16)
          .border({ width: 1, color: '#F0F0F0' })

          // Energy Card
          Column() {
            Column({ space: 8 }) {
              Image($r('app.media.startIcon'))
                .width(20).height(20)
                .objectFit(ImageFit.Contain)
                .fillColor('#A9A9A9')
              
              Text('12 kWh')
                .fontSize(24)
                .fontWeight(FontWeight.Bold)
                .fontColor('#000000')
              
              Text('Energy')
                .fontSize(12)
                .fontColor('#A9A9A9')
            }.padding(16)
          }
          .layoutWeight(1)
          .backgroundColor('#F9F9F9')
          .borderRadius(16)
          .border({ width: 1, color: '#F0F0F0' })
        }.width('100%')

        // === Master Power Switch ===
        Row({ space: 0 }) {
          Column({ space: 0 }) {
            Text('Master Power')
              .fontSize(16)
              .fontWeight(FontWeight.Medium)
              .fontColor('#000000')
            
            Text(this.isPowerOn ? "System is running" : "System is off")
              .fontSize(12)
              .fontColor('#A9A9A9')
          }

          Toggle({ type: ToggleType.Switch, isOn: this.isPowerOn })
            .onChange((isOn: boolean) => { this.isPowerOn = isOn })
        }
        .justifyContent(FlexAlign.SpaceBetween)
        .alignItems(VerticalAlign.Center)
        .width('100%')
        .padding({ left: 20, right: 20, top: 16, bottom: 16 })
        .backgroundColor('#F9F9F9')
        .borderRadius(16)
      }
      .alignItems(HorizontalAlign.Center)
      .width('100%')
      .height('100%')
      .padding({ left: 24, right: 24 })

      // === Header Row ===
      Row({ space: 0 }) {
        Button() {
          Image($r('app.media.startIcon'))
            .width(24).height(24)
            .objectFit(ImageFit.Contain)
            .fillColor('#A9A9A9')
        }

        Column({ space: 0 }) {
          Text('LIVING ROOM')
            .fontSize(14)
            .fontWeight(FontWeight.Bold)
            .letterSpacing(2)
            .fontColor('#A9A9A9')
          
          Text('Active')
            .fontSize(12)
            .fontColor('#4CAF50')
          
          Text('Off')
            .fontSize(12)
            .fontColor('#D3D3D3')
        }.alignItems(HorizontalAlign.Center)

        Button() {
          Image($r('app.media.startIcon'))
            .width(24).height(24)
            .objectFit(ImageFit.Contain)
            .fillColor('#A9A9A9')
        }
      }
      .justifyContent(FlexAlign.SpaceBetween)
      .alignItems(VerticalAlign.Center)
      .width('100%')
      .padding({ left: 24, right: 24, top: 24, bottom: 24 })
    }.width('100%').height('100%')
  }
}