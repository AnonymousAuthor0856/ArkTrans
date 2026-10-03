class AppTokens {
  static readonly Colors = {
    primary: '#FF1976D2',
    secondary: '#FF607D8B',
    tertiary: '#FF757575',
    background: '#FFECEFF1',
    surface: '#FFFFFFFF',
    surfaceVariant: '#FFCFD8DC',
    outline: '#FFB0BEC5',
    success: '#FF4CAF50',
    warning: '#FFFFC107',
    error: '#FFF44336',
    onPrimary: '#FFFFFFFF',
    onSecondary: '#FFFFFFFF',
    onTertiary: '#FFFFFFFF',
    onBackground: '#FF263238',
    onSurface: '#FF263238',
    onSurface70: '#B3263238',
    onPrimary20: '#33FFFFFF'
  }

  static readonly Spacing = {
    sm: 8,
    md: 12,
    lg: 16,
    xl: 24,
    xxl: 32
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

@Entry
@Component
struct RootScreen {
  @State textOpacity: number = 1.0
  @State uploadProgress: number = 0.65
  @State selectedLayer: number = 3

  private layers: StoryLayer[] = [
    new StoryLayer(1, 'BG', 'Gradient'),
    new StoryLayer(2, 'IMG', 'User Photo'),
    new StoryLayer(3, 'TXT', 'Hello World'),
    new StoryLayer(4, 'ICO', 'Sticker')
  ]

  build() {
    Column() {
      Row() {
        Text('Exit')
          .fontSize(14)
          .fontColor(AppTokens.Colors.onBackground)
          .padding({ left: 8, right: 8 })

        Text('Story Editor')
          .fontSize(18)
          .fontWeight(FontWeight.Medium)
          .fontColor(AppTokens.Colors.onSurface)
          .layoutWeight(1)
          .textAlign(TextAlign.Center)

        Text('Post')
          .fontSize(14)
          .fontColor(AppTokens.Colors.onPrimary)
          .padding({ left: 12, right: 12, top: 8, bottom: 8 })
          .borderRadius(8)
          .backgroundColor(AppTokens.Colors.primary)
          .margin({ right: 8 })
      }
      .width('100%')
      .height(64)
      .backgroundColor(AppTokens.Colors.surface)
      .alignItems(VerticalAlign.Center)

      Scroll() {
        Column() {
          Row() {
            Text('Your Story Preview')
              .fontSize(24)
              .fontWeight(FontWeight.Medium)
              .fontColor(AppTokens.Colors.onTertiary)
              .textAlign(TextAlign.Center)
          }
          .width('100%')
          .height(200)
          .borderRadius(12)
          .backgroundColor(AppTokens.Colors.tertiary)
          .justifyContent(FlexAlign.Center)
          .alignItems(VerticalAlign.Center)
          .margin({ left: 16, right: 16 })

          Column() {
            Text('Upload Status')
              .fontSize(12)
              .fontWeight(FontWeight.Medium)
              .fontColor(AppTokens.Colors.secondary)

            Stack() {
              Row()
                .width('100%')
                .height(8)
                .borderRadius(4)
                .backgroundColor(AppTokens.Colors.surfaceVariant)
              Row()
                .width('65%')
                .height(8)
                .borderRadius(4)
                .backgroundColor(AppTokens.Colors.success)
            }
            .width('100%')
            .height(8)
            .alignContent(Alignment.Start)
            .margin({ top: 8 })
          }
          .alignItems(HorizontalAlign.Start)
          .padding({ left: 16, right: 16 })
          .margin({ top: 16 })

          Column() {
            Text('Story Layers')
              .fontSize(12)
              .fontWeight(FontWeight.Medium)
              .fontColor(AppTokens.Colors.secondary)
              .padding({ left: 16, right: 16 })

            Scroll() {
              Row() {
                ForEach(this.layers, (layer: StoryLayer) => {
                  LayerItemView({
                    type: layer.type,
                    content: layer.content,
                    isSelected: layer.id === this.selectedLayer,
                    onSelect: () => {
                      this.selectedLayer = layer.id
                    }
                  })
                    .margin({ right: 16 })
                })
              }
              .padding({ left: 16, right: 16, top: 12, bottom: 12 })
            }
            .scrollDirection(Axis.Horizontal)
            .scrollBar(BarState.Off)
            .margin({ top: 8 })
          }
          .alignItems(HorizontalAlign.Start)
        }
        .padding({ top: 16, bottom: 16 })
      }
      .layoutWeight(1)
      .scrollBar(BarState.Off)
      .backgroundColor(AppTokens.Colors.background)

      Column() {
        Text('Layer Properties')
          .fontSize(12)
          .fontWeight(FontWeight.Medium)
          .fontColor(AppTokens.Colors.secondary)

        Row() {
          Text('Opacity')
            .fontSize(14)
            .fontColor(AppTokens.Colors.onSurface)
            .width(80)
          Slider({
            value: this.textOpacity,
            min: 0,
            max: 1,
            style: SliderStyle.OutSet
          })
            .blockColor(AppTokens.Colors.primary)
            .trackColor(AppTokens.Colors.surfaceVariant)
            .selectedColor(AppTokens.Colors.primary)
            .layoutWeight(1)
            .onChange((value: number) => {
              this.textOpacity = value
            })
        }
        .alignItems(VerticalAlign.Center)
        .margin({ top: 12 })
      }
      .alignItems(HorizontalAlign.Start)
      .padding(16)
      .width('100%')
      .backgroundColor(AppTokens.Colors.surface)
    }
    .width('100%')
    .height('100%')
    .backgroundColor(AppTokens.Colors.background)
  }
}

@Component
struct LayerItemView {
  @Prop type: string
  @Prop content: string
  @Prop isSelected: boolean
  onSelect: () => void = () => {}

  build() {
    Column() {
      Row()
        .width(32)
        .height(32)
        .borderRadius(16)
        .backgroundColor(this.isSelected ? AppTokens.Colors.onPrimary20 : AppTokens.Colors.surfaceVariant)

      Text(this.type)
        .fontSize(12)
        .fontWeight(FontWeight.Medium)
        .fontColor(this.isSelected ? AppTokens.Colors.onPrimary : AppTokens.Colors.onSurface70)
        .margin({ top: 8 })

      Text(this.content)
        .fontSize(14)
        .fontColor(this.isSelected ? AppTokens.Colors.onPrimary : AppTokens.Colors.onSurface)
        .textAlign(TextAlign.Center)
        .margin({ top: 8 })
    }
    .width(130)
    .padding({ left: 32, right: 32, top: 12, bottom: 12 })
    .borderRadius(8)
    .backgroundColor(this.isSelected ? AppTokens.Colors.primary : AppTokens.Colors.surface)
    .border({ width: 1, color: this.isSelected ? AppTokens.Colors.primary : AppTokens.Colors.outline })
    .alignItems(HorizontalAlign.Center)
    .onClick(() => {
      this.onSelect()
    })
  }
}