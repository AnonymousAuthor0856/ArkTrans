@Entry
@Component
struct Index {
  // Constants defined to replace SwiftUI variables
  private screenPadding: number = 16
  private letterSpacingHeader: number = 1.5
  private iconButtonSize: number = 40
  private cornerRadius: number = 12
  private cardHeight: number = 180
  private horizontalPadding: number = 20
  private dividerHeight: number = 80
  private detailSpacing: number = 16
  private verticalSpacingLarge: number = 24
  private bottomPadding: number = 8
  private horizontalSpacing: number = 12
  private itemWidth: number = 60
  private itemHeight: number = 36
  private sliderTopSpacing: number = 16
  private trackHeight: number = 6
  private thumbDiameter: number = 24
  private iconSize: number = 24
  private buttonHeight: number = 56
  private iconBoxSize: number = 32
  private letterSpacingButton: number = 1.0

  @State aperture: string = '2.8'
  @State iso: string = '400'
  @State shutter: string = '1/125'
  @State value: number = 0.5 // Normalized value for slider (0 to 1)
  
  // Mock data for ISO list
  private isoValues: string[] = ['100', '200', '400', '800', '1600', '3200']

  build() {
    Stack() {
      Column() {
        .padding(this.screenPadding)
        
        // Header Row
        Row() {
          Column() {
            Text('LUMEN LOG')
              .fontColor('#999999') // .gray
              .letterSpacing(this.letterSpacingHeader)
              .fontSize(14)
              .fontWeight(FontWeight.Bold)
            
            Text('Roll #034')
              .fontColor('#000000') // .black
              .fontSize(24)
              .fontWeight(FontWeight.Bold) // .heavy approximated by Bold in ArkTS usually, or use specific weight if available
          }
          
          Blank()
          
          Row() {
            Button() {
              Image($r('app.media.startIcon')) // Using required resource
                .width(24)
                .height(24)
            }
            .width(this.iconButtonSize)
            .height(this.iconButtonSize)
            .backgroundColor(Color.Transparent)
            
            Button() {
              Image($r('app.media.startIcon')) // Using required resource
                .width(24)
                .height(24)
            }
            .width(this.iconButtonSize)
            .height(this.iconButtonSize)
            .backgroundColor(Color.Transparent)
          }
        }

        // Main Card
        Rect()
          .fill('#F8F8F8')
          .border({ width: 1, color: '#EEEEEE', radius: this.cornerRadius })
          .width('100%')
          .height(this.cardHeight)
          .overlay(
            Row() {
              // Aperture Section
              Column() {
                Text(`f/${this.aperture}`)
                  .fontSize(56)
                  .fontWeight(FontWeight.Lighter)
                  .fontColor('#000000')
                  .letterSpacing(-2)
                
                Text('APERTURE')
                  .fontSize(12)
                  .fontWeight(FontWeight.Bold)
                  .fontColor('#999999')
              }
              .alignItems(HorizontalAlign.Start)
              .padding({ left: this.horizontalPadding })
              .layoutWeight(1.5)
              
              // Divider
              Rect()
                .fill('#E0E0E0')
                .width(1)
                .height(this.dividerHeight)
              
              // Details Section
              Column() {
                Row() {
                  Text('ISO').fontSize(12).fontColor('#999999')
                  Blank()
                  Text(this.iso).fontSize(12).fontColor('#000000')
                }
                
                Blank().height(this.detailSpacing)
                
                Row() {
                  Text('SHUTTER').fontSize(12).fontColor('#999999')
                  Blank()
                  Text(this.shutter).fontSize(12).fontColor('#000000')
                }
              }
              .alignItems(HorizontalAlign.Start)
              .padding({ left: this.horizontalPadding })
              .layoutWeight(1)
            }
            .width('100%')
            .height('100%')
            .justifyContent(FlexAlign.Center)
          )

        Blank().height(this.verticalSpacingLarge)

        // Controls Container
        Column() {
          .spacing(this.verticalSpacingLarge)

          // ISO Selector
          Column() {
            Text('Film Stock ISO')
              .fontSize(14)
              .fontWeight(FontWeight.Medium)
              .margin({ bottom: this.bottomPadding })
            
            Scroll() {
              Flex({ wrap: FlexWrap.NoWrap, justifyContent: FlexAlign.Start }) {
                ForEach(this.isoValues, (iso: string) => {
                  Text(iso)
                    .fontSize(13)
                    .fontWeight(FontWeight.Medium)
                    .fontColor(iso === this.iso ? '#FFFFFF' : '#000000')
                    .backgroundColor(iso === this.iso ? '#000000' : Color.Transparent)
                    .borderRadius(this.cornerRadius)
                    .width(this.itemWidth)
                    .height(this.itemHeight)
                    .textAlign(TextAlign.Center)
                    .onClick(() => {
                      this.iso = iso
                    })
                    .margin({ right: this.horizontalSpacing })
                })
              }
            }
            .scrollable(ScrollDirection.Horizontal)
            .scrollBar(BarState.Off)
          }

          // Aperture Slider Control
          Column() {
            Row() {
              Text('Aperture Control')
                .fontSize(14)
                .fontWeight(FontWeight.Medium)
              
              Blank()
              
              Image($r('app.media.startIcon')) // Placeholder for gear icon
                .width(this.iconSize)
                .height(this.iconSize)
                .objectFit(ImageFit.Contain)
                .fillColor('#999999')
            }
            
            Blank().height(this.sliderTopSpacing)
            
            // Custom Slider Visuals
            Stack() {
              // Track Background
              Rect()
                .fill('#E0E0E0')
                .height(this.trackHeight)
                .width('100%')
              
              // Track Progress
              Rect()
                .fill('#000000')
                .height(this.trackHeight)
                .width(`${this.value * 100}%`)
              
              // Thumb
              Circle()
                .fill('#000000')
                .width(this.thumbDiameter)
                .height(this.thumbDiameter)
                .shadow({ radius: 2, color: '#33000000' })
                .position({ x: `${this.value * 100}%`, y: '50%' })
                .margin({ left: -this.thumbDiameter / 2 })
            }
            .width('100%')
            .height(this.trackHeight + this.thumbDiameter)
            
            // Invisible Functional Slider
            Slider({ value: this.value, min: 0, max: 1, step: 0.001 })
              .width('100%')
              .trackColor(Color.Transparent)
              .selectedColor(Color.Transparent)
              .blockColor(Color.Transparent)
              .opacity(0.001)
              .onChange((value: number) => {
                this.value = value
                // Map 0-1 to f/1.4 - f/16 logic here if needed
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
          }

          // Shutter Speed Selector
          Column() {
            Text('Shutter Speed')
              .fontSize(14)
              .fontWeight(FontWeight.Medium)
              .margin({ bottom: this.bottomPadding })
            
            Row() {
              .width('100%')
              .justifyContent(FlexAlign.SpaceBetween)
              
              this.buildSpeedOption('prev', false)
              this.buildSpeedOption('curr', true)
              this.buildSpeedOption('next', false)
            }
          }
        }

        Blank()

        // Bottom Button
        Button() {
          Row() {
            Stack() {
              Circle()
                .fill('#FFFFFF')
                .width(this.iconBoxSize)
                .height(this.iconBoxSize)
              
              Image($r('app.media.startIcon')) // Placeholder for plus icon
                .width(this.iconSize)
                .height(this.iconSize)
                .objectFit(ImageFit.Contain)
                .fillColor('#000000')
            }
            
            Text('LOG EXPOSURE')
              .fontSize(16)
              .fontWeight(FontWeight.Bold)
              .fontColor('#FFFFFF')
              .letterSpacing(this.letterSpacingButton)
              .margin({ left: 12 })
          }
          .width('100%')
          .justifyContent(FlexAlign.Center)
          .alignItems(VerticalAlign.Center)
        }
        .backgroundColor('#000000')
        .borderRadius(this.cornerRadius)
        .width('100%')
        .height(this.buttonHeight)
      }
    }
    .width('100%')
    .height('100%')
  }

  @Builder
  buildSpeedOption(text: string, isSelected: boolean) {
    Text(text.toUpperCase())
      .fontSize(14)
      .fontWeight(FontWeight.Medium)
      .fontColor(isSelected ? '#FFFFFF' : '#999999')
      .backgroundColor(isSelected ? '#000000' : Color.Transparent)
      .borderRadius(this.cornerRadius)
      .padding({ left: 20, right: 20, top: 10, bottom: 10 })
      .onClick(() => {
        // Handle selection
      })
  }
}