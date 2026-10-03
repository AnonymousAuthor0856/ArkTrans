// Invoice Scanner - ArkTS implementation

// MARK: - AppTokens (Colors, Typography, Shapes, Spacing)

class AppColors {
  static readonly primary: string = '#06B6D4'
  static readonly secondary: string = '#3B82F6'
  static readonly tertiary: string = '#8B5CF6'
  static readonly background: string = '#F0F9FF'
  static readonly surface: string = '#FFFFFF'
  static readonly surfaceVariant: string = '#E0F2FE'
  static readonly outline: string = '#BAE6FD'
  static readonly success: string = '#22C55E'
  static readonly warning: string = '#FACC15'
  static readonly error: string = '#EF4444'
  static readonly onPrimary: string = '#FFFFFF'
  static readonly onSecondary: string = '#FFFFFF'
  static readonly onTertiary: string = '#FFFFFF'
  static readonly onBackground: string = '#0F172A'
  static readonly onSurface: string = '#0F172A'
}

class AppShapes {
  static readonly small: number = 6
  static readonly medium: number = 12
  static readonly large: number = 20
}

class AppSpacing {
  static readonly sm: number = 8
  static readonly md: number = 12
  static readonly lg: number = 16
  static readonly xl: number = 24
  static readonly xxl: number = 32
}

// MARK: - Data Model

interface Marker {
  id: string
  x: number
  y: number
  label: string
}

// MARK: - RootScreen (Main UI)

@Entry
@Component
struct InvoiceScannerPage {
  @State markers: Marker[] = [
    { id: '1', x: 120, y: 200, label: 'A1' },
    { id: '2', x: 300, y: 400, label: 'B2' },
    { id: '3', x: 520, y: 600, label: 'C3' }
  ]
  @State scanning: boolean = false
  private canvasWidth: number = 0
  private canvasHeight: number = 0

  build() {
    Column() {
      // Top Bar
      Text('Invoice Scanner')
        .fontSize(28)
        .fontWeight(FontWeight.Bold)
        .fontColor(AppColors.onSurface)
        .width('100%')
        .textAlign(TextAlign.Center)
        .padding({ top: AppSpacing.lg, bottom: AppSpacing.lg })
        .backgroundColor(AppColors.background)

      // Main Content Area
      Column({ space: AppSpacing.lg }) {
        // Surface containing the Canvas
        Stack() {
          Canvas(this.onCanvasDraw.bind(this))
            .width('100%')
            .height('100%')
            .padding(AppSpacing.md)
        }
        .width('100%')
        .height(400)
        .backgroundColor(Color.White)
        .borderRadius(AppShapes.large)
        .opacity(0.9)
        .shadow({
          radius: 8,
          color: 'rgba(0, 0, 0, 0.18)',
          offsetX: 0,
          offsetY: 4
        })

        // Scanning Active Row
        Row() {
          Text('Scanning Active')
            .fontSize(18)
            .fontWeight(FontWeight.Medium)
            .fontColor(AppColors.onSurface)

          Blank()

          // Custom Toggle
          Stack() {
            Row() {
            }
            .width(50)
            .height(30)
            .borderRadius(15)
            .backgroundColor(this.scanning ? AppColors.secondary : AppColors.surfaceVariant)

            Row() {
            }
            .width(26)
            .height(26)
            .borderRadius(13)
            .backgroundColor(this.scanning ? AppColors.secondary : AppColors.outline)
            .margin({ left: this.scanning ? 22 : 2 })
          }
          .width(50)
          .height(30)
          .onClick(() => {
            this.scanning = !this.scanning
          })
        }
        .width('100%')

        // Add Marker Button
        Button('Add Marker')
          .width('100%')
          .height(48)
          .fontSize(18)
          .fontWeight(FontWeight.Medium)
          .fontColor(AppColors.onPrimary)
          .backgroundColor(AppColors.primary)
          .borderRadius(AppShapes.medium)
          .onClick(() => {
            if (this.scanning) {
              const newMarker: Marker = {
                id: Date.now().toString(),
                x: 80 + Math.random() * 500,
                y: 150 + Math.random() * 500,
                label: `N${this.markers.length + 1}`
              }
              this.markers.push(newMarker)
            }
          })
      }
      .padding(AppSpacing.lg)
      .width('100%')
      .height('100%')
      .linearGradient({
        direction: GradientDirection.Bottom,
        colors: [
          [AppColors.secondary, 0.0],
          [AppColors.background, 0.5],
          [AppColors.primary, 1.0]
        ]
      })
      .opacity(0.7)
    }
    .width('100%')
    .height('100%')
  }

  onCanvasDraw(canvas: CanvasRenderingContext2D) {
    const width = canvas.width
    const height = canvas.height
    const centerX = width / 2
    const centerY = height / 2
    const radius = Math.min(width, height) / 2.5

    // Draw inner circle (surfaceVariant)
    canvas.beginPath()
    canvas.arc(centerX, centerY, radius, 0, Math.PI * 2)
    canvas.fillStyle = AppColors.surfaceVariant
    canvas.fill()

    // Draw markers
    for (const marker of this.markers) {
      canvas.beginPath()
      canvas.arc(marker.x, marker.y, 12, 0, Math.PI * 2)
      canvas.fillStyle = AppColors.primary
      canvas.fill()
    }
  }
}
