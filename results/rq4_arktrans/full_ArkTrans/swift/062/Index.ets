@Entry
@Component
struct Index {
  @State targetTemp: number = 22
  @State mode: string = 'Cool'

  build() {
    Stack({ alignContent: Alignment.TopStart }) {
      Column() {
        // Header
        Row() {
          Image($r('app.media.startIcon'))
            .width(24)
            .height(24)
            .objectFit(ImageFit.Contain)
            .padding({ left: 16 })
          
          Blank()
          
          Text('ThermoCurve')
            .fontSize(26)
            .fontWeight(FontWeight.Bold)
            .fontColor('#1E293B')
          
          Blank()
          
          Button() {
            Image($r('app.media.startIcon'))
              .width(24)
              .height(24)
              .objectFit(ImageFit.Contain)
          }
          .backgroundColor(Color.Transparent)
          .padding({ right: 16 })
          .onClick(() => {
            this.targetTemp += 1
          })
        }
        .width('100%')
        .height(56)
        .backgroundColor('#F1F5F9')

        // Main Content
        Column() {
          Text('Target Temperature')
            .fontSize(18)
            .fontWeight(FontWeight.Medium)
            .fontColor('#1E293B')
            .margin({ top: 40, bottom: 10 })

          Text(`${this.targetTemp}°C`)
            .fontSize(64)
            .fontWeight(FontWeight.Bold)
            .fontColor('#3B82F6')
            .margin({ bottom: 20 })

          Row() {
            Button() {
              Text('-')
                .fontSize(32)
                .fontColor('#FFFFFF')
            }
            .width(72)
            .height(72)
            .backgroundColor('#3B82F6')
            .borderRadius(12)
            .onClick(() => {
              if (this.targetTemp > 10) {
                this.targetTemp -= 1
              }
            })

            Button() {
              Text('+')
                .fontSize(32)
                .fontColor('#FFFFFF')
            }
            .width(72)
            .height(72)
            .backgroundColor('#3B82F6')
            .borderRadius(12)
            .margin({ left: 16 })
            .onClick(() => {
              if (this.targetTemp < 35) {
                this.targetTemp += 1
              }
            })
          }
          .margin({ bottom: 30 })

          Divider()
            .color('#CBD5E1')
            .strokeWidth(1)
            .margin({ bottom: 30 })

          Text('Mode')
            .fontSize(18)
            .fontWeight(FontWeight.Medium)
            .fontColor('#1E293B')
            .margin({ bottom: 20 })

          Row() {
            Button() {
              Column() {
                Image($r('app.media.startIcon'))
                  .width(32)
                  .height(32)
                  .objectFit(ImageFit.Contain)
                
                Text('Cool')
                  .fontSize(16)
                  .fontColor(this.mode === 'Cool' ? '#FFFFFF' : '#1E293B')
                  .margin({ top: 8 })
              }
            }
            .width(120)
            .height(120)
            .borderRadius(60)
            .backgroundColor(this.mode === 'Cool' ? '#3B82F6' : '#F1F5F9')
            .shadow({ radius: 8, color: '#1F000000', offsetY: 4 })
            .onClick(() => {
              this.mode = 'Cool'
            })

            Button() {
              Column() {
                Image($r('app.media.startIcon'))
                  .width(32)
                  .height(32)
                  .objectFit(ImageFit.Contain)
                
                Text('Heat')
                  .fontSize(16)
                  .fontColor(this.mode === 'Heat' ? '#FFFFFF' : '#1E293B')
                  .margin({ top: 8 })
              }
            }
            .width(120)
            .height(120)
            .borderRadius(60)
            .backgroundColor(this.mode === 'Heat' ? '#3B82F6' : '#F1F5F9')
            .shadow({ radius: 8, color: '#1F000000', offsetY: 4 })
            .margin({ left: 20 })
            .onClick(() => {
              this.mode = 'Heat'
            })
          }
          .margin({ bottom: 30 })

          Text(`Current Mode: ${this.mode}`)
            .fontSize(16)
            .fontColor('#1E293B')
        }
        .width('100%')
        .layoutWeight(1)
        .padding(20)
        .linearGradient({
          angle: 180,
          colors: [['#E0F2FE', 0], ['#BFDBFE', 1]]
        })
      }
      .width('100%')
      .height('100%')
    }
    .width('100%')
    .height('100%')
  }
}