import { router } from '@kit.ArkUI';

// --- Data Models & Tokens ---

interface AccountCard {
  id: number;
  name: string;
  balance: string;
  accentColor: string;
}

interface TxItem {
  id: number;
  title: string;
  subtitle: string;
  amount: string;
  positive: boolean;
}

const AppTokens = {
  Colors: {
    primary: '#1F2937',
    secondary: '#10B981',
    tertiary: '#3B82F6',
    background: '#F3F4F6',
    surface: '#FFFFFF',
    surfaceVariant: '#E5E7EB',
    outline: '#D1D5DB',
    success: '#16A34A',
    warning: '#F59E0B',
    error: '#EF4444',
    onPrimary: '#FFFFFF',
    onSecondary: '#0B1220',
    onTertiary: '#FFFFFF',
    onBackground: '#0B1220',
    onSurface: '#0B1220'
  },
  Spacing: {
    xs: 2,
    sm: 4,
    md: 6,
    lg: 8,
    xl: 12,
    xxl: 16,
    xxxl: 24
  },
  FontSizes: {
    display: 24,
    headline: 18,
    title: 14,
    body: 12,
    label: 10
  }
};

@Entry
@Component
struct RootScreen {
  @State showBalance: boolean = true;
  @State selectedRange: string = 'Month';
  @State flags: string[] = [];

  private accounts: AccountCard[] = [
    { id: 1, name: 'Wallet', balance: '$2,845.20', accentColor: AppTokens.Colors.secondary },
    { id: 2, name: 'Savings', balance: '$8,120.00', accentColor: AppTokens.Colors.tertiary },
    { id: 3, name: 'Investments', balance: '$15,430.55', accentColor: AppTokens.Colors.warning }
  ];

  private txs: TxItem[] = [
    { id: 1, title: 'Grocery Market', subtitle: 'Today • 12:40', amount: '-$32.18', positive: false },
    { id: 2, title: 'Salary', subtitle: 'Yesterday • 09:00', amount: '+$3,200.00', positive: true },
    { id: 3, title: 'Coffee Shop', subtitle: 'Yesterday • 15:22', amount: '-$4.90', positive: false },
    { id: 4, title: 'ETF Purchase', subtitle: 'Mon • 10:05', amount: '-$250.00', positive: false },
    { id: 5, title: 'Refund', subtitle: 'Sun • 18:40', amount: '+$18.99', positive: true }
  ];

  build() {
    Column() {
      // Top Bar
      Row() {
        Text('Wallet')
          .fontSize(AppTokens.FontSizes.display)
          .fontWeight(FontWeight.Bold)
          .fontColor(AppTokens.Colors.onSurface)
      }
      .width('100%')
      .justifyContent(FlexAlign.Center)
      .padding({ top: 20, bottom: 10 })

      // Main Scrollable Content
      Scroll() {
        Column() {
          // Range Filter & Hide Toggle
          Row() {
            Row() {
              ForEach(['All', 'Week', 'Month', 'Year'], (range: string) => {
                Button(range)
                  .type(ButtonType.Normal)
                  .backgroundColor(this.selectedRange === range ? AppTokens.Colors.primary : AppTokens.Colors.surface)
                  .fontColor(this.selectedRange === range ? AppTokens.Colors.onPrimary : AppTokens.Colors.onSurface)
                  .borderWidth(1)
                  .borderColor(AppTokens.Colors.outline)
                  .borderRadius(8)
                  .margin({ right: AppTokens.Spacing.sm })
                  .onClick(() => {
                    this.selectedRange = range;
                  })
              })
            }
            .alignItems(VerticalAlign.Center)

            Blank()

            Row() {
              Text('Hide')
                .fontSize(AppTokens.FontSizes.label)
                .fontColor(AppTokens.Colors.onSurface)
                .margin({ right: AppTokens.Spacing.sm })

              Toggle({ type: ToggleType.Switch, isOn: !this.showBalance })
                .onChange((isOn: boolean) => {
                  this.showBalance = !isOn;
                })
                .selectedColor(AppTokens.Colors.primary)
            }
            .alignItems(VerticalAlign.Center)
          }
          .width('100%')
          .justifyContent(FlexAlign.SpaceBetween)
          .padding({ top: 10, bottom: 10 })

          // Account Cards
          ForEach(this.accounts, (account: AccountCard) => {
            Card({ account: account, showBalance: this.showBalance })
          })

          // Recent Activity Header
          Row() {
            Text('Recent Activity')
              .fontSize(AppTokens.FontSizes.headline)
              .fontWeight(FontWeight.Bold)
              .fontColor(AppTokens.Colors.onSurface)

            Blank()

            Row() {
              ChipButton({ text: 'Income', isActive: this.flags.includes('Income') })
                .margin({ right: AppTokens.Spacing.sm })
                .onClick(() => {
                  if (this.flags.includes('Income')) {
                    this.flags = this.flags.filter(f => f !== 'Income');
                  } else {
                    this.flags.push('Income');
                  }
                })

              ChipButton({ text: 'Expense', isActive: this.flags.includes('Expense') })
                .onClick(() => {
                  if (this.flags.includes('Expense')) {
                    this.flags = this.flags.filter(f => f !== 'Expense');
                  } else {
                    this.flags.push('Expense');
                  }
                })
            }
          }
          .width('100%')
          .justifyContent(FlexAlign.SpaceBetween)
          .alignItems(VerticalAlign.Center)
          .margin({ top: AppTokens.Spacing.lg })

          // Transaction List
          ForEach(this.txs, (tx: TxItem) => {
            TransactionItem({ tx: tx })
          })

          Column().height(AppTokens.Spacing.xxl)
        }
        .padding({ left: AppTokens.Spacing.lg, right: AppTokens.Spacing.lg })
      }
      .layoutWeight(1)

      // Bottom Bar
      Row() {
        Column() {
          Text('Total Balance')
            .fontSize(AppTokens.FontSizes.label)
            .fontColor(AppTokens.Colors.onSurface)
          Text(this.showBalance ? '$26,395.75' : '•••••••')
            .fontSize(AppTokens.FontSizes.headline)
            .fontWeight(FontWeight.Bold)
            .fontColor(AppTokens.Colors.onSurface)
        }
        .alignItems(HorizontalAlign.Start)

        Button('Add Money')
          .type(ButtonType.Normal)
          .backgroundColor(AppTokens.Colors.secondary)
          .fontColor(AppTokens.Colors.onSecondary)
          .borderRadius(12)
          .width(140)
          .height(44)
          .margin({ left: 'auto' })
      }
      .width('100%')
      .padding({ left: AppTokens.Spacing.lg, right: AppTokens.Spacing.lg, top: AppTokens.Spacing.md, bottom: AppTokens.Spacing.md })
      .backgroundColor(AppTokens.Colors.surface)
      .shadow({ radius: 10, color: '#0000001A', offsetY: -2 })
    }
    .width('100%')
    .height('100%')
    .backgroundColor(AppTokens.Colors.background)
  }
}

@Component
struct Card {
  @Prop account: AccountCard;
  @Prop showBalance: boolean;

  build() {
    Column() {
      Row() {
        Row() {
          Circle()
            .width(16)
            .height(16)
            .fill(this.account.accentColor)
            .margin({ right: AppTokens.Spacing.sm })

          Text(this.account.name)
            .fontSize(AppTokens.FontSizes.title)
            .fontWeight(FontWeight.Medium)
            .fontColor(AppTokens.Colors.onSurface)
        }
        .alignItems(VerticalAlign.Center)

        Button('Manage')
          .type(ButtonType.Normal)
          .backgroundColor(AppTokens.Colors.secondary)
          .fontColor(AppTokens.Colors.onSecondary)
          .borderRadius(6)
          .margin({ left: 'auto' })
      }
      .width('100%')
      .margin({ bottom: AppTokens.Spacing.sm })

      Column() {
        Text(this.showBalance ? this.account.balance : '•••••••')
          .fontSize(AppTokens.FontSizes.headline)
          .fontWeight(FontWeight.Bold)
          .fontColor(AppTokens.Colors.onSurface)
      }
      .width('100%')
      .aspectRatio(2.8)
      .backgroundColor(AppTokens.Colors.surfaceVariant)
      .borderRadius(8)
      .justifyContent(FlexAlign.Center)
      .margin({ bottom: AppTokens.Spacing.sm })

      Row() {
        Button('Transfer')
          .type(ButtonType.Normal)
          .backgroundColor(AppTokens.Colors.secondary)
          .fontColor(AppTokens.Colors.onSecondary)
          .borderRadius(6)
          .margin({ right: AppTokens.Spacing.sm })

        Button('Details')
          .type(ButtonType.Normal)
          .backgroundColor(AppTokens.Colors.surface)
          .fontColor(AppTokens.Colors.onSurface)
          .borderWidth(1)
          .borderColor(AppTokens.Colors.outline)
          .borderRadius(6)
      }
    }
    .width('100%')
    .padding(AppTokens.Spacing.lg)
    .backgroundColor(AppTokens.Colors.surface)
    .borderRadius(12)
    .shadow({ radius: 8, color: '#0000001A', offsetY: 2 })
    .margin({ bottom: AppTokens.Spacing.lg })
  }
}

@Component
struct TransactionItem {
  @Prop tx: TxItem;

  build() {
    Row() {
      Row() {
        Circle()
          .width(32)
          .height(32)
          .fill(this.tx.positive ? AppTokens.Colors.success : AppTokens.Colors.error)
          .margin({ right: AppTokens.Spacing.md })

        Column() {
          Text(this.tx.title)
            .fontSize(AppTokens.FontSizes.title)
            .fontWeight(FontWeight.Medium)
            .fontColor(AppTokens.Colors.onSurface)
          Text(this.tx.subtitle)
            .fontSize(AppTokens.FontSizes.body)
            .fontColor(AppTokens.Colors.onSurface)
        }
        .alignItems(HorizontalAlign.Start)
      }
      .alignItems(VerticalAlign.Center)

      Text(this.tx.amount)
        .fontSize(AppTokens.FontSizes.title)
        .fontWeight(FontWeight.Medium)
        .fontColor(this.tx.positive ? AppTokens.Colors.success : AppTokens.Colors.error)
        .margin({ left: 'auto' })
    }
    .width('100%')
    .padding(AppTokens.Spacing.lg)
    .backgroundColor(AppTokens.Colors.surface)
    .borderRadius(12)
    .shadow({ radius: 4, color: '#0000001A', offsetY: 1 })
    .margin({ bottom: AppTokens.Spacing.lg })
  }
}

@Component
struct ChipButton {
  @Prop text: string;
  @Prop isActive: boolean;

  build() {
    Button(this.text)
      .type(ButtonType.Normal)
      .backgroundColor(this.isActive ? AppTokens.Colors.secondary : AppTokens.Colors.surface)
      .fontColor(this.isActive ? AppTokens.Colors.onSecondary : AppTokens.Colors.onSurface)
      .borderWidth(1)
      .borderColor(AppTokens.Colors.outline)
      .borderRadius(6)
  }
}