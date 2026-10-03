// Translation of 069.swift (SwiftUI) into ArkTS (HarmonyOS ArkUI).
// The SwiftUI view hierarchy is mapped to ArkUI declarative components.

// MARK: - Data Models

class CargoCard {
  id: string = ''
  title: string = ''
  itemId: string = ''
  fill: string = ''

  constructor(title: string, itemId: string, fill: string) {
    this.title = title
    this.itemId = itemId
    this.fill = fill
    this.id = title + '-' + itemId
  }
}

class HubFilter {
  id: string = ''
  label: string = ''

  constructor(label: string) {
    this.label = label
    this.id = label
  }
}

// MARK: - Design Tokens

// DesignTokens.Colors
class Colors {
  static readonly primary: string = '#8B6B4C'
  static readonly secondary: string = '#C27D38'
  static readonly tertiary: string = '#F2C57C'
  static readonly background: string = '#100C08'
  static readonly surface: string = '#19110D'
  static readonly surfaceVariant: string = '#2A1C14'
  static readonly outline: string = '#4F3A2C'
  static readonly success: string = '#6ECE89'
  static readonly warning: string = '#E19F41'
  static readonly error: string = '#D96666'
  static readonly onPrimary: string = '#100C08'
  static readonly onSecondary: string = '#100C08'
  static readonly onTertiary: string = '#120E04'
  static readonly onBackground: string = '#F7EAD8'
  static readonly onSurface: string = '#FBEFE0'
  // Translucent variants (opacity applied to the base color)
  static readonly surface95: string = '#F219110D'
  static readonly tertiary40: string = '#66F2C57C'
  static readonly surfaceVariant85: string = '#D92A1C14'
  static readonly surfaceVariant92: string = '#EB2A1C14'
  static readonly onSurface70: string = '#B3FBEFE0'
}

// DesignTokens.Typography
class Typography {
  static readonly display: number = 28
  static readonly headline: number = 22
  static readonly title: number = 16
  static readonly body: number = 14
  static readonly label: number = 12
  static readonly displayWeight: FontWeight = FontWeight.Bold
  static readonly headlineWeight: FontWeight = FontWeight.Bold
  static readonly titleWeight: FontWeight = FontWeight.Medium
  static readonly bodyWeight: FontWeight = FontWeight.Regular
  static readonly labelWeight: FontWeight = FontWeight.Medium
}

// DesignTokens.Spacing
class Spacing {
  static readonly xxs: number = 6
  static readonly xs: number = 10
  static readonly sm: number = 14
  static readonly md: number = 18
  static readonly lg: number = 26
  static readonly xl: number = 36
  static readonly xxl: number = 48
  static readonly xxxl: number = 62
}

// DesignTokens.CornerRadius
class CornerRadius {
  static readonly small: number = 10
  static readonly medium: number = 18
  static readonly large: number = 26
}

// MARK: - Main Content View
// The SwiftUI @main SupplyHubApp / WindowGroup maps to @Entry on this single page.

@Entry
@Component
struct ContentView {
  @State activeFilter: string = 'All'

  private cards: CargoCard[] = [
    new CargoCard('Copper stack', 'SH-014', '78%'),
    new CargoCard('Fiber reels', 'SH-022', '64%'),
    new CargoCard('Agro crates', 'SH-031', '92%'),
    new CargoCard('Glass kits', 'SH-045', '51%'),
    new CargoCard('Steel mesh', 'SH-057', '88%'),
    new CargoCard('Raw silica', 'SH-063', '43%')
  ]

  private filters: HubFilter[] = [
    new HubFilter('All'),
    new HubFilter('Atlantic'),
    new HubFilter('Pacific'),
    new HubFilter('Inland')
  ]

  build() {
    Stack() {
      Column() {
        // Top App Bar
        this.TopAppBar()

        // Main Content
        Scroll() {
          Column({ space: Spacing.lg }) {
            // Filter Buttons
            this.FilterButtons()

            // Cargo Grid Section
            Text('Cargo grid')
              .fontSize(Typography.headline)
              .fontWeight(Typography.headlineWeight)
              .fontColor(Colors.onSurface)
              .padding({ left: Spacing.lg, right: Spacing.lg })

            Grid() {
              ForEach(this.cards, (card: CargoCard) => {
                GridItem() {
                  this.CargoCardView(card)
                }
              }, (card: CargoCard): string => card.id)
            }
            .columnsTemplate('1fr 1fr')
            .columnsGap(Spacing.sm)
            .rowsGap(Spacing.sm)
            .width('100%')
            .padding({ left: Spacing.lg, right: Spacing.lg })

            // Manifest Filter Section
            Column() {
              Column() {
                Text('Manifest filter')
                  .fontSize(Typography.label)
                  .fontWeight(Typography.labelWeight)
                  .fontColor(Colors.onSurface70)

                Text(this.activeFilter)
                  .fontSize(Typography.title)
                  .fontWeight(Typography.titleWeight)
                  .fontColor(Colors.onSurface)
              }
              .alignItems(HorizontalAlign.Start)
              .width('100%')
              .padding({ left: Spacing.lg, right: Spacing.lg, top: Spacing.md, bottom: Spacing.md })
              .backgroundColor(Colors.surfaceVariant85)
              .borderRadius(CornerRadius.medium)
            }
            .width('100%')
            .padding({ left: Spacing.lg, right: Spacing.lg })
          }
          .width('100%')
          .alignItems(HorizontalAlign.Start)
          .padding({ top: Spacing.md, bottom: Spacing.md })
        }
        .scrollBar(BarState.Off)
        .layoutWeight(1)
        .align(Alignment.TopStart)
        .width('100%')
      }
      .width('100%')
      .height('100%')
      .alignItems(HorizontalAlign.Start)
    }
    .width('100%')
    .height('100%')
    .backgroundColor(Colors.background)
  }

  // MARK: - Subviews

  @Builder
  TopAppBar() {
    Row() {
      // Navigation Icon
      Circle()
        .width(26)
        .height(26)
        .fill(Colors.surfaceVariant)

      // Title
      Column({ space: 2 }) {
        Text('SupplyHub')
          .fontSize(Typography.title)
          .fontWeight(Typography.titleWeight)
          .fontColor(Colors.onSurface)

        Text('Logistics grid')
          .fontSize(Typography.label)
          .fontWeight(Typography.labelWeight)
          .fontColor(Colors.onSurface70)
      }

      // Action Icon
      Circle()
        .width(26)
        .height(26)
        .fill(Colors.surfaceVariant)
    }
    .width('100%')
    .justifyContent(FlexAlign.SpaceBetween)
    .alignItems(VerticalAlign.Center)
    .padding({ left: Spacing.lg, right: Spacing.lg, top: Spacing.md, bottom: Spacing.md })
    .height(64)
    .backgroundColor(Colors.surface95)
  }

  @Builder
  FilterButtons() {
    Scroll() {
      Row({ space: Spacing.xs }) {
        ForEach(this.filters, (filter: HubFilter) => {
          Button() {
            Text(filter.label)
              .fontSize(Typography.label)
              .fontWeight(Typography.labelWeight)
              .fontColor(this.activeFilter === filter.label ? Colors.onSecondary : Colors.onSurface)
              .padding({ left: Spacing.sm, right: Spacing.sm, top: Spacing.xxs, bottom: Spacing.xxs })
          }
          .type(ButtonType.Normal)
          .backgroundColor(this.activeFilter === filter.label ? Colors.secondary : Colors.surfaceVariant)
          .borderRadius(CornerRadius.small)
          .onClick(() => {
            this.activeFilter = filter.label
          })
        }, (filter: HubFilter): string => filter.id)
      }
      .padding({ left: Spacing.lg, right: Spacing.lg })
    }
    .scrollable(ScrollDirection.Horizontal)
    .scrollBar(BarState.Off)
    .width('100%')
  }

  @Builder
  CargoCardView(card: CargoCard) {
    Column({ space: Spacing.sm }) {
      // Image placeholder
      Stack({ alignContent: Alignment.Center }) {
        Column()
          .width('100%')
          .height(90)
          .backgroundColor(Colors.surface)
          .borderRadius(CornerRadius.small)

        Circle()
          .width(60)
          .height(60)
          .fill(Colors.tertiary40)
      }
      .width('100%')
      .height(90)

      Column({ space: Spacing.xxs }) {
        Text(card.title)
          .fontSize(Typography.title)
          .fontWeight(Typography.titleWeight)
          .fontColor(Colors.onSurface)

        Text(card.itemId)
          .fontSize(Typography.body)
          .fontWeight(Typography.bodyWeight)
          .fontColor(Colors.onSurface70)

        Text('Fill ' + card.fill)
          .fontSize(Typography.label)
          .fontWeight(Typography.labelWeight)
          .fontColor(Colors.success)
      }
      .alignItems(HorizontalAlign.Start)
    }
    .alignItems(HorizontalAlign.Start)
    .width('100%')
    .padding(Spacing.md)
    .backgroundColor(Colors.surfaceVariant92)
    .borderRadius(CornerRadius.medium)
  }
}
