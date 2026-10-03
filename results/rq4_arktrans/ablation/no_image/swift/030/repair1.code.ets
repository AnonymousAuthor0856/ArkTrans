@Entry
@Component
struct Index {
  @State sliderValue: number = 24

  build() {
    Stack() {
      Column() {
        // Header Row
        Row() {
          Blank()
          Text('Clipboard History')
            .fontColor(0xFF212529)
            .fontSize(22)
          Blank()
          Button()
            .padding({ right: 8 })
        }
        .width('100%')
        .height(56)
        .backgroundColor('#FFFFFF')
        .shadow({ radius: 0.5, color: '#0D000000', offsetX: 0, offsetY: 0.5 })

        // Scrollable List Area
        Scroll() {
          Column() {
            ForEach([1, 2, 3], (item: number) => {
              Column() {
                Row() {
                  Rect()
                    .width(24)
                    .height(24)
                    .fill(0xFF007BFF)
                    .borderRadius(4)
                  
                  Text('Text')
                    .fontWeight(FontWeight.Bold)
                    .fontColor(0xFF007BFF)
                    .fontSize(14)
                
                  Blank()
                  
                  Text('Just now')
                    .fontColor(0xFF6C757D)
                    .fontSize(14)
                }
                .width('100%')
                .padding({ bottom: 8 })

                Text('This is a sample clipboard content item.')
                  .width('100%')
                  .lineHeight(24)
                  .maxLines(2)
                  .textOverflow({ overflow: TextOverflow.Ellipsis })
                  .fontColor(0xFF212529)
                  .fontSize(16)
                  .padding({ bottom: 12 })

                Progress({ value: 50, total: 100, type: ProgressType.Linear })
                  .width('100%')
                  .height(4)
                  .color(0xFF17A2B8)
                  .trackColor(Color.Gray)
              }
              .width('100%')
              .padding(16)
              .backgroundColor('#FFFFFF')
              .borderRadius(16)
              .margin({ bottom: 16 })
              .shadow({ radius: 2, color: '#0D000000', offsetX: 0, offsetY: 1 })
            })
          }
          .padding({ left: 24, right: 24, top: 16, bottom: 16 })
        }
        .layoutWeight(1)
        .backgroundColor(0xFFF8F9FA)

        // Bottom Settings Panel
        Column() {
          Row() {
            Text('History Limit (Hours)')
              .fontColor(0xFF212529)
              .fontSize(14)
            
            Blank()
            
            Text(`${this.sliderValue}`)
              .fontWeight(FontWeight.Medium)
              .fontColor(0xFF212529)
              .fontSize(16)
          }
          .width('100%')
          .padding({ bottom: 8 })

          Slider({
            value: this.sliderValue,
            min: 1,
            max: 72,
            step: 1
          })
          .width('100%')
          .selectedColor(0xFF007BFF)
          .trackColor(0xFFE9ECEF)
        }
        .width('100%')
        .padding(24)
        .backgroundColor('#FFFFFF')
      }
      .width('100%')
      .height('100%')
    }
    .width('100%')
    .height('100%')
  }
}