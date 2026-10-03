@Entry
@Component
struct Index {
  @State targetTemp: number = 0
  @State currentTemp: number = 0
  @State isPowerOn: boolean = false

  build() {
    Stack({ alignContent: Alignment.Top }) {
      Column({ space: 0 }) {
        Blank().height(10)

        // === Circular Control Area ===
        Stack({ alignContent: Alignment.Center }) {
          // Background Circle
          Column()
            .width('100%')
            .height('100%')
            .backgroundColor(Color.White)
            .borderRadius('50%')
            .shadow({ radius: 4, color: '#1A000000' })

          // Center Texts
          Column({ space: 0 }) {
            Text(`${this.targetTemp}°`)
              .fontSize(32)
              .fontWeight(FontWeight.Normal)
              .fontColor(this.isPowerOn ? Color.Black : '#D3D3D3')
            
            Text(`CURRENT: ${this.currentTemp}°`)
              .fontSize(14)
              .fontColor(Color.Gray)
          }
          .alignItems(HorizontalAlign.Center)

          // Increase Button (Right)
          Stack({ alignContent: Alignment.End }) {
            Button() {
              Image($r('app.media.startIcon'))
                .width(24)
                .height(24)
                .objectFit(ImageFit.Contain)
            }
            .width(48)
            .height(48)
            .backgroundColor('#F5F5F5')
            .borderRadius('50%')
            .onClick(() => {
              this.targetTemp++
            })
          }
          .width('100%')
          .height('100%')
          .padding(20)

          // Decrease Button (Left)
          Stack({ alignContent: Alignment.Start }) {
            Button() {
              Image($r('app.media.startIcon'))
                .width(24)
                .height(24)
                .objectFit(ImageFit.Contain)
            }
            .width(48)
            .height(48)
            .backgroundColor('#F5F5F5')
            .borderRadius('50%')
            .onClick(() => {
              this.targetTemp--
            })
          }
          .width('100%')
          .height('100%')
          .padding(20)
        }
        .width(280)
        .height(280)

        // === Mode Selection ===
        Column({ space: 0 }) {
          Text('MODE')
            .fontSize(12)
            .fontColor(Color.Gray)
            .fontWeight(FontWeight.Bold)
            .margin({ bottom: 16 })
            .textAlign(TextAlign.Center)

          Row({ space: 12 }) {
            // Auto Mode
            Column({ space: 0 }) {
              Button() {
                Image($r('app.media.startIcon'))
                  .width(24)
                  .height(24)
              }
              .width(60)
              .height(60)
              .backgroundColor(this.isPowerOn ? Color.White : '#F5F5F5')
              .borderRadius('50%')
              .border({ width: 1, color: '#EEEEEE' })
              
              Blank().height(8)
              
              Text('Auto')
                .fontSize(12)
                .fontColor(this.isPowerOn ? Color.Gray : '#D3D3D3')
            }
            .alignItems(HorizontalAlign.Center)

            // Fan Mode
            Column({ space: 0 }) {
              Button() {
                Image($r('app.media.startIcon'))
                  .width(24)
                  .height(24)
              }
              .width(60)
              .height(60)
              .backgroundColor(this.isPowerOn ? Color.White : '#F5F5F5')
              .borderRadius('50%')
              .border({ width: 1, color: '#EEEEEE' })
              
              Blank().height(8)
              
              Text('Fan')
                .fontSize(12)
                .fontColor(this.isPowerOn ? Color.Gray : '#D3D3D3')
            }
            .alignItems(HorizontalAlign.Center)

            // Cool Mode
            Column({ space: 0 }) {
              Button() {
                Image($r('app.media.startIcon'))
                  .width(24)
                  .height(24)
              }
              .width(60)
              .height(60)
              .backgroundColor(this.isPowerOn ? Color.White : '#F5F5F5')
              .borderRadius('50%')
              .border({ width: 1, color: '#EEEEEE' })
              
              Blank().height(8)
              
              Text('Cool')
                .fontSize(12)
                .fontColor(this.isPowerOn ? Color.Gray : '#D3D3D3')
            }
            .alignItems(HorizontalAlign.Center)
          }
        }
        .width('100%')
        .alignItems(HorizontalAlign.Center)

        // === Info Cards ===
        Row({ space: 16 }) {
          // Humidity Card
          Column() {
            Column({ space: 8 }) {
              Image($r('app.media.startIcon'))
                .width(20)
                .height(20)
                .objectFit(ImageFit.Contain)
              
              Text('45%')
                .fontSize(20)
                .fontWeight(FontWeight.Bold)
              
              Text('Humidity')
                .fontSize(12)
                .fontColor(Color.Gray)
            }
            .padding(16)
          }
          .layoutWeight(1)
          .backgroundColor('#FFFFFF')
          .borderRadius(12)
          .shadow({ radius: 4, color: '#1A000000' })

          // Energy Card
          Column() {
            Column({ space: 8 }) {
              Image($r('app.media.startIcon'))
                .width(20)
                .height(20)
                .objectFit(ImageFit.Contain)
              
              Text('12 kWh')
                .fontSize(20)
                .fontWeight(FontWeight.Bold)
              
              Text('Energy')
                .fontSize(12)
                .fontColor(Color.Gray)
            }
            .padding(16)
          }
          .layoutWeight(1)
          .backgroundColor('#FFFFFF')
          .borderRadius(12)
          .shadow({ radius: 4, color: '#1A000000' })
        }
        .width('100%')

        // === Master Power Switch ===
        Row({ space: 0 }) {
          Column({ space: 0 }) {
            Text('Master Power')
              .fontSize(16)
              .fontWeight(FontWeight.Medium)
            
            Text(this.isPowerOn ? "System is running" : "System is off")
              .fontSize(12)
              .fontColor(Color.Gray)
          }

          Toggle({ type: ToggleType.Switch, isOn: this.isPowerOn })
            .onChange((isOn: boolean) => {
              this.isPowerOn = isOn
            })
        }
        .width('100%')
        .justifyContent(FlexAlign.SpaceBetween)
        .alignItems(VerticalAlign.Center)
        .padding({ left: 20, right: 20, top: 16, bottom: 16 })
        .backgroundColor('#F9F9F9')
        .borderRadius(16)
      }
      .width('100%')
      .height('100%')
      .padding({ left: 24, right: 24 })
      .alignItems(HorizontalAlign.Center)

      // === Top Bar / Header Overlay ===
      Row({ space: 0 }) {
        Button() {
          Image($r('app.media.startIcon'))
            .width(24)
            .height(24)
            .objectFit(ImageFit.Contain)
        }
        .backgroundColor(Color.Transparent)

        Column({ space: 0 }) {
          Text('LIVING ROOM')
            .fontSize(14)
            .fontColor(Color.Gray)
            .fontWeight(FontWeight.Bold)
            .letterSpacing(2)
          
          Text('Active')
            .fontSize(12)
            .fontColor('#4CAF50')
          
          Text('Off')
            .fontSize(12)
            .fontColor('#D3D3D3')
        }
        .alignItems(HorizontalAlign.Center)

        Button() {
          Image($r('app.media.startIcon'))
            .width(24)
            .height(24)
            .objectFit(ImageFit.Contain)
        }
        .backgroundColor(Color.Transparent)
      }
      .width('100%')
      .justifyContent(FlexAlign.SpaceBetween)
      .alignItems(VerticalAlign.Center)
      .padding({ left: 24, right: 24, top: 24, bottom: 24 })
    }
    .width('100%')
    .height('100%')
  }
}