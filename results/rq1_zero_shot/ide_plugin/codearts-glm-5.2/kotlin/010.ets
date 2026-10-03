const AppColors = {
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

const AppSpacing = {
  sm: 8,
  md: 12,
  lg: 16
}

interface StoryLayer {
  id: number
  type: string
  content: string
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

  withAlpha(hex: string, alpha: number): string {
    const a = Math.round(alpha * 255)
    const aHex = a < 16 ? '0' + a.toString(16) : a.toString(16)
    return '#' + aHex + hex.substring(1)
  }

  build() {
    Column() {
      Row() {
        Text('Exit')
          .fontSize(14)
          .fontColor(AppColors.onBackground)
          .padding({ left: AppSpacing.sm, right: AppSpacing.sm })
          .onClick(() => {})

        Text('Story Editor')
          .fontSize(18)
          .fontWeight(FontWeight.Medium)
          .fontColor(AppColors.onSurface)
          .layoutWeight(1)
          .textAlign(TextAlign.Center)

        Text('Post')
          .fontSize(14)
          .fontWeight(FontWeight.Medium)
          .fontColor(AppColors.onPrimary)
          .backgroundColor(AppColors.primary)
          .borderRadius(8)
          .padding({ left: AppSpacing.sm, right: AppSpacing.sm, top: 6, bottom: 6 })
          .onClick(() => {})
      }
      .width('100%')
      .padding({ left: AppSpacing.sm, right: AppSpacing.sm, top: 12, bottom: 12 })
      .backgroundColor(AppColors.surface)
      .alignItems(VerticalAlign.Center)

      Column() {
        Text('Your Story Preview')
          .fontSize(24)
          .fontWeight(FontWeight.Medium)
          .fontColor(this.withAlpha(AppColors.onTertiary, this.textOpacity))
          .textAlign(TextAlign.Center)
      }
      .width('100%')
      .layoutWeight(1)
      .padding(AppSpacing.lg)
      .backgroundColor(AppColors.tertiary)
      .borderRadius(12)
      .justifyContent(FlexAlign.Center)
      .alignItems(HorizontalAlign.Center)

      Column({ space: AppSpacing.sm }) {
        Text('Upload Status')
          .fontSize(12)
          .fontWeight(FontWeight.Medium)
          .fontColor(AppColors.secondary)
        Progress({
          value: this.uploadProgress,
          total: 1,
          type: ProgressType.Linear
        })
          .width('100%')
          .height(AppSpacing.sm)
          .color(AppColors.success)
          .backgroundColor(AppColors.surfaceVariant)
      }
      .width('100%')
      .padding({ left: AppSpacing.lg, right: AppSpacing.lg })

      Scroll() {
        Row({ space: AppSpacing.md }) {
          ForEach(this.layers, (layer: StoryLayer) => {
            Column({ space: AppSpacing.sm }) {
              Column()
                .width(32)
                .height(32)
                .backgroundColor(this.selectedLayer === layer.id ? '#33FFFFFF' : AppColors.surfaceVariant)
                .borderRadius(16)
              Text(layer.type)
                .fontSize(12)
                .fontWeight(FontWeight.Medium)
                .fontColor(this.selectedLayer === layer.id ? AppColors.onPrimary : '#B3263238')
              Text(layer.content)
                .fontSize(14)
                .fontColor(this.selectedLayer === layer.id ? AppColors.onPrimary : AppColors.onSurface)
            }
            .width(100)
            .padding({ left: AppSpacing.lg, right: AppSpacing.lg, top: AppSpacing.md, bottom: AppSpacing.md })
            .backgroundColor(this.selectedLayer === layer.id ? AppColors.primary : AppColors.surface)
            .border({ width: 1, color: this.selectedLayer === layer.id ? AppColors.primary : AppColors.outline, radius: 8 })
            .alignItems(HorizontalAlign.Center)
            .onClick(() => {
              this.selectedLayer = layer.id
            })
          }, (layer: StoryLayer) => layer.id.toString())
        }
        .padding({ left: AppSpacing.lg, right: AppSpacing.lg, top: AppSpacing.md, bottom: AppSpacing.md })
      }
      .scrollDirection(ScrollDirection.Horizontal)
      .scrollBar(BarState.Off)
      .width('100%')

      Column() {
        Text('Layer Properties')
          .fontSize(12)
          .fontWeight(FontWeight.Medium)
          .fontColor(AppColors.secondary)
        Blank().height(AppSpacing.md)
        Row() {
          Text('Opacity')
            .fontSize(14)
            .fontColor(AppColors.onSurface)
            .width(80)
          Slider({
            value: this.textOpacity,
            min: 0,
            max: 1,
            style: SliderStyle.OutSet
          })
            .blockColor(AppColors.primary)
            .trackColor(AppColors.surfaceVariant)
            .selectedColor(AppColors.primary)
            .layoutWeight(1)
            .onChange((value: number) => {
              this.textOpacity = value
            })
        }
        .width('100%')
        .alignItems(VerticalAlign.Center)
      }
      .width('100%')
      .padding(AppSpacing.lg)
      .backgroundColor(AppColors.surface)
    }
    .width('100%')
    .height('100%')
    .backgroundColor(AppColors.background)
  }
}