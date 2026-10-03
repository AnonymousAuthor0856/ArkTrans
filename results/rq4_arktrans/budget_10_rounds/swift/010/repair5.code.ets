@Entry
@Component
struct Index {
  @State textOpacity: number = 0.8
  @State uploadProgress: number = 0.75

  build() {
    Stack({ alignContent: Alignment.Bottom }) {
      Column() {
        // Top Bar
        Row() {
          Button('Exit')
            .backgroundColor(Color.Transparent)
            .fontColor('#263238')
            .fontSize(16)
            .fontWeight(FontWeight.Medium)
            .borderWidth(0)
            .padding({ left: 4, right: 4 })

          Blank()

          Text('Story Editor')
            .fontColor('#263238')
            .fontSize(18)
            .fontWeight(FontWeight.Bold)

          Blank()

          Button('Post')
            .backgroundColor('#1976D2')
            .fontColor('#FFFFFF')
            .fontSize(14)
            .fontWeight(FontWeight.Medium)
            .borderRadius(8)
            .padding({ left: 16, right: 16, top: 8, bottom: 8 })
        }
        .width('100%')
        .height(56)
        .backgroundColor('#FFFFFF')
        .justifyContent(FlexAlign.SpaceBetween)
        .alignItems(VerticalAlign.Center)
        .padding({ left: 16, right: 16 })

        // Scrollable Content
        Scroll() {
          Column() {
            // Story Preview
            Stack() {
              Text('Your Story Preview')
                .fontColor('#FFFFFF')
                .fontSize(24)
                .fontWeight(FontWeight.Bold)
                .opacity(this.textOpacity)
            }
            .width('100%')
            .height(200)
            .backgroundColor('#757575')
            .borderRadius(16)
            .margin({ top: 24, left: 24, right: 24 })

            // Upload Status
            Column() {
              Text('Upload Status')
                .fontColor('#607D8B')
                .fontSize(12)
                .margin({ bottom: 8 })

              Stack({ alignContent: Alignment.Start }) {
                Rect()
                  .width('100%')
                  .height(4)
                  .fill('#CFD8DC')
                  .borderRadius(2)

                Rect()
                  .width(`${this.uploadProgress * 100}%`)
                  .height(4)
                  .fill('#4CAF50')
                  .borderRadius(2)
              }
            }
            .width('100%')
            .padding({ left: 24, right: 24 })
            .margin({ top: 16 })

            // Story Layers
            Column() {
              Text('Story Layers')
                .fontColor('#607D8B')
                .fontSize(12)
                .margin({ bottom: 16 })

              Scroll() {
                Row() {
                  // Layer 1
                  this.LayerCard('BG', 'Gradient', false)
                  
                  // Layer 2
                  this.LayerCard('IMG', 'User Photo', false)
                  
                  // Layer 3 (Selected)
                  this.LayerCard('TX', 'Hello World', true)
                }
                .width('100%')
                .gap(16)
              }
              .scrollable(ScrollDirection.Horizontal)
              .scrollBar(BarState.Off)
              .width('100%')
            }
            .width('100%')
            .padding({ left: 24, right: 24 })
            .margin({ top: 16 })
            
            // Spacer to allow scrolling past the bottom sheet
            Blank().height(100)
          }
          .width('100%')
        }
        .layoutWeight(1)
        .backgroundColor('#ECEFF1')
      }
      .width('100%')
      .height('100%')

      // Bottom Sheet
      Column() {
        Text('Layer Properties')
          .fontColor('#607D8B')
          .fontSize(12)
          .margin({ bottom: 16 })

        Row() {
          Text('Opacity')
            .fontColor('#263238')
            .fontSize(14)
            .width(80)
            .textAlign(TextAlign.Start)

          Slider({ value: this.textOpacity, min: 0, max: 1, step: 0.01 })
            .width('100%')
            .trackThickness(4)
            .selectedColor('#1976D2')
            .blockColor('#FFFFFF')
        }
        .width('100%')
      }
      .width('100%')
      .backgroundColor('#FFFFFF')
      .padding(24)
      .shadow({ radius: 10, color: '#1F000000', offsetY: -2 })
    }
    .width('100%')
    .height('100%')
  }

  @Builder
  LayerCard(type: string, content: string, isSelected: boolean) {
    Column() {
      Circle()
        .width(32)
        .height(32)
        .fill(isSelected ? Color.White : '#CFD8DC')
        .opacity(isSelected ? 0.2 : 1)
        .margin({ bottom: 8 })

      Text(type)
        .fontColor(isSelected ? '#FFFFFF' : '#607D8B')
        .fontSize(12)
        .margin({ bottom: 4 })

      Text(content)
        .fontColor(isSelected ? '#FFFFFF' : '#263238')
        .fontSize(14)
        .maxLines(2)
        .textAlign(TextAlign.Center)
    }
    .width(130)
    .height(130)
    .justifyContent(FlexAlign.Center)
    .alignItems(HorizontalAlign.Center)
    .backgroundColor(isSelected ? '#1976D2' : '#FFFFFF')
    .borderRadius(12)
    .border({ width: 1, color: isSelected ? '#1976D2' : '#CFD8DC' })
  }
}