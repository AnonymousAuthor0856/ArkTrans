import prompt from '@ohos.prompt'

class AppColors {
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

class AppSpacing {
  static sm: number = 8
  static md: number = 12
  static lg: number = 16
  static xl: number = 24
  static xxl: number = 32
}

class AppShapes {
  static small: number = 6
  static medium: number = 10
  static large: number = 14
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

  addMarker(): void {
    const x: number = 100 + Math.floor(Math.random() * 400)
    const y: number = 150 + Math.floor(Math.random() * 300)
    this.markers.push(new Marker(x, y, 'New'))
  }

  clearMarkers(): void {
    this.markers = []
  }

  build() {
    Column() {
      Text('Product Detail')
        .fontSize(28)
        .fontWeight(FontWeight.Bold)
        .fontColor(AppColors.primary)
        .width('100%')
        .margin({ bottom: AppSpacing.lg })

      Column() {
        Column()
          .width('100%')
          .height(160)
          .backgroundColor(AppColors.surfaceVariant)

        Text('Monochrome Bag')
          .fontSize(18)
          .fontWeight(FontWeight.Medium)
          .fontColor(AppColors.onSurface)
          .width('100%')
          .margin({ top: AppSpacing.md })

        Text('A minimalist and timeless design piece.')
          .fontSize(14)
          .fontWeight(FontWeight.Normal)
          .fontColor(AppColors.tertiary)
          .width('100%')
          .margin({ top: AppSpacing.sm })

        Text('$79.00')
          .fontSize(18)
          .fontWeight(FontWeight.Medium)
          .fontColor(AppColors.primary)
          .width('100%')
          .margin({ top: AppSpacing.md })

        Button('Add to Cart')
          .width('100%')
          .height(48)
          .fontSize(18)
          .fontWeight(FontWeight.Medium)
          .backgroundColor(AppColors.primary)
          .fontColor(AppColors.onPrimary)
          .borderRadius(AppShapes.medium)
          .margin({ top: AppSpacing.md })
          .onClick(() => {
            prompt.showToast({ message: 'Added to cart', duration: 1000 })
          })
      }
      .width('100%')
      .padding(AppSpacing.lg)
      .backgroundColor(AppColors.surface)
      .borderRadius(AppShapes.large)
      .shadow({
        radius: 8,
        color: 'rgba(0,0,0,0.12)',
        offsetY: 4
      })

      Stack({ alignContent: Alignment.TopStart }) {
        Column()
          .width('100%')
          .height('100%')
          .backgroundColor(AppColors.surfaceVariant)
          .margin(AppSpacing.lg)

        ForEach(this.markers, (item: Marker) => {
          Circle({ width: 28, height: 28 })
            .fill(AppColors.primary)
            .position({ x: item.x - 14, y: item.y - 14 })
        }, (item: Marker, index: number) => index.toString())
      }
      .width('100%')
      .height(240)
      .backgroundColor(AppColors.surface)
      .borderRadius(AppShapes.large)
      .margin({ top: AppSpacing.lg })

      Row() {
        Button('Add Marker')
          .layoutWeight(1)
          .height(44)
          .fontSize(12)
          .fontWeight(FontWeight.Medium)
          .backgroundColor(AppColors.secondary)
          .fontColor(AppColors.onSecondary)
          .borderRadius(AppShapes.medium)
          .onClick(() => {
            this.addMarker()
          })

        Button('Clear')
          .layoutWeight(1)
          .height(44)
          .fontSize(12)
          .fontWeight(FontWeight.Medium)
          .backgroundColor(AppColors.tertiary)
          .fontColor(AppColors.onTertiary)
          .borderRadius(AppShapes.medium)
          .margin({ left: AppSpacing.md })
          .onClick(() => {
            this.clearMarkers()
          })
      }
      .width('100%')
      .margin({ top: AppSpacing.lg })
    }
    .width('100%')
    .height('100%')
    .padding(AppSpacing.lg)
    .backgroundColor(AppColors.background)
  }
}
