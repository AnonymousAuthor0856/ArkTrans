// entry/src/main/ets/components/AppTokens.ets
export class AppTokens {
  static readonly Colors = {
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

  static readonly Typography = {
    display: { size: 24, weight: FontWeight.Semibold },
    headline: { size: 18, weight: FontWeight.Semibold },
    title: { size: 14, weight: FontWeight.Medium },
    body: { size: 12, weight: FontWeight.Normal },
    label: { size: 10, weight: FontWeight.Medium }
  }

  static readonly Spacing = {
    xs: 2,
    sm: 4,
    md: 6,
    lg: 8,
    xl: 12,
    xxl: 16,
    xxxl: 24
  }

  static readonly Shapes = {
    small: 6,
    medium: 8,
    large: 12
  }
}

// entry/src/main/ets/models/DataModels.ets
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

// entry/src/main/ets/components/FilterChip.ets
import { AppTokens } from './AppTokens';

@Component
export struct FilterChip {
  @Prop label: string;
  @Prop isSelected: boolean;
  onClick: () => void;

  build() {
    Button(this.label) {
      Text(this.label)
        .fontColor(this.isSelected ? AppTokens.Colors.onPrimary : AppTokens.Colors.onSurface)
        .fontSize(this.isSelected ? AppTokens.Typography.title.size : AppTokens.Typography.body.size)
        .fontWeight(this.isSelected ? AppTokens.Typography.title.weight : AppTokens.Typography.body.weight)
    }
    .width('auto')
    .height(36) // Approximate height based on padding + font
    .backgroundColor(this.isSelected ? AppTokens.Colors.primary : AppTokens.Colors.surface)
    .borderRadius(AppTokens.Shapes.medium)
    .border({ width: this.isSelected ? 0 : 1, color: AppTokens.Colors.outline })
    .onClick(() => {
      this.onClick();
    })
  }
}

// entry/src/main/ets/components/AssistChip.ets
import { AppTokens } from './AppTokens';

@Component
export struct AssistChip {
  @Prop label: string;
  @Prop isSelected: boolean;
  onClick: () => void;

  build() {
    Button(this.label) {
      Text(this.label)
        .fontColor(this.isSelected ? AppTokens.Colors.onSecondary : AppTokens.Colors.onSurface)
        .fontSize(AppTokens.Typography.label.size)
        .fontWeight(AppTokens.Typography.label.weight)
    }
    .width('auto')
    .height(28) // Approximate height
    .backgroundColor(this.isSelected ? AppTokens.Colors.secondary : AppTokens.Colors.surface)
    .borderRadius(AppTokens.Shapes.small)
    .border({ width: 1, color: AppTokens.Colors.outline })
    .onClick(() => {
      this.onClick();
    })
  }
}

// entry/src/main/ets/components/AccountCardView.ets
import { AppTokens } from './AppTokens';
import { AccountCardModel } from '../models/DataModels';

@Component
export struct AccountCardView {
  @Object account: AccountCardModel;
  @Prop showBalance: boolean;

  build() {
    Column() {
      Row() {
        Row() {
          Rectangle()
            .fill(this.account.accent)
            .width(16)
            .height(16)
            .borderRadius(AppTokens.Shapes.small)
          
          Text(this.account.name)
            .margin({ left: AppTokens.Spacing.sm })
            .fontColor(AppTokens.Colors.onSurface)
            .fontSize(AppTokens.Typography.title.size)
            .fontWeight(AppTokens.Typography.title.weight)
        }
        
        Blank()
        
        Button('Manage') {
          Text('Manage')
            .fontColor(AppTokens.Colors.onSecondary)
            .fontSize(AppTokens.Typography.label.size)
            .fontWeight(AppTokens.Typography.label.weight)
        }
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
      .justifyContent(FlexAlign.Center)
      .alignItems(HorizontalAlign.Center)
      .margin({ top: AppTokens.Spacing.sm })

      Row() {
        Button('Transfer') {
          Text('Transfer')
            .fontColor(AppTokens.Colors.onSecondary)
            .fontSize(AppTokens.Typography.label.size)
            .fontWeight(AppTokens.Typography.label.weight)
        }
        .backgroundColor(AppTokens.Colors.secondary)
        .borderRadius(AppTokens.Shapes.small)
        .border({ width: 1, color: AppTokens.Colors.outline })
        .height(28)
        .padding({ left: 8, right: 8 })
        .margin({ top: AppTokens.Spacing.sm })

        Button('Details') {
          Text('Details')
            .fontColor(AppTokens.Colors.onSurface)
            .fontSize(AppTokens.Typography.label.size)
            .fontWeight(AppTokens.Typography.label.weight)
        }
        .backgroundColor(AppTokens.Colors.surface)
        .borderRadius(AppTokens.Shapes.small)
        .border({ width: 1, color: AppTokens.Colors.outline })
        .height(28)
        .padding({ left: 8, right: 8 })
        .margin({ top: AppTokens.Spacing.sm, left: AppTokens.Spacing.sm })
      }
    }
    .padding(AppTokens.Spacing.lg)
    .backgroundColor(AppTokens.Colors.surface)
    .borderRadius(AppTokens.Shapes.large)
    .shadow({ radius: 4, color: 'rgba(0,0,0,0.14)', offsetY: 1 })
    .border({ width: 1, color: AppTokens.Colors.outline })
    .minHeight(120)
  }
}

// entry/src/main/ets/components/TransactionCard.ets
import { AppTokens } from './AppTokens';
import { TxItemModel } from '../models/DataModels';

@Component
export struct TransactionCard {
  @Object tx: TxItemModel;

  build() {
    Row() {
      Row() {
        Rectangle()
          .fill(this.tx.positive ? AppTokens.Colors.success : AppTokens.Colors.error)
          .width(32)
          .height(32)
          .borderRadius(AppTokens.Shapes.small)
        
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
    .padding(AppTokens.Spacing.lg)
    .minHeight(72)
    .backgroundColor(AppTokens.Colors.surface)
    .borderRadius(AppTokens.Shapes.large)
    .shadow({ radius: 2, color: 'rgba(0,0,0,0.12)', offsetY: 0.5 })
    .border({ width: 1, color: AppTokens.Colors.outline })
  }
}

// entry/src/main/ets/pages/ContentView.ets
import { AppTokens } from '../components/AppTokens';
import { AccountCardModel, TxItemModel } from '../models/DataModels';
import { FilterChip } from '../components/FilterChip';
import { AssistChip } from '../components/AssistChip';
import { AccountCardView } from '../components/AccountCardView';
import { TransactionCard } from '../components/TransactionCard';

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
          Rectangle()
            .fill(AppTokens.Colors.primary)
            .width(20)
            .height(20)
            .borderRadius(AppTokens.Shapes.small)
          
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
                
                Toggle({ type: ToggleType.Switch, isOn: !this.showBalance })
                  .onChange((isOn: boolean) => {
                    this.showBalance = !isOn;
                  })
                  .width(36)
                  .height(20)
                  .margin({ left: AppTokens.Spacing.sm })
                  // Customizing toggle colors to match SwiftUI implementation roughly
                  .selectedColor(AppTokens.Colors.primary)
                  .color(AppTokens.Colors.surfaceVariant)
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
            .margin({ bottom: AppTokens.Spacing.lg })

            // Transactions List
            ForEach(this.transactions, (tx: TxItemModel) => {
              TransactionCard({ tx: tx })
              .margin({ bottom: AppTokens.Spacing.lg })
            })

            // Bottom Padding for FAB/BottomBar
            Column().height(100)
          }
          .padding({ left: AppTokens.Spacing.lg, right: AppTokens.Spacing.lg, top: AppTokens.Spacing.md })
        }
        .layoutWeight(1)
        .scrollBar(BarState.Off)
      }
      .width('100%')
      .height('100%')

      // Bottom Bar Overlay
      Column() {
        Blank()
        
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
                .margin({ top: AppTokens.Spacing.xs })
            }
            .alignItems(HorizontalAlign.Start)
            
            Blank()
            
            Button("Add Money") {
              Text("Add Money")
                .fontColor(AppTokens.Colors.onSecondary)
                .fontSize(AppTokens.Typography.title.size)
                .fontWeight(AppTokens.Typography.title.weight)
            }
            .width(140)
            .height(44)
            .backgroundColor(AppTokens.Colors.secondary)
            .borderRadius(AppTokens.Shapes.large)
          }
          .padding({ left: AppTokens.Spacing.lg, right: AppTokens.Spacing.lg, top: AppTokens.Spacing.md, bottom: AppTokens.Spacing.md })
        }
        .backgroundColor(AppTokens.Colors.surface)
        .shadow({ radius: 6, color: 'rgba(0,0,0,0.16)', offsetY: -1.5 })
      }
      .width('100%')
    }
    .backgroundColor(AppTokens.Colors.background)
  }
}