import { router } from '@kit.ArkUI'

// App Tokens
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
  onSurface: '#263238',
}

interface StoryLayer {
  id: number
  type: string
  content: string
}

@Entry
@Component
struct RootScreen {
  @State textOpacity: number = 1.0
  @State uploadProgress: number = 0.65
  @State selectedLayerId: number = 3

  private layers: StoryLayer[] = [
    { id: 1, type: 'BG', content: 'Gradient' },
    { id: 2, type: 'IMG', content: 'User Photo' },
    { id: 3, type: 'TXT', content: 'Hello World' },
    { id: 4, type: 'ICO', content: 'Sticker' },
  ]

  build() {
    Column() {
      // Top App Bar
      Row() {
        Button('Exit')
          .backgroundColor(Color.Transparent)
          .fontColor(AppColors.onBackground)
          .fontSize(14)
          .height(40)
          .padding({ left: 8, right: 8 })

        Text('Story Editor')
          .fontSize(18)
          .fontWeight(FontWeight.Medium)
          .fontColor(AppColors.onSurface)
          .layoutWeight(1)
          .textAlign(TextAlign.Center)

        Button('Post')
          .backgroundColor(AppColors.primary)
          .fontColor(AppColors.onPrimary)
          .fontSize(14)
          .height(40)
          .borderRadius(8)
          .padding({ left: 8, right: 8 })
      }
      .width('100%')
      .height(56)
      .backgroundColor(AppColors.surface)
      .padding({ left: 8, right: 8 })
      .alignItems(VerticalAlign.Center)

      // Main Content
      Column() {
        // Story Preview Card
        Stack({ alignContent: Alignment.Center }) {
          Text('Your Story Preview')
            .fontSize(24)
            .fontWeight(FontWeight.SemiBold)
            .fontColor(`rgba(255,255,255,${this.textOpacity})`)
            .textAlign(TextAlign.Center)
        }
        .width('100%')
        .layoutWeight(1)
        .margin({ left: 16, right: 16, top: 16, bottom: 0 })
        .backgroundColor(AppColors.tertiary)
        .borderRadius(12)
        .shadow({ radius: 3, color: '#1A000000', offsetY: 1 })

        // Upload Status
        Column() {
          Text('Upload Status')
            .fontSize(12)
            .fontWeight(FontWeight.Medium)
            .fontColor(AppColors.secondary)
            .letterSpacing(0.5)
            .alignSelf(ItemAlign.Start)

          Progress({
            value: this.uploadProgress * 100,
            total: 100,
            type: ProgressType.Linear
          })
            .width('100%')
            .height(8)
            .color(AppColors.success)
            .backgroundColor(AppColors.surfaceVariant)
            .style({ strokeWidth: 8 })
        }
        .width('100%')
        .padding({ left: 16, right: 16, top: 12, bottom: 0 })
        .alignItems(HorizontalAlign.Start)
        .margin({ top: 16 })

        // Layer Cards - Horizontal Scroll
        Scroll() {
          Row({ space: 12 }) {
            ForEach(this.layers, (layer: StoryLayer) => {
              LayerCard({
                layer: layer,
                isSelected: layer.id === this.selectedLayerId,
                onSelect: (id: number) => {
                  this.selectedLayerId = id
                }
              })
            })
          }
          .padding({ left: 16, right: 16, top: 12, bottom: 12 })
        }
        .scrollable(ScrollDirection.Horizontal)
        .scrollBar(BarState.Off)
        .width('100%')
        .margin({ top: 8 })

        // Bottom Bar - Layer Properties
        Column() {
          Text('Layer Properties')
            .fontSize(12)
            .fontWeight(FontWeight.Medium)
            .fontColor(AppColors.secondary)
            .letterSpacing(0.5)
            .alignSelf(ItemAlign.Start)

          Blank().height(12)

          Row() {
            Text('Opacity')
              .fontSize(14)
              .fontColor(AppColors.onSurface)
              .width(80)

            Slider({
              value: this.textOpacity * 100,
              min: 0,
              max: 100,
              step: 1,
              style: SliderStyle.OutSet
            })
              .layoutWeight(1)
              .selectedColor(AppColors.primary)
              .trackColor(AppColors.surfaceVariant)
              .blockColor(AppColors.primary)
              .onChange((value: number) => {
                this.textOpacity = value / 100
              })
          }
          .width('100%')
          .alignItems(VerticalAlign.Center)
        }
        .width('100%')
        .padding(16)
        .backgroundColor(AppColors.surface)
        .shadow({ radius: 6, color: '#1A000000', offsetY: -2 })
        .alignItems(HorizontalAlign.Start)
      }
      .layoutWeight(1)
      .width('100%')
      .backgroundColor(AppColors.background)
    }
    .width('100%')
    .height('100%')
    .backgroundColor(AppColors.background)
  }
}

@Component
struct LayerCard {
  layer: StoryLayer = { id: 0, type: '', content: '' }
  isSelected: boolean = false
  onSelect: (id: number) => void = () => {}

  build() {
    Column({ space: 8 }) {
      Stack()
        .width(32)
        .height(32)
        .borderRadius(16)
        .backgroundColor(this.isSelected ? 'rgba(255,255,255,0.2)' : AppColors.surfaceVariant)

      Text(this.layer.type)
        .fontSize(12)
        .fontWeight(FontWeight.Medium)
        .letterSpacing(0.5)
        .fontColor(this.isSelected ? AppColors.onPrimary : `rgba(38,50,56,0.7)`)

      Text(this.layer.content)
        .fontSize(14)
        .fontColor(this.isSelected ? AppColors.onPrimary : AppColors.onSurface)
        .textAlign(TextAlign.Center)
        .maxLines(1)
        .textOverflow({ overflow: TextOverflow.Ellipsis })
    }
    .width(100)
    .padding({ left: 16, right: 16, top: 12, bottom: 12 })
    .alignItems(HorizontalAlign.Center)
    .backgroundColor(this.isSelected ? AppColors.primary : AppColors.surface)
    .borderRadius(8)
    .border({
      width: 1,
      color: this.isSelected ? AppColors.primary : AppColors.outline,
      radius: 8
    })
    .onClick(() => {
      this.onSelect(this.layer.id)
    })
  }
}