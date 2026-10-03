/*
 * ArkTS Conversion of InvoiceScanner
 * 
 * This code replicates the SwiftUI implementation using ArkUI components.
 * It includes:
 * 1. AppTokens for design consistency.
 * 2. Custom Toggle component.
 * 3. Canvas drawing for the scanner view.
 * 4. State management for markers and scanning toggle.
 */

// MARK: - 1. AppTokens (Colors, Typography, Shapes, Spacing)

interface ColorTokens {
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

interface TypographyToken {
  size: number;
  weight: FontWeight;
}

interface TypographyTokens {
  display: TypographyToken;
  title: TypographyToken;
  body: TypographyToken;
  label: TypographyToken;
}

interface ShapeTokens {
  small: number;
  medium: number;
  large: number;
}

interface SpacingTokens {
  sm: number;
  md: number;
  lg: number;
  xl: number;
  xxl: number;
}

const AppTokens = {
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
  } as ColorTokens,
  Typography: {
    display: { size: 28, weight: FontWeight.Bold },
    title: { size: 18, weight: FontWeight.Medium },
    body: { size: 14, weight: FontWeight.Normal },
    label: { size: 12, weight: FontWeight.Medium }
  } as TypographyTokens,
  Shapes: {
    small: 6,
    medium: 12,
    large: 20
  } as ShapeTokens,
  Spacing: {
    sm: 8,
    md: 12,
    lg: 16,
    xl: 24,
    xxl: 32
  } as SpacingTokens
}

// MARK: - 2. Data Model

interface Marker {
  id: number;
  x: number;
  y: number;
  label: string;
}

// MARK: - 3. Custom Components

/**
 * Custom Toggle Component
 * Replicates the specific visual style from the SwiftUI InvoiceScannerToggleStyle
 */
@Component
struct CustomToggle {
  @Prop isOn: boolean;
  onChange: (value: boolean) => void = () => {};

  build() {
    Row() {
      // Track
      Capsule()
        .width(50)
        .height(30)
        .backgroundColor(this.isOn ? AppTokens.Colors.secondary : AppTokens.Colors.surfaceVariant)
        .animation({ duration: 200 })

      // Thumb
      Circle()
        .width(26)
        .height(26)
        .backgroundColor(this.isOn ? AppTokens.Colors.secondary : AppTokens.Colors.outline)
        .margin({ left: this.isOn ? 22 : 2 }) // Calculate position based on state
        .animation({ duration: 200 })
    }
    .onClick(() => {
      this.onChange(!this.isOn);
    })
  }
}

/**
 * Scanner Surface Component
 * Handles the canvas drawing and shadow effects
 */
@Component
struct ScannerSurface {
  @Link markers: Marker[];

  build() {
    Column() {
      Canvas(this.renderContext)
        .size({ width: '100%', height: '100%' })
    }
    .width('100%')
    .height(400)
    .borderRadius(AppTokens.Shapes.large)
    .backgroundColor(Color.White)
    .shadow({ radius: 8, color: '#00000030', offsetX: 0, offsetY: 4 }) // Level 2 Shadow
    .padding(AppTokens.Spacing.md)
  }

  private renderContext = new CanvasRenderingContext2D();

  aboutToAppear() {
    // We use drawRect to handle the drawing logic manually in ArkTS
  }
}

// MARK: - 4. RootScreen (Main UI)

@Entry
@Component
struct RootScreen {
  @State markers: Marker[] = [
    { id: 1, x: 120, y: 200, label: "A1" },
    { id: 2, x: 300, y: 400, label: "B2" },
    { id: 3, x: 520, y: 600, label: "C3" }
  ];
  @State scanning: boolean = false;

  build() {
    Column() {
      // Top Bar
      Text("Invoice Scanner")
        .fontSize(AppTokens.Typography.display.size)
        .fontWeight(AppTokens.Typography.display.weight)
        .fontColor(AppTokens.Colors.onSurface)
        .textAlign(TextAlign.Center)
        .width('100%')
        .padding({ top: AppTokens.Spacing.lg, bottom: AppTokens.Spacing.lg })
        .backgroundColor(AppTokens.Colors.background)

      // Main Content Area
      Column() {
        // Scanner View with Canvas Drawing
        Canvas((context: CanvasRenderingContext2D, size: Size) => {
          const centerX = size.width / 2;
          const centerY = size.height / 2;
          
          // Draw inner circle (surfaceVariant)
          context.beginPath();
          context.arc(centerX, centerY, Math.min(size.width, size.height) / 2.5, 0, 2 * Math.PI);
          context.fillStyle = AppTokens.Colors.surfaceVariant;
          context.fill();

          // Draw markers
          // Note: In a real app, you would map screen coordinates to canvas coordinates more precisely.
          // Here we simulate the positions relative to the container size.
          this.markers.forEach(marker => {
            context.beginPath();
            // Normalizing marker positions for the demo visualization
            const normX = (marker.x / 600) * size.width;
            const normY = (marker.y / 700) * size.height;
            
            context.arc(normX, normY, 12, 0, 2 * Math.PI);
            context.fillStyle = AppTokens.Colors.primary;
            context.fill();
          });
        })
        .width('100%')
        .height(400)
        .borderRadius(AppTokens.Shapes.large)
        .backgroundColor(Color.White)
        .shadow({ radius: 8, color: '#00000030', offsetX: 0, offsetY: 4 })
        .margin({ bottom: AppTokens.Spacing.lg })

        // Scanning Active Row
        Row() {
          Text("Scanning Active")
            .fontSize(AppTokens.Typography.title.size)
            .fontWeight(AppTokens.Typography.title.weight)
            .fontColor(AppTokens.Colors.onSurface)
          
          Blank()

          CustomToggle({
            isOn: this.scanning,
            onChange: (val: boolean) => {
              this.scanning = val;
            }
          })
        }
        .width('100%')
        .margin({ bottom: AppTokens.Spacing.lg })

        // Add Marker Button
      }
      .width('100%')
      .padding(AppTokens.Spacing.lg)
      .linearGradient({
        angle: 90,
        colors: [
          ['rgba(59, 130, 246, 0.3)', 0],   // Secondary opacity
          ['#F0F9FF', 0.5],                  // Background
          ['rgba(6, 182, 212, 0.3)', 1]     // Primary opacity
        ]
      })
    }
    .width('100%')
    .height('100%')
    .backgroundColor(AppTokens.Colors.background)
  }
}