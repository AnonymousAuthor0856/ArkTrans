// File 034 - Explore Map (Social)
interface MapMarker {
  name: string
  distance: string
}

const Colors = {
  primary: '#00FF66',
  secondary: '#CCCCCC',
  tertiary: '#999999',
  background: '#000000',
  surface: '#0A0A0A',
  surfaceVariant: '#111111',
  outline: '#1F1F1F',
  success: '#16A34A',
  warning: '#F59E0B',
  error: '#FF4444',
  onPrimary: '#000000',
  onSecondary: '#FFFFFF',
  onTertiary: '#FFFFFF',
  onBackground: '#E0E0E0',
  onSurface: '#E0E0E0'
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
  @State query: string = ''
  private markers: MapMarker[] = [
    { name: 'Central Plaza', distance: '1.2 km' },
    { name: 'Museum District', distance: '3.4 km' },
    { name: 'Tech Park', distance: '5.6 km' },
    { name: 'Old Town Gate', distance: '7.8 km' }
  ]

  build() {
    Column() {
      Row() {
        Text('Explore Map')
          .fontSize(28)
          .fontWeight(FontWeight.Bold)
          .fontColor(Colors.primary)
      }
      .width('100%')
      .height(56)
      .justifyContent(FlexAlign.Center)

      Column({ space: Spacing.lg }) {
        TextInput({ placeholder: 'Search destination', text: this.query })
          .width('100%')
          .height(56)
          .backgroundColor(Colors.surface)
          .borderRadius(10)
          .border({ width: 1, color: Colors.outline })
          .fontColor(Colors.onSurface)
          .placeholderColor(Colors.onSurface)
          .onChange((value: string) => { this.query = value })

        Column({ space: Spacing.md }) {
          ForEach(this.markers, (m: MapMarker) => {
            Column() {
              Row() {
                Column() {
                  Text(m.name)
                    .fontSize(16)
                    .fontWeight(FontWeight.Medium)
                    .fontColor(Colors.onSurface)
                  Text(m.distance)
                    .fontSize(13)
                    .fontColor(Colors.secondary)
                }
                .alignItems(HorizontalAlign.Start)
                Blank().layoutWeight(1)
                Button('View', { type: ButtonType.Normal })
                  .height(32)
                  .backgroundColor(Colors.primary)
                  .fontColor(Colors.onPrimary)
                  .fontSize(11)
                  .borderRadius(6)
                  .padding({ left: 12, right: 12 })
                  .onClick(() => {})
              }
              .width('100%')
              .padding(Spacing.md)
              .justifyContent(FlexAlign.SpaceBetween)
              .alignItems(VerticalAlign.Center)
            }
            .width('100%')
            .backgroundColor(Colors.surface)
            .borderRadius(10)
          }, (m: MapMarker) => m.name)
        }
        .width('100%')

        Blank().height(Spacing.xxl)

        Button('Refresh Map', { type: ButtonType.Normal })
          .width('100%')
          .height(48)
          .backgroundColor(Colors.primary)
          .fontColor(Colors.onPrimary)
          .fontSize(16)
          .borderRadius(14)
          .onClick(() => {})
      }
      .width('100%')
      .layoutWeight(1)
      .padding(Spacing.lg)
      .backgroundColor(Colors.background)
    }
    .width('100%')
    .height('100%')
    .backgroundColor(Colors.background)
  }
}
