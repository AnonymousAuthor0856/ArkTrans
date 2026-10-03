// AppTokens.ts
interface ColorsType {
  primary: string;
  secondary: string;
  tertiary: string;
  background: string;
  surface: string;
  surfaceVariant: string;
  outline: string;
  success: string;
  warning: string;
  error: string;
  onPrimary: string;
  onSecondary: string;
  onTertiary: string;
  onBackground: string;
  onSurface: string;
}

interface TypographyTokenType {
  size: number;
  weight: FontWeight;
}

interface TypographyTokensType {
  display: TypographyTokenType;
  headline: TypographyTokenType;
  title: TypographyTokenType;
  body: TypographyTokenType;
  label: TypographyTokenType;
}

interface ShapesType {
  small: number;
  medium: number;
  large: number;
}

interface SpacingType {
  xs: number;
  sm: number;
  md: number;
  lg: number;
  xl: number;
  xxl: number;
}

interface ShadowSpecType {
  radius: number;
  y: number;
  opacity: number;
}

interface ElevationMappingType {
  level1: ShadowSpecType;
  level2: ShadowSpecType;
}

export class AppTokens {
  static Colors: ColorsType = {
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

  static TypographyTokens: TypographyTokensType = {
    display: { size: 28, weight: FontWeight.Bold },
    headline: { size: 20, weight: FontWeight.Medium },
    title: { size: 16, weight: FontWeight.Medium },
    body: { size: 13, weight: FontWeight.Regular },
    label: { size: 11, weight: FontWeight.Medium },
  };

  static Shapes: ShapesType = {
    small: 6,
    medium: 10,
    large: 14,
  };

  static Spacing: SpacingType = {
    xs: 4,
    sm: 8,
    md: 12,
    lg: 16,
    xl: 24,
    xxl: 32,
  };

  static ElevationMapping: ElevationMappingType = {
    level1: { radius: 0, y: 0, opacity: 0 },
    level2: { radius: 4, y: 2, opacity: 0.12 },
  };
}

// Data Model
interface MapMarker {
  id: string;
  name: string;
  distance: string;
}

// CardView Component
@Component
struct CardView {
  @Prop marker: MapMarker;

  build() {
    Row() {
      // Marker Info
      Column() {
        Text(this.marker.name)
          .fontSize(AppTokens.TypographyTokens.title.size)
          .fontWeight(AppTokens.TypographyTokens.title.weight)
          .fontColor(AppTokens.Colors.onSurface)
        
        Text(this.marker.distance)
          .fontSize(AppTokens.TypographyTokens.body.size)
          .fontWeight(AppTokens.TypographyTokens.body.weight)
          .fontColor(AppTokens.Colors.secondary)
          .margin({ top: AppTokens.Spacing.xs })
      }
      .alignItems(HorizontalAlign.Start)

      Blank() // Pushes the button to the right

      // View Button
      Button() {
        Text('View')
          .fontSize(AppTokens.TypographyTokens.label.size)
          .fontWeight(AppTokens.TypographyTokens.label.weight)
          .fontColor(AppTokens.Colors.onPrimary)
      }
      .backgroundColor(AppTokens.Colors.primary)
      .borderRadius(AppTokens.Shapes.small)
      .padding({
        left: AppTokens.Spacing.md,
        right: AppTokens.Spacing.md,
        top: AppTokens.Spacing.xs,
        bottom: AppTokens.Spacing.xs
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

// RootScreen Component
@Entry
@Component
struct RootScreen {
  @State query: string = '';
  @State isSearchFieldFocused: boolean = false;
  
  private markers: MapMarker[] = [
    { id: '1', name: 'Central Plaza', distance: '1.2 km' },
    { id: '2', name: 'Museum District', distance: '3.4 km' },
    { id: '3', name: 'Tech Park', distance: '5.6 km' },
    { id: '4', name: 'Old Town Gate', distance: '7.8 km' }
  ];

  build() {
    Stack({ alignContent: Alignment.TopStart }) {
      // Background Layer
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
          Stack({ alignContent: Alignment.Start }) {
            if (this.query === '') {
              Text('Search destination')
                .fontSize(AppTokens.TypographyTokens.body.size)
                .fontWeight(AppTokens.TypographyTokens.body.weight)
                .fontColor(AppTokens.Colors.tertiary)
                .margin({ left: AppTokens.Spacing.md })
            }
            TextInput({ text: this.query })
              .onChange((value) => {
                this.query = value;
              })
              .onFocus(() => {
                this.isSearchFieldFocused = true;
              })
              .onBlur(() => {
                this.isSearchFieldFocused = false;
              })
              .fontSize(AppTokens.TypographyTokens.body.size)
              .fontWeight(AppTokens.TypographyTokens.body.weight)
              .fontColor(AppTokens.Colors.onSurface)
              .caretColor(AppTokens.Colors.primary)
              .backgroundColor(AppTokens.Colors.surfaceVariant)
              .borderRadius(AppTokens.Shapes.medium)
              .border({
                width: 1,
                color: this.isSearchFieldFocused ? AppTokens.Colors.primary : AppTokens.Colors.outline
              })
              .width('100%')
              .height(40)
              .padding({ left: AppTokens.Spacing.md, right: AppTokens.Spacing.md })
          }
          .width('100%')

          // Markers List
          Column({ space: AppTokens.Spacing.md }) {
            ForEach(this.markers, (marker: MapMarker) => {
              CardView({ marker: marker })
            })
          }
          .width('100%')
          .margin({ top: AppTokens.Spacing.lg })

          Blank() // Pushes button to bottom

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
        }
        .width('100%')
        .height('100%')
        .padding(AppTokens.Spacing.lg)
      }
      .width('100%')
      .height('100%')
    }
    .width('100%')
    .height('100%')
  }
}