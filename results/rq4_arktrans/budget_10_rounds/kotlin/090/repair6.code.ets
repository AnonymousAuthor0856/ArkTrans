@Entry
@Component
struct Index {
  @State apertureValue: number = 2.8
  @State selectedIsoIndex: number = 2
  @State selectedSpeedIndex: number = 1

  private isoOptions: string[] = ['100', '200', '400', '800', '1600']
  private shutterOptions: string[] = ['1/125', '1/60', '1/30']

  build() {
    Column({ space: 0 }) {
      // === HeaderSection ===
      Row({ space: 0 }) {
        Column({ space: 0 }) {
          Text('LUMEN LOG')
            .fontSize(14)
            .fontWeight(FontWeight.Bold)
            .letterSpacing(2)
            .fontColor('#999999')
          Text('Roll #034')
            .fontSize(24)
            .fontWeight(FontWeight.Bolder)
            .fontColor('#000000')
        }
        Blank()
        Row({ space: 16 }) {
          Button() {
            Image($r('app.media.startIcon'))
              .width(24)
              .height(24)
              .fillColor('#000000')
          }.backgroundColor(Color.Transparent).borderRadius(0)
          
          Button() {
            Image($r('app.media.startIcon'))
              .width(24)
              .height(24)
              .fillColor('#000000')
          }.backgroundColor(Color.Transparent).borderRadius(0)
        }
      }
      .alignItems(VerticalAlign.Center)
      .width('100%')
      .padding({ bottom: 16 })

      // === CurrentSettingsDisplay ===
      Column() {
        Row({ space: 0 }) {
          Column({ space: 0 }) {
            Text(`f/${this.apertureValue.toFixed(1)}`)
              .fontSize(56)
              .fontWeight(FontWeight.Normal)
              .fontColor('#000000')
              .letterSpacing(-2)
            Text('APERTURE')
              .fontSize(12)
              .fontWeight(FontWeight.Bold)
              .fontColor('#999999')
          }
          .justifyContent(FlexAlign.Start)
          .layoutWeight(1.5)
          .padding({ start: 24 })

          Divider()
            .vertical(true)
            .height(80)
            .color('#E0E0E0')

          Column({ space: 16 }) {
            Column({ space: 0 }) {
              Text(this.isoOptions[this.selectedIsoIndex])
                .fontSize(20)
                .fontWeight(FontWeight.Medium)
                .fontColor('#000000')
              Text('ISO')
                .fontSize(10)
                .fontWeight(FontWeight.Bold)
                .fontColor('#999999')
            }
            
            Column({ space: 0 }) {
              Text(this.shutterOptions[this.selectedSpeedIndex])
                .fontSize(20)
                .fontWeight(FontWeight.Medium)
                .fontColor('#000000')
              Text('SHUTTER')
                .fontSize(10)
                .fontWeight(FontWeight.Bold)
                .fontColor('#999999')
            }
          }
          .justifyContent(FlexAlign.Center)
          .layoutWeight(1)
          .padding({ start: 24 })
        }
        .alignItems(VerticalAlign.Center)
        .width('100%')
        .height(160)
      }
      .width('100%')
      .backgroundColor('#F8F8F8')
      .borderRadius(16)
      .border({ width: 1, color: '#EEEEEE' })

      // === Controls Section ===
      Column({ space: 32 }) {
        // === IsoSelector ===
        Column({ space: 12 }) {
          Text('Film Stock ISO')
            .fontSize(14)
            .fontWeight(FontWeight.Medium)
            .fontColor('#000000')
          
          List({ space: 12 }) {
            ForEach(this.isoOptions, (iso: string, index: number) => {
              ListItem() {
                Stack({ alignContent: Alignment.Center }) {
                  Text(iso)
                    .fontSize(13)
                    .fontWeight(FontWeight.Medium)
                    .fontColor(index === this.selectedIsoIndex ? '#FFFFFF' : '#000000')
                }
                .width(60)
                .height(36)
                .borderRadius(50)
                .backgroundColor(index === this.selectedIsoIndex ? '#000000' : 'Transparent')
                .border({ 
                  width: 1, 
                  color: index === this.selectedIsoIndex ? '#000000' : '#E0E0E0',
                  radius: 50 
                })
                .onClick(() => {
                  this.selectedIsoIndex = index
                })
              }
            })
          }
          .listDirection(Axis.Horizontal)
          .width('100%')
        }

        // === ApertureControl ===
        Column({ space: 8 }) {
          Row({ space: 0 }) {
            Text('Aperture Control')
              .fontSize(14)
              .fontWeight(FontWeight.Medium)
              .fontColor('#000000')
            Blank()
            Image($r('app.media.startIcon'))
              .width(16)
              .height(16)
              .fillColor('#999999')
          }
          .width('100%')

          Slider({
            value: this.apertureValue,
            min: 1.4,
            max: 16,
            step: 0.1
          })
          .width('100%')
          .trackColor('#E0E0E0')
          .selectedColor('#000000')
          .blockColor('#000000')
          .onChange((value: number) => {
            this.apertureValue = value
          })

          Row({ space: 0 }) {
            Text('f/1.4')
              .fontSize(12)
              .fontColor('#999999')
            Blank()
            Text('f/16')
              .fontSize(12)
              .fontColor('#999999')
          }
          .width('100%')
        }

        // === ShutterSpeedControl ===
        Column({ space: 12 }) {
          Text('Shutter Speed')
            .fontSize(14)
            .fontWeight(FontWeight.Medium)
            .fontColor('#000000')
          
          Row({ space: 0 }) {
            ForEach(this.shutterOptions, (speed: string, index: number) => {
              Stack({ alignContent: Alignment.Center }) {
                Text(speed)
                  .fontSize(index === this.selectedSpeedIndex ? 22 : 16)
                  .fontWeight(index === this.selectedSpeedIndex ? FontWeight.Bold : FontWeight.Normal)
                  .fontColor(index === this.selectedSpeedIndex ? '#000000' : '#CCCCCC')
              }
              .width(100)
              .height(50)
              .borderRadius(12)
              .backgroundColor(index === this.selectedSpeedIndex ? '#F0F0F0' : 'Transparent')
              .onClick(() => {
                this.selectedSpeedIndex = index
              })
            })
          }
          .width('100%')
        }
      }
      .layoutWeight(1)

      // === LogShotButton ===
      Button() {
        Row({ space: 12 }) {
          Stack({ alignContent: Alignment.Center }) {
            Image($r('app.media.startIcon'))
              .width(16)
              .height(16)
              .fillColor('#000000')
          }
          .width(24)
          .height(24)
          .borderRadius(12)
          .backgroundColor('#FFFFFF')
          
          Text('LOG EXPOSURE')
            .fontSize(16)
            .fontWeight(FontWeight.Bold)
            .letterSpacing(1)
            .fontColor('#FFFFFF')
        }
        .alignItems(VerticalAlign.Center)
      }
      .width('100%')
      .height(56)
      .backgroundColor('#000000')
      .borderRadius(12)
    }
    .width('100%')
    .height('100%')
    .padding(24)
  }
}