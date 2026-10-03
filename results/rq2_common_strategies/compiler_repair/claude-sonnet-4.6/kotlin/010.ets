import { router } from '@kit.ArkUI'

// Color tokens
const Colors = {
  primary: 0xFF1976D2,
  secondary: 0xFF607D8B,
  tertiary: 0xFF757575,
  background: 0xFFECEFF1,
  surface: 0xFFFFFFFF,
  surfaceVariant: 0xFFCFD8DC,
  outline: 0xFFB0BEC5,
  success: 0xFF4CAF50,
  warning: 0xFFFFC107,
  error: 0xFFF44336,
  onPrimary: 0xFFFFFFFF,
  onSecondary: 0xFFFFFFFF,
  onTertiary: 0xFFFFFFFF,
  onBackground: 0xFF263238,
  onSurface: 0xFF263238,
}

interface StoryLayerData {
  id: number;
  type: string;
  content: string;
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
    { id: 4, type: 'ICO', content: 'Sticker' },
  ]

  build() {
    Column() {
      // Top App Bar
      Row() {
        Button('Exit')
          .backgroundColor(Color.Transparent)
          .fontColor(Colors.onBackground)
          .fontSize(14)
          .height(40)
          .padding({ left: 8, right: 8 })

        Text('Story Editor')
          .fontSize(18)
          .fontWeight(FontWeight.Medium)
          .fontColor(Colors.onBackground)
          .layoutWeight(1)
          .textAlign(TextAlign.Center)

        Button('Post')
          .backgroundColor(Colors.primary)
          .fontColor(Colors.onPrimary)
          .fontSize(14)
          .height(40)
          .borderRadius(8)
          .padding({ left: 8, right: 8 })
      }
      .width('100%')
      .height(56)
      .backgroundColor(Colors.surface)
      .padding({ left: 8, right: 8 })
      .alignItems(VerticalAlign.Center)

      // Main content
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
        .backgroundColor(Colors.tertiary)
        .borderRadius(12)
        .margin({ left: 16, right: 16, top: 16, bottom: 8 })

        // Upload Status
        Column() {
          Text('Upload Status')
            .fontSize(12)
            .fontWeight(FontWeight.Medium)
            .fontColor(Colors.secondary)
            .width('100%')
            .margin({ bottom: 6 })

          Progress({ value: this.uploadProgress * 100, total: 100, type: ProgressType.Linear })
            .width('100%')
            .height(8)
            .color(Colors.success)
            .backgroundColor(Colors.surfaceVariant)
        }
        .width('100%')
        .padding({ left: 16, right: 16, top: 8, bottom: 8 })

        // Layer Cards
        Scroll() {
          Row({ space: 12 }) {
            ForEach(this.layers, (layer: StoryLayerData) => {
              LayerCard({
                layer: layer,
                isSelected: layer.id === this.selectedLayer,
                onSelect: (id: number) => {
                  this.selectedLayer = id
                }
              })
            })
          }
          .padding({ left: 16, right: 16, top: 12, bottom: 12 })
        }
        .scrollable(ScrollDirection.Horizontal)
        .scrollBar(BarState.Off)
        .width('100%')
      }
      .layoutWeight(1)
      .backgroundColor(Colors.background)

      // Bottom Bar
      Column() {
        Text('Layer Properties')
          .fontSize(12)
          .fontWeight(FontWeight.Medium)
          .fontColor(Colors.secondary)
          .width('100%')
          .margin({ bottom: 12 })

        Row() {
          Text('Opacity')
            .fontSize(14)
            .fontColor(Colors.onSurface)
            .width(80)

          Slider({
            value: this.textOpacity * 100,
            min: 0,
            max: 100,
            step: 1,
            style: SliderStyle.OutSet
          })
            .layoutWeight(1)
            .selectedColor(Colors.primary)
            .trackColor(Colors.surfaceVariant)
            .blockColor(Colors.primary)
            .onChange((value: number) => {
              this.textOpacity = value / 100
            })
        }
        .width('100%')
        .alignItems(VerticalAlign.Center)
      }
      .width('100%')
      .backgroundColor(Colors.surface)
      .padding(16)
      .shadow({ radius: 6, color: '#1A000000', offsetY: -2 })
    }
    .width('100%')
    .height('100%')
    .backgroundColor(Colors.background)
  }
}

@Component
struct LayerCard {
  layer: StoryLayerData = { id: 0, type: '', content: '' }
  isSelected: boolean = false
  onSelect: (id: number) => void = () => {}

  build() {
    Column({ space: 8 }) {
      Stack()
        .width(32)
        .height(32)
        .borderRadius(16)
        .backgroundColor(this.isSelected ? 0x33FFFFFF : Colors.surfaceVariant)

      Text(this.layer.type)
        .fontSize(12)
        .fontWeight(FontWeight.Medium)
        .fontColor(this.isSelected ? Colors.onPrimary : 0xB3263238)

      Text(this.layer.content)
        .fontSize(14)
        .fontColor(this.isSelected ? Colors.onPrimary : Colors.onSurface)
        .textAlign(TextAlign.Center)
    }
    .width(100)
    .padding({ left: 16, right: 16, top: 12, bottom: 12 })
    .alignItems(HorizontalAlign.Center)
    .backgroundColor(this.isSelected ? Colors.primary : Colors.surface)
    .borderRadius(8)
    .border({
      width: 1,
      color: this.isSelected ? Colors.primary : Colors.outline,
      radius: 8
    })
    .onClick(() => {
      this.onSelect(this.layer.id)
    })
  }
}