@Entry
@Component
struct LumenAppScreen {
  @State selectedIso: string = '400'
  @State apertureValue: number = 2.8 // Represents f/2.8
  @State shutterSpeedIndex: number = 4 // Index for 1/60

  private isoValues: string[] = ['100', '200', '400', '800', '1600', '3200']
  private shutterSpeeds: string[] = ['1/1000', '1/500', '1/250', '1/125', '1/60', '1/30', '1/15', '1/8']

  build() {
    Column() {
      // 1. Header Section
      Row() {
        Column() {
          Text('LUMEN LOG')
            .fontSize(14)
            .fontWeight(FontWeight.Bold)
            .letterSpacing(2)
            .fontColor('#999999')
          
          Text('Roll #034')
            .fontSize(24)
            .fontWeight(FontWeight.ExtraBold)
            .fontColor('#000000')
        }

        Blank()

        Row() {
          // Menu Icon (Hamburger)
          Image($r('app.media.ic_menu')) 
            .width(24)
            .height(24)
            .fillColor('#000000')
            .onClick(() => {})
          
          // Settings Icon
          Image($r('app.media.ic_settings'))
            .width(24)
            .height(24)
            .fillColor('#000000')
            .margin({ left: 16 })
            .onClick(() => {})
        }
      }
      .width('100%')
      .padding({ bottom: 16 })

      // 2. Main Display Card
      Row() {
        // Aperture Section
        Column() {
          Text(`f/${this.apertureValue.toFixed(1)}`)
            .fontSize(56)
            .fontWeight(FontWeight.Light)
            .letterSpacing(-2)
            .fontColor('#000000')
          
          Text('APERTURE')
            .fontSize(12)
            .fontWeight(FontWeight.Bold)
            .fontColor('#999999')
            .margin({ top: 4 })
        }
        .layoutWeight(1.5)
        .alignItems(HorizontalAlign.Start)
        .justifyContent(FlexAlign.Center)

        // Divider
        Divider()
          .vertical(true)
          .height(80)
          .color('#CCCCCC')
          .margin({ left: 16, right: 16 })

        // Details Section (ISO & Shutter)
        Column() {
          Column() {
            Text(this.selectedIso)
              .fontSize(20)
              .fontWeight(FontWeight.SemiBold)
              .fontColor('#000000')
            Text('ISO')
              .fontSize(10)
              .fontWeight(FontWeight.Bold)
              .fontColor('#999999')
          }
          .margin({ bottom: 16 })

          Column() {
            Text(this.shutterSpeeds[this.shutterSpeedIndex])
              .fontSize(20)
              .fontWeight(FontWeight.SemiBold)
              .fontColor('#000000')
            Text('SHUTTER')
              .fontSize(10)
              .fontWeight(FontWeight.Bold)
              .fontColor('#999999')
          }
        }
        .layoutWeight(1)
        .alignItems(HorizontalAlign.Start)
        .justifyContent(FlexAlign.Center)
      }
      .width('100%')
      .height(160)
      .backgroundColor('#F8F8F8')
      .borderRadius(16)
      .border({ width: 1, color: '#EEEEEE' })
      .padding({ left: 24, right: 24 })

      // 3. Controls Section
      Column() {
        // ISO Selector
        Column() {
          Text('Film Stock ISO')
            .fontSize(14)
            .fontWeight(FontWeight.Medium)
            .margin({ bottom: 12 })

          Scroll() {
            Row() {
              ForEach(this.isoValues, (iso: string) => {
                this.buildIsoChip(iso)
              })
            }
          }
          .scrollable(ScrollDirection.Horizontal)
          .scrollBar(BarState.Off)
        }
        .margin({ bottom: 32 })

        // Aperture Slider
        Column() {
          Row() {
            Text('Aperture Control')
              .fontSize(14)
              .fontWeight(FontWeight.Medium)
            
            Blank()
            
            Image($r('app.media.ic_settings'))
              .width(16)
              .height(16)
              .fillColor('#999999')
          }
          .width('100%')
          .margin({ bottom: 8 })

          // Custom Slider Implementation to match visual style
          Stack({ alignContent: Alignment.Start }) {
            // Track Background
            Rect()
              .width('100%')
              .height(8)
              .fill('#E0E0E0')
              .borderRadius(4)

            // Active Track (Visual approximation based on value)
            // Mapping 1.4-16 range to percentage roughly
            const progress = (this.apertureValue - 1.4) / (16 - 1.4)
            Rect()
              .width(`${progress * 100}%`)
              .height(8)
              .fill('#000000')
              .borderRadius(4)

            // Thumb
            Circle({ radius: 12 })
              .fill('#000000')
              .position({ x: `${progress * 100}vw`, y: 0 }) // Simplified positioning logic
              .translate({ x: -12 }) // Center thumb
          }
          .width('100%')
          .height(24)
          .onClick(() => {
             // Simulate interaction
             if (this.apertureValue < 16) this.apertureValue += 0.1;
          })

          Row() {
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
        .margin({ bottom: 32 })

        // Shutter Speed Selector
        Column() {
          Text('Shutter Speed')
            .fontSize(14)
            .fontWeight(FontWeight.Medium)
            .margin({ bottom: 12 })

          Row() {
            // Previous
            this.buildShutterOption(
              this.shutterSpeedIndex > 0 ? this.shutterSpeeds[this.shutterSpeedIndex - 1] : '-',
              false,
              () => {
                if (this.shutterSpeedIndex > 0) this.shutterSpeedIndex--
              }
            )

            // Current
            this.buildShutterOption(
              this.shutterSpeeds[this.shutterSpeedIndex],
              true,
              () => {}
            )

            // Next
            this.buildShutterOption(
              this.shutterSpeedIndex < this.shutterSpeeds.length - 1 ? this.shutterSpeeds[this.shutterSpeedIndex + 1] : '-',
              false,
              () => {
                if (this.shutterSpeedIndex < this.shutterSpeeds.length - 1) this.shutterSpeedIndex++
              }
            )
          }
          .width('100%')
        }
      }
      .layoutWeight(1)

      // 4. Bottom Action Button
      Button() {
        Row() {
          Circle({ radius: 12 })
            .fill('#FFFFFF')
            .width(24)
            .height(24)
            .zIndex(1)
          
          // Plus Icon inside circle (using text for simplicity or image)
          Text('+')
            .fontSize(20)
            .fontColor('#000000')
            .fontWeight(FontWeight.Bold)
            .position({ x: 12, y: 12 })
            .zIndex(2)

          Text('LOG EXPOSURE')
            .fontSize(16)
            .fontWeight(FontWeight.Bold)
            .letterSpacing(1)
            .fontColor('#FFFFFF')
            .margin({ left: 12 })
        }
        .justifyContent(FlexAlign.Center)
      }
      .width('100%')
      .height(56)
      .backgroundColor('#000000')
      .borderRadius(12)
      .margin({ top: 16, bottom: 24 })
    }
    .width('100%')
    .height('100%')
    .padding(24)
    .backgroundColor('#FFFFFF')
  }

  // Helper Component for ISO Chips
  @Builder
  buildIsoChip(iso: string) {
    Column() {
      Text(iso)
        .fontSize(13)
        .fontWeight(FontWeight.SemiBold)
        .fontColor(this.selectedIso === iso ? '#FFFFFF' : '#000000')
    }
    .width(60)
    .height(36)
    .justifyContent(FlexAlign.Center)
    .alignItems(HorizontalAlign.Center)
    .backgroundColor(this.selectedIso === iso ? '#000000' : '#FFFFFF')
    .border({
      width: 1,
      color: this.selectedIso === iso ? '#000000' : '#E0E0E0',
      radius: 50
    })
    .margin({ right: 12 })
    .onClick(() => {
      this.selectedIso = iso
    })
  }

  // Helper Component for Shutter Options
  @Builder
  buildShutterOption(text: string, isSelected: boolean, onClick: () => void) {
    Column() {
      Text(text)
        .fontSize(isSelected ? 22 : 16)
        .fontWeight(isSelected ? FontWeight.Bold : FontWeight.Normal)
        .fontColor(isSelected ? '#000000' : '#CCCCCC')
    }
    .width(100)
    .height(50)
    .justifyContent(FlexAlign.Center)
    .alignItems(HorizontalAlign.Center)
    .backgroundColor(isSelected ? '#F0F0F0' : '#FFFFFF')
    .borderRadius(12)
    .onClick(() => {
      if (!isSelected && text !== '-') {
        onClick()
      }
    })
  }
}