const Colors = {
  primary: '#1E293B',
  secondary: '#0EA5E9',
  tertiary: '#FACC15',
  background: '#111827',
  surface: '#1E293B',
  surfaceVariant: '#334155',
  outline: '#475569',
  success: '#22C55E',
  warning: '#F59E0B',
  error: '#EF4444',
  onPrimary: '#FFFFFF',
  onSecondary: '#FFFFFF',
  onTertiary: '#0B1220',
  onBackground: '#E2E8F0',
  onSurface: '#E2E8F0'
}

interface CodeMarker {
  id: number
  name: string
  desc: string
}

@Entry
@Component
struct Index {
  private markers: CodeMarker[] = [
    { id: 1, name: 'Main.kt', desc: 'Entry point for Compose app' },
    { id: 2, name: 'Utils.kt', desc: 'Helper functions' },
    { id: 3, name: 'Theme.kt', desc: 'Color & Typography setup' },
    { id: 4, name: 'Data.kt', desc: 'Repository and model classes' }
  ]

  build() {
    Column() {
      Row() {
        Text('CodeIDE Terminal')
          .fontSize(26)
          .fontWeight(FontWeight.Bold)
          .fontColor(Colors.onBackground)
      }
      .width('100%')
      .justifyContent(FlexAlign.Center)
      .padding(16)

      Scroll() {
        Column({ space: 16 }) {
          Text('Project Files')
            .fontSize(20)
            .fontWeight(FontWeight.Bold)
            .fontColor(Colors.onBackground)

          ForEach(this.markers, (m: CodeMarker) => {
            Row({ space: 12 }) {
              Stack({ alignContent: Alignment.Center }) {
                Text(m.id.toString())
                  .fontSize(12)
                  .fontWeight(FontWeight.Medium)
                  .fontColor(Colors.onSecondary)
              }
              .width(32)
              .height(32)
              .backgroundColor(Colors.secondary)
              .borderRadius(4)

              Column() {
                Text(m.name)
                  .fontSize(16)
                  .fontWeight(FontWeight.Medium)
                  .fontColor(Colors.onSurface)
                Text(m.desc)
                  .fontSize(14)
                  .fontColor(Colors.onSurface)
              }
              .alignItems(HorizontalAlign.Start)
            }
            .width('100%')
            .padding(12)
            .alignItems(VerticalAlign.Center)
            .backgroundColor(Colors.surfaceVariant)
            .borderRadius(8)
          }, (m: CodeMarker) => m.id.toString())

          Text('Live Terminal')
            .fontSize(20)
            .fontWeight(FontWeight.Bold)
            .fontColor(Colors.onBackground)

          Stack({ alignContent: Alignment.TopStart }) {
            Text('> println("Hello, Kotlin!")')
              .fontSize(14)
              .fontColor(Colors.onSurface)
          }
          .width('100%')
          .height(240)
          .padding(12)
          .backgroundColor(Colors.surfaceVariant)
          .borderRadius(8)
          .border({ width: 1, color: Colors.outline })

          Button('Run Code', { type: ButtonType.Normal })
            .fontSize(16)
            .fontWeight(FontWeight.Medium)
            .backgroundColor(Colors.secondary)
            .fontColor(Colors.onSecondary)
            .borderRadius(12)
            .width('60%')
            .height(48)
        }
        .width('100%')
        .padding(16)
      }
      .layoutWeight(1)
      .linearGradient({
        direction: GradientDirection.Bottom,
        colors: [['#CC1E293B', 0.0], ['#E61E293B', 1.0]]
      })
    }
    .width('100%')
    .height('100%')
    .backgroundColor(Colors.background)
  }
}
