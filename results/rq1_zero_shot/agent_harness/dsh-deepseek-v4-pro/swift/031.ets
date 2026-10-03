// 031.ets - translated from 031.swift (My Wallet UI)

// MARK: - AppTokens (设计系统令牌)
// 统一管理颜色、字体、形状、间距和阴影，便于全局修改和保持一致性。

const CLEAR: string = '#00000000';

class AppTokensColors {
  static readonly primary: string = '#020617';
  static readonly secondary: string = '#4ADE80';
  static readonly tertiary: string = '#64748B';
  static readonly background: string = '#F8FAFC';
  static readonly surface: string = '#FFFFFF';
  static readonly surfaceVariant: string = '#F1F5F9';
  static readonly outline: string = '#E2E8F0';
  static readonly success: string = '#22C55E';
  static readonly warning: string = '#F59E0B';
  static readonly error: string = '#EF4444';
  static readonly onPrimary: string = '#FFFFFF';
  static readonly onSecondary: string = '#020617';
  static readonly onTertiary: string = '#FFFFFF';
  static readonly onBackground: string = '#020617';
  static readonly onSurface: string = '#020617';
}

class AppTokensTypography {
  static readonly displaySize: number = 48;
  static readonly displayWeight: FontWeight = FontWeight.Bold;
  static readonly headlineSize: number = 28;
  static readonly headlineWeight: FontWeight = FontWeight.Semibold;
  static readonly titleSize: number = 20;
  static readonly titleWeight: FontWeight = FontWeight.Medium;
  static readonly bodySize: number = 16;
  static readonly bodyWeight: FontWeight = FontWeight.Regular;
  static readonly labelSize: number = 12;
  static readonly labelWeight: FontWeight = FontWeight.Medium;
}

class AppTokensShapes {
  static readonly small: number = 8;
  static readonly medium: number = 16;
  static readonly large: number = 24;
}

class AppTokensSpacing {
  static readonly xs: number = 4;
  static readonly sm: number = 8;
  static readonly md: number = 16;
  static readonly lg: number = 24;
  static readonly xl: number = 32;
  static readonly xxl: number = 48;
}

interface ShadowSpec {
  radius: number;
  dy: number;
  opacity: number;
}

class AppTokensElevation {
  static readonly level1: ShadowSpec = { radius: 3, dy: 1, opacity: 0.05 };
  static readonly level2: ShadowSpec = { radius: 8, dy: 2, opacity: 0.08 };
  static readonly level3: ShadowSpec = { radius: 12, dy: 4, opacity: 0.10 };
}

class AppTokens {
  static readonly Colors = AppTokensColors;
  static readonly TypographyTokens = AppTokensTypography;
  static readonly Shapes = AppTokensShapes;
  static readonly Spacing = AppTokensSpacing;
  static readonly ElevationMapping = AppTokensElevation;
}

// MARK: - Data Models (数据模型)

interface Transaction {
  id: number;
  name: string;
  detail: string;
  amount: string;
  isCredit: boolean;
}

// MARK: - TransactionCard (交易卡片)
@Component
struct TransactionCard {
  transaction: Transaction;

  build() {
    Row({ space: AppTokens.Spacing.md }) {
      Column()
        .width(48)
        .height(48)
        .backgroundColor(AppTokens.Colors.surfaceVariant)
        .borderRadius(AppTokens.Shapes.medium)

      Column({ space: 0 }) {
        Text(this.transaction.name)
          .fontSize(AppTokens.TypographyTokens.bodySize)
          .fontWeight(FontWeight.Semibold)
          .fontColor(AppTokens.Colors.onSurface)
        Text(this.transaction.detail)
          .fontSize(AppTokens.TypographyTokens.labelSize)
          .fontWeight(AppTokens.TypographyTokens.labelWeight)
          .letterSpacing(0.2)
          .fontColor(AppTokens.Colors.tertiary)
      }
      .alignItems(HorizontalAlign.Start)
      .layoutWeight(1)

      Text(this.transaction.amount)
        .fontSize(AppTokens.TypographyTokens.bodySize)
        .fontWeight(FontWeight.Semibold)
        .fontColor(this.transaction.isCredit ? AppTokens.Colors.success : AppTokens.Colors.onSurface)
        .textAlign(TextAlign.End)
    }
    .alignItems(VerticalAlign.Center)
    .padding(AppTokens.Spacing.md)
    .width('100%')
    .backgroundColor(AppTokens.Colors.surface)
    .borderRadius(AppTokens.Shapes.medium)
    .border({ width: 1, color: AppTokens.Colors.outline })
  }
}

// MARK: - RootScreen (主屏幕视图)
@Component
struct RootScreen {
  @State selectedNavItem: string = 'Home';

  private transactions: Transaction[] = [
    { id: 1, name: 'Spotify', detail: 'Subscription', amount: '-$9.99', isCredit: false },
    { id: 2, name: 'Income', detail: 'Monthly Salary', amount: '+$2,500.00', isCredit: true },
    { id: 3, name: 'Starbucks', detail: 'Coffee', amount: '-$5.75', isCredit: false },
    { id: 4, name: 'Amazon', detail: 'Shopping', amount: '-$124.50', isCredit: false },
    { id: 5, name: 'Refund', detail: 'Amazon Return', amount: '+$32.00', isCredit: true }
  ];

  private controlActions: string[] = ['Send', 'Receive', 'Add', 'More'];
  private navItems: string[] = ['Home', 'Cards', 'Activity', 'Profile'];

  build() {
    Stack() {
      Column()
        .width('100%')
        .height('100%')
        .backgroundColor(AppTokens.Colors.background)

      Column({ space: 0 }) {
        // 顶部栏 (TopAppBar)
        Row() {
          Button() {
            Column()
              .width(28)
              .height(28)
              .backgroundColor(AppTokens.Colors.surfaceVariant)
              .borderRadius(14)
          }
          .type(ButtonType.Normal)
          .backgroundColor(CLEAR)
          .onClick(() => {})

          Blank()

          Text('My Wallet')
            .fontSize(AppTokens.TypographyTokens.titleSize)
            .fontWeight(AppTokens.TypographyTokens.titleWeight)
            .fontColor(AppTokens.Colors.onBackground)

          Blank()

          Button() {
            Column()
              .width(28)
              .height(28)
              .backgroundColor(AppTokens.Colors.surfaceVariant)
              .borderRadius(14)
          }
          .type(ButtonType.Normal)
          .backgroundColor(CLEAR)
          .onClick(() => {})
        }
        .width('100%')
        .height(56)
        .padding({ left: AppTokens.Spacing.md, right: AppTokens.Spacing.md, top: AppTokens.Spacing.sm, bottom: AppTokens.Spacing.sm })
        .backgroundColor('rgba(248,250,252,0.01)')

        // 主要内容区域 (LazyColumn)
        Scroll() {
          Column({ space: AppTokens.Spacing.lg }) {
            // 总余额卡片
            Column({ space: 0 }) {
              Text('Total Balance')
                .fontSize(AppTokens.TypographyTokens.bodySize)
                .fontWeight(AppTokens.TypographyTokens.bodyWeight)
                .fontColor('rgba(255,255,255,0.7)')
              Row().height(AppTokens.Spacing.sm)
              Text('$ 1,145.14')
                .fontSize(AppTokens.TypographyTokens.displaySize)
                .fontWeight(AppTokens.TypographyTokens.displayWeight)
                .letterSpacing(-0.5)
                .fontColor(AppTokens.Colors.onPrimary)
              Row().height(AppTokens.Spacing.xs)
              Row({ space: AppTokens.Spacing.sm }) {
                Column()
                  .width(10)
                  .height(10)
                  .backgroundColor(AppTokens.Colors.secondary)
                  .borderRadius(5)
                Text('+$234.10 today')
                  .fontSize(AppTokens.TypographyTokens.bodySize)
                  .fontWeight(AppTokens.TypographyTokens.bodyWeight)
                  .fontColor(AppTokens.Colors.secondary)
              }
              .alignItems(VerticalAlign.Center)
            }
            .alignItems(HorizontalAlign.Start)
            .padding(AppTokens.Spacing.lg)
            .width('100%')
            .backgroundColor(AppTokens.Colors.primary)
            .borderRadius(AppTokens.Shapes.large)
            .shadow({ radius: AppTokens.ElevationMapping.level2.radius, color: 'rgba(0,0,0,0.08)', offsetX: 0, offsetY: AppTokens.ElevationMapping.level2.dy })

            // 控制操作按钮行
            Row({ space: 0 }) {
              ForEach(this.controlActions, (action: string) => {
                Column({ space: AppTokens.Spacing.sm }) {
                  Button() {
                    Column()
                      .width(24)
                      .height(24)
                      .backgroundColor(AppTokens.Colors.primary)
                      .borderRadius(AppTokens.Shapes.small)
                  }
                  .type(ButtonType.Normal)
                  .width(64)
                  .height(64)
                  .backgroundColor(AppTokens.Colors.surface)
                  .borderRadius(32)
                  .shadow({ radius: AppTokens.ElevationMapping.level1.radius, color: 'rgba(0,0,0,0.05)', offsetX: 0, offsetY: AppTokens.ElevationMapping.level1.dy })
                  .onClick(() => {})

                  Text(action)
                    .fontSize(AppTokens.TypographyTokens.labelSize)
                    .fontWeight(AppTokens.TypographyTokens.labelWeight)
                    .letterSpacing(0.2)
                    .fontColor(AppTokens.Colors.onBackground)
                }
                .layoutWeight(1)
              }, (action: string) => action)
            }
            .width('100%')

            // 最近活动标题
            Row() {
              Text('Recent Activity')
                .fontSize(AppTokens.TypographyTokens.titleSize)
                .fontWeight(AppTokens.TypographyTokens.titleWeight)
                .fontColor(AppTokens.Colors.onBackground)
              Blank()
              Button('View All')
                .fontSize(AppTokens.TypographyTokens.labelSize)
                .fontWeight(AppTokens.TypographyTokens.labelWeight)
                .letterSpacing(0.2)
                .fontColor(AppTokens.Colors.tertiary)
                .type(ButtonType.Normal)
                .backgroundColor(CLEAR)
                .onClick(() => {})
            }
            .width('100%')

            // 交易列表
            ForEach(this.transactions, (transaction: Transaction) => {
              TransactionCard({ transaction: transaction })
            }, (transaction: Transaction) => transaction.id.toString())
          }
          .width('100%')
          .padding({ left: AppTokens.Spacing.md, right: AppTokens.Spacing.md, top: AppTokens.Spacing.sm, bottom: AppTokens.Spacing.sm })
        }
        .scrollable(ScrollDirection.Vertical)
        .scrollBar(BarState.Off)
        .edgeEffect(EdgeEffect.None)
        .layoutWeight(1)
        .padding({ bottom: AppTokens.Spacing.sm })

        // 底部导航栏 (NavigationBar)
        Row({ space: 0 }) {
          ForEach(this.navItems, (item: string) => {
            Button() {
              Column({ space: AppTokens.Spacing.xs }) {
                Column()
                  .width(24)
                  .height(24)
                  .backgroundColor(this.selectedNavItem === item ? AppTokens.Colors.primary : AppTokens.Colors.outline)
                  .borderRadius(12)
                Text(item)
                  .fontSize(AppTokens.TypographyTokens.labelSize)
                  .fontWeight(AppTokens.TypographyTokens.labelWeight)
                  .letterSpacing(0.2)
                  .fontColor(this.selectedNavItem === item ? AppTokens.Colors.primary : AppTokens.Colors.tertiary)
              }
              .width('100%')
              .padding({ top: AppTokens.Spacing.sm, bottom: AppTokens.Spacing.sm })
              .backgroundColor(this.selectedNavItem === item ? AppTokens.Colors.surfaceVariant : CLEAR)
              .borderRadius(AppTokens.Shapes.medium)
            }
            .type(ButtonType.Normal)
            .backgroundColor(CLEAR)
            .layoutWeight(1)
            .onClick(() => {
              this.selectedNavItem = item;
            })
          }, (item: string) => item)
        }
        .width('100%')
        .height(80)
        .padding({ left: AppTokens.Spacing.xs, right: AppTokens.Spacing.xs })
        .backgroundColor(AppTokens.Colors.surface)
        .shadow({ radius: AppTokens.ElevationMapping.level3.radius, color: 'rgba(0,0,0,0.10)', offsetX: 0, offsetY: AppTokens.ElevationMapping.level3.dy })
      }
      .width('100%')
      .height('100%')
    }
    .width('100%')
    .height('100%')
  }
}

// MARK: - App Entry Point (应用入口)
@Entry
@Component
struct Index {
  build() {
    RootScreen()
  }
}
