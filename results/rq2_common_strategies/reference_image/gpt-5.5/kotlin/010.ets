const NAME: string = '007_StoryEditor_en'
const UI_TYPE: string = 'Social'
const STYLE_THEME: string = 'Monochrome'
const LANG: string = 'en'
const BASELINE_SIZE: string = '720x1280'

const PRIMARY: string = '#1976D2'
const SECONDARY: string = '#607D8B'
const TERTIARY: string = '#757575'
const BACKGROUND: string = '#ECEFF1'
const SURFACE: string = '#FFFFFF'
const SURFACE_VARIANT: string = '#CFD8DC'
const OUTLINE: string = '#B0BEC5'
const SUCCESS: string = '#4CAF50'
const ERROR: string = '#F44336'
const ON_PRIMARY: string = '#FFFFFF'
const ON_TERTIARY: string = '#FFFFFF'
const ON_BACKGROUND: string = '#263238'
const ON_SURFACE: string = '#263238'

const SPACING_SM: number = 8
const SPACING_MD: number = 12
const SPACING_LG: number = 16

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
struct StoryEditorPage {
  @State private textOpacity: number = 1
  @State private uploadProgress: number = 65
  @State private selectedLayer: number = 3

  private layers: StoryLayer[] = [
    new StoryLayer(1, 'BG', 'Gradient'),
    new StoryLayer(2, 'IMG', 'User Photo'),
    new StoryLayer(3, 'TXT', 'Hello World'),
    new StoryLayer(4, 'ICO', 'Sticker')
  ]

  @Builder
  private TopBar() {
    Stack({ alignContent: Alignment.Center }) {
      Text('Story Editor')
        .fontSize(18)
        .fontWeight(FontWeight.Bold)
        .fontColor(ON_BACKGROUND)
        .textAlign(TextAlign.Center)

      Row() {
        Text('Exit')
          .fontSize(14)
          .fontWeight(FontWeight.Medium)
          .fontColor(ON_BACKGROUND)
          .height(40)
          .padding({ left: 4, right: 4 })
          .textAlign(TextAlign.Center)
          .onClick(() => {
          })

        Blank()

        Button({ type: ButtonType.Normal, stateEffect: true }) {
          Text('Post')
            .fontSize(14)
            .fontWeight(FontWeight.Bold)
            .fontColor(ON_PRIMARY)
        }
        .width(78)
        .height(40)
        .borderRadius(8)
        .backgroundColor(PRIMARY)
        .padding(0)
        .onClick(() => {
        })
      }
      .width('100%')
      .height('100%')
      .alignItems(VerticalAlign.Center)
      .padding({ left: 32, right: 12 })
    }
    .width('100%')
    .height(64)
    .backgroundColor(SURFACE)
  }

  @Builder
  private PreviewCard() {
    Stack({ alignContent: Alignment.Center }) {
      Text('Your Story Preview')
        .fontSize(24)
        .fontWeight(FontWeight.Bold)
        .fontColor(ON_TERTIARY)
        .textAlign(TextAlign.Center)
        .opacity(this.textOpacity)
        .padding({ left: 16, right: 16 })
    }
    .width('100%')
    .height('100%')
    .backgroundColor(TERTIARY)
    .borderRadius(12)
    .shadow({
      radius: 3,
      color: 'rgba(0, 0, 0, 0.10)',
      offsetX: 0,
      offsetY: 1
    })
  }

  @Builder
  private UploadStatus() {
    Column({ space: 10 }) {
      Text('Upload Status')
        .width('100%')
        .fontSize(12)
        .fontWeight(FontWeight.Medium)
        .fontColor(SECONDARY)

      Progress({
        value: this.uploadProgress,
        total: 100,
        type: ProgressType.Linear
      })
        .width('100%')
        .height(8)
        .color(SUCCESS)
        .backgroundColor(SURFACE_VARIANT)
        .borderRadius(4)
        .style({ strokeWidth: 8 })
    }
    .width('100%')
    .padding({ left: 16, right: 16, top: 4, bottom: 10 })
  }

  @Builder
  private LayerCard(layer: StoryLayer) {
    Column({ space: 8 }) {
      Column()
        .width(32)
        .height(32)
        .borderRadius(16)
        .backgroundColor(layer.id === this.selectedLayer ? '#33FFFFFF' : SURFACE_VARIANT)

      Text(layer.type)
        .fontSize(12)
        .fontWeight(FontWeight.Medium)
        .fontColor(layer.id === this.selectedLayer ? ON_PRIMARY : '#B3263238')
        .maxLines(1)

      Text(layer.content)
        .fontSize(14)
        .fontWeight(FontWeight.Regular)
        .fontColor(layer.id === this.selectedLayer ? ON_PRIMARY : ON_SURFACE)
        .maxLines(1)
        .textOverflow({ overflow: TextOverflow.Ellipsis })
    }
    .width(132)
    .height(102)
    .justifyContent(FlexAlign.Center)
    .alignItems(HorizontalAlign.Center)
    .padding({ left: 16, right: 16, top: 12, bottom: 12 })
    .backgroundColor(layer.id === this.selectedLayer ? PRIMARY : SURFACE)
    .borderRadius(8)
    .border({
      width: 1,
      color: layer.id === this.selectedLayer ? PRIMARY : OUTLINE,
      radius: 8
    })
    .onClick(() => {
      this.selectedLayer = layer.id
    })
  }

  @Builder
  private LayerStrip() {
    Scroll() {
      Row({ space: 12 }) {
        ForEach(this.layers, (layer: StoryLayer) => {
          this.LayerCard(layer)
        }, (layer: StoryLayer) => layer.id.toString())
      }
      .padding({ left: 16, right: 16, top: 12, bottom: 20 })
    }
    .width('100%')
    .height(134)
    .scrollable(ScrollDirection.Horizontal)
    .scrollBar(BarState.Off)
  }

  @Builder
  private BottomProperties() {
    Column() {
      Text('Layer Properties')
        .width('100%')
        .fontSize(12)
        .fontWeight(FontWeight.Medium)
        .fontColor(SECONDARY)

      Row() {
        Text('Opacity')
          .width(82)
          .fontSize(14)
          .fontWeight(FontWeight.Regular)
          .fontColor(ON_BACKGROUND)

        Slider({
          value: this.textOpacity * 100,
          min: 0,
          max: 100,
          step: 1,
          style: SliderStyle.OutSet,
          direction: Axis.Horizontal,
          reverse: false
        })
          .layoutWeight(1)
          .blockColor(PRIMARY)
          .selectedColor(PRIMARY)
          .trackColor(SURFACE_VARIANT)
          .onChange((value: number, mode: SliderChangeMode) => {
            this.textOpacity = value / 100
          })
      }
      .width('100%')
      .height(56)
      .alignItems(VerticalAlign.Center)
      .margin({ top: 8 })
    }
    .width('100%')
    .height(107)
    .padding({ left: 16, right: 16, top: 16, bottom: 12 })
    .backgroundColor(SURFACE)
    .shadow({
      radius: 6,
      color: 'rgba(0, 0, 0, 0.10)',
      offsetX: 0,
      offsetY: -2
    })
  }

  build() {
    Column() {
      this.TopBar()

      Column() {
        Column() {
          this.PreviewCard()
        }
        .width('100%')
        .layoutWeight(1)
        .padding({ left: 16, right: 16, top: 16, bottom: 16 })

        this.UploadStatus()

        this.LayerStrip()
      }
      .width('100%')
      .layoutWeight(1)
      .backgroundColor(BACKGROUND)

      this.BottomProperties()
    }
    .width('100%')
    .height('100%')
    .backgroundColor(BACKGROUND)
  }
}