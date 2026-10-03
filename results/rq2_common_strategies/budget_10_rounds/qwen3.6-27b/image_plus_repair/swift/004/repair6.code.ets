import { FontWeight } from '@kit.ArkUI';

export interface ColorToken {
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

export interface TypographyToken {
  size: number;
  weight: FontWeight;
}

export interface TypographyConfig {
  display: TypographyToken;
  headline: TypographyToken;
  title: TypographyToken;
  body: TypographyToken;
  label: TypographyToken;
}

export interface SpacingToken {
  xs: number;
  sm: number;
  md: number;
  lg: number;
  xl: number;
  xxl: number;
  xxxl: number;
}

export interface ShapeToken {
  small: number;
  medium: number;
  large: number;
}

export class AppTokens {
  static readonly Colors: ColorToken = {
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
  }

  static readonly Typography: TypographyConfig = {
    display: { size: 24, weight: FontWeight.Bold },
    headline: { size: 18, weight: FontWeight.Bold },
    title: { size: 14, weight: FontWeight.Medium },
    body: { size: 12, weight: FontWeight.Normal },
    label: { size: 10, weight: FontWeight.Medium }
  }

  static readonly Spacing: SpacingToken = {
    xs: 2,
    sm: 4,
    md: 6,
    lg: 8,
    xl: 12,
    xxl: 16,
    xxxl: 24
  }

  static readonly Shapes: ShapeToken = {
    small: 6,
    medium: 8,
    large: 12
  }
}

export interface AccountCardModel {
  id: number;
  name: string;
  balance: string;
  accent: string;
}

export interface TxItemModel {
  id: number;
  title: string;
  subtitle: string;
  amount: string;
  positive: boolean;
}

@Component
export struct FilterChip {
  @Prop label: string;
  @Prop isSelected: boolean;
  onClick?: () => void;

  build() {
    Button(this.label)
      .width('auto')
      .height(36) // Approximate height based on padding + font
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
export struct AssistChip {
  @Prop label: string;
  @Prop isSelected: boolean;
  onClick?: () => void;

  build() {
    Button(this.label)
      .width('auto')
      .height(28) // Approximate height
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
export struct AccountCardView {
  @ObjectLink account: AccountCardModel;
  @Prop showBalance: boolean;

  build() {
    Column() {
      Row() {
        Row() {
          Circle()
            .fill(this.account.accent)
            .width(16)
            .height(16)
          
          Text(this.account.name)
            .margin({ left: AppTokens.Spacing.sm })
            .fontColor(AppTokens.Colors.onSurface)
            .fontSize(AppTokens.Typography.title.size)
            .fontWeight(AppTokens.Typography.title.weight)
        }
        
        Blank()
        
        Button('Manage')
          .backgroundColor(AppTokens.Colors.secondary)
          .borderRadius(AppTokens.Shapes.small)
          .border({ width: 1, color: AppTokens.Colors.outline })
          .height(28)
          .padding({ left: 8, right: 8 })
      }
      .width('100%')
      
      Column() {
        Text(this.showBalance ? this.account.balance : '•••••••')
          .fontColor(AppTokens.Colors.onSurface)
          .fontSize(AppTokens.Typography.headline.size)
          .fontWeight(AppTokens.Typography.headline.weight)
      }
      .width('100%')
      .aspectRatio(2.8)
      .backgroundColor(AppTokens.Colors.surfaceVariant)
      .borderRadius(AppTokens.Shapes.medium)
      .margin({ top: AppTokens.Spacing.sm })
      
      Row() {
        Button('Transfer')
          .backgroundColor(AppTokens.Colors.secondary)
          .borderRadius(AppTokens.Shapes.small)
          .border({ width: 1, color: AppTokens.Colors.outline })
          .height(32)
          .padding({ left: 8, right: 8 })
        
        Button('Details')
          .backgroundColor(AppTokens.Colors.surface)
          .borderRadius(AppTokens.Shapes.small)
          .border({ width: 1, color: AppTokens.Colors.outline })
          .height(32)
          .padding({ left: 8, right: 8 })
          .margin({ left: AppTokens.Spacing.sm })
      }
      .margin({ top: AppTokens.Spacing.sm })
    }
    .width('100%')
    .padding(AppTokens.Spacing.lg)
    .backgroundColor(AppTokens.Colors.surface)
    .borderRadius(AppTokens.Shapes.large)
    .shadow({ radius: 4, color: 'rgba(0,0,0,0.14)', offsetY: 1 })
    .border({ width: 1, color: AppTokens.Colors.outline })
    .height(120)
  }
}

@Component
export struct TransactionCard {
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
            .fontColor(AppTokens.Colors.onSurface)
            .fontSize(AppTokens.Typography.title.size)
            .fontWeight(AppTokens.Typography.title.weight)
          
          Text(this.tx.subtitle)
            .fontColor(AppTokens.Colors.onSurface)
            .fontSize(AppTokens.Typography.body.size)
            .fontWeight(AppTokens.Typography.body.weight)
            .margin({ top: AppTokens.Spacing.xs })
        }
        .alignItems(HorizontalAlign.Start)
        .margin({ left: AppTokens.Spacing.md })
      }
      
      Blank()
      
      Text(this.tx.amount)
        .fontColor(this.tx.positive ? AppTokens.Colors.success : AppTokens.Colors.error)
        .fontSize(AppTokens.Typography.title.size)
        .fontWeight(AppTokens.Typography.title.weight)
    }
    .width('100%')
    .padding(AppTokens.Spacing.lg)
    .height(72)
    .backgroundColor(AppTokens.Colors.surface)
    .borderRadius(AppTokens.Shapes.large)
    .shadow({ radius: 2, color: 'rgba(0,0,0,0.12)', offsetY: 0.5 })
    .border({ width: 1, color: AppTokens.Colors.outline })
  }
}

@Entry
@Component
struct ContentView {
  @State showBalance: boolean = true;
  @State selectedFilter: string = "Month";
  @State flags: Set<string> = new Set<string>();
  
  private filters: string[] = ["All", "Week", "Month", "Year"];
  private accounts: AccountCardModel[] = [
    { id: 1, name: "Wallet", balance: "$2,845.20", accent: AppTokens.Colors.secondary },
    { id: 2, name: "Savings", balance: "$8,120.00", accent: AppTokens.Colors.tertiary },
    { id: 3, name: "Investments", balance: "$15,430.55", accent: AppTokens.Colors.warning }
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
            .fontColor(AppTokens.Colors.onSurface)
            .fontSize(AppTokens.Typography.display.size)
            .fontWeight(AppTokens.Typography.display.weight)
            .margin({ left: AppTokens.Spacing.sm })
          
          Blank()
        }
        .width('100%')
        .padding(AppTokens.Spacing.lg)
        
        // Content Scroll
        Scroll() {
          Column() {
            // Filters Row
            Row() {
              Row() {
                ForEach(this.filters, (filter: string) => {
                  FilterChip({
                    label: filter,
                    isSelected: this.selectedFilter === filter,
                    onClick: () => { this.selectedFilter = filter }
                  })
                  .margin({ right: AppTokens.Spacing.sm })
                })
              }
              
              Blank()
              
              Row() {
                Text("Hide")
                  .fontColor(AppTokens.Colors.onSurface)
                  .fontSize(AppTokens.Typography.label.size)
                  .fontWeight(AppTokens.Typography.label.weight)
                
                Toggle({ type: ToggleType.Switch })
                  .onChange((isOn: boolean) => {
                    this.showBalance = !isOn;
                  })
                  .margin({ left: AppTokens.Spacing.sm })
              }
            }
            .width('100%')
            
            // Accounts List
            ForEach(this.accounts, (account: AccountCardModel) => {
              AccountCardView({
                account: account,
                showBalance: this.showBalance
              })
              .margin({ bottom: AppTokens.Spacing.lg })
            })
            
            // Recent Activity Header
            Row() {
              Text("Recent Activity")
                .fontColor(AppTokens.Colors.onSurface)
                .fontSize(AppTokens.Typography.headline.size)
                .fontWeight(AppTokens.Typography.headline.weight)
              
              Blank()
              
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
                .margin({ right: AppTokens.Spacing.sm })
                
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
            .margin({ top: AppTokens.Spacing.lg })
            
            // Transactions List
            ForEach(this.transactions, (tx: TxItemModel) => {
              TransactionCard({ tx: tx })
              .margin({ bottom: AppTokens.Spacing.lg })
            })
            
            // Bottom Padding for FAB/BottomBar
            Blank().height(100)
          }
          .padding({ left: AppTokens.Spacing.lg, right: AppTokens.Spacing.lg, top: AppTokens.Spacing.md, bottom: AppTokens.Spacing.md })
        }
        .layoutWeight(1)
        .scrollBar(BarState.Off)
        
        // Bottom Bar Overlay
        Column() {
          Row() {
            Column() {
              Text("Total Balance")
                .fontColor(AppTokens.Colors.onSurface)
                .fontSize(AppTokens.Typography.title.size)
                .fontWeight(AppTokens.Typography.title.weight)
              
              Text(this.showBalance ? "$26,395.75" : "•••••••")
                .fontColor(AppTokens.Colors.onSurface)
                .fontSize(AppTokens.Typography.headline.size)
                .fontWeight(AppTokens.Typography.headline.weight)
            }
            .alignItems(HorizontalAlign.Start)
            
            Blank()
            
            Button("Add Money")
              .width(140)
              .height(44)
              .backgroundColor(AppTokens.Colors.secondary)
              .borderRadius(AppTokens.Shapes.large)
          }
          .width('100%')
          .padding({ left: AppTokens.Spacing.lg, right: AppTokens.Spacing.lg, top: AppTokens.Spacing.md, bottom: AppTokens.Spacing.md })
        }
        .backgroundColor(AppTokens.Colors.surface)
        .shadow({ radius: 6, color: 'rgba(0,0,0,0.16)', offsetY: -1.5 })
      }
      .width('100%')
      .height('100%')
    }
  }
}