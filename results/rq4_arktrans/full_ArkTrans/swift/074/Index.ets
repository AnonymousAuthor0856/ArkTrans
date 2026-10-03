@Entry
@Component
struct Index {
  @State solarLevel: number = 0.6
  @State ambientGlow: number = 0.4

  build() {
    Stack({ alignContent: Alignment.TopStart }) {
      Column() {
        // Header
        Row() {
          Text('Dock').fontSize(16).fontColor('#2E2924')
          Blank()
          Text('Smart Orbit Panel').fontSize(20).fontWeight(FontWeight.Medium).fontColor('#2E2924')
          Blank()
          Text('Alerts').fontSize(16).fontColor('#1B9AAA')
        }.width('100%').height(56).padding({ left: 16, right: 16 }).backgroundColor('#FFFFFF')

        Scroll() {
          Column() {
            // Mode Tabs
            Row() {
              Button('Orbit')
                .type(ButtonType.Normal)
                .backgroundColor('#F3DCC8')
                .borderRadius(20)
                .fontColor('#2E2924')
                .margin({ right: 8 })
              
              Button('Eclipse')
                .type(ButtonType.Normal)
                .backgroundColor('#FFFFFF')
                .borderRadius(20)
                .fontColor('#2E2924')
                .margin({ right: 8 })
              
              Button('Manual')
                .type(ButtonType.Normal)
                .backgroundColor('#FFFFFF')
                .borderRadius(20)
                .fontColor('#2E2924')
            }.width('100%').justifyContent(FlexAlign.Start).margin({ top: 16, bottom: 16 })

            // Solar Wash Card
            Column() {
              Text('Solar wash').fontSize(24).fontWeight(FontWeight.Bold).fontColor('#2E2924')
              Text('Adjust orbital window glow').fontSize(14).fontColor('#7A7572').margin({ top: 4 })
              
              Slider({ value: this.solarLevel, min: 0, max: 1 })
                .trackColor('#E0E0E0')
                .selectedColor('#D95F02')
                .blockColor('#FFFFFF')
                .width('100%')
                .margin({ top: 20 })

              Row() {
                Text('0%').fontSize(14).fontColor('#2E2924')
                Blank()
                Text(`${Math.round(this.solarLevel * 100)}%`).fontSize(20).fontWeight(FontWeight.Bold).fontColor('#D95F02')
              }.width('100%').margin({ top: 10 })

              Text('Ambient glow').fontSize(24).fontWeight(FontWeight.Bold).fontColor('#2E2924').margin({ top: 20 })
              
              Slider({ value: this.ambientGlow, min: 0, max: 1 })
                .trackColor('#E0E0E0')
                .selectedColor('#1B9AAA')
                .blockColor('#FFFFFF')
                .width('100%')
                .margin({ top: 20 })

              Progress({ value: this.ambientGlow, total: 1, type: ProgressType.Linear })
                .width('100%')
                .height(4)
                .color('#1B9AAA')
                .backgroundColor('#E0E0E0')
                .margin({ top: 10 })
            }
            .width('100%')
            .padding(20)
            .backgroundColor('#FFFFFF')
            .borderRadius(24)
            .shadow({ radius: 10, color: '#1A000000', offsetY: 4 })
            .margin({ bottom: 16 })

            // Orbit Health Card
            Column() {
              Text('Orbit health').fontSize(24).fontWeight(FontWeight.Bold).fontColor('#2E2924')
              
              // Atmos mix
              Column() {
                Row() {
                  Text('Atmos mix').fontSize(16).fontColor('#2E2924')
                  Blank()
                  Text('74%').fontSize(16).fontWeight(FontWeight.Bold).fontColor('#1B9AAA')
                }.width('100%')
                Progress({ value: 0.74, total: 1, type: ProgressType.Linear })
                  .width('100%')
                  .height(4)
                  .color('#1B9AAA')
                  .backgroundColor('#E0E0E0')
                  .margin({ top: 4 })
              }.margin({ top: 16 })

              // Hull temp
              Column() {
                Row() {
                  Text('Hull temp').fontSize(16).fontColor('#2E2924')
                  Blank()
                  Text('42%').fontSize(16).fontWeight(FontWeight.Bold).fontColor('#D95F02')
                }.width('100%')
                Progress({ value: 0.42, total: 1, type: ProgressType.Linear })
                  .width('100%')
                  .height(4)
                  .color('#D95F02')
                  .backgroundColor('#E0E0E0')
                  .margin({ top: 4 })
              }.margin({ top: 16 })

              // Shield sync
              Column() {
                Row() {
                  Text('Shield sync').fontSize(16).fontColor('#2E2924')
                  Blank()
                  Text('88%').fontSize(16).fontWeight(FontWeight.Bold).fontColor('#FFC107')
                }.width('100%')
                Progress({ value: 0.88, total: 1, type: ProgressType.Linear })
                  .width('100%')
                  .height(4)
                  .color('#FFC107')
                  .backgroundColor('#E0E0E0')
                  .margin({ top: 4 })
              }.margin({ top: 16 })
            }
            .width('100%')
            .padding(20)
            .backgroundColor('#F3DCC8')
            .borderRadius(24)
            .shadow({ radius: 10, color: '#1A000000', offsetY: 4 })
            .margin({ bottom: 16 })

            // Deck Zones Card
            Column() {
              Text('Deck zones').fontSize(24).fontWeight(FontWeight.Bold).fontColor('#2E2924')
              
              Column() {
                Row() {
                  Text('Atrium').fontSize(18).fontWeight(FontWeight.Bold).fontColor('#2E2924')
                  Blank()
                  Text('72°F').fontSize(16).fontWeight(FontWeight.Bold).fontColor('#D95F02')
                }.width('100%')
                Progress({ value: 0.6, total: 1, type: ProgressType.Linear })
                  .width('100%')
                  .height(4)
                  .color('#1B9AAA')
                  .backgroundColor('#E0E0E0')
                  .margin({ top: 8 })
              }
              .width('100%')
              .padding(12)
              .backgroundColor('#F3DCC8')
              .borderRadius(12)
              .margin({ top: 16 })
            }
            .width('100%')
            .padding(20)
            .backgroundColor('#FFFFFF')
            .borderRadius(24)
            .shadow({ radius: 10, color: '#1A000000', offsetY: 4 })
            .margin({ bottom: 80 }) // Space for bottom bar
          }
          .width('100%')
          .padding({ left: 16, right: 16, top: 16 })
        }

        // Bottom Bar
        Row() {
          Column() {
            Text('Grid draw').fontSize(12).fontColor('#2E2924')
            Text('18.4 kWh').fontSize(20).fontWeight(FontWeight.Bold).fontColor('#D95F02')
          }
          Blank()
          Button('Engage eco hold')
            .type(ButtonType.Normal)
            .backgroundColor('#D95F02')
            .borderRadius(20)
            .fontColor('#FFFFFF')
            .margin({ right: 16 })
        }
        .width('100%')
        .height(60)
        .padding({ left: 16 })
        .backgroundColor('#FFFFFF')
        .shadow({ radius: 10, color: '#1A000000', offsetY: -4 })
        .position({ x: 0, y: '100%' })
        .translate({ y: -60 })
      }
      .width('100%')
      .height('100%')
      .backgroundColor('#FDF8F3')
    }.width('100%').height('100%')
  }
}