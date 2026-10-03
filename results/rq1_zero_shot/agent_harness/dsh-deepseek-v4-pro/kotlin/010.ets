interface StoryLayer {
  id: number
  type: string
  content: string
}

const Colors = {
  primary: '#1976D2',
  secondary: '#607D8B',
  tertiary: '#757575',
  background: '#ECEFF1',
  surface: '#FFFFFF',
  surfaceVariant: '#CFD8DC',
  outline: '#B0BEC5',
  success: '#4CAF50',
  warning: '#FFC107',
  error: '#F44336',
  onPrimary: '#FFFFFF',
  onSecondary: '#FFFFFF',
  onTertiary: '#FFFFFF',
  onBackground: '#263238',
  onSurface: '#263238'
}

const Spacing = {
  sm: 8, md: 12, lg: 16
}

@Entry
@Component
struct Index {
  @State textOpacity: number = 1
  @State uploadProgress: number = 0.65
  @State selectedLayer: number = 3
  private layers: StoryLayer[] = [
    { id: 1, type: 'BG', content: 'Gradient' },
    { id: 2, type: 'IMG', content: 'User Photo' },
    { id: 3, type: 'TXT', content: 'Hello World' },
    { id: 4, type: 'ICO', content: 'Sticker' }
  ]

  build() {
    Column() {
      Row() {
        Button('Exit')
          .fontSize(14)
          .fontWeight(FontWeight.Medium)
          .fontColor(Colors.onBackground)
          .backgroundColor('#00000000')
        Text('Story Editor')
          .fontSize(18)
          .fontWeight(FontWeight.Medium)
          .layoutWeight(1)
          .textAlign(TextAlign.Center)
        Button('Post')
          .fontSize(14)
          .fontWeight(FontWeight.Medium)
          .fontColor(Colors.onPrimary)
          .backgroundColor(Colors.primary)
          .borderRadius(8)
      }
      .width('100%')
      .height(56)
      .backgroundColor(Colors.surface)
      .alignItems(VerticalAlign.Center)
      .padding({ left: Spacing.sm, right: Spacing.sm })

      Column({ space: Spacing.lg }) {
        Stack() {
          Text('Your Story Preview')
            .fontSize(24)
            .fontWeight(FontWeight.Bold)
            .fontColor(Colors.onTertiary)
            .textAlign(TextAlign.Center)
            .opacity(this.textOpacity)
        }
        .width('100%')
        .layoutWeight(1)
        .backgroundColor(Colors.tertiary)
        .borderRadius(12)
        .margin({ left: Spacing.lg, right: Spacing.lg, top: Spacing.lg, bottom: 0 })
        .shadow({ radius: 3, color: '#1A000000', offsetY: 1 })

        Column({ space: Spacing.sm }) {
          Text('Upload Status')
            .fontSize(12)
            .fontWeight(FontWeight.Medium)
            .fontColor(Colors.secondary)
          Progress({ value: this.uploadProgress, total: 1, type: ProgressType.Linear })
            .width('100%')
            .height(Spacing.sm)
            .color(Colors.success)
            .backgroundColor(Colors.surfaceVariant)
        }
        .width('100%')
        .padding({ left: Spacing.lg, right: Spacing.lg })

        Scroll() {
          Row({ space: Spacing.md }) {
            ForEach(this.layers, (layer: StoryLayer) => {
              Column({ space: Spacing.sm }) {
                Blank()
                  .width(32)
                  .height(32)
                  .backgroundColor(this.selectedLayer === layer.id ? '#33FFFFFF' : Colors.surfaceVariant)
                  .borderRadius(32)
                Text(layer.type)
                  .fontSize(12)
                  .fontWeight(FontWeight.Medium)
                  .fontColor(this.selectedLayer === layer.id ? Colors.onPrimary : Colors.onSurface)
                  .opacity(this.selectedLayer === layer.id ? 1 : 0.7)
                Text(layer.content)
                  .fontSize(14)
                  .fontColor(this.selectedLayer === layer.id ? Colors.onPrimary : Colors.onSurface)
              }
              .width(100)
              .padding({ left: Spacing.lg, right: Spacing.lg, top: Spacing.md, bottom: Spacing.md })
              .backgroundColor(this.selectedLayer === layer.id ? Colors.primary : Colors.surface)
              .borderRadius(8)
              .border({ width: 1, color: this.selectedLayer === layer.id ? Colors.primary : Colors.outline })
              .onClick(() => { this.selectedLayer = layer.id })
            }, (layer: StoryLayer) => layer.id.toString())
          }
          .padding({ left: Spacing.lg, right: Spacing.lg, top: Spacing.md, bottom: Spacing.md })
        }
        .scrollable(ScrollDirection.Horizontal)
        .scrollBar(BarState.Off)
        .width('100%')
      }
      .layoutWeight(1)
      .width('100%')

      Column() {
        Text('Layer Properties')
          .fontSize(12)
          .fontWeight(FontWeight.Medium)
          .fontColor(Colors.secondary)
        Blank().height(Spacing.md)
        Row() {
          Text('Opacity')
            .fontSize(14)
            .width(80)
          Slider({ value: this.textOpacity, min: 0, max: 1 })
            .layoutWeight(1)
            .selectedColor(Colors.primary)
            .trackColor(Colors.surfaceVariant)
            .blockColor(Colors.primary)
            .onChange((value: number) => { this.textOpacity = value })
        }
        .alignItems(VerticalAlign.Center)
      }
      .width('100%')
      .backgroundColor(Colors.surface)
      .padding(Spacing.lg)
      .shadow({ radius: 6, color: '#1A000000', offsetY: -2 })
    }
    .width('100%')
    .height('100%')
    .backgroundColor(Colors.background)
  }
}
