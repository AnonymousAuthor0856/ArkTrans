import { Color, Font, LinearGradient, Path, Rect, ShadowSpec } from '@kit.ArkUI';

// MARK: - 1. AppTokens (Colors, Typography, Shapes, Spacing, ElevationMapping)

// Data structure for shadow specifications
interface ShadowSpecData {
  radius: number; // Blur radius
  x: number;      // X offset
  y: number;      // Y offset
  opacity: number; // Shadow color opacity
}

interface TypographyToken {
  size: number;
  weight: FontWeight;
}

interface ColorsMap {
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

interface ShapesMap {
  small: number;
  medium: number;
  large: number;
}

interface SpacingMap {
  sm: number;
  md: number;
  lg: number;
  xl: number;
  xxl: number;
}

interface ElevationMappingMap {
  level1: ShadowSpecData;
  level2: ShadowSpecData;
}

interface TypographyTokensMap {
  display: TypographyToken;
  title: TypographyToken;
  body: TypographyToken;
  label: TypographyToken;
}

interface AppTokensConfig {
  Colors: ColorsMap;
  TypographyTokens: TypographyTokensMap;
  Shapes: ShapesMap;
  Spacing: SpacingMap;
  ElevationMapping: ElevationMappingMap;
}

// Centralized design tokens for easy modification and consistency
const AppTokens: AppTokensConfig = {
  Colors: {
    primary: '#06B6D4',
    secondary: '#3B82F6',
    tertiary: '#8B5CF6',
    background: '#F0F9FF',
    surface: '#FFFFFF',
    surfaceVariant: '#E0F2FE',
    outline: '#BAE6FD',
    success: '#22C55E',
    warning: '#FACC15',
    error: '#EF4444',
    onPrimary: '#FFFFFF',
    onSecondary: '#FFFFFF',
    onTertiary: '#FFFFFF',
    onBackground: '#0F172A',
    onSurface: '#0F172A'
  },

  TypographyTokens: {
    display: { size: 28, weight: FontWeight.Bold },
    title: { size: 18, weight: FontWeight.Medium },
    body: { size: 14, weight: FontWeight.Normal },
    label: { size: 12, weight: FontWeight.Medium }
  },

  Shapes: {
    small: 6,
    medium: 12,
    large: 20
  },

  Spacing: {
    sm: 8,
    md: 12,
    lg: 16,
    xl: 24,
    xxl: 32
  },

  ElevationMapping: {
    level1: { radius: 4, x: 0, y: 2, opacity: 0.12 },
    level2: { radius: 8, x: 0, y: 4, opacity: 0.18 }
  }
};

// MARK: - 4. Data Model

interface Marker {
  id: string;
  x: number;
  y: number;
  label: string;
}

// Helper to generate unique IDs
let markerIdCounter = 0;
function generateId(): string {
  return `marker_${markerIdCounter++}`;
}

@Entry
@Component
struct RootScreen {
  @State markers: Marker[] = [
    { id: generateId(), x: 120, y: 200, label: "A1" },
    { id: generateId(), x: 300, y: 400, label: "B2" },
    { id: generateId(), x: 520, y: 600, label: "C3" }
  ];
  @State scanning: boolean = false;

  build() {
    Column() {
      // Top Bar
      Text("Invoice Scanner")
        .font({ size: AppTokens.TypographyTokens.display.size, weight: AppTokens.TypographyTokens.display.weight })
        .fontColor(AppTokens.Colors.onSurface)
        .width('100%')
        .padding({ top: AppTokens.Spacing.lg, bottom: AppTokens.Spacing.lg })
        .backgroundColor(AppTokens.Colors.background)

      // Main Content Area
      Column() {
        // Surface containing the Canvas
        this.SurfaceView(
          shapeCornerRadius: AppTokens.Shapes.large,
          backgroundColor: AppTokens.Colors.surface,
          shadowSpec: AppTokens.ElevationMapping.level2
        ) {
          // BoxView equivalent: Container filling space
          Stack() {
            // Canvas drawing
            Drawing() {
              let width = this.width();
              let height = this.height();
              let centerX = width / 2;
              let centerY = height / 2;
              let minDim = Math.min(width, height);
              
              // Draw inner circle (surfaceVariant)
              Path.create((path: Path) => {
                path.addCircle(centerX, centerY, minDim / 2.5);
              }).fill(Color(AppTokens.Colors.surfaceVariant))

              // Draw markers
              ForEach(this.markers, (marker: Marker) => {
                Path.create((path: Path) => {
                  path.addCircle(marker.x, marker.y, 12);
                }).fill(Color(AppTokens.Colors.primary))
              })
            }
            .padding(AppTokens.Spacing.md)
            .width('100%')
            .height('100%')
          }
          .width('100%')
          .height('100%')
        }
        .width('100%')
        .height(400)

        // Scanning Active Row
        Row() {
          Text("Scanning Active")
            .font({ size: AppTokens.TypographyTokens.title.size, weight: AppTokens.TypographyTokens.title.weight })
            .fontColor(AppTokens.Colors.onSurface)
          
          Blank()
          
          // Custom Toggle Implementation
          this.CustomToggle(isOn: $this.scanning)
        }
        .width('100%')
        .alignItems(VerticalAlign.Center)

        // Add Marker Button
        Button("Add Marker", { type: ButtonType.Capsule, stateEffect: true })
          .fontSize(AppTokens.TypographyTokens.title.size)
          .fontWeight(AppTokens.TypographyTokens.title.weight)
          .fontColor(AppTokens.Colors.onPrimary)
          .width('100%')
          .height(48)
          .backgroundColor(AppTokens.Colors.primary)
          .borderRadius(AppTokens.Shapes.medium)
          .onClick(() => {
            if (this.scanning) {
              const newX = Math.random() * (580 - 80) + 80;
              const newY = Math.random() * (650 - 150) + 150;
              this.markers.push({
                id: generateId(),
                x: newX,
                y: newY,
                label: `N${this.markers.length + 1}`
              });
            }
          })
      }
      .padding(AppTokens.Spacing.lg)
      .width('100%')
      .layoutWeight(1)
      .linearGradient({
        angle: 90,
        colors: [
          [AppTokens.Colors.secondary, 0.3],
          [AppTokens.Colors.background, 0.5],
          [AppTokens.Colors.primary, 0.3]
        ]
      })
    }
    .width('100%')
    .height('100%')
    .backgroundColor(AppTokens.Colors.background)
  }

  // Helper Component for Surface with Shadow
  @Builder
  SurfaceView(shapeCornerRadius: number, backgroundColor: string, shadowSpec: ShadowSpecData, content: () => void) {
    Stack() {
      content()
    }
    .clip(RoundedRectangle({ cornerRadius: shapeCornerRadius }))
    .backgroundColor(backgroundColor)
    .shadow({
      radius: shadowSpec.radius,
      color: Color.Black.withAlpha(shadowSpec.opacity),
      offsetX: shadowSpec.x,
      offsetY: shadowSpec.y
    })
  }

  // Helper Component for Custom Toggle
  @Builder
  CustomToggle(isOn: boolean) {
    Row() {
      if (isOn) {
        Circle()
          .width(26)
          .height(26)
          .backgroundColor(AppTokens.Colors.secondary)
          .margin({ right: 2 })
      } else {
        Circle()
          .width(26)
          .height(26)
          .backgroundColor(AppTokens.Colors.outline)
          .margin({ left: 2 })
      }
    }
    .width(50)
    .height(30)
    .justifyContent(isOn ? FlexAlign.End : FlexAlign.Start)
    .backgroundColor(isOn ? AppTokens.Colors.secondary : AppTokens.Colors.surfaceVariant)
    .borderRadius(15)
    .onClick(() => {
      this.scanning = !this.scanning;
    })
  }
}