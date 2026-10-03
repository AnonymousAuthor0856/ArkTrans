import { Font, FontWeight } from '@kit.ArkUI'

// MARK: - App Tokens & Colors
interface ColorTokens {
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

interface TypographyToken {
  size: number;
  weight: FontWeight;
}

interface TypographyTokens {
  display: TypographyToken;
  headline: TypographyToken;
  title: TypographyToken;
  body: TypographyToken;
  label: TypographyToken;
}

interface SpacingTokens {
  xs: number;
  sm: number;
  md: number;
  lg: number;
  xl: number;
  xxl: number;
  xxxl: number;
}

interface ShapeTokens {
  small: number;
  medium: number;
  large: number;
}

interface AppTokenConfig {
  Colors: ColorTokens;
  Typography: TypographyTokens;
  Spacing: SpacingTokens;
  Shapes: ShapeTokens;
}

const AppTokens: AppTokenConfig = {
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
    onSurface: '#0B1220'
  },
  Typography: {
    display: { size: 24, weight: FontWeight.Bold },
    headline: { size: 18, weight: FontWeight.Bold },
    title: { size: 14, weight: FontWeight.Medium },
    body: { size: 12, weight: FontWeight.Normal },
    label: { size: 10, weight: FontWeight.Medium }
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
  Shapes: {
    small: 6,
    medium: 8,
    large: 12
  }
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

// MARK: - Components

@Component
struct FilterChip {
  @Prop label: string;
  @Prop isSelected: boolean;
  onClick?: () => void;

  build() {
    Button(this.label, { type: ButtonType.Normal })
      .font({ size: this.isSelected ? AppTokens.Typography.title.size : AppTokens.Typography.body.size, weight: this.isSelected ? AppTokens.Typography.title.weight : AppTokens.Typography.body.weight })
      .fontColor(this.isSelected ? AppTokens.Colors.onPrimary : AppTokens.Colors.onSurface)
      .padding({ left: 12, right: 12, top: 8, bottom: 8 })
      .backgroundColor(this.isSelected ? AppTokens.Colors.primary : AppTokens.Colors.surface)
      .borderRadius(AppTokens.Shapes.medium)
      .border({ width: this.isSelected ? 0 : 1, color: AppTokens.Colors.outline })
      .onClick(() => {
        if (this.onClick) {
          this.onClick();
        }
      })
  }
}

@Component
struct AssistChip {
  @Prop label: string;
  @Prop isSelected: boolean;
  onClick?: () => void;

  build() {
    Button(this.label, { type: ButtonType.Normal })
      .font({ size: AppTokens.Typography.label.size, weight: AppTokens.Typography.label.weight })
      .fontColor(this.isSelected ? AppTokens.Colors.onSecondary : AppTokens.Colors.onSurface)
      .padding({ left: 8, right: 8, top: 6, bottom: 6 })
      .backgroundColor(this.isSelected ? AppTokens.Colors.secondary : AppTokens.Colors.surface)
      .borderRadius(AppTokens.Shapes.small)
      .border({ width: 1, color: AppTokens.Colors.outline })
      .onClick(() => {
        if (this.onClick) {
          this.onClick();
        }
      })
  }
}

@Component
struct AccountCardView {
  @ObjectLink account: AccountCardModel;
  @Prop showBalance: boolean;

  build() {
    Column() {
      // Header
      Row() {
        Row() {
          Circle()
            .fill(this.account.accent)
            .width(16)
            .height(16)
          
          Text(this.account.name)
            .font({ size: AppTokens.Typography.title.size, weight: AppTokens.Typography.title.weight })
            .fontColor(AppTokens.Colors.onSurface)
        }
        .margin({ right: AppTokens.Spacing.sm })

        Flex().alignSelf(ItemAlign.Center)

        Button('Manage')
          .font({ size: AppTokens.Typography.label.size, weight: AppTokens.Typography.label.weight })
          .fontColor(AppTokens.Colors.onSecondary)
          .backgroundColor(AppTokens.Colors.secondary)
          .borderRadius(AppTokens.Shapes.small)
          .border({ width: 1, color: AppTokens.Colors.outline })
          .type(ButtonType.Capsule)
      }
      .width('100%')
      .margin({ bottom: AppTokens.Spacing.sm })

      // Balance Box
      Stack({ alignContent: Alignment.Center }) {
        Text(this.showBalance ? this.account.balance : '•••••••')
          .font({ size: AppTokens.Typography.headline.size, weight: AppTokens.Typography.headline.weight })
          .fontColor(AppTokens.Colors.onSurface)
      }
      .width('100%')
      .aspectRatio(2.8)
      .backgroundColor(AppTokens.Colors.surfaceVariant)
      .borderRadius(AppTokens.Shapes.medium)
      .margin({ bottom: AppTokens.Spacing.sm })

      // Actions
      Row() {
        Button('Transfer')
          .font({ size: AppTokens.Typography.label.size, weight: AppTokens.Typography.label.weight })
          .fontColor(AppTokens.Colors.onSecondary)
          .backgroundColor(AppTokens.Colors.secondary)
          .borderRadius(AppTokens.Shapes.small)
          .border({ width: 1, color: AppTokens.Colors.outline })
          .type(ButtonType.Capsule)
        
        Flex().alignSelf(ItemAlign.Center)

        Button('Details')
          .font({ size: AppTokens.Typography.label.size, weight: AppTokens.Typography.label.weight })
          .fontColor(AppTokens.Colors.onSurface)
          .backgroundColor(AppTokens.Colors.surface)
          .borderRadius(AppTokens.Shapes.small)
          .border({ width: 1, color: AppTokens.Colors.outline })
          .type(ButtonType.Capsule)
      }
      .width('100%')
    }
    .padding(AppTokens.Spacing.lg)
    .backgroundColor(AppTokens.Colors.surface)
    .borderRadius(AppTokens.Shapes.large)
    .shadow({ radius: 4, color: '#00000022', offsetX: 0, offsetY: 1 })
    .border({ width: 1, color: AppTokens.Colors.outline })
    .height(120)
  }
}

@Component
struct TransactionCard {
  @ObjectLink tx: TxItemModel;

  build() {
    Row() {
      Row() {
        Circle()
          .fill(this.tx.positive ? AppTokens.Colors.success : AppTokens.Colors.error)
          .width(32)
          .height(32)
        
        Column() {
          Text(this.tx.title)
            .font({ size: AppTokens.Typography.title.size, weight: AppTokens.Typography.title.weight })
            .fontColor(AppTokens.Colors.onSurface)
          
          Text(this.tx.subtitle)
            .font({ size: AppTokens.Typography.body.size, weight: AppTokens.Typography.body.weight })
            .fontColor(AppTokens.Colors.onSurface)
        }
        .alignItems(HorizontalAlign.Start)
        .margin({ left: AppTokens.Spacing.md })
      }

      Flex().alignSelf(ItemAlign.Center)

      Text(this.tx.amount)
        .font({ size: AppTokens.Typography.title.size, weight: AppTokens.Typography.title.weight })
        .fontColor(this.tx.positive ? AppTokens.Colors.success : AppTokens.Colors.error)
    }
    .padding(AppTokens.Spacing.lg)
    .height(72)
    .backgroundColor(AppTokens.Colors.surface)
    .borderRadius(AppTokens.Shapes.large)
    .shadow({ radius: 2, color: '#0000001F', offsetX: 0, offsetY: 0.5 })
    .border({ width: 1, color: AppTokens.Colors.outline })
  }
}

// MARK: - Root View
@Entry
@Component
struct ContentView {
  @State showBalance: boolean = true;
  @State selectedFilter: string = "Month";
  @State flags: Set<string> = new Set<string>();

  private filters: string[] = ["All", "Week", "Month", "Year"];
  
  private accounts: AccountCardModel[] = [
    { id: 1, name: "Wallet", balance: "$2,845.20", accent: '#10B981' },
    { id: 2, name: "Savings", balance: "$8,120.00", accent: '#3B82F6' },
    { id: 3, name: "Investments", balance: "$15,430.55", accent: '#F59E0B' }
  ];

  private transactions: TxItemModel[] = [
    { id: 1, title: "Grocery Market", subtitle: "Today • 12:40", amount: "-$32.18", positive: false },
    { id: 2, title: "Salary", subtitle: "Yesterday • 09:00", amount: "+$3,200.00", positive: true },
    { id: 3, title: "Coffee Shop", subtitle: "Yesterday • 15:22", amount: "-$4.90", positive: false },
    { id: 4, title: "ETF Purchase", subtitle: "Mon • 10:05", amount: "-$250.00", positive: false },
    { id: 5, title: "Refund", subtitle: "Sun • 18:40", amount: "+$18.99", positive: true }
  ];

  build() {
    Stack() {
      // Background
      Column()
        .width('100%')
        .height('100%')
        .backgroundColor(AppTokens.Colors.background)

      Column() {
        // Top Bar
        Row() {
          Circle()
            .fill(AppTokens.Colors.primary)
            .width(20)
            .height(20)
          
          Text("Wallet")
            .font({ size: AppTokens.Typography.display.size, weight: AppTokens.Typography.display.weight })
            .fontColor(AppTokens.Colors.onSurface)
          
          Flex().alignSelf(ItemAlign.Center)
        }
        .padding(AppTokens.Spacing.lg)
        .width('100%')

        // Content
        Scroll() {
          Column() {
            // Filters Row
            Row() {
              Row() {
                ForEach(this.filters, (filter: string) => {
                  FilterChip({
                    label: filter,
                    isSelected: this.selectedFilter === filter,
                    onClick: () => {
                      this.selectedFilter = filter;
                    }
                  })
                }, (item: string) => item)
              }
              .margin({ right: AppTokens.Spacing.sm })

              Flex().alignSelf(ItemAlign.Center)

              Row() {
                Text("Hide")
                  .font({ size: AppTokens.Typography.label.size, weight: AppTokens.Typography.label.weight })
                  .fontColor(AppTokens.Colors.onSurface)
                
                Toggle({ type: ToggleType.Switch, isOn: !this.showBalance })
                  .onChange((isOn: boolean) => {
                    this.showBalance = !isOn;
                  })
                  .width(36)
                  .height(20)
                  .selectedColor(AppTokens.Colors.primary)
              }
            }
            .width('100%')
            .margin({ bottom: AppTokens.Spacing.lg })

            // Accounts List
            ForEach(this.accounts, (account: AccountCardModel) => {
              AccountCardView({
                account: account,
                showBalance: this.showBalance
              })
            }, (item: AccountCardModel) => item.id.toString())

            // Recent Activity Header
            Row() {
              Text("Recent Activity")
                .font({ size: AppTokens.Typography.headline.size, weight: AppTokens.Typography.headline.weight })
                .fontColor(AppTokens.Colors.onSurface)
              
              Flex().alignSelf(ItemAlign.Center)
              
              Row() {
                AssistChip({
                  label: "Income",
                  isSelected: this.flags.has("Income"),
                  onClick: () => {
                    if (this.flags.has("Income")) {
                      this.flags.delete("Income");
                    } else {
                      this.flags.add("Income");
                    }
                  }
                })
                
                AssistChip({
                  label: "Expense",
                  isSelected: this.flags.has("Expense"),
                  onClick: () => {
                    if (this.flags.has("Expense")) {
                      this.flags.delete("Expense");
                    } else {
                      this.flags.add("Expense");
                    }
                  }
                })
              }
            }
            .width('100%')
            .margin({ top: AppTokens.Spacing.lg, bottom: AppTokens.Spacing.md })

            // Transactions List
            ForEach(this.transactions, (tx: TxItemModel) => {
              TransactionCard({
                tx: tx
              })
            }, (item: TxItemModel) => item.id.toString())

            // Bottom Padding for FAB/BottomBar
            Flex().height(100)
          }
          .padding({ left: AppTokens.Spacing.lg, right: AppTokens.Spacing.lg, top: AppTokens.Spacing.md, bottom: AppTokens.Spacing.md })
        }
        .layoutWeight(1)
        .scrollBar(BarState.Off)
      }
      .width('100%')
      .height('100%')

      // Bottom Bar Overlay
      Column() {
        Flex().alignSelf(ItemAlign.End)
        
        Column() {
          Row() {
            Column() {
              Text("Total Balance")
                .font({ size: AppTokens.Typography.title.size, weight: AppTokens.Typography.title.weight })
                .fontColor(AppTokens.Colors.onSurface)
              
              Text(this.showBalance ? "$26,395.75" : "•••••••")
                .font({ size: AppTokens.Typography.headline.size, weight: AppTokens.Typography.headline.weight })
                .fontColor(AppTokens.Colors.onSurface)
            }
            .alignItems(HorizontalAlign.Start)
            
            Flex().alignSelf(ItemAlign.Center)
            
            Button("Add Money")
              .font({ size: AppTokens.Typography.title.size, weight: AppTokens.Typography.title.weight })
              .fontColor(AppTokens.Colors.onSecondary)
              .width(140)
              .height(44)
              .backgroundColor(AppTokens.Colors.secondary)
              .borderRadius(AppTokens.Shapes.large)
          }
          .padding({ left: AppTokens.Spacing.lg, right: AppTokens.Spacing.lg, top: AppTokens.Spacing.md, bottom: AppTokens.Spacing.md })
        }
        .width('100%')
        .backgroundColor(AppTokens.Colors.surface)
        .shadow({ radius: 6, color: '#00000029', offsetX: 0, offsetY: -1.5 })
      }
      .width('100%')
    }
  }
}