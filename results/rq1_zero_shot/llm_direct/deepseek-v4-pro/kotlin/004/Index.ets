import { UIAbility } from '@kit.AbilityKit';
import { window } from '@kit.ArkUI';

// AppTokens - Design tokens
class AppColors {
  static readonly primary: string = '#1F2937';
  static readonly secondary: string = '#10B981';
  static readonly tertiary: string = '#3B82F6';
  static readonly background: string = '#F3F4F6';
  static readonly surface: string = '#FFFFFF';
  static readonly surfaceVariant: string = '#E5E7EB';
  static readonly outline: string = '#D1D5DB';
  static readonly success: string = '#16A34A';
  static readonly warning: string = '#F59E0B';
  static readonly error: string = '#EF4444';
  static readonly onPrimary: string = '#FFFFFF';
  static readonly onSecondary: string = '#0B1220';
  static readonly onTertiary: string = '#FFFFFF';
  static readonly onBackground: string = '#0B1220';
  static readonly onSurface: string = '#0B1220';
}

class AppSpacing {
  static readonly xs: number = 2;
  static readonly sm: number = 4;
  static readonly md: number = 6;
  static readonly lg: number = 8;
  static readonly xl: number = 12;
  static readonly xxl: number = 16;
  static readonly xxxl: number = 24;
}

class AppShapes {
  static readonly small: number = 6;
  static readonly medium: number = 8;
  static readonly large: number = 12;
}

// Data models
interface AccountCard {
  id: number;
  name: string;
  balance: string;
  accent: string;
}

interface TxItem {
  id: number;
  title: string;
  subtitle: string;
  amount: string;
  positive: boolean;
}

@Entry
@Component
struct FinanceWalletApp {
  @State showBalance: boolean = true;
  @State selectedRange: string = 'Month';
  @State incomeFilter: boolean = false;
  @State expenseFilter: boolean = false;
  @State accounts: AccountCard[] = [
    { id: 1, name: 'Wallet', balance: '$2,845.20', accent: '#10B981' },
    { id: 2, name: 'Savings', balance: '$8,120.00', accent: '#3B82F6' },
    { id: 3, name: 'Investments', balance: '$15,430.55', accent: '#F59E0B' }
  ];
  @State transactions: TxItem[] = [
    { id: 1, title: 'Grocery Market', subtitle: 'Today • 12:40', amount: '-$32.18', positive: false },
    { id: 2, title: 'Salary', subtitle: 'Yesterday • 09:00', amount: '+$3,200.00', positive: true },
    { id: 3, title: 'Coffee Shop', subtitle: 'Yesterday • 15:22', amount: '-$4.90', positive: false },
    { id: 4, title: 'ETF Purchase', subtitle: 'Mon • 10:05', amount: '-$250.00', positive: false },
    { id: 5, title: 'Refund', subtitle: 'Sun • 18:40', amount: '+$18.99', positive: true }
  ];
  private rangeOptions: string[] = ['All', 'Week', 'Month', 'Year'];

  @Builder
  TopBar() {
    Row() {
      Row({ space: AppSpacing.sm }) {
        Row()
          .width(20)
          .height(20)
          .borderRadius(AppShapes.small)
          .backgroundColor(AppColors.primary)
        Text('Wallet')
          .fontSize(24)
          .fontWeight(FontWeight.Medium)
          .fontColor(AppColors.onSurface)
      }
    }
    .width('100%')
    .height(56)
    .padding({ left: AppSpacing.lg, right: AppSpacing.lg })
    .alignItems(VerticalAlign.Center)
    .backgroundColor(AppColors.surface)
  }

  @Builder
  BottomBar() {
    Row() {
      Column({ space: AppSpacing.xs }) {
        Text('Total Balance')
          .fontSize(10)
          .fontWeight(FontWeight.Medium)
          .fontColor(AppColors.onSurface)
        Text(this.showBalance ? '$26,395.75' : '•••••••')
          .fontSize(18)
          .fontWeight(FontWeight.Medium)
          .fontColor(AppColors.onSurface)
      }
      .alignItems(HorizontalAlign.Start)

      Button('Add Money')
        .height(44)
        .width(140)
        .borderRadius(AppShapes.large)
        .backgroundColor(AppColors.secondary)
        .fontColor(AppColors.onSecondary)
        .fontSize(14)
        .fontWeight(FontWeight.Medium)
    }
    .width('100%')
    .padding({
      left: AppSpacing.lg,
      right: AppSpacing.lg,
      top: AppSpacing.md,
      bottom: AppSpacing.md
    })
    .justifyContent(FlexAlign.SpaceBetween)
    .alignItems(VerticalAlign.Center)
    .backgroundColor(AppColors.surface)
    .shadow({ radius: 6, color: 'rgba(0,0,0,0.16)', offsetY: 1.5 })
  }

  @Builder
  RangeFilterChip(label: string, active: boolean) {
    Row() {
      Text(label)
        .fontSize(active ? 14 : 12)
        .fontWeight(active ? FontWeight.Medium : FontWeight.Normal)
        .fontColor(active ? AppColors.onPrimary : AppColors.onSurface)
    }
    .padding({
      left: AppSpacing.xl,
      right: AppSpacing.xl,
      top: AppSpacing.md,
      bottom: AppSpacing.md
    })
    .borderRadius(AppShapes.medium)
    .backgroundColor(active ? AppColors.primary : AppColors.surface)
    .border({ width: 1, color: AppColors.outline })
    .onClick(() => {
      this.selectedRange = label;
    })
  }

  @Builder
  AccountCardView(account: AccountCard) {
    Column({ space: AppSpacing.sm }) {
      Row() {
        Row({ space: AppSpacing.sm }) {
          Row()
            .width(16)
            .height(16)
            .borderRadius(AppShapes.small)
            .backgroundColor(account.accent)
          Text(account.name)
            .fontSize(14)
            .fontWeight(FontWeight.Medium)
            .fontColor(AppColors.onSurface)
        }

        Row() {
          Text('Manage')
            .fontSize(10)
            .fontWeight(FontWeight.Medium)
            .fontColor(AppColors.onSecondary)
        }
        .padding({
          left: AppSpacing.lg,
          right: AppSpacing.lg,
          top: AppSpacing.sm,
          bottom: AppSpacing.sm
        })
        .borderRadius(AppShapes.small)
        .backgroundColor(AppColors.secondary)
        .border({ width: 1, color: AppColors.outline })
      }
      .width('100%')
      .justifyContent(FlexAlign.SpaceBetween)
      .alignItems(VerticalAlign.Center)

      Row() {
        Text(this.showBalance ? account.balance : '•••••••')
          .fontSize(18)
          .fontWeight(FontWeight.Medium)
          .fontColor(AppColors.onSurface)
      }
      .width('100%')
      .aspectRatio(2.8)
      .borderRadius(AppShapes.medium)
      .backgroundColor(AppColors.surfaceVariant)
      .justifyContent(FlexAlign.Center)
      .alignItems(VerticalAlign.Center)

      Row({ space: AppSpacing.sm }) {
        Row() {
          Text('Transfer')
            .fontSize(10)
            .fontWeight(FontWeight.Medium)
            .fontColor(AppColors.onSecondary)
        }
        .padding({
          left: AppSpacing.lg,
          right: AppSpacing.lg,
          top: AppSpacing.sm,
          bottom: AppSpacing.sm
        })
        .borderRadius(AppShapes.small)
        .backgroundColor(AppColors.secondary)
        .border({ width: 1, color: AppColors.outline })

        Row() {
          Text('Details')
            .fontSize(10)
            .fontWeight(FontWeight.Medium)
            .fontColor(AppColors.onSurface)
        }
        .padding({
          left: AppSpacing.lg,
          right: AppSpacing.lg,
          top: AppSpacing.sm,
          bottom: AppSpacing.sm
        })
        .borderRadius(AppShapes.small)
        .backgroundColor(AppColors.surface)
        .border({ width: 1, color: AppColors.outline })
      }
    }
    .width('100%')
    .padding(AppSpacing.lg)
    .borderRadius(AppShapes.large)
    .backgroundColor(AppColors.surface)
    .border({ width: 1, color: AppColors.outline })
    .shadow({ radius: 4, color: 'rgba(0,0,0,0.14)', offsetY: 1 })
  }

  @Builder
  TransactionCardView(tx: TxItem) {
    Row() {
      Row({ space: AppSpacing.md }) {
        Row()
          .width(32)
          .height(32)
          .borderRadius(AppShapes.small)
          .backgroundColor(tx.positive ? AppColors.success : AppColors.error)
        Column({ space: AppSpacing.xs }) {
          Text(tx.title)
            .fontSize(14)
            .fontWeight(FontWeight.Medium)
            .fontColor(AppColors.onSurface)
          Text(tx.subtitle)
            .fontSize(12)
            .fontWeight(FontWeight.Normal)
            .fontColor(AppColors.onSurface)
        }
        .alignItems(HorizontalAlign.Start)
      }
      .alignItems(VerticalAlign.Center)

      Text(tx.amount)
        .fontSize(14)
        .fontWeight(FontWeight.Medium)
        .fontColor(tx.positive ? AppColors.success : AppColors.error)
    }
    .width('100%')
    .padding(AppSpacing.lg)
    .justifyContent(FlexAlign.SpaceBetween)
    .alignItems(VerticalAlign.Center)
    .borderRadius(AppShapes.large)
    .backgroundColor(AppColors.surface)
    .border({ width: 1, color: AppColors.outline })
    .shadow({ radius: 2, color: 'rgba(0,0,0,0.12)', offsetY: 0.5 })
  }

  @Builder
  FilterChipButton(label: string, active: boolean, onToggle: () => void) {
    Row() {
      Text(label)
        .fontSize(10)
        .fontWeight(FontWeight.Medium)
        .fontColor(active ? AppColors.onSecondary : AppColors.onSurface)
    }
    .padding({
      left: AppSpacing.lg,
      right: AppSpacing.lg,
      top: AppSpacing.sm,
      bottom: AppSpacing.sm
    })
    .borderRadius(AppShapes.small)
    .backgroundColor(active ? AppColors.secondary : AppColors.surface)
    .border({ width: 1, color: AppColors.outline })
    .onClick(() => {
      onToggle();
    })
  }

  build() {
    Column() {
      // Top Bar
      this.TopBar()

      // Main Content
      Scroll() {
        Column({ space: AppSpacing.lg }) {
          // Range filter row
          Row() {
            Row({ space: AppSpacing.sm }) {
              ForEach(this.rangeOptions, (range: string) => {
                this.RangeFilterChip(range, range === this.selectedRange)
              })
            }

            Row({ space: AppSpacing.sm }) {
              Text('Hide')
                .fontSize(10)
                .fontWeight(FontWeight.Medium)
                .fontColor(AppColors.onSurface)
              Toggle({ type: ToggleType.Switch, isOn: !this.showBalance })
                .selectedColor(AppColors.primary)
                .switchPointColor(AppColors.onPrimary)
                .onChange((isOn: boolean) => {
                  this.showBalance = !isOn;
                })
            }
            .alignItems(VerticalAlign.Center)
          }
          .width('100%')
          .justifyContent(FlexAlign.SpaceBetween)
          .alignItems(VerticalAlign.Center)

          // Account cards
          ForEach(this.accounts, (account: AccountCard) => {
            this.AccountCardView(account)
          })

          // Recent Activity header
          Row() {
            Text('Recent Activity')
              .fontSize(18)
              .fontWeight(FontWeight.Medium)
              .fontColor(AppColors.onSurface)
            Row({ space: AppSpacing.sm }) {
              this.FilterChipButton('Income', this.incomeFilter, () => {
                this.incomeFilter = !this.incomeFilter;
              })
              this.FilterChipButton('Expense', this.expenseFilter, () => {
                this.expenseFilter = !this.expenseFilter;
              })
            }
            .alignItems(VerticalAlign.Center)
          }
          .width('100%')
          .justifyContent(FlexAlign.SpaceBetween)
          .alignItems(VerticalAlign.Center)

          // Transaction cards
          ForEach(this.transactions, (tx: TxItem) => {
            this.TransactionCardView(tx)
          })

          // Bottom spacer
          Row()
            .width('100%')
            .height(AppSpacing.xxl)
        }
        .width('100%')
        .padding({
          left: AppSpacing.lg,
          right: AppSpacing.lg,
          top: AppSpacing.md,
          bottom: AppSpacing.xxxl
        })
      }
      .layoutWeight(1)
      .backgroundColor(AppColors.background)
      .scrollBar(BarState.Off)

      // Bottom Bar
      this.BottomBar()
    }
    .width('100%')
    .height('100%')
    .backgroundColor(AppColors.background)
  }
}

@Entry
@Component
struct FinanceWalletAppEntry {
  build() {
    FinanceWalletApp()
  }
}