class DesignTokens {
  static readonly Colors = {
    primary: '#FF8B6B4C',
    secondary: '#FFC27D38',
    tertiary: '#FFF2C57C',
    background: '#FF100C08',
    surface: '#FF19110D',
    surfaceVariant: '#FF2A1C14',
    outline: '#FF4F3A2C',
    success: '#FF6ECE89',
    warning: '#FFE19F41',
    error: '#FFD96666',
    onPrimary: '#FF100C08',
    onSecondary: '#FF100C08',
    onTertiary: '#FF120E04',
    onBackground: '#FFF7EAD8',
    onSurface: '#FFFBEFE0',
  }
  static readonly Typography = {
    display: { size: 28, weight: FontWeight.Bold },
    headline: { size: 22, weight: FontWeight.Medium },
    title: { size: 16, weight: FontWeight.Medium },
    body: { size: 14, weight: FontWeight.Normal },
    label: { size: 12, weight: FontWeight.Medium },
  }
  static readonly Spacing = {
    xxs: 6,
    xs: 10,
    sm: 14,
    md: 18,
    lg: 26,
    xl: 36,
    xxl: 48,
    xxxl: 62,
  }
  static readonly CornerRadius = {
    small: 10,
    medium: 18,
    large: 26,
  }
}

class CargoCard {
  title: string
  itemId: string
  fill: string

  constructor(title: string, itemId: string, fill: string) {
    this.title = title
    this.itemId = itemId
    this.fill = fill
  }
}

@Component
struct CargoCardView {
  @Prop title: string
  @Prop itemId: string
  @Prop fill: string

  build() {
    Column({ space: DesignTokens.Spacing.sm }) {
      Stack() {
        Circle({ width: 60, height: 60 })
          .fill('#66F2C57C')
      }
      .width('100%')
      .height(90)
      .backgroundColor(DesignTokens.Colors.surface)
      .borderRadius(DesignTokens.CornerRadius.small)

      Column({ space: DesignTokens.Spacing.xxs }) {
        Text(this.title)
          .fontSize(DesignTokens.Typography.title.size)
          .fontWeight(DesignTokens.Typography.title.weight)
          .fontColor(DesignTokens.Colors.onSurface)

        Text(this.itemId)
          .fontSize(DesignTokens.Typography.body.size)
          .fontWeight(DesignTokens.Typography.body.weight)
          .fontColor('#B3FBEFE0')

        Text(`Fill ${this.fill}`)
          .fontSize(DesignTokens.Typography.label.size)
          .fontWeight(DesignTokens.Typography.label.weight)
          .fontColor(DesignTokens.Colors.success)
      }
      .alignItems(HorizontalAlign.Start)
    }
    .width('100%')
    .padding(DesignTokens.Spacing.md)
    .backgroundColor('#EB2A1C14')
    .borderRadius(DesignTokens.CornerRadius.medium)
  }
}

@Entry
@Component
struct RootScreen {
  @State activeFilter: string = 'All'
  private cards: CargoCard[] = [
    new CargoCard('Copper stack', 'SH-014', '78%'),
    new CargoCard('Fiber reels', 'SH-022', '64%'),
    new CargoCard('Agro crates', 'SH-031', '92%'),
    new CargoCard('Glass kits', 'SH-045', '51%'),
    new CargoCard('Steel mesh', 'SH-057', '88%'),
    new CargoCard('Raw silica', 'SH-063', '43%'),
  ]
  private filters: string[] = ['All', 'Atlantic', 'Pacific', 'Inland']

  build() {
    Column() {
      Row() {
        Column()
          .width(26)
          .height(26)
          .backgroundColor(DesignTokens.Colors.surfaceVariant)
          .borderRadius(13)

        Blank()

        Column({ space: 2 }) {
          Text('SupplyHub')
            .fontSize(DesignTokens.Typography.title.size)
            .fontWeight(DesignTokens.Typography.title.weight)
            .fontColor(DesignTokens.Colors.onSurface)
          Text('Logistics grid')
            .fontSize(DesignTokens.Typography.label.size)
            .fontWeight(DesignTokens.Typography.label.weight)
            .fontColor('#B3FBEFE0')
        }

        Blank()

        Column()
          .width(26)
          .height(26)
          .backgroundColor(DesignTokens.Colors.surfaceVariant)
          .borderRadius(13)
      }
      .width('100%')
      .height(64)
      .padding({ left: DesignTokens.Spacing.lg, right: DesignTokens.Spacing.lg, top: DesignTokens.Spacing.md, bottom: DesignTokens.Spacing.md })
      .backgroundColor('#F219110D')

      Scroll() {
       1        Column({ space: DesignTokens.Spacing.lg }) {
          Scroll() {
            Row({ space: DesignTokens.Spacing.xs }) {
              ForEach(this.filters, (f: string) => {
                Text(f)
                  .fontSize(DesignTokens.Typography.label.size)
                  .fontWeight(DesignTokens.Typography.label.weight)
                  .fontColor(this.activeFilter === f ? DesignTokens.Colors.onSecondary : DesignTokens.Colors.onSurface)
                  .padding({ left: DesignTokens.Spacing.sm, right: DesignTokens.Spacing.sm, top: DesignTokens.Spacing.xxs, bottom: DesignTokens.Spacing.xxs })
                  .backgroundColor(this.activeFilter === f ? DesignTokens.Colors.secondary : DesignTokens.Colors.surfaceVariant)
                  .borderRadius(DesignTokens.CornerRadius.small)
                  .onClick(() => {
                    this.activeFilter = f
                  })
              })
            }
            .padding({ left: DesignTokens.Spacing.lg, right: DesignTokens.Spacing.lg })
          }
          .scrollable(ScrollDirection.Horizontal)
          .scrollBar(BarState.Off)
          .width('100%')

          Text('Cargo grid')
            .fontSize(DesignTokens.Typography.headline.size)
            .fontWeight(DesignTokens.Typography.headline.weight)
            .fontColor(DesignTokens.Colors.onSurface)
            .margin({ left: DesignTokens.Spacing.lg, right: DesignTokens.Spacing.lg })

          Row({ space: DesignTokens.Spacing.sm }) {
            CargoCardView({ title: this.cards[0].title, itemId: this.cards[0].itemId, fill: this.cards[0].fill })
              .layoutWeight(1)
            CargoCardView({ title: this.cards[1].title, itemId: this.cards[1].itemId, fill: this.cards[1].fill })
              .layoutWeight(1)
          }
          .width('100%')
          .padding({ left: DesignTokens.Spacing.lg, right: DesignTokens.Spacing.lg })

          Row({ space: DesignTokens.Spacing.sm }) {
            CargoCardView({ title: this.cards[2].title, itemId: this.cards[2].itemId, fill: this.cards[2].fill })
              .layoutWeight(1)
            CargoCardView({ title: this.cards[3].title, itemId: this.cards[3].itemId, fill: this.cards[3].fill })
              .layoutWeight(1)
          }
          .width('100%')
          .padding({ left: DesignTokens.Spacing.lg, right: DesignTokens.Spacing.lg })

          Row({ space: DesignTokens.Spacing.sm }) {
            CargoCardView({ title: this.cards[4].title, itemId: this.cards[4].itemId, fill: this.cards[4].fill })
              .layoutWeight(1)
            CargoCardView({ title: this.cards[5].title, itemId: this.cards[5].itemId, fill: this.cards[5].fill })
              .layoutWeight(1)
          }
          .width('100%')
          .padding({ left: DesignTokens.Spacing.lg, right: DesignTokens.Spacing.lg })

          Column({ space: DesignTokens.Spacing.xs }) {
            Text('Manifest filter')
              .fontSize(DesignTokens.Typography.label.size)
              .fontWeight(DesignTokens.Typography.label.weight)
              .fontColor('#B3FBEFE0')
            Text(this.activeFilter)
              .fontSize(DesignTokens.Typography.title.size)
              .fontWeight(DesignTokens.Typography.title.weight)
              .fontColor(DesignTokens.Colors.onSurface)
          }
          .width('100%')
          .alignItems(HorizontalAlign.Start)
          .padding({ left: DesignTokens.Spacing.lg, right: DesignTokens.Spacing.lg, top: DesignTokens.Spacing.md, bottom: DesignTokens.Spacing.md })
          .backgroundColor('#D92A1C14')
          .borderRadius(DesignTokens.CornerRadius.medium)
          .margin({ left: DesignTokens.Spacing.lg, right: DesignTokens.Spacing.lg })
        }
        .width('100%')
        .padding({ top: DesignTokens.Spacing.md, bottom: DesignTokens.Spacing.md })
        .alignItems(HorizontalAlign.Start)
      }
      .scrollBar(BarState.Off)
      .layoutWeight(1)
      .width('100%')
    }
    .width('100%')
    .height('100%')
    .backgroundColor(DesignTokens.Colors.background)
  }
}