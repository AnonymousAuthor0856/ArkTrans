interface Marker {
  x: number
  y: number
  label: string
}

class AppColors {
  static readonly primary: string = '#111111'
  static readonly secondary: string = '#333333'
  static readonly tertiary: string = '#777777'
  static readonly background: string = '#FFFFFF'
  static readonly surface: string = '#F9F9F9'
  static readonly surfaceVariant: string = '#E5E5E5'
  static readonly onPrimary: string = '#FFFFFF'
  static readonly onSecondary: string = '#FFFFFF'
  static readonly onTertiary: string = '#111111'
}

@Entry
@Component
struct ProductDetailApp {
  @State private markers: Marker[] = [
    { x: 120, y: 200, label: 'Store A' },
    { x: 360, y: 400, label: 'Store B' }
  ]

  private addMarker(): void {
    const nextMarker: Marker = {
      x: 80 + Math.floor(Math.random() * 370),
      y: 70 + Math.floor(Math.random() * 145),
      label: 'New'
    }
    this.markers = [...this.markers, nextMarker]
  }

  build() {
    Scroll() {
      Column({ space: 16 }) {
        Text('Product Detail')
          .fontSize(38)
          .fontWeight(FontWeight.Bold)
          .fontColor(AppColors.primary)
          .width('100%')
          .textAlign(TextAlign.Start)
          .margin({ top: -28 })

        Column({ space: 12 }) {
          Row()
            .width('100%')
            .height(320)
            .backgroundColor(AppColors.surfaceVariant)

          Text('Monochrome Bag')
            .fontSize(36)
            .fontWeight(FontWeight.Medium)
            .fontColor(AppColors.primary)
            .width('100%')
            .margin({ top: 4 })

          Text('A minimalist and timeless design piece.')
            .fontSize(27)
            .fontColor(AppColors.tertiary)
            .width('100%')
            .margin({ top: 5 })

          Text('$79.00')
            .fontSize(36)
            .fontWeight(FontWeight.Medium)
            .fontColor(AppColors.primary)
            .width('100%')
            .margin({ top: 5 })

          Button('Add to Cart')
            .width('100%')
            .height(97)
            .fontSize(34)
            .fontColor(AppColors.onPrimary)
            .backgroundColor(AppColors.primary)
            .borderRadius(20)
            .margin({ top: 8 })
            .onClick(() => {
              console.info('Add to Cart tapped')
            })
        }
        .width('100%')
        .padding(32)
        .backgroundColor(AppColors.surface)
        .borderRadius(28)
        .shadow({
          radius: 18,
          color: '#1F000000',
          offsetX: 0,
          offsetY: 8
        })

        Stack() {
          Row()
            .width('100%')
            .height(448)
            .backgroundColor(AppColors.surfaceVariant)

          ForEach(this.markers, (marker: Marker) => {
            Circle()
              .width(28)
              .height(28)
              .fill(AppColors.primary)
              .position({ x: marker.x, y: marker.y })
          }, (marker: Marker) => `${marker.x}-${marker.y}-${marker.label}`)
        }
        .width('100%')
        .height(480)
        .padding(32)
        .backgroundColor(AppColors.surface)
        .borderRadius(28)

        Row({ space: 24 }) {
          Button('Add Marker')
            .layoutWeight(1)
            .height(88)
            .fontSize(22)
            .fontColor(AppColors.onSecondary)
            .backgroundColor(AppColors.secondary)
            .borderRadius(18)
            .onClick(() => {
              this.addMarker()
            })

          Button('Clear')
            .layoutWeight(1)
            .height(88)
            .fontSize(22)
            .fontColor(AppColors.onTertiary)
            .backgroundColor(AppColors.tertiary)
            .borderRadius(18)
            .onClick(() => {
              this.markers = []
            })
        }
        .width('100%')
      }
      .width('100%')
      .padding({ left: 32, right: 32, top: 32, bottom: 32 })
    }
    .width('100%')
    .height('100%')
    .backgroundColor(AppColors.background)
    .scrollBar(BarState.Off)
  }
}
