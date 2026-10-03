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

const NAME: string = '049*InvoiceScanner*en'
const UI_TYPE: string = 'Finance'
const STYLE_THEME: string = 'Gradient Flow'
const LANG: string = 'en'
const BASELINE_SIZE: string = '720x1280'

const AppTokens = {
  Colors: {
    primary: '#06B6D4',
    secondary: '#3B82F6',
    tertiary: '#8B5CF6',
    background: '#F0F9FF',
    surface: '#FFFFFF',
    surface90: '#E6FFFFFF',
    surfaceVariant: '#E0F2FE',
    outline: '#BAE6FD',
    success: '#22C55E',
    warning: '#FACC15',
    error: '#EF4444',
    onPrimary: '#FFFFFF',
    onSecondary: '#FFFFFF',
    onTertiary: '#FFFFFF',
    onBackground: '#0F172A',
    onSurface: '#0F172A',
    secondary30: '#4D3B82F6',
    primary30: '#4D06B6D4'
  },
  Typography: {
    displaySize: 28,
    titleSize: 18,
    bodySize: 14,
    labelSize: 12
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
    level1: {
      elevation: 2,
      radius: 4,
      dy: 2,
      opacity: 0.12
    },
    level2: {
      elevation: 6,
      radius: 8,
      dy: 4,
      opacity: 0.18
    }
  }
}

@Entry
@Component
struct RootScreen {
  @State private markers: Marker[] = [
    new Marker(120, 200, 'A1'),
    new Marker(300, 400, 'B2'),
    new Marker(520, 600, 'C3')
  ]

  @State private scanning: boolean = false

  private addMarker(): void {
    if (this.scanning) {
      const nextIndex: number = this.markers.length + 1
      const x: number = Math.floor(Math.random() * (580 - 80)) + 80
      const y: number = Math.floor(Math.random() * (650 - 150)) + 150
      this.markers = [
        ...this.markers,
        new Marker(x, y, `N${nextIndex}`)
      ]
    }
  }

  build() {
    Column() {
      Row() {
        Text('Invoice Scanner')
          .fontSize(AppTokens.Typography.displaySize)
          .fontWeight(FontWeight.Bold)
          .fontColor(AppTokens.Colors.onSurface)
      }
      .width('100%')
      .height(80)
      .justifyContent(FlexAlign.Center)
      .alignItems(VerticalAlign.Center)
      .backgroundColor(AppTokens.Colors.background)

      Column({ space: AppTokens.Spacing.lg }) {
        Stack({ alignContent: Alignment.Center }) {
          Circle()
            .width(260)
            .height(260)
            .fill(AppTokens.Colors.surfaceVariant)

          ForEach(this.markers, (marker: Marker) => {
            Circle()
              .width(24)
              .height(24)
              .fill(AppTokens.Colors.primary)
              .position({
                x: marker.x - 12,
                y: marker.y - 12
              })
          }, (marker: Marker) => marker.label)
        }
        .width('100%')
        .height(400)
        .padding(AppTokens.Spacing.md)
        .backgroundColor(AppTokens.Colors.surface90)
        .borderRadius(AppTokens.Shapes.large)
        .clip(true)
        .shadow({
          radius: AppTokens.ElevationMapping.level2.radius,
          color: '#2E0F172A',
          offsetX: 0,
          offsetY: AppTokens.ElevationMapping.level2.dy
        })

        Row() {
          Text('Scanning Active')
            .fontSize(AppTokens.Typography.titleSize)
            .fontWeight(FontWeight.Medium)
            .fontColor(AppTokens.Colors.onSurface)

          Toggle({
            type: ToggleType.Switch,
            isOn: this.scanning
          })
            .selectedColor(AppTokens.Colors.secondary)
            .switchPointColor(this.scanning ? AppTokens.Colors.onSecondary : AppTokens.Colors.outline)
            .onChange((isOn: boolean) => {
              this.scanning = isOn
            })
        }
        .width('100%')
        .justifyContent(FlexAlign.SpaceBetween)
        .alignItems(VerticalAlign.Center)

        Button('Add Marker', { type: ButtonType.Normal })
          .width('100%')
          .height(48)
          .borderRadius(AppTokens.Shapes.medium)
          .backgroundColor(AppTokens.Colors.primary)
          .fontColor(AppTokens.Colors.onPrimary)
          .fontSize(AppTokens.Typography.titleSize)
          .fontWeight(FontWeight.Medium)
          .onClick(() => {
            this.addMarker()
          })
      }
      .width('100%')
      .layoutWeight(1)
      .padding(AppTokens.Spacing.lg)
      .alignItems(HorizontalAlign.Center)
      .linearGradient({
        direction: GradientDirection.Bottom,
        colors: [
          [AppTokens.Colors.secondary30, 0.0],
          [AppTokens.Colors.background, 0.5],
          [AppTokens.Colors.primary30, 1.0]
        ]
      })
    }
    .width('100%')
    .height('100%')
    .backgroundColor(AppTokens.Colors.background)
  }
}