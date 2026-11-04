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

@Entry
@Component
struct Index {
  @State textOpacity: number = 1.0
  @State uploadProgress: number = 0.65
  @State selectedLayer: number = 3

  private cPrimary: string = '#1976D2'
  private cSecondary: string = '#607D8B'
  private cTertiary: string = '#757575'
  private cBg: string = '#ECEFF1'
  private cSurface: string = '#FFFFFF'
  private cSurfaceVariant: string = '#CFD8DC'
  private cLine: string = '#B0BEC5'
  private cSuccess: string = '#4CAF50'
  private cText: string = '#263238'
  private layers: StoryLayer[] = [
    new StoryLayer(1, 'BG', 'Gradient'),
    new StoryLayer(2, 'IMG', 'User Photo'),
    new StoryLayer(3, 'TXT', 'Hello World'),
    new StoryLayer(4, 'ICO', 'Sticker')
  ]

  private opacityColor(): string {
    const alpha = Math.round(this.textOpacity * 255)
    const hex = alpha.toString(16).padStart(2, '0').toUpperCase()
    return '#' + hex + 'FFFFFF'
  }

  @Builder
  TopBar() {
    Row() {
      Button('Exit')
        .height(36)
        .fontSize(14)
        .fontColor(this.cText)
        .backgroundColor(Color.Transparent)
        .padding({ left: 8, right: 8 })
      Blank()
      Text('Story Editor')
        .fontSize(18)
        .fontWeight(FontWeight.Medium)
        .fontColor(this.cText)
      Blank()
      Button('Post')
        .height(36)
        .padding({ left: 12, right: 12 })
        .fontSize(14)
        .fontColor(Color.White)
        .backgroundColor(this.cPrimary)
        .borderRadius(8)
        .margin({ right: 8 })
    }
    .width('100%')
    .height(64)
    .backgroundColor(this.cSurface)
  }

  @Builder
  LayerItem(layer: StoryLayer) {
    Button() {
      Column() {
        Circle()
          .width(32)
          .height(32)
          .fill(this.selectedLayer === layer.id ? '#33FFFFFF' : this.cSurfaceVariant)
        Text(layer.type)
          .fontSize(12)
          .fontWeight(FontWeight.Medium)
          .fontColor(this.selectedLayer === layer.id ? Color.White : '#B3263238')
          .margin({ top: 8 })
        Text(layer.content)
          .fontSize(14)
          .fontColor(this.selectedLayer === layer.id ? Color.White : this.cText)
          .textAlign(TextAlign.Center)
          .maxLines(2)
          .margin({ top: 8 })
      }
      .width(130)
      .padding({ left: 32, right: 32, top: 12, bottom: 12 })
    }
    .width(130)
    .backgroundColor(this.selectedLayer === layer.id ? this.cPrimary : this.cSurface)
    .border({ width: 1, color: this.selectedLayer === layer.id ? this.cPrimary : this.cLine, radius: 8 })
    .margin({ right: 16 })
    .onClick(() => {
      this.selectedLayer = layer.id
    })
  }

  @Builder
  ProgressBar() {
    Stack({ alignContent: Alignment.Start }) {
      Rect()
        .width('100%')
        .height(8)
        .radius(4)
        .fill(this.cSurfaceVariant)
      Rect()
        .width('65%')
        .height(8)
        .radius(4)
        .fill(this.cSuccess)
    }
    .width('100%')
    .height(8)
  }

  build() {
    Stack({ alignContent: Alignment.Bottom }) {
      Column() {
        this.TopBar()

        Scroll() {
          Column() {
            Stack({ alignContent: Alignment.Center }) {
              Rect()
                .width('100%')
                .height(200)
                .radius(12)
                .fill(this.cTertiary)
              Text('Your Story Preview')
                .fontSize(24)
                .fontWeight(FontWeight.Bold)
                .fontColor(this.opacityColor())
                .textAlign(TextAlign.Center)
            }
            .width('100%')
            .height(200)
            .padding({ left: 16, right: 16 })
            .margin({ bottom: 16 })

            Column() {
              Text('Upload Status')
                .fontSize(12)
                .fontWeight(FontWeight.Medium)
                .fontColor(this.cSecondary)
                .width('100%')
                .margin({ bottom: 8 })
              this.ProgressBar()
            }
            .width('100%')
            .padding({ left: 16, right: 16 })
            .margin({ bottom: 16 })

            Column() {
              Text('Story Layers')
                .fontSize(12)
                .fontWeight(FontWeight.Medium)
                .fontColor(this.cSecondary)
                .width('100%')
                .padding({ left: 16, right: 16 })
              Scroll() {
                Row() {
                  ForEach(this.layers, (layer: StoryLayer) => {
                    this.LayerItem(layer)
                  }, (layer: StoryLayer) => layer.id.toString())
                }
                .padding({ left: 16, right: 16, top: 12, bottom: 12 })
              }
              .scrollable(ScrollDirection.Horizontal)
              .scrollBar(BarState.Off)
              .width('100%')
            }
            .width('100%')

            Blank().height(120)
          }
          .width('100%')
          .padding({ top: 16, bottom: 16 })
        }
        .layoutWeight(1)
        .backgroundColor(this.cBg)
      }
      .width('100%')
      .height('100%')

      Column() {
        Text('Layer Properties')
          .fontSize(12)
          .fontWeight(FontWeight.Medium)
          .fontColor(this.cSecondary)
          .width('100%')
        Row() {
          Text('Opacity')
            .width(80)
            .fontSize(14)
            .fontColor(this.cText)
          Slider({ value: this.textOpacity, min: 0, max: 1, step: 0.01 })
            .layoutWeight(1)
            .onChange((value: number) => {
              this.textOpacity = value
            })
        }
        .width('100%')
        .margin({ top: 12 })
      }
      .width('100%')
      .padding(16)
      .backgroundColor(this.cSurface)
      .shadow({ radius: 6, color: '#1A000000', offsetY: -2 })
    }
    .width('100%')
    .height('100%')
    .backgroundColor(this.cBg)
  }
}
