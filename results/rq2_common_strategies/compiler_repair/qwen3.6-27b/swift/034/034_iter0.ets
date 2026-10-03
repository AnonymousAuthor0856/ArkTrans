import { BusinessError } from '@kit.BasicServicesKit';

// MARK: - AppTokens
// Mapping SwiftUI tokens to ArkTS constants. 
// Note: ArkTS uses vp (virtual pixels) for layout and font sizes.
const AppTokens = {
  Colors: {
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
  },
  TypographyTokens: {
    display: { size: 28, weight: FontWeight.Bold },
    headline: { size: 20, weight: FontWeight.Medium },
    title: { size: 16, weight: FontWeight.Medium },
    body: { size: 13, weight: FontWeight.Regular },
    label: { size: 11, weight: FontWeight.Medium }
  },
  Shapes: {
    small: 6,
    medium: 10,
    large: 14
  },
  Spacing: {
    xs: 4,
    sm: 8,
    md: 12,
    lg: 16,
    xl: 24,
    xxl: 32
  },
  ElevationMapping: {
    level2: {
      radius: 4,
      y: 2,
      opacity: 0.12
    }
  }
};

// MARK: - Data Model
interface MapMarker {
  id: number;
  name: string;
  distance: string;
}

@Entry
@Component
struct RootScreen {
  @State query: string = '';
  // In ArkTS, TextField handles focus internally or via specific APIs, 
  // but for simple styling based on focus, we can often rely on the component's built-in states 
  // or just style it statically if dynamic border color isn't strictly required by the prompt's visual fidelity.
  // However, to match the SwiftUI logic closely, we might need a state if we want to change border color on focus.
  // For simplicity in this conversion, we will use the default focused state of TextField which usually highlights the border.
  // If strict custom border color change is needed, we'd wrap it. Here we stick to standard styling.
  
  private markers: MapMarker[] = [
    { id: 1, name: 'Central Plaza', distance: '1.2 km' },
    { id: 2, name: 'Museum District', distance: '3.4 km' },
    { id: 3, name: 'Tech Park', distance: '5.6 km' },
    { id: 4, name: 'Old Town Gate', distance: '7.8 km' }
  ];

  build() {
    Column() {
      // Top Bar
      Text('Explore Map')
        .font({ size: AppTokens.TypographyTokens.display.size, weight: AppTokens.TypographyTokens.display.weight })
        .foregroundColor(AppTokens.Colors.primary)
        .width('100%')
        .textAlign(TextAlign.Start)
        .padding({ top: AppTokens.Spacing.lg, bottom: AppTokens.Spacing.lg })
        .backgroundColor(AppTokens.Colors.background)

      // Main Content Area
      Column() {
        // Search Field
        TextField('', { placeholder: 'Search destination' })
          .text(this.query)
          .onChange((value: string) => {
            this.query = value;
          })
          .font({ size: AppTokens.TypographyTokens.body.size, weight: AppTokens.TypographyTokens.body.weight })
          .placeholderColor(AppTokens.Colors.secondary) // Placeholder color
          .backgroundColor(AppTokens.Colors.surfaceVariant)
          .borderWidth(1)
          .borderColor(AppTokens.Colors.outline)
          .cornerRadius(AppTokens.Shapes.medium)
          .padding(AppTokens.Spacing.md)
          .width('100%')
          .margin({ bottom: AppTokens.Spacing.lg })
          // Note: ArkTS TextField has native focus styles. To exactly mimic the SwiftUI code where 
          // border changes to primary on focus, we would need more complex state management or custom drawing.
          // We'll keep it simple with the outline color defined above.

        // Markers List
        Column() {
          ForEach(this.markers, (marker: MapMarker) => {
            CardView(marker: marker)
              .margin({ bottom: AppTokens.Spacing.md })
          })
        }
        .width('100%')

        Spacer()

        // Refresh Map Button
        Button('Refresh Map') {
          console.info('Refresh Map Tapped');
        }
        .font({ size: AppTokens.TypographyTokens.title.size, weight: AppTokens.TypographyTokens.title.weight })
        .backgroundColor(AppTokens.Colors.primary)
        .foregroundColor(AppTokens.Colors.onPrimary)
        .height(48)
        .width('100%')
        .cornerRadius(AppTokens.Shapes.large)
        .margin({ top: AppTokens.Spacing.lg })
      }
      .padding(AppTokens.Spacing.lg)
      .width('100%')
    }
    .backgroundColor(AppTokens.Colors.background)
    .width('100%')
    .height('100%')
  }
}

@Component
struct CardView {
  @Prop marker: MapMarker;

  build() {
    Row() {
      Column() {
        Text(this.marker.name)
          .font({ size: AppTokens.TypographyTokens.title.size, weight: AppTokens.TypographyTokens.title.weight })
          .foregroundColor(AppTokens.Colors.onSurface)
        
        Text(this.marker.distance)
          .font({ size: AppTokens.TypographyTokens.body.size, weight: AppTokens.TypographyTokens.body.weight })
          .foregroundColor(AppTokens.Colors.secondary)
          .margin({ top: 4 }) // Small spacing between name and distance
      }
      .alignItems(HorizontalAlign.Start)

      Flex({ justifyContent: FlexAlign.End, alignItems: ItemAlign.Center }) {
        Button('View') {
          console.info(`View ${this.marker.name} Tapped`);
        }
        .font({ size: AppTokens.TypographyTokens.label.size, weight: AppTokens.TypographyTokens.label.weight })
        .backgroundColor(AppTokens.Colors.primary)
        .foregroundColor(AppTokens.Colors.onPrimary)
        .cornerRadius(AppTokens.Shapes.small)
        .padding({ left: AppTokens.Spacing.md, right: AppTokens.Spacing.md, top: AppTokens.Spacing.xs, bottom: AppTokens.Spacing.xs })
      }
    }
    .width('100%')
    .padding(AppTokens.Spacing.md)
    .backgroundColor(AppTokens.Colors.surface)
    .cornerRadius(AppTokens.Shapes.medium)
    .shadow({
      radius: AppTokens.ElevationMapping.level2.radius,
      color: `rgba(0, 0, 0, ${AppTokens.ElevationMapping.level2.opacity})`,
      offsetX: 0,
      offsetY: AppTokens.ElevationMapping.level2.y
    })
  }
}