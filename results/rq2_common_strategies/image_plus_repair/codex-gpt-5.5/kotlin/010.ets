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

class AppColors {
  static readonly primary: string = '#1976D2'
  static readonly secondary: string = '#607D8B'
  static readonly tertiary: string = '#757575'
  static readonly background: string = '#ECEFF1'
  static readonly surface: string = '#FFFFFF'
  static readonly surfaceVariant: string = '#CFD8DC'
  static readonly outline: string = '#B0BEC5'
  static readonly success: string = '#4CAF50'
  static readonly onPrimary: string = '#FFFFFF'
  static readonly onBackground: string = '#263238'
  static readonly onSurface: string = '#263238'
}

@Entry
@Component
struct StoryEditorPage {
  @State private textOpacity: number = 1
  @State private uploadProgress: number = 65
  @State private selectedLayer: number = 3
  private readonly layers: StoryLayer[] = [
    new StoryLayer(1, 'BG', 'Gradient'),
    new StoryLayer(2, 'IMG', 'User Photo'),
    new StoryLayer(3, 'TXT', 'Hello World'),
    new StoryLayer(4, 'ICO', 'Sticker')
  ]

  @Builder
  private TopBar() {
    Row() {
      Button('Exit')
        .fontSize(24)
        .fontWeight(FontWeight.Medium)
        .fontColor(AppColors.onBackground)
        .backgroundColor(Color.Transparent)
        .padding({ left: 16, right: 16 })
        .height(56)

      Text('Story Editor')
        .fontSize(32)
        .fontWeight(FontWeight.Bold)
        .fontColor(AppColors.onBackground)
        .textAlign(TextAlign.Center)
        .layoutWeight(1)

      Button('Post')
        .fontSize(28)
        .fontWeight(FontWeight.Bold)
        .fontColor(AppColors.onPrimary)
        .backgroundColor(AppColors.primary)
        .borderRadius(16)
        .width(155)
        .height(80)
    }
    .height(128)
    .width('100%')
    .padding({ left: 32, right: 24, top: 24, bottom: 24 })
    .backgroundColor(AppColors.surface)
    .alignItems(VerticalAlign.Center)
  }

  @Builder
  private StoryPreview() {
    Stack() {
      Text('Your Story Preview')
        .fontSize(45)
        .fontWeight(FontWeight.Bold)
        .fontColor(AppColors.onPrimary)
        .opacity(this.textOpacity)
        .textAlign(TextAlign.Center)
        .width('100%')
    }
    .width('100%')
    .layoutWeight(1)
    .backgroundColor(AppColors.tertiary)
    .borderRadius(22)
    .shadow({ radius: 3, color: '#1A000000', offsetX: 0, offsetY: 1 })
    .alignContent(Alignment.Center)
  }

  @Builder
  private UploadStatus() {
    Column() {
      Text('Upload Status')
        .fontSize(24)
        .fontWeight(FontWeight.Medium)
        .fontColor(AppColors.secondary)
        .letterSpacing(1)
        .width('100%')

      Progress({ value: this.uploadProgress, total: 100, type: ProgressType.Linear })
        .color(AppColors.success)
        .backgroundColor(AppColors.surfaceVariant)
        .height(16)
        .borderRadius(8)
        .width('100%')
        .margin({ top: 16 })
    }
    .width('100%')
    .padding({ left: 32, right: 32 })
  }

  @Builder
  private LayerCard(layer: StoryLayer) {
    Column({ space: 8 }) {
      Circle()
        .width(64)
        .height(64)
        .fill(layer.id === this.selectedLayer ? '#40FFFFFF' : AppColors.surfaceVariant)

      Text(layer.type)
        .fontSize(24)
        .fontWeight(FontWeight.Medium)
        .fontColor(layer.id === this.selectedLayer ? AppColors.onPrimary : '#B3263238')
        .textAlign(TextAlign.Center)
        .width('100%')

      Text(layer.content)
        .fontSize(28)
        .fontColor(layer.id === this.selectedLayer ? AppColors.onPrimary : AppColors.onSurface)
        .textAlign(TextAlign.Center)
        .maxLines(1)
        .textOverflow({ overflow: TextOverflow.Ellipsis })
        .width('100%')
    }
    .width(264)
    .height(204)
    .padding({ left: 16, right: 16, top: 22, bottom: 18 })
    .justifyContent(FlexAlign.Center)
    .alignItems(HorizontalAlign.Center)
    .backgroundColor(layer.id === this.selectedLayer ? AppColors.primary : AppColors.surface)
    .borderRadius(12)
    .border({
      width: 1.5,
      color: layer.id === this.selectedLayer ? AppColors.primary : AppColors.outline
    })
    .onClick(() => {
      this.selectedLayer = layer.id
    })
  }

  @Builder
  private LayerStrip() {
    Scroll() {
      Row({ space: 24 }) {
        ForEach(this.layers, (layer: StoryLayer) => {
          this.LayerCard(layer)
        }, (layer: StoryLayer) => layer.id.toString())
      }
      .padding({ left: 32, right: 32, top: 12, bottom: 22 })
    }
    .scrollable(ScrollDirection.Horizontal)
    .scrollBar(BarState.Off)
    .width('100%')
  }

  @Builder
  private BottomPanel() {
    Column() {
      Text('Layer Properties')
        .fontSize(24)
        .fontWeight(FontWeight.Medium)
        .fontColor(AppColors.secondary)
        .letterSpacing(1)
        .width('100%')

      Row() {
        Text('Opacity')
          .fontSize(28)
          .fontColor(AppColors.onSurface)
          .width(160)

        Slider({
          value: this.textOpacity,
          min: 0,
          max: 1,
          step: 0.01,
          style: SliderStyle.OutSet
        })
          .layoutWeight(1)
          .blockColor(AppColors.primary)
          .trackColor(AppColors.surfaceVariant)
          .selectedColor(AppColors.primary)
          .onChange((value: number) => {
            this.textOpacity = value
          })
      }
      .height(80)
      .width('100%')
      .margin({ top: 24 })
      .alignItems(VerticalAlign.Center)
    }
    .width('100%')
    .height(214)
    .padding({ left: 32, right: 32, top: 34, bottom: 24 })
    .backgroundColor(AppColors.surface)
    .shadow({ radius: 6, color: '#1A000000', offsetX: 0, offsetY: -2 })
  }

  build() {
    Column() {
      this.TopBar()

      Column({ space: 24 }) {
        this.StoryPreview()
        this.UploadStatus()
        this.LayerStrip()
      }
      .width('100%')
      .layoutWeight(1)
      .padding({ top: 32 })

      this.BottomPanel()
    }
    .width('100%')
    .height('100%')
    .backgroundColor(AppColors.background)
  }
}
