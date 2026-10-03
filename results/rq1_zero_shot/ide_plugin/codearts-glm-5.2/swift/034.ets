class AppTokens {
  static readonly Colors = {
    primary: '#FF00FF66',
    secondary: '#FFCCCCCC',
    tertiary: '#FF999999',
    background: '#FF000000',
    surface: '#FF0A0A0A',
    surfaceVariant: '#FF111111',
    outline: '#FF1F1F1F',
    success: '#FF16A34A',
    warning: '#FFF59E0B',
    error: '#FFFF4444',
    onPrimary: '#FF000000',
    onSecondary: '#FFFFFFFF',
    onTertiary: '#FFFFFFFF',
    onBackground: '#FFE0E0E0',
    onSurface: '#FFE0E0E0'
  }

  static readonly Spacing = {
    xs: 4,
    sm: 8,
    md: 12,
    lg: 16,
    xl: 24,
    xxl: 32
  }

  static readonly Shapes = {
    small: 6,
    medium: 10,
    large: 14
  }
}

class MapMarker {
  name: string
  distance: string

  constructor(name: string, distance: string) {
    this.name = name
    this.distance = distance
  }
}

@Component
struct MarkerCard {
  @Prop name: string
  @Prop distance: string

  build() {
    Row() {
      Column() {
        Text(this.name)
          .fontSize(16)
          .fontWeight(FontWeight.Medium)
          .fontColor(AppTokens.Colors.onSurface)
        Text(this.distance)
          .fontSize(13)
          .fontColor(AppTokens.Colors.secondary)
          .margin({ top: 2 })
      }
      .alignItems(HorizontalAlign.Start)
      .layoutWeight(1)

      Text('View')
        .fontSize(11)
        .fontWeight(FontWeight.Medium)
        .fontColor(AppTokens.Colors.onPrimary)
        .padding({ left: 12, right: 12, top: 4, bottom: 4 })
        .borderRadius(6)
        .backgroundColor(AppTokens.Colors.primary)
    }
    .width('100%')
    .padding(12)
    .borderRadius(10)
    .backgroundColor(AppTokens.Colors.surface)
    .shadow({ radius: 4, color: '#1F000000', offsetX: 0, offsetY: 2 })
  }
}

@Entry
@Component
struct ExploreMap {
  @State query: string = ''

  private markers: MapMarker[] = [
    new MapMarker('Central Plaza', '1.2 km'),
    new MapMarker('Museum District', '3.4 km'),
    new MapMarker('Tech Park', '5.6 km'),
    new MapMarker('Old Town Gate', '7.8 km')
  ]

  build() {
    Column() {
      Text('Explore Map')
        .fontSize(28)
        .fontWeight(FontWeight.Bold)
        .fontColor(AppTokens.Colors.primary)
        .width('100%')
        .padding({ top: 16, bottom: 16 })
        .textAlign(TextAlign.Center)
        .backgroundColor(AppTokens.Colors.background)

      Column() {
        TextInput({ text: this.query, placeholder: 'Search destination' })
          .fontSize(13)
          .fontColor(AppTokens.Colors.onSurface)
          .padding(12)
          .borderRadius(10)
          .backgroundColor(AppTokens.Colors.surfaceVariant)
          .border({ width: 1, color: AppTokens.Colors.outline })
          .placeholderColor(AppTokens.Colors.secondary)
          .onChange((value: string) => {
            this.query = value
          })

        Column() {
          ForEach(this.markers, (marker: MapMarker) => {
            MarkerCard({ name: marker.name, distance: marker.distance })
              .margin({ top: 12 })
          })
        }
        .width('100%')

        Blank()

        Button('Refresh Map') {
        }
        .fontSize(16)
        .fontWeight(FontWeight.Medium)
        .fontColor(AppTokens.Colors.onPrimary)
        .width('100%')
        .height(48)
        .borderRadius(14)
        .backgroundColor(AppTokens.Colors.primary)
      }
      .padding(16)
      .layoutWeight(1)
    }
    .width('100%')
    .height('100%')
    .backgroundColor(AppTokens.Colors.background)
  }
}