import { window } from '@kit.ArkUI';

// --- App Tokens & Constants ---
const NAME = "010*ExploreMap*en";
const UI_TYPE = "Social";
const STYLE_THEME = "Monochrome Terminal";
const LANG = "en";
const BASELINE_SIZE = "720x1280";

interface ShadowSpec {
  elevation: number; // px
  radius: number;    // px
  dy: number;        // px
  opacity: number;   // 0-1
}

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
    onSurface: '#E0E0E0'
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
    level1: { elevation: 0, radius: 0, dy: 0, opacity: 0 },
    level2: { elevation: 2, radius: 4, dy: 2, opacity: 0.12 }
  };
}

// --- Data Model ---
interface MapMarker {
  name: string;
  distance: string;
}

@Entry
@Component
struct RootScreen {
  @State query: string = "";
  private markers: MapMarker[] = [
    { name: "Central Plaza", distance: "1.2 km" },
    { name: "Museum District", distance: "3.4 km" },
    { name: "Tech Park", distance: "5.6 km" },
    { name: "Old Town Gate", distance: "7.8 km" }
  ];

  build() {
    Column() {
      // Top Bar Area
      Row() {
        Text("Explore Map")
          .fontSize(28)
          .fontWeight(FontWeight.Bold)
          .fontColor(AppTokens.Colors.primary)
          .textAlign(TextAlign.Center)
          .width('100%')
      }
      .width('100%')
      .height(60) // Approximate height for top bar area
      .justifyContent(FlexAlign.Center)

      // Main Content
      Column({ space: AppTokens.Spacing.lg }) {
        
        // Search Field
        TextInput({ placeholder: 'Search destination' })
          .placeholderColor(AppTokens.Colors.onSurface)
          .backgroundColor(Color.Transparent)
          .borderRadius(AppTokens.Spacing.sm) // 10dp approx
          .border({ width: 1, color: AppTokens.Colors.outline })
          .padding({ left: AppTokens.Spacing.md, right: AppTokens.Spacing.md })
          .height(48)
          .fontColor(AppTokens.Colors.onSurface)
          .onChange((value: string) => {
            this.query = value;
          })

        // Markers List
        Column({ space: AppTokens.Spacing.md }) {
          ForEach(this.markers, (item: MapMarker) => {
            Row() {
              Column() {
                Text(item.name)
                  .fontSize(16)
                  .fontWeight(FontWeight.Medium)
                  .fontColor(AppTokens.Colors.onSurface)
                
                Text(item.distance)
                  .fontSize(13)
                  .fontWeight(FontWeight.Normal)
                  .fontColor(AppTokens.Colors.secondary)
                  .margin({ top: 2 })
              }
              .layoutWeight(1)
              .alignItems(HorizontalAlign.Start)

              Button("View")
                .backgroundColor(AppTokens.Colors.primary)
                .fontColor(AppTokens.Colors.onPrimary)
                .fontSize(11)
                .fontWeight(FontWeight.Medium)
                .borderRadius(AppTokens.Spacing.xs) // 6dp
                .height(36)
                .width(80)
            }
            .width('100%')
            .padding(AppTokens.Spacing.md)
            .backgroundColor(AppTokens.Colors.surface)
            .borderRadius(AppTokens.Spacing.sm) // 10dp
            .shadow({
              radius: AppTokens.ElevationMapping.level2.radius,
              color: `rgba(0, 0, 0, ${AppTokens.ElevationMapping.level2.opacity})`,
              offsetX: 0,
              offsetY: AppTokens.ElevationMapping.level2.dy
            })
          }, (item: MapMarker) => item.name)
        }
        .width('100%')

        Spacer().height(AppTokens.Spacing.xxl)

        // Refresh Button
        Button("Refresh Map")
          .width('100%')
          .height(48)
          .backgroundColor(AppTokens.Colors.primary)
          .fontColor(AppTokens.Colors.onPrimary)
          .fontSize(16)
          .fontWeight(FontWeight.Medium)
          .borderRadius(AppTokens.Spacing.lg) // 14dp
      }
      .width('100%')
      .padding(AppTokens.Spacing.lg)
      .layoutWeight(1)
    }
    .width('100%')
    .height('100%')
    .backgroundColor(AppTokens.Colors.background)
  }
}