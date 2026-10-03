// Translated from SwiftUI (018.swift) to ArkTS (HarmonyOS ArkUI).

// MARK: - Color Extension for Hex
// SwiftUI Color.init(hex:alpha:) is translated to helper functions that produce
// an ArkUI color string in #AARRGGBB format.

function toHexByte(value: number): string {
  let s: string = value.toString(16).toUpperCase()
  if (s.length < 2) {
    s = '0' + s
  }
  return s
}

/// Initializes a color string from a hex value (e.g., 0xD7BBA8) and an optional alpha.
function hexColor(hex: number, alpha: number = 1.0): string {
  const r: number = (hex >> 16) & 0xff
  const g: number = (hex >> 8) & 0xff
  const b: number = hex & 0xff
  const a: number = Math.round(alpha * 255)
  return '#' + toHexByte(a) + toHexByte(r) + toHexByte(g) + toHexByte(b)
}

// Equivalent of Color.opacity(_:) applied to an existing #AARRGGBB color string.
function colorOpacity(color: string, alpha: number): string {
  return '#' + toHexByte(Math.round(alpha * 255)) + color.substring(3)
}

// MARK: - AppTokens

class Colors {
  readonly primary: string = hexColor(0xD7BBA8)
  readonly secondary: string = hexColor(0xA2C4C9)
  readonly tertiary: string = hexColor(0xB3C9A2)
  readonly background: string = hexColor(0xF0EBE3)
  readonly surface: string = hexColor(0xFFFFFF)
  readonly surfaceVariant: string = hexColor(0xE6E0D9)
  readonly outline: string = hexColor(0xDCD7CF)
  readonly success: string = hexColor(0x7EA87E)
  readonly warning: string = hexColor(0xD9B872)
  readonly error: string = hexColor(0xD98B8B)
  readonly onPrimary: string = hexColor(0x433E3A)
  readonly onSecondary: string = hexColor(0x433E3A)
  readonly onTertiary: string = hexColor(0x433E3A)
  readonly onBackground: string = hexColor(0x433E3A)
  readonly onSurface: string = hexColor(0x433E3A)
}

// Font.system(size:weight:) mapped to fontSize/fontWeight.
// weight values: 700 = bold, 600 = semibold, 500 = medium, 400 = regular.
class FontSpec {
  size: number
  weight: number
  constructor(size: number, weight: number) {
    this.size = size
    this.weight = weight
  }
}

class TypographyTokens {
  readonly display: FontSpec = new FontSpec(28, 700)
  readonly headline: FontSpec = new FontSpec(22, 600)
  readonly title: FontSpec = new FontSpec(16, 500)
  readonly body: FontSpec = new FontSpec(14, 400)
  readonly label: FontSpec = new FontSpec(12, 500)
}

// RoundedRectangle(cornerRadius:) maps to borderRadius; Circle() maps to a 50% radius.
class Shapes {
  readonly small: number = 8
  readonly medium: number = 16
  readonly large: number = 24
  readonly circle: string = '50%'
}

class Spacing {
  readonly xs: number = 4
  readonly sm: number = 8
  readonly md: number = 12
  readonly lg: number = 16
  readonly xl: number = 24
}

class ShadowSpec {
  elevation: number // Kept for reference, but ArkUI shadow uses radius, x, y directly
  color: string
  offsetX: number
  offsetY: number
  blurRadius: number
  constructor(elevation: number, color: string, offsetX: number, offsetY: number, blurRadius: number) {
    this.elevation = elevation
    this.color = color
    this.offsetX = offsetX
    this.offsetY = offsetY
    this.blurRadius = blurRadius
  }
}

class ElevationMapping {
  readonly level1: ShadowSpec = new ShadowSpec(3, colorOpacity(hexColor(0x000000), 0.05), 4, 4, 8)
  readonly level2: ShadowSpec = new ShadowSpec(6, colorOpacity(hexColor(0x000000), 0.08), 6, 6, 12)
}

// Nested groups from SwiftUI's AppTokens are exposed here for faithful references.
class AppTokens {
  static readonly Colors: Colors = new Colors()
  static readonly TypographyTokens: TypographyTokens = new TypographyTokens()
  static readonly Shapes: Shapes = new Shapes()
  static readonly Spacing: Spacing = new Spacing()
  static readonly ElevationMapping: ElevationMapping = new ElevationMapping()
}

// MARK: - Custom View Modifier for Shadows
// SwiftUI AppShadowModifier / View.appShadow are replaced by ArkUI's .shadow()
// common attribute. The shadow options are applied inline at each call site below.

// MARK: - Data Models
// Note: renamed from "Filter" because ArkUI already declares a global "Filter" type.
class FilterOption {
  id: string
  name: string
  constructor(id: string, name: string) {
    this.id = id
    this.name = name
  }
}

class FilterItem {
  id: number
  name: string
  author: string
  price: string
  color: string
  constructor(id: number, name: string, author: string, price: string, color: string) {
    this.id = id
    this.name = name
    this.author = author
    this.price = price
    this.color = color
  }
}

// MARK: - TopBarSection
@Component
struct TopBarSection {
  @Prop filters: FilterOption[] = []
  @Link selectedFilter: string

  build() {
    Column({ space: AppTokens.Spacing.md }) {
      Text('Filter Shop')
        .fontSize(AppTokens.TypographyTokens.display.size)
        .fontWeight(AppTokens.TypographyTokens.display.weight)
        .fontColor(AppTokens.Colors.onBackground)

      Row({ space: AppTokens.Spacing.sm }) {
        ForEach(this.filters, (filter: FilterOption) => {
          Text(filter.name)
            .fontSize(AppTokens.TypographyTokens.label.size)
            .fontWeight(AppTokens.TypographyTokens.label.weight)
            .letterSpacing(0.5) // Corresponds to letterSpacing
            .fontColor(filter.id === this.selectedFilter ? AppTokens.Colors.onPrimary : AppTokens.Colors.onBackground)
            .padding({
              left: AppTokens.Spacing.md,
              right: AppTokens.Spacing.md,
              top: AppTokens.Spacing.sm,
              bottom: AppTokens.Spacing.sm
            })
            .backgroundColor(filter.id === this.selectedFilter ? AppTokens.Colors.primary : AppTokens.Colors.surface)
            .borderRadius(AppTokens.Shapes.large)
            .border({
              width: 2,
              color: filter.id === this.selectedFilter ? colorOpacity(AppTokens.Colors.onBackground, 0.1) : AppTokens.Colors.outline,
              radius: AppTokens.Shapes.large
            })
            .onClick(() => {
              this.selectedFilter = filter.id
            })
        }, (filter: FilterOption) => filter.id)
      }
    }
    .alignItems(HorizontalAlign.Start)
    .width('100%') // Corresponds to Modifier.fillMaxWidth()
  }
}

// MARK: - FilterCard
@Component
struct FilterCard {
  @Prop item: FilterItem

  build() {
    Column({ space: 0 }) { // Outer Column, content of the Card
      Row() {} // item.color block with 1:1 aspect ratio
        .width('100%')
        .aspectRatio(1)
        .backgroundColor(this.item.color)
        .borderRadius(AppTokens.Shapes.medium)

      Column({ space: AppTokens.Spacing.sm }) { // Inner Column for text content
        Text(this.item.name)
          .fontSize(AppTokens.TypographyTokens.title.size)
          .fontWeight(700)
          .fontColor(AppTokens.Colors.onSurface)

        Text(this.item.author)
          .fontSize(AppTokens.TypographyTokens.label.size)
          .fontWeight(AppTokens.TypographyTokens.label.weight)
          .letterSpacing(0.5) // Corresponds to letterSpacing
          .fontColor(colorOpacity(AppTokens.Colors.onSurface, 0.6))

        Text(this.item.price)
          .fontSize(AppTokens.TypographyTokens.title.size)
          .fontWeight(700)
          .fontColor(AppTokens.Colors.primary)
      }
      .alignItems(HorizontalAlign.Start)
      .padding(AppTokens.Spacing.sm) // Padding for the inner text Column
    }
    .alignItems(HorizontalAlign.Start)
    .padding(AppTokens.Spacing.sm) // Padding for the outer Column, inside the card
    .backgroundColor(AppTokens.Colors.surface)
    .borderRadius(AppTokens.Shapes.large)
    .shadow({
      radius: AppTokens.ElevationMapping.level1.blurRadius,
      color: AppTokens.ElevationMapping.level1.color,
      offsetX: AppTokens.ElevationMapping.level1.offsetX,
      offsetY: AppTokens.ElevationMapping.level1.offsetY
    }) // appShadow(AppTokens.ElevationMapping.level1)
  }
}

// MARK: - BottomBarSection
@Component
struct BottomBarSection {
  build() {
    Row() {
      Text('3 items in cart')
        .fontSize(AppTokens.TypographyTokens.body.size)
        .fontWeight(AppTokens.TypographyTokens.body.weight)
        .lineHeight(20) // Corresponds to lineHeight = 20 for fontSize = 14 (20-14=6)
        .fontColor(AppTokens.Colors.onSurface)

      Blank() // Spacer()

      Button({ type: ButtonType.Normal }) {
        Row({ space: AppTokens.Spacing.sm }) {
          Row() {}
            .width(16)
            .height(16)
            .backgroundColor(colorOpacity(AppTokens.Colors.onPrimary, 0.2))
            .borderRadius(AppTokens.Shapes.circle) // clipShape(Circle())

          Text('Checkout')
            .fontSize(AppTokens.TypographyTokens.title.size)
            .fontWeight(AppTokens.TypographyTokens.title.weight)
            .fontColor(AppTokens.Colors.onPrimary)
        }
        // ButtonDefaults.ContentPadding is typically (horizontal = 24, vertical = 8)
        .padding({
          left: 24,
          right: 24,
          top: 8,
          bottom: 8
        })
      }
      .backgroundColor(AppTokens.Colors.primary)
      .borderRadius(AppTokens.Shapes.large) // Clip shape before applying shadow
      .shadow({
        radius: AppTokens.ElevationMapping.level1.blurRadius,
        color: AppTokens.ElevationMapping.level1.color,
        offsetX: AppTokens.ElevationMapping.level1.offsetX,
        offsetY: AppTokens.ElevationMapping.level1.offsetY
      }) // appShadow(AppTokens.ElevationMapping.level1)
      .onClick(() => {
        // Handle checkout action
        console.log('Checkout tapped')
      })
    }
    .alignItems(VerticalAlign.Center)
    .padding({
      left: AppTokens.Spacing.lg,
      right: AppTokens.Spacing.lg,
      top: AppTokens.Spacing.md,
      bottom: AppTokens.Spacing.md
    })
    .width('100%') // .frame(maxWidth: .infinity)
  }
}

// MARK: - RootScreen
@Component
struct RootScreen {
  @State selectedFilter: string = 'vintage'

  filters: FilterOption[] = [
    new FilterOption('vintage', 'Vintage'),
    new FilterOption('grain', 'Grain'),
    new FilterOption('b&w', 'B&W'),
    new FilterOption('neon', 'Neon')
  ]

  items: FilterItem[] = [
    new FilterItem(1, 'Redscale', 'by UserA', '$4.99', AppTokens.Colors.error),
    new FilterItem(2, 'Sepia Tone', 'by UserB', '$2.99', AppTokens.Colors.primary),
    new FilterItem(3, 'Aqua', 'by UserC', '$4.99', AppTokens.Colors.secondary),
    new FilterItem(4, 'Forest', 'by UserD', '$3.99', AppTokens.Colors.tertiary),
    new FilterItem(5, 'Golden Hour', 'by UserE', '$5.99', AppTokens.Colors.warning),
    new FilterItem(6, 'Monochrome', 'by UserF', '$1.99', AppTokens.Colors.outline)
  ]

  build() {
    Column({ space: 0 }) { // Mimics Scaffold structure
      TopBarSection({ filters: this.filters, selectedFilter: $selectedFilter })
        .padding({
          left: AppTokens.Spacing.lg,
          right: AppTokens.Spacing.lg,
          top: AppTokens.Spacing.md,
          bottom: AppTokens.Spacing.md
        })
        .backgroundColor(AppTokens.Colors.background) // Top bar background

      Scroll() {
        Grid() {
          ForEach(this.items, (item: FilterItem) => {
            GridItem() {
              FilterCard({ item: item })
            }
          }, (item: FilterItem) => item.id.toString())
        }
        .columnsTemplate('1fr 1fr')
        .columnsGap(AppTokens.Spacing.md)
        .rowsGap(AppTokens.Spacing.md)
        .padding(AppTokens.Spacing.lg) // Corresponds to contentPadding for LazyVerticalGrid
        .width('100%')
      }
      .backgroundColor(AppTokens.Colors.background) // Content background
      .width('100%')
      .layoutWeight(1)
      // .ignoresSafeArea(.container, edges: .bottom) // Not strictly needed if bottom bar is part of Column

      BottomBarSection()
        .backgroundColor(AppTokens.Colors.surface) // Bottom bar background
        .shadow({
          radius: AppTokens.ElevationMapping.level2.blurRadius,
          color: AppTokens.ElevationMapping.level2.color,
          offsetX: AppTokens.ElevationMapping.level2.offsetX,
          offsetY: AppTokens.ElevationMapping.level2.offsetY
        }) // appShadow(AppTokens.ElevationMapping.level2)
    }
    .width('100%')
    .height('100%')
    .backgroundColor(AppTokens.Colors.background) // Overall background, extends to safe areas
    // .statusBarHidden(true) // Hide the status bar (window-level API in ArkUI)
  }
}

// MARK: - App Entry Point
// SwiftUI's @main App / WindowGroup maps to ArkUI's @Entry page component.
@Entry
@Component
struct SingleFileUIApp {
  build() {
    Column() {
      RootScreen()
    }
    .width('100%')
    .height('100%')
  }
}
