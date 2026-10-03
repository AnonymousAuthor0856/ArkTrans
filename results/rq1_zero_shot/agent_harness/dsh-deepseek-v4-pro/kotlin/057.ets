const Colors = {
  primary: '#2563EB',
  secondary: '#38BDF8',
  tertiary: '#60A5FA',
  background: '#F8FAFC',
  surface: '#FFFFFF',
  surfaceVariant: '#E2E8F0',
  outline: '#CBD5E1',
  success: '#22C55E',
  warning: '#F59E0B',
  error: '#EF4444',
  onPrimary: '#FFFFFF',
  onSecondary: '#0F172A',
  onTertiary: '#FFFFFF',
  onBackground: '#0F172A',
  onSurface: '#1E293B'
}

@Entry
@Component
struct Index {
  build() {
    Column() {
      Row() {
        Stack({ alignContent: Alignment.Center }) {
          Text('<')
            .fontSize(12)
            .fontWeight(FontWeight.Medium)
            .fontColor(Colors.onPrimary)
        }
        .width(24)
        .height(24)
        .backgroundColor(Colors.primary)
        .borderRadius(12)

        Text('Sleep Cycle')
          .fontSize(28)
          .fontWeight(FontWeight.Bold)
          .fontColor(Colors.onBackground)

        Stack({ alignContent: Alignment.Center }) {
          Text('?')
            .fontSize(12)
            .fontWeight(FontWeight.Medium)
            .fontColor(Colors.onSecondary)
        }
        .width(24)
        .height(24)
        .backgroundColor(Colors.secondary)
        .borderRadius(12)
      }
      .width('100%')
      .padding({ left: 16, right: 16 })
      .justifyContent(FlexAlign.SpaceBetween)
      .alignItems(VerticalAlign.Center)

      Column({ space: 24 }) {
        Stack({ alignContent: Alignment.Center }) {
          Text('😴').fontSize(48)
        }
        .width(160)
        .height(160)
        .backgroundColor(Colors.surface)
        .borderRadius(80)
        .border({ width: 2, color: Colors.outline })

        Text('Welcome Back')
          .fontSize(20)
          .fontWeight(FontWeight.Bold)
          .fontColor(Colors.onSurface)
        Text('Track your sleep patterns and improve rest quality.')
          .fontSize(14)
          .fontColor(Colors.onSurface)

        Button('Sign In', { type: ButtonType.Normal })
          .fontSize(16)
          .fontWeight(FontWeight.Medium)
          .backgroundColor(Colors.primary)
          .fontColor(Colors.onPrimary)
          .borderRadius(16)
          .width('80%')
          .height(52)
      }
      .width('100%')
      .layoutWeight(1)
      .alignItems(HorizontalAlign.Center)
      .padding(16)
      .linearGradient({
        direction: GradientDirection.Bottom,
        colors: [['#2638BDF8', 0.0], ['#1A2563EB', 1.0]]
      })
    }
    .width('100%')
    .height('100%')
    .backgroundColor(Colors.background)
  }
}
