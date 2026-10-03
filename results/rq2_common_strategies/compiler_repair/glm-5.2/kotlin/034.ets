// Index.ets

interface MapMarker {
  name: string;
  distance: string;
}

interface TextStyleSpec {
  fontSize: number;
  fontWeight: number;
}

interface ShadowSpec {
  elevation: number;
  radius: number;
  dy: number;
  opacity: number;
}

class AppTokens {
  static Colors = {
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

  static TypographyTokens = {
    display: { fontSize: 28, fontWeight: FontWeight.Bold } as TextStyleSpec,
    headline: { fontSize: 20, fontWeight: FontWeight.Medium } as TextStyleSpec,
    title: { fontSize: 16, fontWeight: FontWeight.Medium } as TextStyleSpec,
    body: { fontSize: 13, fontWeight: FontWeight.Normal } as TextStyleSpec,
    label: { fontSize: 11, fontWeight: FontWeight.Medium } as TextStyleSpec
  };

  static Shapes = {
    small: 6,
    medium: 10,
    large: 14
  };

  static Spacing = {
    xs: 4,
    sm: 8,
    md: 12,
    lg: 16,
    xl: 24,
    xxl: 32
  };

  static ElevationMapping = {
    level1: { elevation: 0, radius: 0, dy: 0, opacity: 0 } as ShadowSpec,
    level2: { elevation: 2, radius: 4, dy: 2, opacity: 0.12 } as ShadowSpec
  };
}

@Entry
@Component
struct RootScreen {
  @State query: string = '';
  private markers: MapMarker[] = [
    { name: 'Central Plaza', distance: '1.2 km' },
    { name: 'Museum District', distance: '3.4 km' },
    { name: 'Tech Park', distance: '5.6 km' },
    { name: 'Old Town Gate', distance: '7.8 km' }
  ];

  build() {
    Column() {
      // Top App Bar
      Row() {
        Text('Explore Map')
          .fontSize(AppTokens.TypographyTokens.display.fontSize)
          .fontWeight(AppTokens.TypographyTokens.display.fontWeight)
          .fontColor(AppTokens.Colors.primary)
          .layoutWeight(1)
          .textAlign(TextAlign.Center)
      }
      .width('100%')
      .padding(16)
      .backgroundColor(AppTokens.Colors.background)

      // Content
      Scroll() {
        Column() {
          // Search Field
          TextInput({ text: this.query, placeholder: 'Search destination' })
            .onChange((value: string) => {
              this.query = value;
            })
            .height(48)
            .borderRadius(AppTokens.Shapes.medium)
            .backgroundColor(AppTokens.Colors.surfaceVariant)
            .borderWidth(1)
            .borderColor(AppTokens.Colors.outline)
            .fontColor(AppTokens.Colors.onSurface)
            .placeholderColor(AppTokens.Colors.tertiary)
            .margin({ bottom: AppTokens.Spacing.lg })

          // Markers List
          ForEach(this.markers, (marker: MapMarker) => {
            Row() {
              Column() {
                Text(marker.name)
                  .fontSize(AppTokens.TypographyTokens.title.fontSize)
                  .fontWeight(AppTokens.TypographyTokens.title.fontWeight)
                  .fontColor(AppTokens.Colors.onSurface)
                  .margin({ bottom: 4 })

                Text(marker.distance)
                  .fontSize(AppTokens.TypographyTokens.body.fontSize)
                  .fontWeight(AppTokens.TypographyTokens.body.fontWeight)
                  .fontColor(AppTokens.Colors.secondary)
              }
              .alignItems(HorizontalAlign.Start)
              .layoutWeight(1)

              Button('View', { type: ButtonType.Capsule })
                .height(32)
                .borderRadius(AppTokens.Shapes.small)
                .backgroundColor(AppTokens.Colors.primary)
                .fontColor(AppTokens.Colors.onPrimary)
                .fontSize(AppTokens.TypographyTokens.label.fontSize)
                .fontWeight(AppTokens.TypographyTokens.label.fontWeight)
            }
            .width('100%')
            .padding(AppTokens.Spacing.md)
            .borderRadius(AppTokens.Shapes.medium)
            .backgroundColor(AppTokens.Colors.surface)
            .margin({ bottom: AppTokens.Spacing.md })
          })

          // Spacer
          Blank().height(AppTokens.Spacing.xxl)

          // Refresh Button
          Button('Refresh Map', { type: ButtonType.Capsule })
            .width('100%')
            .height(48)
            .borderRadius(AppTokens.Shapes.large)
            .backgroundColor(AppTokens.Colors.primary)
            .fontColor(AppTokens.Colors.onPrimary)
            .fontSize(AppTokens.TypographyTokens.title.fontSize)
            .fontWeight(AppTokens.TypographyTokens.title.fontWeight)
        }
        .width('100%')
        .padding(AppTokens.Spacing.lg)
      }
      .layoutWeight(1)
      .backgroundColor(AppTokens.Colors.background)
      .scrollBar(BarState.Off)
    }
    .width('100%')
    .height('100%')
    .backgroundColor(AppTokens.Colors.background)
  }
}