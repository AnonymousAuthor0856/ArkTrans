// AppColors
const COLOR_PRIMARY = 0xFF1976D2
const COLOR_SECONDARY = 0xFF607D8B
const COLOR_TERTIARY = 0xFF757575
const COLOR_BACKGROUND = 0xFFECEFF1
const COLOR_SURFACE = 0xFFFFFFFF
const COLOR_SURFACE_VARIANT = 0xFFCFD8DC
const COLOR_OUTLINE = 0xFFB0BEC5
const COLOR_SUCCESS = 0xFF4CAF50
const COLOR_ON_PRIMARY = 0xFFFFFFFF
const COLOR_ON_SECONDARY = 0xFFFFFFFF
const COLOR_ON_TERTIARY = 0xFFFFFFFF
const COLOR_ON_BACKGROUND = 0xFF263238
const COLOR_ON_SURFACE = 0xFF263238

const SPACING_SM = 8
const SPACING_MD = 12
const SPACING_LG = 16

interface StoryLayerData {
  id: number
  type: string
  content: string
}

@Entry
@Component
struct RootScreen {
  @State textOpacity: number = 1.0
  @State uploadProgress: number = 0.65
  @State selectedLayer: number = 3

  private layers: StoryLayerData[] = [
    { id: 1, type: 'BG', content: 'Gradient' },
    { id: 2, type: 'IMG', content: 'User Photo' },
    { id: 3, type: 'TXT', content: 'Hello World' },
    { id: 4, type: 'ICO', content: 'Sticker' }
  ]

  build() {
    Column() {
      // Top App Bar
      Row() {
        Button('Exit')
          .backgroundColor(Color.Transparent)
          .fontColor(COLOR_ON_BACKGROUND)
          .fontSize(14)
          .padding({ left: SPACING_SM, right: SPACING_SM })

        Text('Story Editor')
          .fontSize(18)
          .fontWeight(FontWeight.Medium)
          .layoutWeight(1)
          .textAlign(TextAlign.Center)

        Button('Post')
          .backgroundColor(COLOR_PRIMARY)
          .fontColor(COLOR_ON_PRIMARY)
          .fontSize(14)
          .borderRadius(8)
          .padding({ left: SPACING_SM, right: SPACING_SM })
      }
      .width('100%')
      .height(56)
      .backgroundColor(COLOR_SURFACE)
      .padding({ left: SPACING_SM, right: SPACING_SM })
      .alignItems(VerticalAlign.Center)

      // Main content area
      Column() {
        // Story Preview Card
        Stack({ alignContent: Alignment.Center }) {
          Text('Your Story Preview')
            .fontSize(24)
            .fontWeight(FontWeight.Bold)
            .fontColor(`rgba(255,255,255,${this.textOpacity})`)
            .textAlign(TextAlign.Center)
        }
        .width('100%')
        .layoutWeight(1)
        .backgroundColor(COLOR_TERTIARY)
        .borderRadius(12)
        .margin({ left: SPACING_LG, right: SPACING_LG, top: SPACING_LG, bottom: SPACING_LG })

        // Upload Status
        Column() {
          Text('Upload Status')
            .fontSize(12)
            .fontWeight(FontWeight.Medium)
            .fontColor(COLOR_SECONDARY)
            .alignSelf(ItemAlign.Start)

          Progress({ value: this.uploadProgress * 100, total: 100, type: ProgressType.Linear })
            .width('100%')
            .height(SPACING_SM)
            .color(COLOR_SUCCESS)
            .backgroundColor(COLOR_SURFACE_VARIANT)
            .margin({ top: 4 })
        }
        .width('100%')
        .padding({ left: SPACING_LG, right: SPACING_LG })
        .margin({ bottom: SPACING_LG })
        .alignItems(HorizontalAlign.Start)

        // Layer Cards Row
        Scroll() {
          Row({ space: SPACING_MD }) {
            ForEach(this.layers, (layer: StoryLayerData) => {
              this.LayerCard(layer)
            }, (layer: StoryLayerData) => layer.id.toString())
          }
          .padding({ left: SPACING_LG, right: SPACING_LG, top: SPACING_MD, bottom: SPACING_MD })
        }
        .scrollable(ScrollDirection.Horizontal)
        .scrollBar(BarState.Off)
        .width('100%')
        .margin({ bottom: SPACING_LG })
      }
      .layoutWeight(1)
      .backgroundColor(COLOR_BACKGROUND)

      // Bottom Bar - Layer Properties
      Column() {
        Text('Layer Properties')
          .fontSize(12)
          .fontWeight(FontWeight.Medium)
          .fontColor(COLOR_SECONDARY)
          .alignSelf(ItemAlign.Start)

        Row() {
          Text('Opacity')
            .fontSize(14)
            .width(80)

          Slider({
            value: this.textOpacity * 100,
            min: 0,
            max: 100,
            step: 1,
            style: SliderStyle.OutSet
          })
            .layoutWeight(1)
            .selectedColor(COLOR_PRIMARY)
            .trackColor(COLOR_SURFACE_VARIANT)
            .onChange((value: number) => {
              this.textOpacity = value / 100
            })
        }
        .width('100%')
        .alignItems(VerticalAlign.Center)
        .margin({ top: SPACING_MD })
      }
      .width('100%')
      .padding(SPACING_LG)
      .backgroundColor(COLOR_SURFACE)
      .alignItems(HorizontalAlign.Start)
    }
    .width('100%')
    .height('100%')
    .backgroundColor(COLOR_BACKGROUND)
  }

  @Builder
  LayerCard(layer: StoryLayerData) {
    Column({ space: SPACING_SM }) {
      Stack() {
      }
      .width(32)
      .height(32)
      .borderRadius(16)
      .backgroundColor(
        layer.id === this.selectedLayer
          ? 0x33FFFFFF
          : COLOR_SURFACE_VARIANT
      )

      Text(layer.type)
        .fontSize(12)
        .fontWeight(FontWeight.Medium)
        .fontColor(
          layer.id === this.selectedLayer
            ? COLOR_ON_PRIMARY
            : 0xB3263238
        )

      Text(layer.content)
        .fontSize(14)
        .fontColor(
          layer.id === this.selectedLayer
            ? COLOR_ON_PRIMARY
            : COLOR_ON_SURFACE
        )
    }
    .width(100)
    .padding({ left: SPACING_LG, right: SPACING_LG, top: SPACING_MD, bottom: SPACING_MD })
    .alignItems(HorizontalAlign.Center)
    .backgroundColor(
      layer.id === this.selectedLayer
        ? COLOR_PRIMARY
        : COLOR_SURFACE
    )
    .borderRadius(8)
    .border({
      width: 1,
      color: layer.id === this.selectedLayer ? COLOR_PRIMARY : COLOR_OUTLINE
    })
    .onClick(() => {
      this.selectedLayer = layer.id
    })
  }
}