import { window } from '@kit.ArkUI';

// --- Constants & Tokens ---

const NAME = "010*ExploreMap*en";
const UI_TYPE = "Social";
const STYLE_THEME = "Monochrome Terminal";
const LANG = "en";
const BASELINE_SIZE = "720x1280";

interface AppColors {
  primary: string,
  secondary: string,
  tertiary: string,
  background: string,
  surface: string,
  surfaceVariant: string,
  outline: string,
  success: string,
  warning: string,
  error: string,
  onPrimary: string,
  onSecondary: string,
  onTertiary: string,
  onBackground: string,
  onSurface: string
}

interface AppSpacing {
  xs: number,
  sm: number,
  md: number,
  lg: number,
  xl: number,
  xxl: number
}

interface AppShapes {
  small: number,
  medium: number,
  large: number
}

class AppTokens {
  static Colors: AppColors = {
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
  };

  static Spacing: AppSpacing = {
    xs: 4,
    sm: 8,
    md: 12,
    lg: 16,
    xl: 24,
    xxl: 32
  };

  static Shapes: AppShapes = {
    small: 6,
    medium: 10,
    large: 14
  };
}

interface MapMarker {
  name: string;
  distance: string;
}

// --- Components ---

@Component
struct MarkerCard {
  private marker: MapMarker = { name: '', distance: '' };

  build() {
    Row() {
      Column() {
        Text(this.marker.name)
          .fontSize(16)
          .fontWeight(FontWeight.Medium)
          .fontColor(AppTokens.Colors.onSurface)
        
        Text(this.marker.distance)
          .margin({ top: 4 })
          .fontSize(13)
          .fontColor(AppTokens.Colors.secondary)
      }

      Button('View')
        .backgroundColor(AppTokens.Colors.primary)
        .fontColor(AppTokens.Colors.onPrimary)
        .borderRadius(AppTokens.Shapes.small)
        .height(32)
        .width(60)
        .fontSize(11)
        .fontWeight(FontWeight.Medium)
    }
    .width('100%')
    .justifyContent(FlexAlign.SpaceBetween)
    .alignItems(VerticalAlign.Center)
    .padding(AppTokens.Spacing.md)
    .backgroundColor(AppTokens.Colors.surface)
    .borderRadius(AppTokens.Shapes.medium)
    // Simulating elevation with a subtle border or shadow if needed, 
    // but standard ArkTS Card usually handles this. Here we use simple styling.
    .shadow({ radius: 4, color: 'rgba(0,0,0,0.12)', offsetY: 2 })
  }
}

@Entry
@Component
struct RootScreen {
  @State query: string = '';
  
  // Mock data
  private markers: MapMarker[] = [
    { name: "Central Plaza", distance: "1.2 km" },
    { name: "Museum District", distance: "3.4 km" },
    { name: "Tech Park", distance: "5.6 km" },
    { name: "Old Town Gate", distance: "7.8 km" }
  ];

  build() {
    Column() {
      // Top Bar Area
      Column() {
        Text("Explore Map")
          .fontSize(28)
          .fontWeight(FontWeight.Bold)
          .fontColor(AppTokens.Colors.primary)
          .textAlign(TextAlign.Center)
      }
      .width('100%')
      .padding({ bottom: AppTokens.Spacing.lg })

      // Search Field
      TextInput({ placeholder: 'Search destination' })
        .placeholderColor(AppTokens.Colors.onSurface)
        .fontColor(AppTokens.Colors.onSurface)
        .backgroundColor(AppTokens.Colors.surface)
        .borderRadius(AppTokens.Shapes.medium)
        .borderWidth(1)
        .borderColor(AppTokens.Colors.outline)
        .onChange((value: string) => {
          this.query = value;
        })
        .onFocus(() => {
          // In a real app, we might change border color here via state
        })

      // List of Markers
      Column() {
        ForEach(this.markers, (item: MapMarker) => {
          MarkerCard({ marker: item })
            .margin({ bottom: AppTokens.Spacing.md })
        })
      }
      .layoutWeight(1)
      .margin({ top: AppTokens.Spacing.lg })

      Blank().height(AppTokens.Spacing.xxl)

      // Bottom Action Button
      Button('Refresh Map')
        .width('100%')
        .height(48)
        .backgroundColor(AppTokens.Colors.primary)
        .fontColor(AppTokens.Colors.onPrimary)
        .borderRadius(AppTokens.Shapes.large)
        .fontSize(16)
        .fontWeight(FontWeight.Medium)
    }
    .width('100%')
    .height('100%')
    .padding(AppTokens.Spacing.lg)
    .backgroundColor(AppTokens.Colors.background)
  }
}