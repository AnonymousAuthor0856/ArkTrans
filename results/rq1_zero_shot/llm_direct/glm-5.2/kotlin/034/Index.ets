// AppTokens.ets
export class AppTokens {
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
  };
  static readonly TypographyTokens = {
    display: { fontSize: 28, fontWeight: FontWeight.Bold },
    headline: { fontSize: 20, fontWeight: FontWeight.Medium },
    title: { fontSize: 16, fontWeight: FontWeight.Medium },
    body: { fontSize: 13, fontWeight: FontWeight.Normal },
    label: { fontSize: 11, fontWeight: FontWeight.Medium }
  };
  static readonly Shapes = {
    small: 6,
    medium: 10,
    large: 14
  };
  static readonly Spacing = {
    xs: 4,
    sm: 8,
    md: 12,
    lg: 16,
    xl: 24,
    xxl: 32
  };
  static readonly ElevationMapping = {
    level1: { elevation: 0, radius: 0, dy: 0, opacity: 0 },
    level2: { elevation: 2, radius: 4, dy: 2, opacity: 0.12 }
  };
}

// MapMarker.ets
export class MapMarker {
  name: string;
  distance: string;
  constructor(name: string, distance: string) {
    this.name = name;
    this.distance = distance;
  }
}

// RootScreen.ets
import { AppTokens } from './AppTokens';
import { MapMarker } from './MapMarker';

@Entry
@Component
struct RootScreen {
  @State query: string = '';
  private markers: Array<MapMarker> = [
    new MapMarker("Central Plaza", "1.2 km"),
    new MapMarker("Museum District", "3.4 km"),
    new MapMarker("Tech Park", "5.6 km"),
    new MapMarker("Old Town Gate", "7.8 km")
  ];

  build() {
    Column() {
      // Top App Bar
      Text('Explore Map')
        .fontSize(AppTokens.TypographyTokens.display.fontSize)
        .fontColor(AppTokens.Colors.primary)
        .fontWeight(AppTokens.TypographyTokens.display.fontWeight)
        .width('100%')
        .textAlign(TextAlign.Center)
        .padding(16)

      // Content
      Column() {
        // Search Field
        TextInput({ text: this.query, placeholder: 'Search destination' })
          .onChange((value: string) => {
            this.query = value;
          })
          .fontColor(AppTokens.Colors.onSurface)
          .placeholderColor(AppTokens.Colors.secondary)
          .backgroundColor(AppTokens.Colors.surface)
          .borderRadius(AppTokens.Shapes.medium)
          .height(50)
          .padding(12)
          .margin({ bottom: AppTokens.Spacing.lg })

        // Markers List
        ForEach(this.markers, (marker: MapMarker) => {
          Row() {
            Column() {
              Text(marker.name)
                .fontSize(AppTokens.TypographyTokens.title.fontSize)
                .fontColor(AppTokens.Colors.onSurface)
                .fontWeight(AppTokens.TypographyTokens.title.fontWeight)
              Text(marker.distance)
                .fontSize(AppTokens.TypographyTokens.body.fontSize)
                .fontColor(AppTokens.Colors.secondary)
                .fontWeight(AppTokens.TypographyTokens.body.fontWeight)
                .margin({ top: 4 })
            }
            .alignItems(HorizontalAlign.Start)

            Button('View') {
              // onClick logic
            }
            .fontSize(AppTokens.TypographyTokens.label.fontSize)
            .fontColor(AppTokens.Colors.onPrimary)
            .backgroundColor(AppTokens.Colors.primary)
            .borderRadius(AppTokens.Shapes.small)
            .height(36)
          }
          .width('100%')
          .padding(AppTokens.Spacing.md)
          .backgroundColor(AppTokens.Colors.surface)
          .borderRadius(AppTokens.Shapes.medium)
          .margin({ bottom: AppTokens.Spacing.md })
          .justifyContent(FlexAlign.SpaceBetween)
          .alignItems(VerticalAlign.Center)
        })

        // Spacer
        Blank().height(AppTokens.Spacing.xxl)

        // Refresh Map Button
        Button('Refresh Map') {
          // onClick logic
        }
        .width('100%')
        .height(48)
        .fontSize(AppTokens.TypographyTokens.title.fontSize)
        .fontColor(AppTokens.Colors.onPrimary)
        .backgroundColor(AppTokens.Colors.primary)
        .borderRadius(AppTokens.Shapes.large)
      }
      .width('100%')
      .layoutWeight(1)
      .padding(AppTokens.Spacing.lg)
    }
    .width('100%')
    .height('100%')
    .backgroundColor(AppTokens.Colors.background)
  }
}