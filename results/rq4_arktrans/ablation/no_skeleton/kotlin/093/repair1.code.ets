@Entry
@Component
struct TeaMaster {
  @State selectedIndex: number = 0

  // Data Models
  private teaPresets: Array<TeaPreset> = [
    { name: 'Sencha', temp: '70°C', time: '1-2 min' },
    { name: 'Earl Grey', temp: '98°C', time: '3-4 min' },
    { name: 'Oolong', temp: '85°C', time: '3-5 min' }
  ]

  build() {
    Column() {
      // === Header Section ===
      Row() {
        Column() {
          Text('Tea Master')
            .fontSize(36)
            .fontWeight(FontWeight.Bold)
            .fontColor('#000000')
            .lineHeight(42)
          
          Text('Perfect brew, every time')
            .fontSize(16)
            .fontColor('#9E9E9E')
            .margin({ top: 4 })
        }

        Blank()

        // Settings Icon (Simulated with text for compilation safety as per rules)
        Text('⚙') 
          .fontSize(28)
          .fontColor('#000000')
          .textAlign(TextAlign.Center)
          .width(48)
          .height(48)
          .onClick(() => {})
      }
      .width('100%')
      .padding({ top: 40, bottom: 32 })

      // === Visualization Circle ===
      Column() {
        // Heart Icon
        Text('♥')
          .fontSize(48)
          .fontColor('#8D6E63')
        
        Text(this.teaPresets[this.selectedIndex].name)
          .fontSize(32)
          .fontWeight(FontWeight.Medium)
          .fontColor('#000000')
          .margin({ top: 8 })
      }
      .width(220)
      .height(220)
      .borderRadius(110)
      .backgroundColor('#F5F5F5')
      .justifyContent(FlexAlign.Center)
      .alignItems(HorizontalAlign.Center)
      .margin({ top: 20, bottom: 40 })

      // === Stats Row ===
      Row() {
        // Temp
        Column() {
          Text('TEMP')
            .fontSize(14)
            .fontWeight(FontWeight.Bold)
            .letterSpacing(1)
            .fontColor('#9E9E9E')
          
          Text(this.teaPresets[this.selectedIndex].temp)
            .fontSize(24)
            .fontWeight(FontWeight.Medium)
            .fontColor('#000000')
            .margin({ top: 4 })
        }
        .alignItems(HorizontalAlign.Center)

        Divider()
          .vertical(true)
          .height(40)
          .color('#E0E0E0')
          .margin({ left: 16, right: 16 })

        // Time
        Column() {
          Text('TIME')
            .fontSize(14)
            .fontWeight(FontWeight.Bold)
            .letterSpacing(1)
            .fontColor('#9E9E9E')
          
          Text(this.teaPresets[this.selectedIndex].time)
            .fontSize(24)
            .fontWeight(FontWeight.Medium)
            .fontColor('#000000')
            .margin({ top: 4 })
        }
        .alignItems(HorizontalAlign.Center)

        Divider()
          .vertical(true)
          .height(40)
          .color('#E0E0E0')
          .margin({ left: 16, right: 16 })

        // Amount
        Column() {
          Text('AMOUNT')
            .fontSize(14)
            .fontWeight(FontWeight.Bold)
            .letterSpacing(1)
            .fontColor('#9E9E9E')
          
          Text('250ml')
            .fontSize(24)
            .fontWeight(FontWeight.Medium)
            .fontColor('#000000')
            .margin({ top: 4 })
        }
        .alignItems(HorizontalAlign.Center)
      }
      .width('100%')
      .justifyContent(FlexAlign.SpaceEvenly)
      .margin({ bottom: 40 })

      // === Selection List ===
      Column() {
        Text('Select Variety')
          .fontSize(18)
          .fontWeight(FontWeight.Medium)
          .fontColor('#000000')
          .margin({ bottom: 12 })

        Flex({ wrap: FlexWrap.Wrap }) {
          ForEach(this.teaPresets, (item: TeaPreset, index: number) => {
            Button(item.name)
              .type(ButtonType.Normal)
              .backgroundColor(index === this.selectedIndex ? '#000000' : '#FFFFFF')
              .fontColor(index === this.selectedIndex ? '#FFFFFF' : '#000000')
              .borderWidth(1)
              .borderColor('#E0E0E0')
              .borderRadius(50)
              .height(48)
              .margin({ right: 12, bottom: 12 })
              .onClick(() => {
                this.selectedIndex = index
              })
          })
        }
        .width('100%')
      }
      .width('100%')
      .margin({ bottom: 40 })

      Blank()

      // === Action Button ===
      Button() {
        Row() {
          // Play Icon simulation using $r as requested
          Image($r('app.media.startIcon'))
            .width(20)
            .height(20)
            .fillColor('#FFFFFF')
          
          Text('START TIMER')
            .fontSize(16)
            .fontWeight(FontWeight.Bold)
            .fontColor('#FFFFFF')
            .margin({ left: 8 })
        }
        .justifyContent(FlexAlign.Center)
      }
      .width('100%')
      .height(56)
      .backgroundColor('#000000')
      .borderRadius(16)
      .margin({ bottom: 40 })
    }
    .width('100%')
    .height('100%')
    .padding(24)
    .backgroundColor('#FFFFFF')
  }
}

interface TeaPreset {
  name: string;
  temp: string;
  time: string;
}