import { LengthMetrics } from '@kit.ArkUI'

// ── Design Tokens ──────────────────────────────────────────────────────────────
namespace AppTokens {
  export namespace Colors {
    export const primary = '#7B61FF'
    export const secondary = '#26C6DA'
    export const tertiary = '#FF8A80'
    export const background = '#F5F7FF'
    export const surface = '#FFFFFF'
    export const surfaceVariant = '#F0F2F8'
    export const outline = '#E0E3EB'
    export const success = '#22C55E'
    export const warning = '#F59E0B'
    export const error = '#EF4444'
    export const onPrimary = '#FFFFFF'
    export const onSecondary = '#0B1220'
    export const onTertiary = '#0B1220'
    export const onBackground = '#0B1220'
    export const onSurface = '#0B1220'
  }

  export namespace Spacing {
    export const xs = 4
    export const sm = 8
    export const md = 12
    export const lg = 16
    export const xl = 24
    export const xxl = 32
  }

  export namespace Radius {
    export const small = 8
    export const medium = 14
    export const large = 20
  }
}

// ── Data Models ────────────────────────────────────────────────────────────────
interface Coupon {
  id: number
  title: string
  value: string
  colorA: string
  colorB: string
}

interface MapPin {
  x: number
  y: number
  label: string
  tint: string
}

// ── Coupon Card ────────────────────────────────────────────────────────────────
@Component
struct CouponCard {
  coupon: Coupon = { id: 0, title: '', value: '', colorA: '', colorB: '' }

  build() {
    Column({ space: AppTokens.Spacing.sm }) {
      Row({ space: AppTokens.Spacing.sm }) {
        Circle({ width: 14, height: 14 })
          .fill(AppTokens.Colors.primary)
        Text(this.coupon.title)
          .fontSize(16)
          .fontWeight(FontWeight.Medium)
          .fontColor(AppTokens.Colors.onSurface)
      }
      .alignItems(VerticalAlign.Center)

      Text(this.coupon.value)
        .fontSize(28)
        .fontWeight(FontWeight.Bold)
        .fontColor(AppTokens.Colors.onSurface)

      Button('Redeem')
        .width('100%')
        .height(40)
        .backgroundColor(AppTokens.Colors.primary)
        .fontColor(AppTokens.Colors.onPrimary)
        .fontSize(12)
        .fontWeight(FontWeight.Medium)
        .borderRadius(AppTokens.Radius.medium)
    }
    .alignItems(HorizontalAlign.Start)
    .width(200)
    .height(140)
    .padding(AppTokens.Spacing.lg)
    .linearGradient({
      angle: 90,
      colors: [
        [this.coupon.colorA + '2E', 0.0],
        [this.coupon.colorB + '2E', 1.0]
      ]
    })
    .borderRadius(AppTokens.Radius.large)
    .backgroundColor(AppTokens.Colors.surface)
    .shadow({ radius: 10, color: '#29000000', offsetY: 6 })
  }
}

// ── Map View ───────────────────────────────────────────────────────────────────
@Component
struct MapView {
  pins: MapPin[] = []

  build() {
    Stack({ alignContent: Alignment.TopEnd }) {
      // Map background with pins drawn via Canvas
      Canvas(new RenderingContextSettings(true))
        .width('100%')
        .height('100%')
        .onReady((context: CanvasRenderingContext2D) => {
          // Background
          context.fillStyle = AppTokens.Colors.surfaceVariant
          context.fillRect(0, 0, context.width, context.height)
          // Draw pins
          this.pins.forEach((pin: MapPin) => {
            context.beginPath()
            context.arc(pin.x, pin.y, 14, 0, Math.PI * 2)
            context.fillStyle = pin.tint
            context.fill()
            context.closePath()
          })
        })

      // Legend overlay
      Row({ space: AppTokens.Spacing.sm }) {
        Circle({ width: 10, height: 10 }).fill(AppTokens.Colors.primary)
        Text('A')
          .fontSize(12)
          .fontWeight(FontWeight.Medium)
          .fontColor(AppTokens.Colors.onSurface)
        Circle({ width: 10, height: 10 }).fill(AppTokens.Colors.secondary)
        Text('B')
          .fontSize(12)
          .fontWeight(FontWeight.Medium)
          .fontColor(AppTokens.Colors.onSurface)
        Circle({ width: 10, height: 10 }).fill(AppTokens.Colors.tertiary)
        Text('C')
          .fontSize(12)
          .fontWeight(FontWeight.Medium)
          .fontColor(AppTokens.Colors.onSurface)
      }
      .alignItems(VerticalAlign.Center)
      .padding({ left: AppTokens.Spacing.md, right: AppTokens.Spacing.md, top: AppTokens.Spacing.xs, bottom: AppTokens.Spacing.xs })
      .backgroundColor('#E6FFFFFF')
      .borderRadius(AppTokens.Radius.small)
      .margin(AppTokens.Spacing.md)
    }
    .width('100%')
    .aspectRatio(16 / 9)
    .borderRadius(AppTokens.Radius.large)
    .backgroundColor(AppTokens.Colors.surface)
    .clip(true)
  }
}

// ── Root Screen ────────────────────────────────────────────────────────────────
@Component
struct RootScreen {
  private coupons: Coupon[] = [
    { id: 1, title: 'Grocery Pack', value: '-$5', colorA: AppTokens.Colors.primary, colorB: AppTokens.Colors.secondary },
    { id: 2, title: 'Cafe Bundle', value: '-15%', colorA: AppTokens.Colors.secondary, colorB: AppTokens.Colors.tertiary },
    { id: 3, title: 'Electro Deal', value: '-$20', colorA: AppTokens.Colors.tertiary, colorB: AppTokens.Colors.primary },
    { id: 4, title: 'Fashion Duo', value: '-10%', colorA: AppTokens.Colors.secondary, colorB: AppTokens.Colors.primary }
  ]

  private pins: MapPin[] = [
    { x: 140, y: 220, label: 'A', tint: AppTokens.Colors.primary },
    { x: 320, y: 400, label: 'B', tint: AppTokens.Colors.secondary },
    { x: 520, y: 300, label: 'C', tint: AppTokens.Colors.tertiary }
  ]

  build() {
    Column() {
      // ── Top App Bar ──────────────────────────────────────────────────────────
      Row() {
        Circle({ width: 20, height: 20 })
          .fill(AppTokens.Colors.onSurface)

        Text('Coupon Pack')
          .fontSize(28)
          .fontWeight(FontWeight.Bold)
          .fontColor(AppTokens.Colors.onSurface)
          .layoutWeight(1)
          .textAlign(TextAlign.Center)

        Circle({ width: 20, height: 20 })
          .fill(AppTokens.Colors.primary)
      }
      .width('100%')
      .height(56)
      .padding({ left: AppTokens.Spacing.lg, right: AppTokens.Spacing.lg })
      .alignItems(VerticalAlign.Center)
      .backgroundColor(AppTokens.Colors.surface)

      // ── Scrollable Body ──────────────────────────────────────────────────────
      Scroll() {
        Column({ space: AppTokens.Spacing.lg }) {
          // Section: Nearby Packs
          Text('Nearby Packs')
            .fontSize(20)
            .fontWeight(FontWeight.Bold)
            .fontColor(AppTokens.Colors.onSurface)

          MapView({ pins: this.pins })

          // Section: Coupon Packs
          Text('Your Coupon Packs')
            .fontSize(20)
            .fontWeight(FontWeight.Bold)
            .fontColor(AppTokens.Colors.onSurface)

          // Horizontal coupon list
          Scroll() {
            Row({ space: AppTokens.Spacing.lg }) {
              ForEach(this.coupons, (coupon: Coupon) => {
                CouponCard({ coupon: coupon })
              }, (coupon: Coupon) => coupon.id.toString())
            }
            .padding({ left: AppTokens.Spacing.xs, right: AppTokens.Spacing.xs })
          }
          .scrollable(ScrollDirection.Horizontal)
          .scrollBar(BarState.Off)
          .width('100%')

          Blank().height(AppTokens.Spacing.sm)

          // ── Action Buttons ─────────────────────────────────────────────────
          Row({ space: AppTokens.Spacing.md }) {
            Button('My Coupons')
              .layoutWeight(1)
              .height(52)
              .backgroundColor(AppTokens.Colors.secondary)
              .fontColor(AppTokens.Colors.onSecondary)
              .fontSize(16)
              .fontWeight(FontWeight.Medium)
              .borderRadius(AppTokens.Radius.large)

            Button('Explore More')
              .layoutWeight(1)
              .height(52)
              .backgroundColor(AppTokens.Colors.primary)
              .fontColor(AppTokens.Colors.onPrimary)
              .fontSize(16)
              .fontWeight(FontWeight.Medium)
              .borderRadius(AppTokens.Radius.large)
          }
          .width('100%')
          .alignItems(VerticalAlign.Center)
        }
        .padding(AppTokens.Spacing.lg)
        .width('100%')
      }
      .layoutWeight(1)
      .scrollBar(BarState.Off)
      .linearGradient({
        angle: 180,
        colors: [
          ['#4026C6DA', 0.0],
          [AppTokens.Colors.background, 0.5],
          ['#407B61FF', 1.0]
        ]
      })
    }
    .width('100%')
    .height('100%')
    .backgroundColor(AppTokens.Colors.background)
  }
}

// ── Entry Point ────────────────────────────────────────────────────────────────
@Entry
@Component
struct Index {
  build() {
    RootScreen()
  }
}