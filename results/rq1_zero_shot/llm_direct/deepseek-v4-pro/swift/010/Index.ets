@Entry
@Component
struct RootScreen {
  @State private textOpacity: number = 1.0
  @State private uploadProgress: number = 0.65
  @State private layers: StoryLayer[] = [
    new StoryLayer(1, "BG", "Gradient"),
    new StoryLayer(2, "IMG", "User Photo"),
    new StoryLayer(3, "TXT", "Hello World"),
    new StoryLayer(4, "ICO", "Sticker")
  ]
  @State private selectedLayer: number = 3

  build() {
    Stack({ alignContent: Alignment.Bottom }) {
      Column() {
        // Top bar
        Row() {
          Button() {
          }
          .backgroundColor(Color.Transparent)
          .padding({ left: 8, right: 8 }) {
            Text('Exit')
              .fontSize(14)
              .fontColor('#263238')
          }

          Blank()

          Text('Story Editor')
            .fontSize(18)
            .fontWeight(FontWeight.Medium)
            .fontColor('#263238')

          Blank()

          Button() {
          }
          .backgroundColor('#1976D2')
          .borderRadius(8)
          .padding({ left: 8, right: 8 }) {
            Text('Post')
              .fontSize(14)
              .fontColor('#FFFFFF')
              .padding({ left: 12, right: 12, top: 8, bottom: 8 })
          }
        }
        .width('100%')
        .height(64)
        .backgroundColor('#FFFFFF')

        // Main content
        Scroll() {
          Column({ space: 16 }) {
            // Preview card
            Stack() {
              Text('Your Story Preview')
                .fontSize(24)
                .fontWeight(FontWeight.SemiBold)
                .fontColor('#FFFFFF')
                .opacity(this.textOpacity)
                .textAlign(TextAlign.Center)
            }
            .width('100%')
            .height(200)
            .backgroundColor('#757575')
            .borderRadius(12)
            .shadow({ radius: 3, color: '#1A000000', offsetY: 1 })
            .padding({ left: 16, right: 16 })

            // Upload status
            Column({ space: 8 }) {
              Text('Upload Status')
                .fontSize(12)
                .fontWeight(FontWeight.Medium)
                .fontColor('#607D8B')

              Stack({ alignContent: Alignment.Start }) {
                Row()
                  .width('100%')
                  .height(8)
                  .backgroundColor('#CFD8DC')
                  .borderRadius(4)

                Row()
                  .width(`${this.uploadProgress * 100}%`)
                  .height(8)
                  .backgroundColor('#4CAF50')
                  .borderRadius(4)
              }
              .width('100%')
              .height(8)
            }
            .width('100%')
            .alignItems(HorizontalAlign.Start)
            .padding({ left: 16, right: 16 })

            // Story layers
            Column({ space: 8 }) {
              Text('Story Layers')
                .fontSize(12)
                .fontWeight(FontWeight.Medium)
                .fontColor('#607D8B')
                .padding({ left: 16, right: 16 })

              Scroll() {
                Row({ space: 16 }) {
                  ForEach(this.layers, (layer: StoryLayer) => {
                    LayerItemView({
                      layer: layer,
                      isSelected: layer.id === this.selectedLayer,
                      onSelect: () => {
                        this.selectedLayer = layer.id
                      }
                    })
                  }, (layer: StoryLayer) => layer.id.toString())
                }
                .padding({ left: 16, right: 16, top: 12, bottom: 12 })
              }
              .scrollable(ScrollDirection.Horizontal)
              .scrollBar(BarState.Off)
              .width('100%')
            }
            .width('100%')
            .alignItems(HorizontalAlign.Start)
          }
          .width('100%')
          .padding({ top: 16, bottom: 16 })
        }
        .width('100%')
        .layoutWeight(1)
        .backgroundColor('#ECEFF1')
        .align(Alignment.TopStart)
      }
      .width('100%')
      .height('100%')

      // Bottom bar
      Column({ space: 12 }) {
        Text('Layer Properties')
          .fontSize(12)
          .fontWeight(FontWeight.Medium)
          .fontColor('#607D8B')

        Row() {
          Text('Opacity')
            .fontSize(14)
            .width(80)
            .textAlign(TextAlign.Start)

          Slider({ value: this.textOpacity, min: 0, max: 1 })
            .selectedColor('#1976D2')
            .trackColor('#CFD8DC')
            .layoutWeight(1)
            .onChange((value: number) => {
              this.textOpacity = value
            })
        }
        .width('100%')
      }
      .width('100%')
      .alignItems(HorizontalAlign.Start)
      .padding(16)
      .backgroundColor('#FFFFFF')
      .shadow({ radius: 6, color: '#1A000000', offsetY: -2 })
    }
    .width('100%')
    .height('100%')
    .backgroundColor('#ECEFF1')
  }
}

@Component
struct LayerItemView {
  @Prop layer: StoryLayer
  @Prop isSelected: boolean
  onSelect: () => void = () => {}

  build() {
    Button() {
      this.onSelect()
    }
    .backgroundColor(this.isSelected ? '#1976D2' : '#FFFFFF')
    .borderRadius(8)
    .border({
      width: 1,
      color: this.isSelected ? '#1976D2' : '#B0BEC5'
    }) {
      Column({ space: 8 }) {
        Circle()
          .width(32)
          .height(32)
          .fill(this.isSelected ? '#33FFFFFF' : '#CFD8DC')

        Text(this.layer.type)
          .fontSize(12)
          .fontWeight(FontWeight.Medium)
          .fontColor(this.isSelected ? '#FFFFFF' : '#B3263828')

        Text(this.layer.content)
          .fontSize(14)
          .fontColor(this.isSelected ? '#FFFFFF' : '#263238')
          .textAlign(TextAlign.Center)
          .maxLines(2)
      }
      .width('100%')
      .padding({ left: 32, right: 32, top: 12, bottom: 12 })
    }
    .width(130)
  }
}

class StoryLayer {
  id: number
  type: string
  content: string

  constructor(id: number, type: string, content: string) {
    this.id = id
    this.type = type
    this.content = content
  }
}