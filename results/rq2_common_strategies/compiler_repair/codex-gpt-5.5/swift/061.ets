class AppColors {
  static primary: string = '#111827'
  static secondary: string = '#374151'
  static tertiary: string = '#6B7280'
  static background: string = '#F9FAFB'
  static surface: string = '#FFFFFF'
  static surfaceVariant: string = '#E5E7EB'
  static outline: string = '#D1D5DB'
  static onPrimary: string = '#FFFFFF'
  static onSecondary: string = '#FFFFFF'
  static onBackground: string = '#111827'
  static onSurface: string = '#1F2937'
}

class AppSpacing {
  static sm: number = 6
  static md: number = 10
  static lg: number = 14
  static xl: number = 22
}

class AppShape {
  static small: number = 6
  static medium: number = 10
  static large: number = 16
}

class ParcelPoint {
  left: number
  top: number

  constructor(left: number, top: number) {
    this.left = left
    this.top = top
  }
}

@Entry
@Component
struct Index {
  private points: ParcelPoint[] = [
    new ParcelPoint(10, 20), new ParcelPoint(22, 54), new ParcelPoint(36, 18), new ParcelPoint(48, 72),
    new ParcelPoint(61, 34), new ParcelPoint(76, 62), new ParcelPoint(88, 26), new ParcelPoint(16, 82),
    new ParcelPoint(31, 39), new ParcelPoint(45, 51), new ParcelPoint(55, 15), new ParcelPoint(70, 46),
    new ParcelPoint(83, 78), new ParcelPoint(24, 12), new ParcelPoint(40, 88), new ParcelPoint(64, 81)
  ]

  @Builder
  ParcelCanvas() {
    Stack() {
      ForEach(this.points, (point: ParcelPoint) => {
        Circle()
          .width(8)
          .height(8)
          .fill(AppColors.secondary)
          .position({ x: point.left.toString() + '%', y: point.top.toString() + '%' })
      })

      Circle()
        .width(40)
        .height(40)
        .fill('#00FFFFFF')
        .stroke(AppColors.primary)
        .strokeWidth(3)
        .position({ x: '58%', y: '45%' })

      Text('Drag to locate parcel')
        .fontSize(12)
        .fontColor(AppColors.onSurface)
        .textAlign(TextAlign.Center)
    }
    .width('100%')
    .height(300)
    .padding(AppSpacing.md)
    .backgroundColor(AppColors.surface)
    .border({ width: 1, color: AppColors.outline, radius: AppShape.large })
  }

  build() {
    Column({ space: AppSpacing.xl }) {
      Text('Parcel Tracker')
        .fontSize(26)
        .fontWeight(FontWeight.Bold)
        .fontColor(AppColors.onBackground)

      this.ParcelCanvas()

      Text('Visualize parcel movements and positions.')
        .fontSize(12)
        .fontColor(AppColors.onSurface)
        .textAlign(TextAlign.Center)
    }
    .width('100%')
    .height('100%')
    .padding(AppSpacing.lg)
    .alignItems(HorizontalAlign.Center)
    .linearGradient({
      angle: 180,
      colors: [[AppColors.surfaceVariant, 0.0], [AppColors.background, 1.0]]
    })
  }
}
