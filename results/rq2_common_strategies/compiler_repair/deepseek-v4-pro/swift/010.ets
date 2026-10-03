@Entry
@Component
struct RootScreen {
  @State private textOpacity: number = 1.0
  @State private uploadProgress: number = 0.65
  @State private layers: StoryLayer[] = [
    { id: 1, type: 'BG', content: 'Gradient' },
    { id: 2, type: 'IMG', content: 'User Photo' },
    { id: 3, type: 'TXT', content: 'Hello World' },
    { id: 4, type: 'ICO', content: 'Sticker' }
  ]
  @State private selectedLayer: number = 3

  build() {
    Stack({ alignContent: Alignment.Bottom }) {
      // Background
      Column()
        .width('100%')
        .height('100%')
        .backgroundColor('#ECEFF1')

      // Main content
      Column({ space: 0 }) {
        // Top bar
        Row({ space: 0 }) {
          Button({ type: ButtonType.Normal }) {
            Text('Exit')
              .fontSize(14)
              .fontWeight(FontWeight.Regular)
              .fontColor('#263238')
          }
          .padding({ left: 8 })

          Blank()

          Text('Story Editor')
            .fontSize(18)
            .fontWeight(FontWeight.Medium)
            .fontColor('#263238')

          Blank()

          Button({ type: ButtonType.Normal }) {
            Text('Post')
              .fontSize(14)
              .fontWeight(FontWeight.Regular)
              .fontColor('#FFFFFF')
              .padding({ left: 12, right: 12, top: 8, bottom: 8 })
          }
          .backgroundColor('#1976D2')
          .borderRadius(8)
          .padding({ right: 8 })
        }
        .height(64)
        .width('100%')
        .backgroundColor('#FFFFFF')

        // Scrollable content using List
        List({ space: 16 }) {
          // Preview card
          ListItem() {
            Column() {
              Text('Your Story Preview')
                .fontSize(24)
                .fontWeight(FontWeight.Medium)
                .fontColor('#FFFFFF')
                .textAlign(TextAlign.Center)
                .opacity(this.textOpacity)
            }
            .width('100%')
            .height(200)
            .backgroundColor('#757575')
            .borderRadius(12)
            .shadow({ radius: 3, color: '#1A000000', offsetY: 1 })
          }

          // Upload status
          ListItem() {
            Column({ space: 4 }) {
              Text('Upload Status')
                .fontSize(12)
                .fontWeight(FontWeight.Medium)
                .fontColor('#607D8B')

              Progress({ value: this.uploadProgress, total: 1, type: ProgressType.Linear })
                .width('100%')
                .height(8)
                .color('#4CAF50')
            }
          }

          // Story layers (horizontal)
          ListItem() {
            Column({ space: 4 }) {
              Text('Story Layers')
                .fontSize(12)
                .fontWeight(FontWeight.Medium)
                .fontColor('#607D8B')

              // Horizontal row of layer items
              Row({ space: 16 }) {
                ForEach(this.layers, (layer: StoryLayer) => {
                  LayerItemView({
                    layer: layer,
                    isSelected: layer.id == this.selectedLayer,
                    onSelect: () => { this.selectedLayer = layer.id }
                  })
                })
              }
              .padding({ top: 8, bottom: 8 })
            }
          }
        }
        .width('100%')
        .layoutWeight(1)
        .padding({ top: 16 })
      }
      .width('100%')

      // Bottom properties panel
      Column({ space: 8 }) {
        Text('Layer Properties')
          .fontSize(12)
          .fontWeight(FontWeight.Medium)
          .fontColor('#607D8B')

        Row() {
          Text('Opacity')
            .fontSize(14)
            .fontWeight(FontWeight.Regular)
            .fontColor('#263238')
            .width(80)

          Slider({ value: this.textOpacity, min: 0, max: 1 })
            .width('100%')
            .onChange((value: number) => { this.textOpacity = value })
        }
      }
      .padding(16)
      .width('100%')
      .backgroundColor('#FFFFFF')
      .shadow({ radius: 6, color: '#1A000000', offsetY: -2 })
    }
    .width('100%')
    .height('100%')
  }
}

@Builder
function LayerItemView(param: LayerItemParam) {
  Button({ type: ButtonType.Normal }) {
    Column({ space: 4 }) {
      // Circle icon
      Image('')
        .width(32)
        .height(32)
        .borderRadius(16)
        .backgroundColor(param.isSelected ? '#FFFFFF' : '#CFD8DC')
        .opacity(0.2)

      Text(param.layer.type)
        .fontSize(12)
        .fontWeight(FontWeight.Medium)
        .fontColor(param.isSelected ? '#FFFFFF' : '#263238')
        .opacity(param.isSelected ? 1 : 0.7)

      Text(param.layer.content)
        .fontSize(14)
        .fontWeight(FontWeight.Regular)
        .fontColor(param.isSelected ? '#FFFFFF' : '#263238')
        .textAlign(TextAlign.Center)
        .maxLines(2)
    }
    .padding({ left: 24, right: 24, top: 8, bottom: 8 })
    .width(130)
    .backgroundColor(param.isSelected ? '#1976D2' : '#FFFFFF')
    .borderRadius(8)
    .border({ width: 1, color: param.isSelected ? '#1976D2' : '#B0BEC5' })
  }
  .onClick(param.onSelect)
}

interface StoryLayer {
  id: number
  type: string
  content: string
}

interface LayerItemParam {
  layer: StoryLayer
  isSelected: boolean
  onSelect: () => void
}