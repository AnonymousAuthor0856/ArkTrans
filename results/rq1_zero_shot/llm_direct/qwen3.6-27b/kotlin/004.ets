import { window } from '@kit.ArkUI'

// --- Design Tokens & Constants ---

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
  Shapes: {
    small: 6,
    medium: 8,
    large: 12
  }
}

// --- Data Models ---

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

// --- Main Entry ---

@Entry
@Component
struct FinanceWalletApp {
  @State showBalance: boolean = true;
  @State selectedRange: string = 'Month';
  @State flags: string[] = [];

  private accounts: AccountCard[] = [
    { id: 1, name: 'Wallet', balance: '$2,845.20', accent: AppTokens.Colors.secondary },
    { id: 2, name: 'Savings', balance: '$8,120.00', accent: AppTokens.Colors.tertiary },
    { id: 3, name: 'Investments', balance: '$15,430.55', accent: AppTokens.Colors.warning }
  ];

  private txs: TxItem[] = [
    { id: 1, title: 'Grocery Market', subtitle: 'Today • 12:40', amount: '-$32.18', positive: false },
    { id: 2, title: 'Salary', subtitle: 'Yesterday • 09:00', amount: '+$3,200.00', positive: true },
    { id: 3, title: 'Coffee Shop', subtitle: 'Yesterday • 15:22', amount: '-$4.90', positive: false },
    { id: 4, title: 'ETF Purchase', subtitle: 'Mon • 10:05', amount: '-$250.00', positive: false },
    { id: 5, title: 'Refund', subtitle: 'Sun • 18:40', amount: '+$18.99', positive: true }
  ];

  aboutToAppear() {
    // Hide system navigation bars for immersive experience similar to the Kotlin code
    let windowClass: window.Window = null;
    try {
      windowClass = window.getWindowSync(this.context);
      windowClass.setWindowLayoutFullScreen(true);
      windowClass.setWindowSystemBarEnable([window.SystemBarType.STATUS_BAR]); // Keep status bar, hide nav
    } catch (e) {
      console.error('Failed to set window layout');
    }
  }

  build() {
    Column() {
      // Top Bar
      Row() {
        Text('')
          .width(20)
          .height(20)
          .backgroundColor(AppTokens.Colors.primary)
          .borderRadius(AppTokens.Shapes.small)
        
        Text('Wallet')
          .fontSize(24)
          .fontWeight(FontWeight.SemiBold)
          .fontColor(AppTokens.Colors.onSurface)
          .margin({ left: AppTokens.Spacing.sm })
      }
      .width('100%')
      .padding({ left: AppTokens.Spacing.lg, right: AppTokens.Spacing.lg, top: AppTokens.Spacing.md, bottom: AppTokens.Spacing.md })
      .alignItems(VerticalAlign.Center)

      // Scrollable Content
      Scroll() {
        Column() {
          // Filter Chips & Toggle
          Row() {
            // Range Filters
            Flex({ wrap: FlexWrap.Wrap, justifyContent: FlexAlign.Start, alignItems: ItemAlign.Center }) {
              ForEach(['All', 'Week', 'Month', 'Year'], (range: string) => {
                this.FilterChip(range, range === this.selectedRange, () => {
                  this.selectedRange = range;
                })
              })
            }
            
            Spacer().layoutWeight(1)

            // Balance Toggle
            Row() {
              Text('Hide')
                .fontSize(10)
                .fontWeight(FontWeight.Medium)
                .fontColor(AppTokens.Colors.onSurface)
              
              Toggle({ type: ToggleType.Switch, isOn: !this.showBalance })
                .width(36)
                .height(20)
                .selectedColor(AppTokens.Colors.primary)
                .onChange((isOn: boolean) => {
                  this.showBalance = !isOn;
                })
                .margin({ left: AppTokens.Spacing.sm })
            }
            .alignItems(VerticalAlign.Center)
          }
          .width('100%')
          .justifyContent(FlexAlign.SpaceBetween)
          .margin({ bottom: AppTokens.Spacing.lg })

          // Account Cards
          ForEach(this.accounts, (account: AccountCard) => {
            this.AccountCard(account)
          })

          // Recent Activity Header
          Row() {
            Text('Recent Activity')
              .fontSize(18)
              .fontWeight(FontWeight.SemiBold)
              .fontColor(AppTokens.Colors.onSurface)
            
            Spacer().layoutWeight(1)

            // Income/Expense Flags
            Row() {
              this.FlagChip('Income')
              this.FlagChip('Expense')
            }
          }
          .width('100%')
          .margin({ top: AppTokens.Spacing.lg, bottom: AppTokens.Spacing.md })

          // Transaction List
          ForEach(this.txs, (tx: TxItem) => {
            this.TransactionItem(tx)
          })

          // Bottom Spacer for Bottom Bar
          Column().height(AppTokens.Spacing.xxxl + 80) 
        }
        .padding({ left: AppTokens.Spacing.lg, right: AppTokens.Spacing.lg })
      }
      .layoutWeight(1)
      .scrollBar(BarState.Off)

      // Bottom Bar
      this.BottomBar()
    }
    .width('100%')
    .height('100%')
    .backgroundColor(AppTokens.Colors.background)
  }

  @Builder
  FilterChip(label: string, isSelected: boolean, onClick: () => void) {
    Button(label)
      .type(ButtonType.Normal)
      .backgroundColor(isSelected ? AppTokens.Colors.primary : AppTokens.Colors.surface)
      .fontColor(isSelected ? AppTokens.Colors.onPrimary : AppTokens.Colors.onSurface)
      .fontSize(isSelected ? 14 : 12)
      .fontWeight(isSelected ? FontWeight.Medium : FontWeight.Normal)
      .borderRadius(AppTokens.Shapes.medium)
      .border({ width: 1, color: AppTokens.Colors.outline })
      .margin({ right: AppTokens.Spacing.sm })
      .onClick(onClick)
  }

  @Builder
  FlagChip(label: string) {
    Button(label)
      .type(ButtonType.Normal)
      .backgroundColor(this.flags.includes(label) ? AppTokens.Colors.secondary : AppTokens.Colors.surface)
      .fontColor(this.flags.includes(label) ? AppTokens.Colors.onSecondary : AppTokens.Colors.onSurface)
      .fontSize(10)
      .fontWeight(FontWeight.Medium)
      .borderRadius(AppTokens.Shapes.small)
      .border({ width: 1, color: AppTokens.Colors.outline })
      .margin({ left: AppTokens.Spacing.sm })
      .onClick(() => {
        if (this.flags.includes(label)) {
          this.flags = this.flags.filter(f => f !== label);
        } else {
          this.flags.push(label);
        }
      })
  }

  @Builder
  AccountCard(account: AccountCard) {
    Column() {
      Row() {
        Row() {
          Text('').width(16).height(16).backgroundColor(account.accent).borderRadius(AppTokens.Shapes.small)
          Text(account.name)
            .fontSize(14)
            .fontWeight(FontWeight.Medium)
            .fontColor(AppTokens.Colors.onSurface)
            .margin({ left: AppTokens.Spacing.sm })
        }
        
        Spacer().layoutWeight(1)

        Button('Manage')
          .type(ButtonType.Normal)
          .backgroundColor(AppTokens.Colors.secondary)
          .fontColor(AppTokens.Colors.onSecondary)
          .fontSize(10)
          .fontWeight(FontWeight.Medium)
          .borderRadius(AppTokens.Shapes.small)
          .border({ width: 1, color: AppTokens.Colors.outline })
      }
      .width('100%')
      
      Column() {
        Text(this.showBalance ? account.balance : '•••••••')
          .fontSize(18)
          .fontWeight(FontWeight.SemiBold)
          .fontColor(AppTokens.Colors.onSurface)
      }
      .width('100%')
      .aspectRatio(2.8)
      .backgroundColor(AppTokens.Colors.surfaceVariant)
      .borderRadius(AppTokens.Shapes.medium)
      .justifyContent(FlexAlign.Center)
      .alignItems(HorizontalAlign.Center)
      .margin({ top: AppTokens.Spacing.sm })

      Row() {
        Button('Transfer')
          .type(ButtonType.Normal)
          .backgroundColor(AppTokens.Colors.secondary)
          .fontColor(AppTokens.Colors.onSecondary)
          .fontSize(10)
          .fontWeight(FontWeight.Medium)
          .borderRadius(AppTokens.Shapes.small)
          .border({ width: 1, color: AppTokens.Colors.outline })
        
        Button('Details')
          .type(ButtonType.Normal)
          .backgroundColor(AppTokens.Colors.surface)
          .fontColor(AppTokens.Colors.onSurface)
          .fontSize(10)
          .fontWeight(FontWeight.Medium)
          .borderRadius(AppTokens.Shapes.small)
          .border({ width: 1, color: AppTokens.Colors.outline })
          .margin({ left: AppTokens.Spacing.sm })
      }
      .margin({ top: AppTokens.Spacing.sm })
    }
    .width('100%')
    .padding(AppTokens.Spacing.lg)
    .backgroundColor(AppTokens.Colors.surface)
    .borderRadius(AppTokens.Shapes.large)
    .border({ width: 1, color: AppTokens.Colors.outline })
    .shadow({ radius: 4, color: 'rgba(0,0,0,0.1)', offsetY: 1 })
    .margin({ bottom: AppTokens.Spacing.lg })
  }

  @Builder
  TransactionItem(tx: TxItem) {
    Row() {
      Row() {
        Text('').width(32).height(32).backgroundColor(tx.positive ? AppTokens.Colors.success : AppTokens.Colors.error).borderRadius(AppTokens.Shapes.small)
        
        Column() {
          Text(tx.title)
            .fontSize(14)
            .fontWeight(FontWeight.Medium)
            .fontColor(AppTokens.Colors.onSurface)
          
          Text(tx.subtitle)
            .fontSize(12)
            .fontColor(AppTokens.Colors.onSurface)
            .margin({ top: AppTokens.Spacing.xs })
        }
        .margin({ left: AppTokens.Spacing.md })
      }

      Spacer().layoutWeight(1)

      Text(tx.amount)
        .fontSize(14)
        .fontWeight(FontWeight.Medium)
        .fontColor(tx.positive ? AppTokens.Colors.success : AppTokens.Colors.error)
    }
    .width('100%')
    .padding(AppTokens.Spacing.lg)
    .backgroundColor(AppTokens.Colors.surface)
    .borderRadius(AppTokens.Shapes.large)
    .border({ width: 1, color: AppTokens.Colors.outline })
    .shadow({ radius: 2, color: 'rgba(0,0,0,0.12)', offsetY: 0.5 })
    .margin({ bottom: AppTokens.Spacing.md })
  }

  @Builder
  BottomBar() {
    Row() {
      Column() {
        Text('Total Balance')
          .fontSize(10)
          .fontWeight(FontWeight.Medium)
          .fontColor(AppTokens.Colors.onSurface)
        
        Text(this.showBalance ? '$26,395.75' : '•••••••')
          .fontSize(18)
          .fontWeight(FontWeight.SemiBold)
          .fontColor(AppTokens.Colors.onSurface)
          .margin({ top: AppTokens.Spacing.xs })
      }
      
      Spacer().layoutWeight(1)

      Button('Add Money')
        .type(ButtonType.Normal)
        .backgroundColor(AppTokens.Colors.secondary)
        .fontColor(AppTokens.Colors.onSecondary)
        .fontSize(14)
        .fontWeight(FontWeight.Medium)
        .borderRadius(AppTokens.Shapes.large)
        .width(140)
        .height(44)
    }
    .width('100%')
    .padding({ left: AppTokens.Spacing.lg, right: AppTokens.Spacing.lg, top: AppTokens.Spacing.md, bottom: AppTokens.Spacing.md })
    .backgroundColor(AppTokens.Colors.surface)
    .shadow({ radius: 6, color: 'rgba(0,0,0,0.16)', offsetY: 1.5 })
  }
}