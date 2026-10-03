const NAME = '010*ExploreMap*en'
const UI_TYPE = 'Social'
const STYLE_THEME = 'Monochrome Terminal'
const LANG = 'en'
const BASELINE_SIZE = '720x1280'

class AppTokens {
  static Colors = {
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
    onSurface: '#E0E0E0',
  }

  static TypographyTokens = {
    display: { fontSize: 28, fontWeight: FontWeight.Bold },
    headline: { fontSize: 20, fontWeight: FontWeight.Medium },
    title: { fontSize: 16, fontWeight: FontWeight.Medium },
    body: { fontSize: 13, fontWeight: FontWeight.Normal },
    label: { fontSize: 11, fontWeight: FontWeight.Medium },
  }

  static Shapes = {
    small: 6,
    medium: 10,
    large: 14,
  }

  static Spacing = {
    xs: 4,
    sm: 8,
    md: 12,
    lg: 16,
    xl: 24,
    xxl: 32,
  }

  static ElevationMapping = {
    level1: { elevation: 0, radius: 0, dy: 0, opacity: 0 },
    level2: { elevation: 2, radius: 4, dy: 2, opacity: 0.12 },
  }
}

interface MapMarker {
  name: string
  distance: string
}

@Entry
@Component
struct RootScreen {
  @State query: string = ''

  private markers: MapMarker[] = [
    { name: 'Central Plaza', distance: '1.2 km' },
    { name: 'Museum District', distance: '3.4 km' },
    { name: 'Tech Park', distance: '5.6 km' },
    { name: 'Old Town Gate', distance: '7.8 km' },
  ]

  build() {
    Column() {
      Row() {
        Text('Explore Map')
          .fontSize(AppTokens.TypographyTokens.display.fontSize)
          .fontWeight(AppTokens.TypographyTokens.display.fontWeight)
          .fontColor(AppTokens.Colors.primary)
      }
      .width('100%')
      .height(56)
      .justifyContent(FlexAlign.Center)
      .backgroundColor(AppTokens.Colors.background)

      Column() {
        TextInput({ text: this.query, placeholder: 'Search destination' })
          .width('100%')
          .height(48)
          .borderRadius(AppTokens.Shapes.medium)
          .border({ width: 1, color: AppTokens.Colors.outline })
          .backgroundColor(AppTokens.Colors.surface)
          .fontColor(AppTokens.Colors.onSurface)
          .fontSize(AppTokens.TypographyTokens.body.fontSize)
          .placeholderColor(AppTokens.Colors.secondary)
          .onChange((value: string) => {
            this.query = value
          })

        List() {
          ForEach(this.markers, (marker: MapMarker, index: number) => {
            ListItem() {
              MapMarkerCard({ marker: marker })
            }
          }, (marker: MapMarker, index: number) => index.toString())
        }
        .width('100%')
        .layoutWeight(1)
        .margin({ top: AppTokens.Spacing.lg })

        Button('Refresh Map')
          .type(ButtonType.Normal)
          .width('100%')
          .height(48)
          .borderRadius(AppTokens.Shapes.large)
          .backgroundColor(AppTokens.Colors.primary)
          .fontColor(AppTokens.Colors.onPrimary)
          .fontSize(AppTokens.TypographyTokens.title.fontSize)
          .fontWeight(AppTokens.TypographyTokens.title.fontWeight)
      }
      .layoutWeight(1)
      .width('100%')
      .padding(AppTokens.Spacing.lg)
      .backgroundColor(AppTokens.Colors.background)
    }
    .width('100%')
    .height('100%')
    .backgroundColor(AppTokens.Colors.background)
  }
}

@Component
struct MapMarkerCard {
  private marker: MapMarker = { name: '', distance: '' }

  build() {
    Row() {
      Column() {
        Text(this.marker.name)
          .fontSize(AppTokens.TypographyTokens.title.fontSize)
          .fontWeight(AppTokens.TypographyTokens.title.fontWeight)
          .fontColor(AppTokens.Colors.onSurface)

        Text(this.marker.distance)
          .fontSize(AppTokens.TypographyTokens.body.fontSize)
          .fontWeight(AppTokens.TypographyTokens.body.fontWeight)
          .fontColor(AppTokens.Colors.secondary)
      }
      .alignItems(HorizontalAlign.Start)
      .layoutWeight(1)

      Button('View')
        .type(ButtonType.Normal)
        .height(32)
        .borderRadius(AppTokens.Shapes.small)
        .backgroundColor(AppTokens.Colors.primary)
        .fontColor(AppTokens.Colors.onPrimary)
        .fontSize(AppTokens.TypographyTokens.label.fontSize)
        .fontWeight(AppTokens.TypographyTokens.label.fontWeight)
    }
    .width('100%')
    .padding(AppTokens.Spacing.md)
    .backgroundColor(AppTokens.Colors.surface)
    .borderRadius(AppTokens.Shapes.medium)
    .alignItems(VerticalAlign.Center)
    .shadow({ radius: AppTokens.ElevationMapping.level2.radius, color: `rgba(0,0,0,${AppTokens.ElevationMapping.level2.opacity})`, offsetY: AppTokens.ElevationMapping.level2.dy })
  }
}