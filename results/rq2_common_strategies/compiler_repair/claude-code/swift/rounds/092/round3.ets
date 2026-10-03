import prompt from '@ohos.promptAction'

// MARK: - Color Palette (Custom Muted Earth Tones)
namespace ZenColors {
  export const zenGreen: string = '#6A8E6A'
  export const zenGreenLight: string = '#E8F5E9'
  export const zenBrown: string = '#8D6E63'
  export const zenTextPrimary: string = '#2C3E50'
  export const zenTextSecondary: string = '#7F8C8D'
  export const zenWhite: string = '#FFFFFF'
  export const zenAccent: string = '#D4E157'
  export const statusItemBg: string = '#F7F9F9'
  export const statusItemBorder: string = '#ECEFF1'
  export const careLogBg: string = '#FAFAFA'
  export const careLogBorder: string = '#F0F0F0'
  export const careLogSubtitle: string = '#9E9E9E'
  export const navIconInactive: string = '#CFD8DC'
  export const bottomBarDivider: string = '#F5F5F5'
  export const lightGrayCircle: string = '#E0E0E0'
  export const trunkColor: string = '#5D4037'
  export const healthRed: string = '#E57373'
  export const waterBlue: string = '#64B5F6'
}

// MARK: - Typography
class FontStyle {
  size: number = 0
  weight: number = 0
  constructor(size: number, weight: number) {
    this.size = size
    this.weight = weight
  }
}

namespace AppTypography {
  export const labelMedium: FontStyle = new FontStyle(12, 500)
  export const displaySmallLight: FontStyle = new FontStyle(36, 300)
  export const titleMediumBold: FontStyle = new FontStyle(16, 700)
  export const titleMediumSemiBold: FontStyle = new FontStyle(16, 600)
  export const labelSmall: FontStyle = new FontStyle(11, 400)
  export const bodyMedium: FontStyle = new FontStyle(14, 400)
}

// MARK: - Status Item
@Component
struct StatusItem {
  icon: string = ''
  label: string = ''
  value: string = ''
  tint: string = ''

  build() {
    Column() {
      Stack() {
        Circle()
          .width(50)
          .height(50)
          .fill(ZenColors.statusItemBg)
        Circle()
          .width(50)
          .height(50)
          .fill('transparent')
          .stroke(ZenColors.statusItemBorder)
          .strokeWidth(1)
        Text(this.icon)
          .fontSize(24)
          .fontColor(this.tint)
      }
      .width(50)
      .height(50)

      Blank().height(8)

      Text(this.value)
        .fontSize(AppTypography.titleMediumBold.size)
        .fontWeight(AppTypography.titleMediumBold.weight)
        .fontColor(ZenColors.zenTextPrimary)

      Text(this.label)
        .fontSize(AppTypography.labelSmall.size)
        .fontWeight(AppTypography.labelSmall.weight)
        .fontColor(ZenColors.zenTextSecondary)
    }
    .alignItems(HorizontalAlign.Center)
  }
}

// MARK: - Status Row
@Component
struct StatusRow {
  build() {
    Row() {
      Blank()
      StatusItem({ icon: '♥', label: 'Health', value: '98%', tint: ZenColors.healthRed })
      Blank()
      StatusItem({ icon: '📅', label: 'Age', value: '4 Yrs', tint: ZenColors.zenBrown })
      Blank()
      StatusItem({ icon: '💧', label: 'Water', value: '2 Days', tint: ZenColors.waterBlue })
      Blank()
    }
    .width('100%')
    .alignItems(VerticalAlign.Center)
  }
}

// MARK: - Header Section
@Component
struct HeaderSection {
  build() {
    Column() {
      Text('JUNIPER · #04')
        .fontSize(AppTypography.labelMedium.size)
        .fontWeight(AppTypography.labelMedium.weight)
        .fontColor(ZenColors.zenTextSecondary)
        .letterSpacing(2)

      Blank().height(8)

      Text('Zen Garden')
        .fontSize(AppTypography.displaySmallLight.size)
        .fontWeight(AppTypography.displaySmallLight.weight)
        .fontColor(ZenColors.zenTextPrimary)
    }
    .alignItems(HorizontalAlign.Center)
  }
}

// MARK: - Care Log Item
@Component
struct CareLogItem {
  title: string = ''
  subtitle: string = ''
  isDone: boolean = false

  build() {
    Row() {
      Circle()
        .width(12)
        .height(12)
        .fill(this.isDone ? ZenColors.zenGreen : ZenColors.lightGrayCircle)

      Blank().width(16)

      Column() {
        Text(this.title)
          .fontSize(AppTypography.bodyMedium.size)
          .fontWeight(AppTypography.bodyMedium.weight)
          .fontColor(this.isDone ? ZenColors.zenTextPrimary : ZenColors.zenTextSecondary)

        Text(this.subtitle)
          .fontSize(AppTypography.labelSmall.size)
          .fontWeight(AppTypography.labelSmall.weight)
          .fontColor(ZenColors.careLogSubtitle)
      }
      .alignItems(HorizontalAlign.Start)
      .layoutWeight(1)

      if (this.isDone) {
        Text('✓')
          .fontSize(20)
          .fontColor(ZenColors.zenGreen)
          .fontWeight(FontWeight.Bold)
      }
    }
    .width('100%')
    .padding(16)
    .backgroundColor(ZenColors.careLogBg)
    .borderRadius(12)
    .border({ width: 1, color: ZenColors.careLogBorder, radius: 12 })
    .alignItems(VerticalAlign.Center)
  }
}

// MARK: - Activity Log Section
@Component
struct ActivityLogSection {
  build() {
    Column() {
      Row() {
        Text('Care Schedule')
          .fontSize(AppTypography.titleMediumSemiBold.size)
          .fontWeight(AppTypography.titleMediumSemiBold.weight)
          .fontColor(ZenColors.zenTextPrimary)

        Blank()

        Text('+')
          .fontSize(20)
          .fontColor(ZenColors.zenGreen)
          .fontWeight(FontWeight.Bold)
          .padding(4)
          .width(28)
          .height(28)
          .textAlign(TextAlign.Center)
          .backgroundColor(ZenColors.zenGreenLight)
          .borderRadius(14)
          .onClick(() => {
            prompt.showToast({ message: 'Add care log' })
          })
      }
      .width('100%')
      .alignItems(VerticalAlign.Center)

      Blank().height(16)

      CareLogItem({ title: 'Watering', subtitle: 'Today, 8:00 AM', isDone: true })
      Blank().height(12)
      CareLogItem({ title: 'Pruning', subtitle: 'Tomorrow', isDone: false })
      Blank().height(12)
      CareLogItem({ title: 'Fertilizer', subtitle: 'In 5 days', isDone: false })
    }
    .width('100%')
    .alignItems(HorizontalAlign.Start)
  }
}

// MARK: - Nav Icon
@Component
struct NavIcon {
  icon: string = ''
  isSelected: boolean = false

  build() {
    Column() {
      Text(this.icon)
        .fontSize(28)
        .fontColor(this.isSelected ? ZenColors.zenGreen : ZenColors.navIconInactive)

      if (this.isSelected) {
        Blank().height(4)
        Circle()
          .width(4)
          .height(4)
          .fill(ZenColors.zenGreen)
      }
    }
    .alignItems(HorizontalAlign.Center)
    .layoutWeight(1)
  }
}

// MARK: - Simple Bottom Nav
@Component
struct SimpleBottomNav {
  build() {
    Column() {
      Divider()
        .color(ZenColors.bottomBarDivider)
        .strokeWidth(1)

      Row() {
        NavIcon({ icon: '⌂', isSelected: true })
        NavIcon({ icon: 'ⓘ', isSelected: false })
        NavIcon({ icon: '⚙', isSelected: false })
      }
      .width('100%')
      .height(80)
      .backgroundColor(ZenColors.zenWhite)
      .alignItems(VerticalAlign.Center)
    }
    .width('100%')
  }
}

// MARK: - Bonsai Visual (Custom Canvas Drawing)
@Component
struct BonsaiVisual {
  private settings: RenderingContextSettings = new RenderingContextSettings(true)
  private context: CanvasRenderingContext2D = new CanvasRenderingContext2D(this.settings)

  aboutToAppear(): void {
  }

  onReady(): void {
    this.drawBonsai()
  }

  drawBonsai(): void {
    const w: number = 220
    const h: number = 220

    const ctx: CanvasRenderingContext2D = this.context
    ctx.clearRect(0, 0, w, h)

    // 1. Draw pot
    const potWidth: number = w * 0.5
    const potHeight: number = h * 0.15
    const potTop: number = h * 0.85

    // Pot body
    ctx.fillStyle = ZenColors.zenBrown
    ctx.fillRect((w - potWidth) / 2, potTop, potWidth, potHeight)

    // Pot rim
    ctx.globalAlpha = 0.8
    ctx.fillRect((w - potWidth) / 2 - 10, potTop, potWidth + 20, 15)
    ctx.globalAlpha = 1.0

    // 2. Draw trunk (bezier curves)
    ctx.strokeStyle = ZenColors.trunkColor
    ctx.lineWidth = 25
    ctx.lineCap = 'round'
    ctx.beginPath()
    ctx.moveTo(w * 0.5, potTop)
    ctx.quadraticCurveTo(w * 0.45, h * 0.6, w * 0.35, h * 0.5)
    ctx.quadraticCurveTo(w * 0.4, h * 0.35, w * 0.6, h * 0.3)
    ctx.stroke()

    // Secondary branch
    ctx.lineWidth = 15
    ctx.beginPath()
    ctx.moveTo(w * 0.38, h * 0.55)
    ctx.lineTo(w * 0.25, h * 0.45)
    ctx.stroke()

    // 3. Draw leaf clusters
    // Leaf cluster 1 (top right)
    this.drawLeafCluster(w * 0.6, h * 0.25, 45, ZenColors.zenGreen)
    this.drawLeafCluster(w * 0.68, h * 0.28, 35, this.hexWithAlpha(ZenColors.zenGreen, 0.8))
    this.drawLeafCluster(w * 0.55, h * 0.22, 30, this.hexWithAlpha(ZenColors.zenGreen, 0.9))

    // Leaf cluster 2 (middle left)
    this.drawLeafCluster(w * 0.35, h * 0.5, 35, ZenColors.zenGreen)
    this.drawLeafCluster(w * 0.30, h * 0.45, 25, this.hexWithAlpha(ZenColors.zenGreen, 0.8))

    // Leaf cluster 3 (far left branch)
    this.drawLeafCluster(w * 0.22, h * 0.42, 25, ZenColors.zenGreen)
  }

  drawLeafCluster(cx: number, cy: number, r: number, color: string): void {
    const ctx: CanvasRenderingContext2D = this.context
    ctx.fillStyle = color
    ctx.beginPath()
    ctx.ellipse(cx, cy, r, r, 0, 0, Math.PI * 2)
    ctx.fill()
  }

  hexWithAlpha(hex: string, alpha: number): string {
    const r: number = parseInt(hex.slice(1, 3), 16)
    const g: number = parseInt(hex.slice(3, 5), 16)
    const b: number = parseInt(hex.slice(5, 7), 16)
    return `rgba(${r}, ${g}, ${b}, ${alpha})`
  }

  build() {
    Canvas(this.context)
      .width(220)
      .height(220)
      .onReady(() => {
        this.drawBonsai()
      })
  }
}

// MARK: - ZenBonsaiAppView (Main Content View)
@Component
struct ZenBonsaiAppView {
  build() {
    Stack({ alignContent: Alignment.Bottom }) {
      Scroll() {
        Column() {
          HeaderSection()
            .margin({ top: 24 })

          Blank().height(32)

          BonsaiVisual()
            .width(220)
            .height(220)

          Blank().height(32)

          StatusRow()

          Blank().height(32)

          ActivityLogSection()
            .margin({ bottom: 24 })
        }
        .width('100%')
        .padding({ left: 24, right: 24 })
        .backgroundColor(ZenColors.zenWhite)
        .margin({ bottom: 80 })
      }
      .width('100%')
      .height('100%')
      .backgroundColor(ZenColors.zenWhite)
      .scrollBar(BarState.Off)

      SimpleBottomNav()
        .backgroundColor(ZenColors.zenWhite)
    }
    .width('100%')
    .height('100%')
    .backgroundColor(ZenColors.zenWhite)
  }
}

// MARK: - Main Entry
@Entry
@Component
struct ZenBonsaiApp {
  build() {
    Column() {
      ZenBonsaiAppView()
    }
    .width('100%')
    .height('100%')
  }
}
