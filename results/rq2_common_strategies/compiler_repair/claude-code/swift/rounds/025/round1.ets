import prompt from '@ohos.promptAction'

class AppColors {
  static readonly primary: string = '#FF00FFFF'
  static readonly secondary: string = '#FF00FF88'
  static readonly tertiary: string = '#FFBB86FC'
  static readonly background: string = '#FF0D0D0D'
  static readonly surface: string = '#FF1C1C1C'
  static readonly surfaceVariant: string = '#FF2E2E2E'
  static readonly outline: string = '#FF3F3F3F'
  static readonly success: string = '#FF00FFAA'
  static readonly warning: string = '#FFFFC107'
  static readonly error: string = '#FFFF1744'
  static readonly onPrimary: string = '#FF000000'
  static readonly onSecondary: string = '#FF000000'
  static readonly onTertiary: string = '#FF000000'
  static readonly onBackground: string = '#FFFFFFFF'
  static readonly onSurface: string = '#FFFFFFFF'
}

class FontSpec {
  size: number
  weight: FontWeight

  constructor(size: number, weight: FontWeight) {
    this.size = size
    this.weight = weight
  }
}

class AppTypographyTokens {
  static readonly display: FontSpec = new FontSpec(28, FontWeight.Bold)
  static readonly title: FontSpec = new FontSpec(18, FontWeight.Medium)
  static readonly body: FontSpec = new FontSpec(14, FontWeight.Normal)
  static readonly label: FontSpec = new FontSpec(12, FontWeight.Medium)
}

class AppSpacing {
  static readonly sm: number = 8
  static readonly md: number = 12
  static readonly lg: number = 16
  static readonly xl: number = 24
}

class ShadowSpec {
  elevation: number
  radius: number
  dy: number
  opacity: number

  constructor(elevation: number, radius: number, dy: number, opacity: number) {
    this.elevation = elevation
    this.radius = radius
    this.dy = dy
    this.opacity = opacity
  }
}

class AppElevationMapping {
  static readonly level1: ShadowSpec = new ShadowSpec(2, 4, 2, 0.12)
  static readonly level2: ShadowSpec = new ShadowSpec(6, 8, 4, 0.18)
}

interface NodePoint {
  x: number
  y: number
}

@Entry
@Component
struct RootScreen {
  @State nodes: NodePoint[] = [
    { x: 200, y: 400 },
    { x: 500, y: 700 },
    { x: 350, y: 250 }
  ]
  @State currentColor: string = AppColors.primary

  private onTouch(event: TouchEvent): void {
    if (event.type === TouchType.Down || event.type === TouchType.Move) {
      const touch: TouchObject = event.touches[0]
      this.nodes.push({ x: touch.x, y: touch.y })
    }
  }

  private addRandomNode(): void {
    const randomX: number = 100 + Math.random() * 500
    const randomY: number = 200 + Math.random() * 600
    this.nodes.push({ x: randomX, y: randomY })
  }

  build() {
    Stack() {
      Canvas(this.drawNodeCanvas.bind(this))
        .width('100%')
        .height('100%')
        .onTouch((event: TouchEvent) => {
          this.onTouch(event)
        })

      Column() {
        Text('Neon Mind Map')
          .fontSize(AppTypographyTokens.display.size)
          .fontWeight(AppTypographyTokens.display.weight)
          .fontColor(AppColors.primary)
          .padding({ top: AppSpacing.lg, bottom: AppSpacing.lg })
          .width('100%')
          .backgroundColor(AppColors.background)
        Spacer()
      }
      .width('100%')
      .height('100%')

      Column() {
        Spacer()
        Row() {
          Button('Cyan')
            .fontSize(AppTypographyTokens.body.size)
            .fontColor(AppColors.onPrimary)
            .backgroundColor(AppColors.primary)
            .borderRadius(15)
            .padding({
              left: AppSpacing.lg,
              right: AppSpacing.lg,
              top: AppSpacing.sm,
              bottom: AppSpacing.sm
            })
            .onClick(() => {
              this.currentColor = AppColors.primary
            })

          Button('Green')
            .fontSize(AppTypographyTokens.body.size)
            .fontColor(AppColors.onSecondary)
            .backgroundColor(AppColors.secondary)
            .borderRadius(15)
            .padding({
              left: AppSpacing.lg,
              right: AppSpacing.lg,
              top: AppSpacing.sm,
              bottom: AppSpacing.sm
            })
            .onClick(() => {
              this.currentColor = AppColors.secondary
            })

          Button('Purple')
            .fontSize(AppTypographyTokens.body.size)
            .fontColor(AppColors.onTertiary)
            .backgroundColor(AppColors.tertiary)
            .borderRadius(15)
            .padding({
              left: AppSpacing.lg,
              right: AppSpacing.lg,
              top: AppSpacing.sm,
              bottom: AppSpacing.sm
            })
            .onClick(() => {
              this.currentColor = AppColors.tertiary
            })
        }
        .justifyContent(FlexAlign.Center)
        .space(AppSpacing.md)
        .padding(AppSpacing.md)
        .width('100%')
        .backgroundColor(AppColors.surfaceVariant)
      }
      .width('100%')
      .height('100%')

      Column() {
        Spacer()
        Row() {
          Spacer()
          Button('+')
            .fontSize(AppTypographyTokens.title.size)
            .fontWeight(AppTypographyTokens.title.weight)
            .fontColor(AppColors.onSecondary)
            .width(56)
            .height(56)
            .backgroundColor(AppColors.secondary)
            .borderRadius(28)
            .shadow({
              radius: AppElevationMapping.level2.radius,
              color: 'rgba(0,0,0,' + AppElevationMapping.level2.opacity + ')',
              offsetX: 0,
              offsetY: AppElevationMapping.level2.dy
            })
            .onClick(() => {
              this.addRandomNode()
            })
            .margin(AppSpacing.lg)
        }
        .width('100%')
      }
      .width('100%')
      .height('100%')
    }
    .width('100%')
    .height('100%')
    .backgroundColor(AppColors.background)
  }

  private drawNodeCanvas(canvas: CanvasRenderingContext2D): void {
    canvas.strokeStyle = this.currentColor
    canvas.lineWidth = 6
    canvas.beginPath()
    if (this.nodes.length > 0) {
      canvas.moveTo(this.nodes[0].x, this.nodes[0].y)
      for (let i: number = 1; i < this.nodes.length; i++) {
        canvas.lineTo(this.nodes[i].x, this.nodes[i].y)
      }
    }
    canvas.stroke()

    canvas.fillStyle = this.currentColor
    for (let i: number = 0; i < this.nodes.length; i++) {
      const node: NodePoint = this.nodes[i]
      canvas.beginPath()
      canvas.arc(node.x, node.y, 20, 0, Math.PI * 2)
      canvas.fill()
    }
  }
}
