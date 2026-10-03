import { LengthMetrics } from '@kit.ArkUI'

// ── Token definitions ──────────────────────────────────────────────────────────
namespace AppTokens {
  export namespace Colors {
    export const primary = '#FF111111'
    export const secondary = '#FF2A2A2A'
    export const tertiary = '#FF474747'
    export const background = '#FFF6F6F6'
    export const surface = '#FFFFFFFF'
    export const surfaceVariant = '#FFEDEDED'
    export const outline = '#FFD1D1D1'
    export const success = '#FF2E7D32'
    export const warning = '#FFB98900'
    export const error = '#FFB3261E'
    export const onPrimary = '#FFFFFFFF'
    export const onSecondary = '#FFFFFFFF'
    export const onTertiary = '#FFFFFFFF'
    export const onBackground = '#FF0A0A0A'
    export const onSurface = '#FF0A0A0A'
  }

  export namespace Typography {
    export const display: TextStyle = { fontSize: 28, fontWeight: FontWeight.Medium }
    export const headline: TextStyle = { fontSize: 20, fontWeight: FontWeight.Medium }
    export const title: TextStyle = { fontSize: 16, fontWeight: FontWeight.Medium }
    export const body: TextStyle = { fontSize: 14, fontWeight: FontWeight.Normal }
    export const label: TextStyle = { fontSize: 12, fontWeight: FontWeight.Medium }
  }

  export namespace Radius {
    export const small = 8
    export const medium = 12
    export const large = 16
  }

  export namespace Spacing {
    export const xs = 4
    export const sm = 8
    export const md = 12
    export const lg = 16
    export const xl = 24
    export const xxl = 32
    export const xxxl = 48
  }
}

interface TextStyle {
  fontSize: number
  fontWeight: FontWeight
}

// ── Data model ─────────────────────────────────────────────────────────────────
interface AssetMarker {
  id: number
  name: string
  type: string
  x: number
  y: number
}

const MARKERS: AssetMarker[] = [
  { id: 1, name: 'Main Warehouse', type: 'Warehouse', x: 0.18, y: 0.34 },
  { id: 2, name: 'CNC-07', type: 'Device', x: 0.52, y: 0.46 },
  { id: 3, name: 'HQ Office', type: 'Office', x: 0.75, y: 0.62 },
  { id: 4, name: 'Spare Parts', type: 'Warehouse', x: 0.33, y: 0.78 },
]

const ALL_CATEGORIES: string[] = ['Warehouse', 'Device', 'Office']

// ── Map grid overlay ───────────────────────────────────────────────────────────
@Component
struct MapGridOverlay {
  build() {
    Stack() {
      // Horizontal lines
      Column() {
        ForEach([0, 1, 2, 3, 4, 5], () => {
          Divider()
            .color(AppTokens.Colors.surfaceVariant)
            .strokeWidth(1)
        }, (item: number) => item.toString())
      }
      .width('100%')
      .height('100%')
      .padding(AppTokens.Spacing.lg)
      .justifyContent(FlexAlign.SpaceEvenly)

      // Vertical lines
      Row() {
        ForEach([0, 1, 2, 3, 4, 5], () => {
          Divider()
            .vertical(true)
            .color(AppTokens.Colors.surfaceVariant)
            .strokeWidth(1)
            .height('100%')
        }, (item: number) => item.toString())
      }
      .width('100%')
      .height('100%')
      .padding(AppTokens.Spacing.lg)
      .justifyContent(FlexAlign.SpaceEvenly)
    }
    .width('100%')
    .height('100%')
  }
}

// ── Map marker ─────────────────────────────────────────────────────────────────
@Component
struct MapMarker {
  @Prop markerType: string = ''
  @Prop selected: boolean = false
  onClick: () => void = () => {}
  offsetX: number = 0
  offsetY: number = 0

  markerColor(): string {
    if (this.markerType === 'Warehouse') return AppTokens.Colors.tertiary
    if (this.markerType === 'Device') return AppTokens.Colors.secondary
    return AppTokens.Colors.primary
  }

  build() {
    Stack() {
      // Dot
      Circle()
        .width(this.selected ? 28 : 22)
        .height(this.selected ? 28 : 22)
        .fill(this.markerColor())
        .stroke(this.selected ? AppTokens.Colors.primary : AppTokens.Colors.surface)
        .strokeWidth(2)
        .position({ x: this.offsetX, y: this.offsetY })

      // Label chip
      Text(this.markerType)
        .fontSize(AppTokens.Typography.label.fontSize)
        .fontWeight(AppTokens.Typography.label.fontWeight)
        .fontColor(AppTokens.Colors.onSurface)
        .padding({ left: AppTokens.Spacing.sm, right: AppTokens.Spacing.sm, top: AppTokens.Spacing.xs, bottom: AppTokens.Spacing.xs })
        .backgroundColor(AppTokens.Colors.surface)
        .borderRadius(AppTokens.Radius.small)
        .border({ width: 1, color: AppTokens.Colors.outline })
        .shadow({ radius: 4, color: '#1A000000', offsetY: 2 })
        .position({ x: this.offsetX + 18, y: this.offsetY - 4 })
        .onClick(() => this.onClick())
    }
    .width('100%')
    .height('100%')
  }
}

// ── Root screen ────────────────────────────────────────────────────────────────
@Entry
@Component
struct RootScreen {
  @State enabledCats: string[] = ['Warehouse', 'Device', 'Office']
  @State assetName: string = ''
  @State assetCode: string = ''
  @State assetType: string = 'Device'
  @State selectedId: number | null = null
  @State mapWidth: number = 0
  @State mapHeight: number = 0

  selectedMarkerName(): string {
    if (this.selectedId === null) return 'None'
    const m = MARKERS.find(m => m.id === this.selectedId)
    return m ? m.name : 'None'
  }

  toggleCat(c: string) {
    const idx = this.enabledCats.indexOf(c)
    if (idx >= 0) {
      const next = [...this.enabledCats]
      next.splice(idx, 1)
      this.enabledCats = next
    } else {
      this.enabledCats = [...this.enabledCats, c]
    }
  }

  build() {
    Column() {
      // ── Top bar ──────────────────────────────────────────────────────────────
      Row() {
        Text('Asset Inventory')
          .fontSize(AppTokens.Typography.display.fontSize)
          .fontWeight(AppTokens.Typography.display.fontWeight)
          .fontColor(AppTokens.Colors.onSurface)
      }
      .width('100%')
      .height(56)
      .justifyContent(FlexAlign.Center)
      .backgroundColor(AppTokens.Colors.surface)

      // ── Scrollable body ──────────────────────────────────────────────────────
      Scroll() {
        Column({ space: AppTokens.Spacing.lg }) {
          // Category filter chips
          Scroll() {
            Row({ space: AppTokens.Spacing.sm }) {
              ForEach(ALL_CATEGORIES, (c: string) => {
                Text(c)
                  .fontSize(this.enabledCats.includes(c)
                    ? AppTokens.Typography.title.fontSize
                    : AppTokens.Typography.body.fontSize)
                  .fontWeight(this.enabledCats.includes(c)
                    ? AppTokens.Typography.title.fontWeight
                    : AppTokens.Typography.body.fontWeight)
                  .fontColor(this.enabledCats.includes(c)
                    ? AppTokens.Colors.onPrimary
                    : AppTokens.Colors.onSurface)
                  .padding({ left: AppTokens.Spacing.md, right: AppTokens.Spacing.md, top: AppTokens.Spacing.sm, bottom: AppTokens.Spacing.sm })
                  .backgroundColor(this.enabledCats.includes(c)
                    ? AppTokens.Colors.primary
                    : AppTokens.Colors.surface)
                  .borderRadius(AppTokens.Radius.small)
                  .border({ width: 1, color: AppTokens.Colors.outline })
                  .onClick(() => this.toggleCat(c))
              }, (c: string) => c)
            }
          }
          .scrollable(ScrollDirection.Horizontal)
          .scrollBar(BarState.Off)
          .width('100%')

          // Main two-column row
          Row({ space: AppTokens.Spacing.lg }) {
            // Left column – form fields + selected card
            Column({ space: AppTokens.Spacing.md }) {
              TextInput({ placeholder: 'Asset Name', text: this.assetName })
                .onChange((v: string) => { this.assetName = v })
                .width('100%')
                .borderRadius(AppTokens.Radius.small)

              TextInput({ placeholder: 'Asset Code', text: this.assetCode })
                .onChange((v: string) => { this.assetCode = v })
                .width('100%')
                .borderRadius(AppTokens.Radius.small)

              TextInput({ placeholder: 'Asset Type', text: this.assetType })
                .onChange((v: string) => { this.assetType = v })
                .width('100%')
                .borderRadius(AppTokens.Radius.small)

              // Selected card
              Column({ space: AppTokens.Spacing.sm }) {
                Text('Selected')
                  .fontSize(AppTokens.Typography.label.fontSize)
                  .fontWeight(AppTokens.Typography.label.fontWeight)
                  .fontColor(AppTokens.Colors.onSurface)

                Text(this.selectedMarkerName())
                  .fontSize(AppTokens.Typography.headline.fontSize)
                  .fontWeight(AppTokens.Typography.headline.fontWeight)
                  .fontColor(AppTokens.Colors.onSurface)
              }
              .width('100%')
              .padding(AppTokens.Spacing.lg)
              .backgroundColor(AppTokens.Colors.surface)
              .borderRadius(AppTokens.Radius.large)
              .border({ width: 1, color: AppTokens.Colors.outline })
              .shadow({ radius: 4, color: '#1A000000', offsetY: 2 })
              .alignItems(HorizontalAlign.Start)
            }
            .layoutWeight(1)
            .alignItems(HorizontalAlign.Start)

            // Right column – map
            Stack() {
              MapGridOverlay()

              ForEach(
                MARKERS.filter(m => this.enabledCats.includes(m.type)),
                (m: AssetMarker) => {
                  MapMarker({
                    markerType: m.type,
                    selected: this.selectedId === m.id,
                    onClick: () => {
                      this.selectedId = this.selectedId === m.id ? null : m.id
                    },
                    offsetX: this.mapWidth * m.x,
                    offsetY: this.mapHeight * m.y,
                  })
                },
                (m: AssetMarker) => m.id.toString()
              )
            }
            .layoutWeight(1)
            .aspectRatio(0.9)
            .constraintSize({ minHeight: 360 })
            .backgroundColor(AppTokens.Colors.surface)
            .borderRadius(AppTokens.Radius.large)
            .border({ width: 1, color: AppTokens.Colors.outline })
            .clip(true)
            .onAreaChange((_old, newArea) => {
              this.mapWidth = newArea.width as number
              this.mapHeight = newArea.height as number
            })
          }
          .width('100%')
          .alignItems(VerticalAlign.Top)
        }
        .padding({ left: AppTokens.Spacing.lg, right: AppTokens.Spacing.lg, top: AppTokens.Spacing.md, bottom: AppTokens.Spacing.md })
        .width('100%')
      }
      .layoutWeight(1)
      .scrollBar(BarState.Off)
      .backgroundColor(AppTokens.Colors.background)

      // ── Bottom bar ───────────────────────────────────────────────────────────
      Row({ space: AppTokens.Spacing.md }) {
        Button('Reset')
          .layoutWeight(1)
          .height(48)
          .fontSize(AppTokens.Typography.title.fontSize)
          .fontWeight(AppTokens.Typography.title.fontWeight)
          .fontColor(AppTokens.Colors.onSurface)
          .backgroundColor(AppTokens.Colors.surfaceVariant)
          .borderRadius(AppTokens.Radius.medium)
          .onClick(() => {
            this.assetName = ''
            this.assetCode = ''
            this.assetType = 'Device'
            this.selectedId = null
          })

        Button('Save Asset')
          .layoutWeight(1)
          .height(48)
          .fontSize(AppTokens.Typography.title.fontSize)
          .fontWeight(AppTokens.Typography.title.fontWeight)
          .fontColor(AppTokens.Colors.onPrimary)
          .backgroundColor(AppTokens.Colors.primary)
          .borderRadius(AppTokens.Radius.medium)
          .onClick(() => {})
      }
      .width('100%')
      .padding({ left: AppTokens.Spacing.lg, right: AppTokens.Spacing.lg, top: AppTokens.Spacing.md, bottom: AppTokens.Spacing.md })
      .backgroundColor(AppTokens.Colors.surface)
      .shadow({ radius: 8, color: '#24000000', offsetY: -2 })
    }
    .width('100%')
    .height('100%')
    .backgroundColor(AppTokens.Colors.background)
  }
}