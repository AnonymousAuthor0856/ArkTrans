interface TypographyStyle {
  fontSize: number;
  fontWeight: number;
  lineHeight: number;
}

interface ElevationSpec {
  radius: number;
  dy: number;
}

interface Transaction {
  id: number;
  name: string;
  detail: string;
  amount: string;
  isCredit: boolean;
}

namespace AppTokens {
  export class Colors {
    static readonly primary: Color = Color('#FF020617')
    static readonly secondary: Color = Color('#FF4ADE80')
    static readonly tertiary: Color = Color('#FF64748B')
    static readonly background: Color = Color('#FFF8FAFC')
    static readonly surface: Color = Color('#FFFFFFFF')
    static readonly surfaceVariant: Color = Color('#FFF1F5F9')
    static readonly outline: Color = Color('#FFE2E8F0')
    static readonly success: Color = Color('#FF22C55E')
    static readonly warning: Color = Color('#FFF59E0B')
    static readonly error: Color = Color('#FFEF4444')
    static readonly onPrimary: Color = Color('#FFFFFFFF')
    static readonly onSecondary: Color = Color('#FF020617')
    static readonly onTertiary: Color = Color('#FFFFFFFF')
    static readonly onBackground: Color = Color('#FF020617')
    static readonly onSurface: Color = Color('#FF020617')
  }

  export class Typography {
    static readonly display: TypographyStyle = new TypographyStyleImpl(48, FontWeight.Bold, 56)
    static readonly headline: TypographyStyle = new TypographyStyleImpl(28, FontWeight.SemiBold, 36)
    static readonly title: TypographyStyle = new TypographyStyleImpl(20, FontWeight.Medium, 28)
    static readonly body: TypographyStyle = new TypographyStyleImpl(16, FontWeight.Normal, 24)
    static readonly label: TypographyStyle = new TypographyStyleImpl(12, FontWeight.Medium, 16)
  }

  export class Shapes {
    static readonly small: number = 8
    static readonly medium: number = 16
    static readonly large: number = 24
  }

  export class Spacing {
    static readonly xs: number = 4
    static readonly sm: number = 8
    static readonly md: number = 16
    static readonly lg: number = 24
    static readonly xl: number = 32
    static readonly xxl: number = 48
  }

  export class Elevation {
    static readonly level1: ElevationSpec = new ElevationSpecImpl(3, 1)
    static readonly level2: ElevationSpec = new ElevationSpecImpl(8, 2)
    static readonly level3: ElevationSpec = new ElevationSpecImpl(12, 4)
  }
}

class TypographyStyleImpl implements TypographyStyle {
  fontSize: number;
  fontWeight: number;
  lineHeight: number;

  constructor(fontSize: number, fontWeight: number, lineHeight: number) {
    this.fontSize = fontSize
    this.fontWeight = fontWeight
    this.lineHeight = lineHeight
  }
}

class ElevationSpecImpl implements ElevationSpec {
  radius: number;
  dy: number;

  constructor(radius: number, dy: number) {
    this.radius = radius
    this.dy = dy
  }
}

@Entry
@Component
struct Index {
  @State selectedNavItem: string = 'Home'

  private transactions: Transaction[] = [
    { id: 1, name: 'Spotify', detail: 'Subscription', amount: '-$9.99', isCredit: false },
    { id: 2, name: 'Income', detail: 'Monthly Salary', amount: '+$2,500.00', isCredit: true },
    { id: 3, name: 'Starbucks', detail: 'Coffee', amount: '-$5.75', isCredit: false },
    { id: 4, name: 'Amazon', detail: 'Shopping', amount: '-$124.50', isCredit: false },
    { id: 5, name: 'Refund', detail: 'Amazon Return', amount: '+$32.00', isCredit: true }
  ]

  private controlActions: string[] = ['Send', 'Receive', 'Add', 'More']
  private navItems: string[] = ['Home', 'Cards', 'Activity', 'Profile']

  build() {
    Column() {
      this.TopBar()
      List({ space: AppTokens.Spacing.lg }) {
        ListItem() {
          this.BalanceCard()
        }

        ListItem() {
          this.ControlActions()
        }

        ListItem() {
          this.SectionHeader()
        }

        ForEach(this.transactions, (item: Transaction) => {
          ListItem() {
            this.TransactionItem(item)
          }
        }, (item: Transaction) => item.id.toString())
      }
      .width('100%')
      .layoutWeight(1)
      .padding({ left: AppTokens.Spacing.md, right: AppTokens.Spacing.md, top: AppTokens.Spacing.sm, bottom: AppTokens.Spacing.sm })

      this.BottomNav()
    }
    .width('100%')
    .height('100%')
    .backgroundColor(AppTokens.Colors.background)
  }

  @Builder
  TopBar() {
    Row() {
      Button() {
        Circle({ width: 28, height: 28 })
          .fill(AppTokens.Colors.surfaceVariant)
      }
      .type(ButtonType.Normal)
      .backgroundColor(Color.Transparent)
      .width(40)
      .height(40)
      .borderRadius(20)
      .padding(0)

      Text('My Wallet')
        .fontSize(AppTokens.Typography.title.fontSize)
        .fontWeight(AppTokens.Typography.title.fontWeight)
        .fontColor(AppTokens.Colors.onBackground)
        .layoutWeight(1)
        .textAlign(TextAlign.Center)

      Button() {
        Circle({ width: 28, height: 28 })
          .fill(AppTokens.Colors.surfaceVariant)
      }
      .type(ButtonType.Normal)
      .backgroundColor(Color.Transparent)
      .width(40)
      .height(40)
      .borderRadius(20)
      .padding(0)
    }
    .width('100%')
    .padding({ left: AppTokens.Spacing.sm, right: AppTokens.Spacing.sm })
    .height(56)
    .backgroundColor(Color.Transparent)
  }

  @Builder
  BalanceCard() {
    Column() {
      Text('Total Balance')
        .fontSize(AppTokens.Typography.body.fontSize)
        .fontWeight(AppTokens.Typography.body.fontWeight)
        .fontColor(AppTokens.Colors.onPrimary.copy({ alpha: 0.7 }))

      Blank()
        .height(AppTokens.Spacing.sm)

      Text('$ 1,145.14')
        .fontSize(AppTokens.Typography.display.fontSize)
        .fontWeight(AppTokens.Typography.display.fontWeight)
        .fontColor(AppTokens.Colors.onPrimary)
        .lineHeight(AppTokens.Typography.display.lineHeight)

      Blank()
        .height(AppTokens.Spacing.xs)

      Row() {
        Circle({ width: 10, height: 10 })
          .fill(AppTokens.Colors.secondary)

        Blank()
          .width(AppTokens.Spacing.sm)

        Text('+$234.10 today')
          .fontSize(AppTokens.Typography.body.fontSize)
          .fontWeight(AppTokens.Typography.body.fontWeight)
          .fontColor(AppTokens.Colors.secondary)
      }
      .alignItems(VerticalAlign.Center)
    }
    .width('100%')
    .alignItems(HorizontalAlign.Start)
    .padding(AppTokens.Spacing.lg)
    .backgroundColor(AppTokens.Colors.primary)
    .borderRadius(AppTokens.Shapes.large)
    .shadow({
      radius: AppTokens.Elevation.level2.radius,
      color: '#0D000000',
      offsetY: AppTokens.Elevation.level2.dy
    })
  }

  @Builder
  ControlActions() {
    Row() {
      ForEach(this.controlActions, (action: string) => {
        Column() {
          Button() {
            Column() {
              Rect({ width: 24, height: 24 })
                .fill(AppTokens.Colors.primary)
                .borderRadius(AppTokens.Shapes.small)
            }
            .width('100%')
            .height('100%')
            .justifyContent(FlexAlign.Center)
          }
          .type(ButtonType.Normal)
          .backgroundColor(AppTokens.Colors.surface)
          .width(64)
          .height(64)
          .borderRadius(32)
          .shadow({
            radius: AppTokens.Elevation.level1.radius,
            color: '#0D000000',
            offsetY: AppTokens.Elevation.level1.dy
          })
          .padding(0)

          Blank()
            .height(AppTokens.Spacing.sm)

          Text(action)
            .fontSize(AppTokens.Typography.label.fontSize)
            .fontWeight(AppTokens.Typography.label.fontWeight)
            .fontColor(AppTokens.Colors.onSurface)
        }
        .alignItems(HorizontalAlign.Center)
        .layoutWeight(1)
      }, (action: string) => action)
    }
    .width('100%')
    .justifyContent(FlexAlign.SpaceAround)
    .alignItems(VerticalAlign.Center)
  }

  @Builder
  SectionHeader() {
    Row() {
      Text('Recent Activity')
        .fontSize(AppTokens.Typography.title.fontSize)
        .fontWeight(AppTokens.Typography.title.fontWeight)
        .fontColor(AppTokens.Colors.onBackground)
        .layoutWeight(1)

      Button('View All') {
      }
      .type(ButtonType.Normal)
      .backgroundColor(Color.Transparent)
      .fontSize(AppTokens.Typography.label.fontSize)
      .fontColor(AppTokens.Colors.tertiary)
      .fontWeight(AppTokens.Typography.label.fontWeight)
      .padding(0)
      .height(24)
    }
    .width('100%')
    .alignItems(VerticalAlign.Center)
  }

  @Builder
  TransactionItem(item: Transaction) {
    Row() {
      Rect({ width: 48, height: 48 })
        .fill(AppTokens.Colors.surfaceVariant)
        .borderRadius(AppTokens.Shapes.medium)

      Column() {
        Text(item.name)
          .fontSize(AppTokens.Typography.body.fontSize)
          .fontWeight(FontWeight.SemiBold)
          .fontColor(AppTokens.Colors.onSurface)

        Text(item.detail)
          .fontSize(AppTokens.Typography.label.fontSize)
          .fontWeight(AppTokens.Typography.label.fontWeight)
          .fontColor(AppTokens.Colors.tertiary)
      }
      .alignItems(HorizontalAlign.Start)
      .layoutWeight(1)
      .margin({ left: AppTokens.Spacing.md })

      Text(item.amount)
        .fontSize(AppTokens.Typography.body.fontSize)
        .fontWeight(FontWeight.SemiBold)
        .fontColor(item.isCredit ? AppTokens.Colors.success : AppTokens.Colors.onSurface)
        .textAlign(TextAlign.End)
    }
    .width('100%')
    .alignItems(VerticalAlign.Center)
    .padding(AppTokens.Spacing.md)
    .backgroundColor(AppTokens.Colors.surface)
    .borderRadius(AppTokens.Shapes.medium)
    .border({ width: 1, color: AppTokens.Colors.outline })
  }

  @Builder
  BottomNav() {
    Row() {
      ForEach(this.navItems, (item: string) => {
        Column() {
          Circle({
            width: 24,
            height: 24
          })
          .fill(this.selectedNavItem === item ? AppTokens.Colors.primary : AppTokens.Colors.outline)

          Blank()
            .height(4)

          Text(item)
            .fontSize(AppTokens.Typography.label.fontSize)
            .fontWeight(AppTokens.Typography.label.fontWeight)
            .fontColor(this.selectedNavItem === item ? AppTokens.Colors.primary : AppTokens.Colors.tertiary)
        }
        .alignItems(HorizontalAlign.Center)
        .justifyContent(FlexAlign.Center)
        .layoutWeight(1)
        .height('100%')
        .onClick(() => {
          this.selectedNavItem = item
        })
      }, (item: string) => item)
    }
    .width('100%')
    .height(72)
    .backgroundColor(AppTokens.Colors.surface)
    .shadow({
      radius: AppTokens.Elevation.level3.radius,
      color: '#1A000000',
      offsetY: -AppTokens.Elevation.level3.dy
    })
  }
}
