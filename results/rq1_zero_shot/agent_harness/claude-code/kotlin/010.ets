import promptAction from '@ohos.promptAction'

@Observed
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

namespace AppTokens {
  export namespace Colors {
    export const primary: string = '#FF1976D2'
    export const secondary: string = '#FF607D8B'
    export const tertiary: string = '#FF757575'
    export const background: string = '#FFECEFF1'
    export const surface: string = '#FFFFFFFF'
    export const surfaceVariant: string = '#FFCFD8DC'
    export const outline: string = '#FFB0BEC5'
    export const success: string = '#FF4CAF50'
    export const warning: string = '#FFFFC107'
    export const error: string = '#FFF44336'
    export const onPrimary: string = '#FFFFFFFF'
    export const onSecondary: string = '#FFFFFFFF'
    export const onTertiary: string = '#FFFFFFFF'
    export const onBackground: string = '#FF263238'
    export const onSurface: string = '#FF263238'
  }

  export namespace Spacing {
    export const sm: number = 8
    export const md: number = 12
    export const lg: number = 16
  }
}

@Component
struct LayerCard {
  @Link selectedLayer: number
  layer: StoryLayer

  build() {
    Column() {
      Row() {
      }
      .width(32)
      .height(32)
      .borderRadius(16)
      .backgroundColor(this.layer.id === this.selectedLayer
        ? AppTokens.Colors.onPrimary
        : AppTokens.Colors.surfaceVariant)
      .opacity(this.layer.id === this.selectedLayer ? 0.2 : 1)

      Text(this.layer.type)
        .fontSize(12)
        .fontWeight(FontWeight.Medium)
        .letterSpacing(0.5)
        .fontColor(this.layer.id === this.selectedLayer
          ? AppTokens.Colors.onPrimary
          : AppTokens.Colors.onSurface)
        .opacity(this.layer.id === this.selectedLayer ? 1 : 0.7)

      Text(this.layer.content)
        .fontSize(14)
        .fontWeight(FontWeight.Normal)
        .letterSpacing(0.25)
        .fontColor(this.layer.id === this.selectedLayer
          ? AppTokens.Colors.onPrimary
          : AppTokens.Colors.onSurface)
    }
    .width(100)
    .padding({ left: AppTokens.Spacing.lg, right: AppTokens.Spacing.lg, top: AppTokens.Spacing.md, bottom: AppTokens.Spacing.md })
    .alignItems(HorizontalAlign.Center)
    .justifyContent(FlexAlign.Center)
    .borderRadius(8)
    .borderWidth(1)
    .borderColor(this.layer.id === this.selectedLayer
      ? AppTokens.Colors.primary
      : AppTokens.Colors.outline)
    .backgroundColor(this.layer.id === this.selectedLayer
      ? AppTokens.Colors.primary
      : AppTokens.Colors.surface)
    .onClick(() => {
      this.selectedLayer = this.layer.id
    })
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
      // Top App Bar
      Row() {
        Button('Exit')
          .fontSize(14)
          .fontColor(AppTokens.Colors.onBackground)
          .backgroundColor(Color.Transparent)
          .padding({ left: AppTokens.Spacing.sm, right: AppTokens.Spacing.sm })
          .onClick(() => {
            promptAction.showToast({ message: 'Exit', duration: 1000 })
          })

        Text('Story Editor')
          .fontSize(18)
          .fontWeight(FontWeight.Medium)
          .letterSpacing(0.1)
          .fontColor(AppTokens.Colors.onSurface)
          .layoutWeight(1)
          .textAlign(TextAlign.Center)

        Button('Post')
          .fontSize(14)
          .fontColor(AppTokens.Colors.onPrimary)
          .backgroundColor(AppTokens.Colors.primary)
          .borderRadius(8)
          .padding({ left: AppTokens.Spacing.sm, right: AppTokens.Spacing.sm })
          .onClick(() => {
            promptAction.showToast({ message: 'Post', duration: 1000 })
          })
      }
      .width('100%')
      .padding({ left: AppTokens.Spacing.md, right: AppTokens.Spacing.md, top: 12, bottom: 12 })
      .backgroundColor(AppTokens.Colors.surface)

      // Main content
      Column() {
        // Story Preview Card
        Column() {
          Text('Your Story Preview')
            .fontSize(24)
            .fontWeight(FontWeight.SemiBold)
            .fontColor(AppTokens.Colors.onTertiary)
            .opacity(this.textOpacity)
            .textAlign(TextAlign.Center)
        }
        .width('100%')
        .layoutWeight(1)
        .margin(AppTokens.Spacing.lg)
        .borderRadius(12)
        .backgroundColor(AppTokens.Colors.tertiary)
        .alignItems(HorizontalAlign.Center)
        .justifyContent(FlexAlign.Center)
        .shadow({
          radius: 3,
          color: 'rgba(0,0,0,0.1)',
          offsetY: 1
        })

        // Upload Status
        Column() {
          Text('Upload Status')
            .fontSize(12)
            .fontWeight(FontWeight.Medium)
            .letterSpacing(0.5)
            .fontColor(AppTokens.Colors.secondary)
            .margin({ bottom: AppTokens.Spacing.sm })

          Progress({ value: this.uploadProgress * 100, total: 100, type: ProgressType.Linear })
            .width('100%')
            .height(AppTokens.Spacing.sm)
            .color(AppTokens.Colors.success)
            .backgroundColor(AppTokens.Colors.surfaceVariant)
        }
        .width('100%')
        .padding({ left: AppTokens.Spacing.lg, right: AppTokens.Spacing.lg })
        .margin({ bottom: AppTokens.Spacing.sm })

        // Layers horizontal list
        List({ space: AppTokens.Spacing.md }) {
          ForEach(this.layers, (layer: StoryLayer) => {
            ListItem() {
              LayerCard({ layer: layer, selectedLayer: $selectedLayer })
            }
          }, (layer: StoryLayer) => layer.id.toString())
        }
        .listDirection(Axis.Horizontal)
        .width('100%')
        .padding({ left: AppTokens.Spacing.lg, right: AppTokens.Spacing.lg, top: AppTokens.Spacing.md, bottom: AppTokens.Spacing.md })
        .divider({ strokeWidth: 0, color: Color.Transparent })
      }
      .width('100%')
      .layoutWeight(1)
      .alignItems(HorizontalAlign.Center)

      // Bottom bar - Layer Properties
      Column() {
        Text('Layer Properties')
          .fontSize(12)
          .fontWeight(FontWeight.Medium)
          .letterSpacing(0.5)
          .fontColor(AppTokens.Colors.secondary)
          .margin({ bottom: AppTokens.Spacing.md })

        Row() {
          Text('Opacity')
            .fontSize(14)
            .fontWeight(FontWeight.Normal)
            .letterSpacing(0.25)
            .fontColor(AppTokens.Colors.onSurface)
            .width(80)

          Slider({
            value: this.textOpacity,
            min: 0,
            max: 1,
            step: 0.01,
            style: SliderStyle.OutSet
          })
            .layoutWeight(1)
            .blockColor(AppTokens.Colors.primary)
            .trackColor(AppTokens.Colors.surfaceVariant)
            .selectedColor(AppTokens.Colors.primary)
            .onChange((value: number) => {
              this.textOpacity = value
            })
        }
        .width('100%')
        .alignItems(VerticalAlign.Center)
      }
      .width('100%')
      .padding(AppTokens.Spacing.lg)
      .backgroundColor(AppTokens.Colors.surface)
      .shadow({
        radius: 6,
        color: 'rgba(0,0,0,0.1)',
        offsetY: -2
      })
    }
    .width('100%')
    .height('100%')
    .backgroundColor(AppTokens.Colors.background)
  }
}
