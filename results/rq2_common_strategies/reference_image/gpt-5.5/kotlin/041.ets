class AppColors {
  static readonly primary: string = '#111111'
  static readonly secondary: string = '#333333'
  static readonly tertiary: string = '#777777'
  static readonly background: string = '#FFFFFF'
  static readonly surface: string = '#F9F9F9'
  static readonly surfaceVariant: string = '#E5E5E5'
  static readonly outline: string = '#CCCCCC'
  static readonly success: string = '#16A34A'
  static readonly warning: string = '#F59E0B'
  static readonly error: string = '#DC2626'
  static readonly onPrimary: string = '#FFFFFF'
  static readonly onSecondary: string = '#FFFFFF'
  static readonly onTertiary: string = '#111111'
  static readonly onBackground: string = '#111111'
  static readonly onSurface: string = '#111111'
}

class AppSpacing {
  static readonly sm: number = 8
  static readonly md: number = 12
  static readonly lg: number = 16
  static readonly xl: number = 24
  static readonly xxl: number = 32
}

class Marker {
  x: number
  y: number
  label: string

  constructor(x: number, y: number, label: string) {
    this.x = x
    this.y = y
    this.label = label
  }
}

@Entry
@Component
struct ProductDetailPage {
  @State private markers: Marker[] = [
    new Marker(120, 200, 'Store A'),
    new Marker(360, 400, 'Store B')
  ]

  private randomInt(min: number, max: number): number {
    return Math.floor(Math.random() * (max - min)) + min
  }

  build() {
    Column({ space: AppSpacing.lg }) {
      Text('Product Detail')
        .fontSize(28)
        .fontWeight(FontWeight.Bold)
        .fontColor(AppColors.primary)
        .width('100%')

      Column({ space: AppSpacing.md }) {
        Blank()
          .width('100%')
          .height(320)
          .backgroundColor(AppColors.surfaceVariant)

        Text('Monochrome Bag')
          .fontSize(18)
          .fontWeight(FontWeight.Medium)
          .fontColor(AppColors.onSurface)
          .width('100%')

        Text('A minimalist and timeless design piece.')
          .fontSize(14)
          .fontWeight(FontWeight.Regular)
          .fontColor(AppColors.tertiary)
          .width('100%')

        Text('$79.00')
          .fontSize(18)
          .fontWeight(FontWeight.Medium)
          .fontColor(AppColors.primary)
          .width('100%')

        Button('Add to Cart')
          .width('100%')
          .height(48)
          .fontSize(18)
          .fontWeight(FontWeight.Medium)
          .fontColor(AppColors.onPrimary)
          .backgroundColor(AppColors.primary)
          .borderRadius(10)
      }
      .width('100%')
      .padding(AppSpacing.lg)
      .backgroundColor(AppColors.surface)
      .borderRadius(14)
      .shadow({
        radius: 8,
        color: '#1F000000',
        offsetX: 0,
        offsetY: 4
      })

      Stack({ alignContent: Alignment.TopStart }) {
        Blank()
          .width('100%')
          .height('100%')
          .backgroundColor(AppColors.surfaceVariant)
          .margin(AppSpacing.lg)

        ForEach(this.markers, (marker: Marker, index: number) => {
          Circle({ width: 28, height: 28 })
            .fill(AppColors.primary)
            .position({
              x: marker.x,
              y: marker.y
            })
        }, (marker: Marker, index: number) => `${marker.label}-${index}-${marker.x}-${marker.y}`)
      }
      .width('100%')
      .height(240)
      .backgroundColor(AppColors.surface)
      .borderRadius(14)
      .clip(true)

      Row({ space: AppSpacing.md }) {
        Button('Add Marker')
          .layoutWeight(1)
          .height(44)
          .fontSize(12)
          .fontWeight(FontWeight.Medium)
          .fontColor(AppColors.onSecondary)
          .backgroundColor(AppColors.secondary)
          .borderRadius(10)
          .onClick(() => {
            this.markers = [
              ...this.markers,
              new Marker(
                this.randomInt(100, 500),
                this.randomInt(150, 450),
                'New'
              )
            ]
          })

        Button('Clear')
          .layoutWeight(1)
          .height(44)
          .fontSize(12)
          .fontWeight(FontWeight.Medium)
          .fontColor(AppColors.onTertiary)
          .backgroundColor(AppColors.tertiary)
          .borderRadius(10)
          .onClick(() => {
            this.markers = []
          })
      }
      .width('100%')
      .alignItems(VerticalAlign.Center)
      .justifyContent(FlexAlign.SpaceBetween)
    }
    .width('100%')
    .height('100%')
    .padding(AppSpacing.lg)
    .backgroundColor(AppColors.background)
  }
}