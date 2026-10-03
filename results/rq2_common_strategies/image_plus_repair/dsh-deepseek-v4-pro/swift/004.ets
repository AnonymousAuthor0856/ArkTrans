// MARK: - Entry Point
// The SwiftUI `App` + `WindowGroup` entry point maps to an ArkUI `@Entry` page
// component that renders the root view.
@Entry
@Component
struct FinanceWalletApp {
  build() {
    Stack() {
      ContentView()
    }
    .width('100%')
    .height('100%')
  }
}

// MARK: - App Tokens & Colors

interface ColorPalette {
  primary: string;
  secondary: string;
  tertiary: string;
  background: string;
  surface: string;
  surfaceVariant: string;
  outline: string;
  success: string;
  warning: string;
  error: string;
  onPrimary: string;
  onSecondary: string;
  onSurface: string;
}

interface TypeStyle {
  size: number;
  weight: number;
}

interface TypographyScheme {
  display: TypeStyle;
  headline: TypeStyle;
  title: TypeStyle;
  body: TypeStyle;
  label: TypeStyle;
}

interface SpacingScheme {
  xs: number;
  sm: number;
  md: number;
  lg: number;
  xl: number;
  xxl: number;
  xxxl: number;
}

interface ShapesScheme {
  small: number;
  medium: number;
  large: number;
}

class AppTokens {
  static readonly Colors: ColorPalette = {
    primary: colorFromHex(0x1F2937),
    secondary: colorFromHex(0x10B981),
    tertiary: colorFromHex(0x3B82F6),
    background: colorFromHex(0xF3F4F6),
    surface: colorFromHex(0xFFFFFFFF),
    surfaceVariant: colorFromHex(0xE5E7EB),
    outline: colorFromHex(0xD1D5DB),
    success: colorFromHex(0x16A34A),
    warning: colorFromHex(0xF59E0B),
    error: colorFromHex(0xEF4444),
    onPrimary: colorFromHex(0xFFFFFFFF),
    onSecondary: colorFromHex(0x0B1220),
    onSurface: colorFromHex(0x0B1220)
  };

  static readonly Typography: TypographyScheme = {
    display: { size: 24, weight: 600 },
    headline: { size: 18, weight: 600 },
    title: { size: 14, weight: 500 },
    body: { size: 12, weight: 400 },
    label: { size: 10, weight: 500 }
  };

  static readonly Spacing: SpacingScheme = {
    xs: 2,
    sm: 4,
    md: 6,
    lg: 8,
    xl: 12,
    xxl: 16,
    xxxl: 24
  };

  static readonly Shapes: ShapesScheme = {
    small: 6,
    medium: 8,
    large: 12
  };
}

// MARK: - Models

interface AccountCardModel {
  id: number;
  name: string;
  balance: string;
  accent: string;
}

interface TxItemModel {
  id: number;
  title: string;
  subtitle: string;
  amount: string;
  positive: boolean;
}

// MARK: - Root View
@Component
struct ContentView {
  // State
  @State showBalance: boolean = true;
  @State selectedFilter: string = 'Month';
  @State flags: string[] = [];

  // Data
  filters: string[] = ['All', 'Week', 'Month', 'Year'];
  accounts: AccountCardModel[] = [
    { id: 1, name: 'Wallet', balance: '$2,845.20', accent: colorFromHex(0x10B981) },
    { id: 2, name: 'Savings', balance: '$8,120.00', accent: colorFromHex(0x3B82F6) },
    { id: 3, name: 'Investments', balance: '$15,430.55', accent: colorFromHex(0xF59E0B) }
  ];
  transactions: TxItemModel[] = [
    { id: 1, title: 'Grocery Market', subtitle: 'Today • 12:40', amount: '-$32.18', positive: false },
    { id: 2, title: 'Salary', subtitle: 'Yesterday • 09:00', amount: '+$3,200.00', positive: true },
    { id: 3, title: 'Coffee Shop', subtitle: 'Yesterday • 15:22', amount: '-$4.90', positive: false },
    { id: 4, title: 'ETF Purchase', subtitle: 'Mon • 10:05', amount: '-$250.00', positive: false },
    { id: 5, title: 'Refund', subtitle: 'Sun • 18:40', amount: '+$18.99', positive: true }
  ];

  build() {
    Stack({ alignContent: Alignment.Bottom }) {
      Column() {
        // Top Bar
        Row({ space: AppTokens.Spacing.sm }) {
          Column()
            .width(20)
            .height(20)
            .backgroundColor(AppTokens.Colors.primary)
            .borderRadius(AppTokens.Shapes.small)
          Text('Wallet')
            .fontSize(AppTokens.Typography.display.size)
            .fontWeight(AppTokens.Typography.display.weight)
            .fontColor(AppTokens.Colors.onSurface)
          Blank()
        }
        .padding(AppTokens.Spacing.xxl)
        .width('100%')
        .backgroundColor(AppTokens.Colors.background) // Match background for sticky feel

        // Content
        Scroll() {
          Column({ space: AppTokens.Spacing.lg }) {

            // Filters Row
            Row() {
              Row({ space: AppTokens.Spacing.sm }) {
                ForEach(this.filters, (filter: string) => {
                  FilterChip({
                    label: filter,
                    isSelected: this.selectedFilter === filter,
                    onClickCallback: () => {
                      this.selectedFilter = filter;
                    }
                  })
                }, (filter: string) => filter)
              }

              Blank()

              Row({ space: AppTokens.Spacing.sm }) {
                Text('Hide')
                  .fontSize(AppTokens.Typography.label.size)
                  .fontWeight(AppTokens.Typography.label.weight)
                  .fontColor(AppTokens.Colors.onSurface)

                Toggle({ type: ToggleType.Switch, isOn: !this.showBalance })
                  .selectedColor(AppTokens.Colors.primary)
                  .switchPointColor(AppTokens.Colors.onPrimary)
                  .width(36)
                  .height(20)
                  .onChange((isOn: boolean) => {
                    this.showBalance = !isOn;
                  })
              }
            }
            .width('100%')

            // Accounts List
            ForEach(this.accounts, (account: AccountCardModel) => {
              AccountCardView({ account: account, showBalance: this.showBalance })
            }, (account: AccountCardModel) => account.id.toString())

            // Recent Activity Header
            Row() {
              Text('Recent Activity')
                .fontSize(AppTokens.Typography.headline.size)
                .fontWeight(AppTokens.Typography.headline.weight)
                .fontColor(AppTokens.Colors.onSurface)

              Blank()

              Row({ space: AppTokens.Spacing.sm }) {
                AssistChip({
                  label: 'Income',
                  isSelected: this.flags.indexOf('Income') >= 0,
                  onClickCallback: () => {
                    const idx: number = this.flags.indexOf('Income');
                    if (idx >= 0) {
                      this.flags.splice(idx, 1);
                    } else {
                      this.flags.push('Income');
                    }
                  }
                })
                AssistChip({
                  label: 'Expense',
                  isSelected: this.flags.indexOf('Expense') >= 0,
                  onClickCallback: () => {
                    const idx: number = this.flags.indexOf('Expense');
                    if (idx >= 0) {
                      this.flags.splice(idx, 1);
                    } else {
                      this.flags.push('Expense');
                    }
                  }
                })
              }
            }
            .width('100%')

            // Transactions List
            ForEach(this.transactions, (tx: TxItemModel) => {
              TransactionCard({ tx: tx })
            }, (tx: TxItemModel) => tx.id.toString())

            // Bottom Padding for FAB/BottomBar
            Row()
              .width('100%')
              .height(100)
          }
          .padding({
            left: AppTokens.Spacing.lg,
            right: AppTokens.Spacing.lg,
            top: AppTokens.Spacing.md,
            bottom: AppTokens.Spacing.md
          })
          .width('100%')
        }
        .scrollBar(BarState.Off)
        .layoutWeight(1)
        .width('100%')
      }
      .width('100%')
      .height('100%')

      // Bottom Bar Overlay
      Column() {
        Row() {
          Column({ space: AppTokens.Spacing.xs }) {
            Text('Total Balance')
              .fontSize(AppTokens.Typography.title.size) // labelMedium in Kotlin, upped slightly for visibility
              .fontWeight(AppTokens.Typography.title.weight)
              .fontColor(AppTokens.Colors.onSurface)
            Text(this.showBalance ? '$26,395.75' : '•••••••')
              .fontSize(AppTokens.Typography.headline.size)
              .fontWeight(AppTokens.Typography.headline.weight)
              .fontColor(AppTokens.Colors.onSurface)
          }
          .alignItems(HorizontalAlign.Start)

          Blank()

          Button({ type: ButtonType.Normal }) {
            Text('Add Money')
              .fontSize(AppTokens.Typography.title.size)
              .fontWeight(AppTokens.Typography.title.weight)
              .fontColor(AppTokens.Colors.onSecondary)
          }
          .width(140)
          .height(44)
          .backgroundColor(AppTokens.Colors.secondary)
          .borderRadius(AppTokens.Shapes.large)
          .onClick(() => {})
        }
        .padding({
          left: AppTokens.Spacing.lg,
          right: AppTokens.Spacing.lg,
          top: AppTokens.Spacing.md,
          bottom: AppTokens.Spacing.md
        })
        .width('100%')
      }
      .width('100%')
      .backgroundColor(AppTokens.Colors.surface)
      .shadow({ radius: 6, color: '#29000000', offsetX: 0, offsetY: -1.5 }) // Level 3 Shadow approx
    }
    .width('100%')
    .height('100%')
    .backgroundColor(AppTokens.Colors.background)
    // SwiftUI `.statusBarHidden(true)` has no direct per-view equivalent in ArkUI;
    // it is configured via the ability's window stage instead.
  }
}

// MARK: - Components

@Component
struct FilterChip {
  label: string = '';
  @Prop isSelected: boolean;
  onClickCallback: () => void = () => {};

  build() {
    Button({ type: ButtonType.Normal }) {
      Text(this.label)
        .fontSize(this.isSelected ? AppTokens.Typography.title.size : AppTokens.Typography.body.size)
        .fontWeight(this.isSelected ? AppTokens.Typography.title.weight : AppTokens.Typography.body.weight)
        .fontColor(this.isSelected ? AppTokens.Colors.onPrimary : AppTokens.Colors.onSurface)
    }
    .padding({ left: 12, right: 12, top: 8, bottom: 8 })
    .backgroundColor(this.isSelected ? AppTokens.Colors.primary : AppTokens.Colors.surface)
    .borderRadius(AppTokens.Shapes.medium)
    .border({ width: this.isSelected ? 0 : 1, color: AppTokens.Colors.outline })
    .onClick(() => {
      this.onClickCallback();
    })
  }
}

@Component
struct AssistChip {
  label: string = '';
  @Prop isSelected: boolean;
  onClickCallback: () => void = () => {};

  build() {
    Button({ type: ButtonType.Normal }) {
      Text(this.label)
        .fontSize(AppTokens.Typography.label.size)
        .fontWeight(AppTokens.Typography.label.weight)
        .fontColor(this.isSelected ? AppTokens.Colors.onSecondary : AppTokens.Colors.onSurface)
    }
    .padding({ left: 8, right: 8, top: 6, bottom: 6 })
    .backgroundColor(this.isSelected ? AppTokens.Colors.secondary : AppTokens.Colors.surface)
    .borderRadius(AppTokens.Shapes.small)
    .border({ width: 1, color: AppTokens.Colors.outline })
    .onClick(() => {
      this.onClickCallback();
    })
  }
}

@Component
struct AccountCardView {
  account: AccountCardModel = { id: 0, name: '', balance: '', accent: '#FF000000' };
  @Prop showBalance: boolean;

  build() {
    Column({ space: AppTokens.Spacing.sm }) {
      // Header
      Row() {
        Row({ space: AppTokens.Spacing.sm }) {
          Column()
            .width(16)
            .height(16)
            .backgroundColor(this.account.accent)
            .borderRadius(AppTokens.Shapes.small)
          Text(this.account.name)
            .fontSize(AppTokens.Typography.title.size)
            .fontWeight(AppTokens.Typography.title.weight)
            .fontColor(AppTokens.Colors.onSurface)
        }
        Blank()
        Button({ type: ButtonType.Normal }) {
          Text('Manage')
            .fontSize(AppTokens.Typography.label.size)
            .fontWeight(AppTokens.Typography.label.weight)
            .fontColor(AppTokens.Colors.onSecondary)
        }
        .padding({ left: 8, right: 8, top: 4, bottom: 4 })
        .backgroundColor(AppTokens.Colors.secondary)
        .borderRadius(AppTokens.Shapes.small)
        .border({ width: 1, color: AppTokens.Colors.outline })
        .onClick(() => {})
      }
      .width('100%')

      // Balance Box
      Column() {
        Text(this.showBalance ? this.account.balance : '•••••••')
          .fontSize(AppTokens.Typography.headline.size)
          .fontWeight(AppTokens.Typography.headline.weight)
          .fontColor(AppTokens.Colors.onSurface)
      }
      .width('100%')
      .aspectRatio(2.8)
      .justifyContent(FlexAlign.Center)
      .alignItems(HorizontalAlign.Center)
      .backgroundColor(AppTokens.Colors.surfaceVariant)
      .borderRadius(AppTokens.Shapes.medium)

      // Actions
      Row({ space: AppTokens.Spacing.sm }) {
        // Transfer Button
        Button({ type: ButtonType.Normal }) {
          Text('Transfer')
            .fontSize(AppTokens.Typography.label.size)
            .fontWeight(AppTokens.Typography.label.weight)
            .fontColor(AppTokens.Colors.onSecondary)
        }
        .padding({ left: 8, right: 8, top: 6, bottom: 6 })
        .backgroundColor(AppTokens.Colors.secondary)
        .borderRadius(AppTokens.Shapes.small)
        .border({ width: 1, color: AppTokens.Colors.outline })
        .onClick(() => {})

        // Details Button
        Button({ type: ButtonType.Normal }) {
          Text('Details')
            .fontSize(AppTokens.Typography.label.size)
            .fontWeight(AppTokens.Typography.label.weight)
            .fontColor(AppTokens.Colors.onSurface)
        }
        .padding({ left: 8, right: 8, top: 6, bottom: 6 })
        .backgroundColor(AppTokens.Colors.surface)
        .borderRadius(AppTokens.Shapes.small)
        .border({ width: 1, color: AppTokens.Colors.outline })
        .onClick(() => {})
      }
      .width('100%')
    }
    .padding(AppTokens.Spacing.lg)
    .width('100%')
    .backgroundColor(AppTokens.Colors.surface)
    .borderRadius(AppTokens.Shapes.large)
    .shadow({ radius: 4, color: '#24000000', offsetX: 0, offsetY: 1 }) // Level 2 Shadow
    .border({ width: 1, color: AppTokens.Colors.outline })
    .constraintSize({ minHeight: 120 })
  }
}

@Component
struct TransactionCard {
  tx: TxItemModel = { id: 0, title: '', subtitle: '', amount: '', positive: false };

  build() {
    Row() {
      Row({ space: AppTokens.Spacing.md }) {
        Column()
          .width(32)
          .height(32)
          .backgroundColor(this.tx.positive ? AppTokens.Colors.success : AppTokens.Colors.error)
          .borderRadius(AppTokens.Shapes.small)

        Column({ space: AppTokens.Spacing.xs }) {
          Text(this.tx.title)
            .fontSize(AppTokens.Typography.title.size)
            .fontWeight(AppTokens.Typography.title.weight)
            .fontColor(AppTokens.Colors.onSurface)
          Text(this.tx.subtitle)
            .fontSize(AppTokens.Typography.body.size)
            .fontWeight(AppTokens.Typography.body.weight)
            .fontColor(AppTokens.Colors.onSurface)
        }
        .alignItems(HorizontalAlign.Start)
      }
      Blank()
      Text(this.tx.amount)
        .fontSize(AppTokens.Typography.title.size)
        .fontWeight(AppTokens.Typography.title.weight)
        .fontColor(this.tx.positive ? AppTokens.Colors.success : AppTokens.Colors.error)
    }
    .padding(AppTokens.Spacing.lg)
    .width('100%')
    .constraintSize({ minHeight: 72 })
    .backgroundColor(AppTokens.Colors.surface)
    .borderRadius(AppTokens.Shapes.large)
    .shadow({ radius: 2, color: '#1F000000', offsetX: 0, offsetY: 0.5 }) // Level 1 Shadow
    .border({ width: 1, color: AppTokens.Colors.outline })
  }
}

// MARK: - Color Hex Extension
// SwiftUI's `Color(hex:alpha:)` extension maps to an ArkTS helper that produces an
// ARGB hex string accepted by ArkUI color attributes.
function colorFromHex(hex: number, alpha: number = 255): string {
  const r: number = (hex >> 16) & 0xff;
  const g: number = (hex >> 8) & 0xff;
  const b: number = hex & 0xff;
  const toByte = (v: number): string => {
    const s: string = v.toString(16);
    return s.length === 1 ? '0' + s : s;
  };
  return '#' + toByte(alpha) + toByte(r) + toByte(g) + toByte(b);
}
