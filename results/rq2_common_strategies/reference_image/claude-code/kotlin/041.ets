// @ts-nocheck
import prompt from '@ohos.prompt'

class AppTokens {
  static Colors = class {
    static primary: string = '#FF111111'
    static secondary: string = '#FF333333'
    static tertiary: string = '#FF777777'
    static background: string = '#FFFFFFFF'
    static surface: string = '#FFF9F9F9'
    static surfaceVariant: string = '#FFE5E5E5'
    static outline: string = '#FFCCCCCC'
    static success: string = '#FF16A34A'
    static warning: string = '#FFF59E0B'
    static error: string = '#FFDC2626'
    static onPrimary: string = '#FFFFFFFF'
    static onSecondary: string = '#FFFFFFFF'
    static onTertiary: string = '#FF111111'
    static onBackground: string = '#FF111111'
    static onSurface: string = '#FF111111'
  }
  static Spacing = class {
    static sm: Length = 8
    static md: Length = 12
    static lg: Length = 16
    static xl: Length = 24
    static xxl: Length = 32
  }
  static Shapes = class {
    static small: Length = 6
    static medium: Length = 10
    static large: Length = 14
  }
}

class Marker {
  x: number = 0
  y: number = 0
  label: string = ''

  constructor(x: number, y: number, label: string) {
    this.x = x
    this.y = y
    this.label = label
  }
}

@Entry
@Component
struct RootScreen {
  @State markers: Marker[] = [
    new Marker(120, 200, 'Store A'),
    new Marker(360, 400, 'Store B')
  ]

  private addMarker(): void {
    const x = 100 + Math.floor(Math.random() * 400)
    const y = 150 + Math.floor(Math.random() * 300)
    this.markers.push(new Marker(x, y, 'New'))
  }

  private clearMarkers(): void {
    this.markers = []
  }

  build() {
    Column() {
      Text('Product Detail')
        .fontSize(28)
        .fontWeight(FontWeight.Bold)
        .fontColor(AppTokens.Colors.primary)
        .width('100%')
        .margin({ bottom: AppTokens.Spacing.lg })

      // Product Card
      Column() {
        // Product image placeholder
        Column()
          .width('100%')
          .height(160)
          .backgroundColor(AppTokens.Colors.surfaceVariant)

        Text('Monochrome Bag')
          .fontSize(18)
          .fontWeight(FontWeight.Medium)
          .fontColor(AppTokens.Colors.onSurface)
          .width('100%')
          .margin({ top: AppTokens.Spacing.md })

        Text('A minimalist and timeless design piece.')
          .fontSize(14)
          .fontWeight(FontWeight.Normal)
          .fontColor(AppTokens.Colors.tertiary)
          .width('100%')
          .margin({ top: AppTokens.Spacing.sm })

        Text('$79.00')
          .fontSize(18)
          .fontWeight(FontWeight.Medium)
          .fontColor(AppTokens.Colors.primary)
          .width('100%')
          .margin({ top: AppTokens.Spacing.md })

        Button('Add to Cart')
          .width('100%')
          .height(48)
          .fontSize(18)
          .fontWeight(FontWeight.Medium)
          .backgroundColor(AppTokens.Colors.primary)
          .fontColor(AppTokens.Colors.onPrimary)
          .borderRadius(AppTokens.Shapes.medium)
          .margin({ top: AppTokens.Spacing.md })
          .onClick(() => {
            prompt.showToast({ message: 'Added to cart', duration: 1000 })
          })
      }
      .width('100%')
      .padding(AppTokens.Spacing.lg)
      .backgroundColor(AppTokens.Colors.surface)
      .borderRadius(AppTokens.Shapes.large)
      .shadow({
        radius: 8,
        color: 'rgba(0,0,0,0.12)',
        offsetY: 4
      })

      // Map / Canvas area
      Stack({ alignContent: Alignment.TopStart }) {
        Column()
          .width('100%')
          .height('100%')
          .backgroundColor(AppTokens.Colors.surfaceVariant)
          .margin(AppTokens.Spacing.lg)

        ForEach(this.markers, (item: Marker) => {
          Circle({ width: 28, height: 28 })
            .fill(AppTokens.Colors.primary)
            .position({ x: item.x - 14, y: item.y - 14 })
        }, (item: Marker, index: number) => index.toString())
      }
      .width('100%')
      .height(240)
      .backgroundColor(AppTokens.Colors.surface)
      .borderRadius(AppTokens.Shapes.large)
      .margin({ top: AppTokens.Spacing.lg })

      // Action buttons row
      Row() {
        Button('Add Marker')
          .layoutWeight(1)
          .height(44)
          .fontSize(12)
          .fontWeight(FontWeight.Medium)
          .backgroundColor(AppTokens.Colors.secondary)
          .fontColor(AppTokens.Colors.onSecondary)
          .borderRadius(AppTokens.Shapes.medium)
          .onClick(() => {
            this.addMarker()
          })

        Button('Clear')
          .layoutWeight(1)
          .height(44)
          .fontSize(12)
          .fontWeight(FontWeight.Medium)
          .backgroundColor(AppTokens.Colors.tertiary)
          .fontColor(AppTokens.Colors.onTertiary)
          .borderRadius(AppTokens.Shapes.medium)
          .margin({ left: AppTokens.Spacing.md })
          .onClick(() => {
            this.clearMarkers()
          })
      }
      .width('100%')
      .margin({ top: AppTokens.Spacing.lg })
    }
    .width('100%')
    .height('100%')
    .padding(AppTokens.Spacing.lg)
    .backgroundColor(AppTokens.Colors.background)
  }
}
