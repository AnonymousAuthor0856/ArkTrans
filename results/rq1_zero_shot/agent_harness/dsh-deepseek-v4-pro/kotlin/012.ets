const Colors = {
  primary: '#60A5FA',
  secondary: '#93C5FD',
  tertiary: '#A5B4FC',
  background: '#F9FAFB',
  surface: '#FFFFFF',
  surfaceVariant: '#EFF6FF',
  outline: '#D1D5DB',
  success: '#16A34A',
  warning: '#F59E0B',
  error: '#DC2626',
  onPrimary: '#FFFFFF',
  onSecondary: '#1E293B',
  onTertiary: '#1E1E2F',
  onBackground: '#111827',
  onSurface: '#111827'
}

const Spacing = {
  xs: 4,
  sm: 8,
  md: 12,
  lg: 16,
  xl: 24,
  xxl: 32
}

@Entry
@Component
struct Index {
  @State markerX: number = 200
  @State markerY: number = 400

  build() {
    Column() {
      Row() {
        Text('Favorite Spots Map')
          .fontSize(28)
          .fontWeight(FontWeight.Bold)
          .fontColor(Colors.onSurface)
          .layoutWeight(1)
          .textAlign(TextAlign.Center)
      }
      .width('100%')
      .height(56)
      .padding({ left: Spacing.lg, right: Spacing.lg })
      .backgroundColor(Colors.background)

      Stack() {
        Stack({ alignContent: Alignment.Center }) {
          Circle().width(440).height(440).fill(Colors.secondary).opacity(0.3)
          Circle().width(680).height(680).fill(Colors.secondary).opacity(0.2)
          Circle().width(28).height(28).fill(Colors.primary)
          Circle().width(60).height(60).stroke(Colors.primary).strokeWidth(3).opacity(0.3)
        }
        .width('100%')
        .height(400)
        .borderRadius(24)
        .border({ width: 1, color: Colors.outline })
        .radialGradient({
          center: ['50%', '50%'],
          radius: '100%',
          colors: [[Colors.surface, 0.0], [Colors.surfaceVariant, 1.0]]
        })

        Column({ space: Spacing.md }) {
          Text('Spot Coordinates: (' + this.markerX + ', ' + this.markerY + ')')
            .fontSize(14)
            .fontColor(Colors.onSurface)

          Button('Save Marker', { type: ButtonType.Normal })
            .backgroundColor(Colors.primary)
            .fontColor(Colors.onPrimary)
            .fontSize(18)
            .width('100%')
            .height(48)
            .borderRadius(16)
            .onClick(() => {})
        }
        .width('100%')
        .alignItems(HorizontalAlign.Center)
        .align(Alignment.Bottom)
      }
      .layoutWeight(1)
      .width('100%')
      .padding(Spacing.lg)
      .linearGradient({
        angle: 180,
        colors: [['#FFFFFF', 0.0], [Colors.surfaceVariant, 0.5], ['#FFFFFF', 1.0]]
      })
    }
    .width('100%')
    .height('100%')
    .backgroundColor(Colors.background)
  }
}
