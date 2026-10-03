@Entry
@Component
struct InvoiceScannerApp {
  build() {
    RootScreen()
  }
}

// Design tokens
class AppTokens {
  static readonly Colors = {
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
  }

  static readonly Spacing = {
    sm: 8,
    md: 12,
    lg: 16,
    xl: 24,
    xxl: 32
  }

  static readonly Shapes = {
    small: 6,
    medium: 12,
    large: 20
  }
}

// Data model
class Marker {
  x: number
  y: number
  label: string

  constructor(x: number, y: number, label: string) {
    this.x = x
    this.y = y
    this.label = label
  }
}

@Component
struct RootScreen {
  @State markers: Marker[] = [
    new Marker(120, 200, 'A1'),
    new Marker(300, 400, 'B2'),
    new Marker(520, 600, 'C3')
  ]
  @State scanning: boolean = false

  build() {
    Column() {
      // Top Bar
      Text('Invoice Scanner')
        .fontSize(28)
        .fontWeight(FontWeight.Bold)
        .fontColor(AppTokens.Colors.onSurface)
        .width('100%')
        .textAlign(TextAlign.Center)
        .padding({ top: AppTokens.Spacing.lg, bottom: AppTokens.Spacing.lg })
        .backgroundColor(AppTokens.Colors.background)

      // Main Content Area
      Column({ space: AppTokens.Spacing.lg }) {
        // Surface containing the Canvas
        Column() {
          Stack() {
            // Inner circle
            Circle()
              .width(160)
              .height(160)
              .fill(AppTokens.Colors.surfaceVariant)

            // Markers
            ForEach(this.markers, (marker: Marker) => {
              Circle()
                .width(24)
                .height(24)
                .fill(AppTokens.Colors.primary)
                .position({ x: marker.x, y: marker.y })
            }, (marker: Marker) => marker.label)
          }
          .width('100%')
          .height('100%')
        }
        .width('100%')
        .height(400)
        .backgroundColor('#E6FFFFFF')
        .borderRadius(AppTokens.Shapes.large)
        .shadow({
          radius: 8,
          color: '#1A000000',
          offsetX: 0,
          offsetY: 4
        })
        .padding(AppTokens.Spacing.md)

        // Scanning Active Row
        Row() {
          Text('Scanning Active')
            .fontSize(18)
            .fontWeight(FontWeight.Medium)
            .fontColor(AppTokens.Colors.onSurface)

          Blank()

          Toggle({ type: ToggleType.Switch, isOn: this.scanning })
            .selectedColor(AppTokens.Colors.secondary)
            .switchPointColor(AppTokens.Colors.secondary)
            .onChange((isOn: boolean) => {
              this.scanning = isOn
            })
        }
        .width('100%')
        .alignItems(VerticalAlign.Center)

        // Add Marker Button
        Button('Add Marker')
          .fontSize(18)
          .fontWeight(FontWeight.Medium)
          .fontColor(AppTokens.Colors.onPrimary)
          .width('100%')
          .height(48)
          .backgroundColor(AppTokens.Colors.primary)
          .borderRadius(AppTokens.Shapes.medium)
          .onClick(() => {
            if (this.scanning) {
              const randomX = Math.floor(Math.random() * (580 - 80 + 1)) + 80
              const randomY = Math.floor(Math.random() * (650 - 150 + 1)) + 150
              this.markers.push(new Marker(randomX, randomY, `N${this.markers.length + 1}`))
            }
          })
      }
      .width('100%')
      .layoutWeight(1)
      .padding(AppTokens.Spacing.lg)
      .linearGradient({
        angle: 180,
        colors: [
          ['#4D3B82F6', 0],
          [AppTokens.Colors.background, 0.5],
          ['#4D06B6D4', 1]
        ]
      })
    }
    .width('100%')
    .height('100%')
    .backgroundColor(AppTokens.Colors.background)
  }
}