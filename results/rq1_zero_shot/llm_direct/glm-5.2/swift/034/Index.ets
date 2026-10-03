// AppTokens.ets
// MARK: - AppTokens
export class AppTokens {
  static readonly Colors = {
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
  };

  static readonly TypographyTokens = {
    display: { size: 28, weight: FontWeight.Bold },
    headline: { size: 20, weight: FontWeight.Medium },
    title: { size: 16, weight: FontWeight.Medium },
    body: { size: 13, weight: FontWeight.Normal },
    label: { size: 11, weight: FontWeight.Medium },
  };

  static readonly Shapes = {
    small: 6,
    medium: 10,
    large: 14,
  };

  static readonly Spacing = {
    xs: 4,
    sm: 8,
    md: 12,
    lg: 16,
    xl: 24,
    xxl: 32,
  };

  static readonly ElevationMapping = {
    level1: { radius: 0, y: 0, opacity: 0 },
    level2: { radius: 4, y: 2, opacity: 0.12 },
  };
}

// MARK: - Data Model
export class MapMarker {
  id: string;
  name: string;
  distance: string;

  constructor(id: string, name: string, distance: string) {
    this.id = id;
    this.name = name;
    this.distance = distance;
  }
}

// MARK: - RootScreen View
@Entry
@Component
struct RootScreen {
  @State query: string = '';
  @State isSearchFieldFocused: boolean = false;
  
  private markers: Array<MapMarker> = [
    new MapMarker('1', 'Central Plaza', '1.2 km'),
    new MapMarker('2', 'Museum District', '3.4 km'),
    new MapMarker('3', 'Tech Park', '5.6 km'),
    new MapMarker('4', 'Old Town Gate', '7.8 km')
  ];

  build() {
    Stack() {
      // Background
      Column()
        .width('100%')
        .height('100%')
        .backgroundColor(AppTokens.Colors.background)

      // Main Content
      Column() {
        // Top Bar
        Text('Explore Map')
          .fontSize(AppTokens.TypographyTokens.display.size)
          .fontWeight(AppTokens.TypographyTokens.display.weight)
          .fontColor(AppTokens.Colors.primary)
          .width('100%')
          .padding({ top: AppTokens.Spacing.lg, bottom: AppTokens.Spacing.lg })
          .backgroundColor(AppTokens.Colors.background)
          .textAlign(TextAlign.Center)

        // Content Area
        Column() {
          // Search Field
          TextInput({ placeholder: 'Search destination', text: this.query })
            .onChange((value: string) => {
              this.query = value;
            })
            .onFocus((isFocus: boolean) => {
              this.isSearchFieldFocused = isFocus;
            })
            .fontSize(AppTokens.TypographyTokens.body.size)
            .fontColor(AppTokens.Colors.onSurface)
            .placeholderColor(AppTokens.Colors.tertiary)
            .caretColor(AppTokens.Colors.primary)
            .padding(AppTokens.Spacing.md)
            .backgroundColor(AppTokens.Colors.surfaceVariant)
            .borderRadius(AppTokens.Shapes.medium)
            .border({ width: 1, color: this.isSearchFieldFocused ? AppTokens.Colors.primary : AppTokens.Colors.outline })
            .width('100%')

          // Markers List
          Column({ space: AppTokens.Spacing.md }) {
            ForEach(this.markers, (marker: MapMarker) => {
              CardView({ marker: marker })
            })
          }
          .width('100%')

          // Spacer
          Blank()

          // Refresh Map Button
          Button() {
            Text('Refresh Map')
              .fontSize(AppTokens.TypographyTokens.title.size)
              .fontWeight(AppTokens.TypographyTokens.title.weight)
              .fontColor(AppTokens.Colors.onPrimary)
          }
          .width('100%')
          .height(48)
          .backgroundColor(AppTokens.Colors.primary)
          .borderRadius(AppTokens.Shapes.large)
          .onClick(() => {
            console.log('Refresh Map Tapped');
          })
        }
        .padding(AppTokens.Spacing.lg)
        .width('100%')
        .layoutWeight(1) // Fill remaining space
      }
    }
    .width('100%')
    .height('100%')
    .expandSafeArea([SafeAreaType.SYSTEM], [SafeAreaEdge.ALL]) // Ignore safe areas
  }
}

// MARK: - CardView
@Component
struct CardView {
  private marker: MapMarker;

  build() {
    Row() {
      // Left Content
      Column() {
        Text(this.marker.name)
          .fontSize(AppTokens.TypographyTokens.title.size)
          .fontWeight(AppTokens.TypographyTokens.title.weight)
          .fontColor(AppTokens.Colors.onSurface)
        Text(this.marker.distance)
          .fontSize(AppTokens.TypographyTokens.body.size)
          .fontWeight(AppTokens.TypographyTokens.body.weight)
          .fontColor(AppTokens.Colors.secondary)
      }
      .alignItems(HorizontalAlign.Start)

      // Spacer
      Blank()

      // View Button
      Button() {
        Text('View')
          .fontSize(AppTokens.TypographyTokens.label.size)
          .fontWeight(AppTokens.TypographyTokens.label.weight)
          .fontColor(AppTokens.Colors.onPrimary)
      }
      .padding({ left: AppTokens.Spacing.md, right: AppTokens.Spacing.md, top: AppTokens.Spacing.xs, bottom: AppTokens.Spacing.xs })
      .backgroundColor(AppTokens.Colors.primary)
      .borderRadius(AppTokens.Shapes.small)
      .onClick(() => {
        console.log(`View ${this.marker.name} Tapped`);
      })
    }
    .width('100%')
    .padding(AppTokens.Spacing.md)
    .backgroundColor(AppTokens.Colors.surface)
    .borderRadius(AppTokens.Shapes.medium)
    .shadow({
      radius: AppTokens.ElevationMapping.level2.radius,
      color: `rgba(0,0,0,${AppTokens.ElevationMapping.level2.opacity})`,
      offsetY: AppTokens.ElevationMapping.level2.y
    })
  }
}