const Colors = {
  primary: '#2563EB',
  secondary: '#38BDF8',
  tertiary: '#3B82F6',
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
    Stack({ alignContent: Alignment.BottomEnd }) {
      Column() {
        Row() {
          Text('Workout Plan')
            .fontSize(28)
            .fontWeight(FontWeight.Bold)
            .fontColor(Colors.onBackground)
        }
        .width('100%')
        .justifyContent(FlexAlign.Center)
        .padding(16)

        Column({ space: 16 }) {
          Text('Sign In to Continue')
            .fontSize(20)
            .fontWeight(FontWeight.Bold)
            .fontColor(Colors.onSurface)

          Stack({ alignContent: Alignment.Center }) {
            Text('Workout Preview')
              .fontSize(14)
              .fontColor(Colors.onSurface)
          }
          .width('100%')
          .height(200)
          .backgroundColor(Colors.surface)
          .borderRadius(16)
          .border({ width: 1, color: Colors.outline })

          Button('Authenticate', { type: ButtonType.Normal })
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
        .padding(16)
        .alignItems(HorizontalAlign.Center)
        .linearGradient({
          direction: GradientDirection.Bottom,
          colors: [['#1A38BDF8', 0.0], ['#262563EB', 1.0]]
        })

        Row() {
          Text('Home').fontSize(16).fontWeight(FontWeight.Medium).fontColor(Colors.primary)
          Text('Plan').fontSize(16).fontWeight(FontWeight.Medium).fontColor(Colors.onSurface)
          Text('Profile').fontSize(16).fontWeight(FontWeight.Medium).fontColor(Colors.onSurface)
        }
        .width('100%')
        .padding({ left: 16, right: 16, top: 12, bottom: 12 })
        .justifyContent(FlexAlign.SpaceBetween)
        .alignItems(VerticalAlign.Center)
        .backgroundColor(Colors.surface)
        .shadow({ radius: 8, color: '#00000024', offsetX: 0, offsetY: 4 })
      }
      .width('100%')
      .height('100%')

      Button('+', { type: ButtonType.Normal })
        .width(56)
        .height(56)
        .borderRadius(28)
        .fontSize(28)
        .fontWeight(FontWeight.Bold)
        .backgroundColor(Colors.primary)
        .fontColor(Colors.onPrimary)
        .margin({ right: 16, bottom: 72 })
    }
    .width('100%')
    .height('100%')
    .backgroundColor(Colors.background)
  }
}
