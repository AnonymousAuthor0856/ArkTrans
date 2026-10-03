// 032_WalletDashFinance_en
// Finance/Wallet - Monochrome Comfortable

// --- Data Models ---
interface Transaction {
  id: number;
  name: string;
  detail: string;
  amount: string;
  isCredit: boolean;
}

interface ControlAction {
  label: string;
}

interface NavItem {
  label: string;
}

// --- Design Tokens ---
class AppTokens {
  static Colors = {
    primary: '#020617',
    secondary: '#4ADE80',
    tertiary: '#64748B',
    background: '#F8FAFC',
    surface: '#FFFFFF',
    surfaceVariant: '#F1F5F9',
    outline: '#E2E8F0',
    success: '#22C55E',
    warning: '#F59E0B',
    error: '#EF4444',
    onPrimary: '#FFFFFF',
    onSecondary: '#020617',
    onTertiary: '#FFFFFF',
    onBackground: '#020617',
    onSurface: '#020617',
  };

  static Spacing = {
    xs: 4,
    sm: 8,
    md: 16,
    lg: 24,
    xl: 32,
    xxl: 48,
  };
}

// --- Mock Data ---
const transactions: Transaction[] = [
  { id: 1, name: 'Spotify', detail: 'Subscription', amount: '-$9.99', isCredit: false },
  { id: 2, name: 'Income', detail: 'Monthly Salary', amount: '+$2,500.00', isCredit: true },
  { id: 3, name: 'Starbucks', detail: 'Coffee', amount: '-$5.75', isCredit: false },
  { id: 4, name: 'Amazon', detail: 'Shopping', amount: '-$124.50', isCredit: false },
  { id: 5, name: 'Refund', detail: 'Amazon Return', amount: '+$32.00', isCredit: true },
];

const controlActions: ControlAction[] = [
  { label: 'Send' },
  { label: 'Receive' },
  { label: 'Add' },
  { label: 'More' },
];

const navItems: NavItem[] = [
  { label: 'Home' },
  { label: 'Cards' },
  { label: 'Activity' },
  { label: 'Profile' },
];

// --- State ---
@Entry
@Component
struct RootScreen {
  @State selectedNavItem: string = 'Home';

  build() {
    Column() {
      // Content Area
      Scroll() {
        Column() {
          // Total Balance Card
          Column() {
            Text('Total Balance')
              .fontSize(16)
              .fontColor('#B3FFFFFF') // onPrimary with 0.7 alpha
              .margin({ bottom: 8 });

            Text('$ 1,145.14')
              .fontSize(48)
              .fontWeight(FontWeight.Bold)
              .fontColor(AppTokens.Colors.onPrimary)
              .margin({ bottom: 4 });

            Row() {
              Circle({ width: 10, height: 10 })
                .fill(AppTokens.Colors.secondary)
                .margin({ right: 8 });
              Text('+$234.10 today')
                .fontSize(16)
                .fontColor(AppTokens.Colors.secondary);
            }
            .alignItems(VerticalAlign.Center);
          }
          .padding(24)
          .backgroundColor(AppTokens.Colors.primary)
          .borderRadius(24)
          .width('100%')
          .margin({ bottom: 24 });

          // Control Actions Row
          Row() {
            ForEach(controlActions, (action: ControlAction) => {
              Column() {
                Button() {
                  Column() {
                    // Inner Icon Box
                    Column()
                      .width(24)
                      .height(24)
                      .backgroundColor(AppTokens.Colors.primary)
                      .borderRadius(8);
                  }
                  .justifyContent(FlexAlign.Center)
                  .alignItems(HorizontalAlign.Center)
                }
                .width(64)
                .height(64)
                .borderRadius(32)
                .backgroundColor(AppTokens.Colors.surface)
                .shadow({ radius: 3, color: '#0D000000', offsetX: 0, offsetY: 1 })
                .margin({ bottom: 8 });

                Text(action.label)
                  .fontSize(12)
                  .fontWeight(FontWeight.Medium)
                  .fontColor(AppTokens.Colors.onSurface);
              }
              .layoutWeight(1)
              .justifyContent(FlexAlign.Center);
            });
          }
          .width('100%')
          .margin({ bottom: 24 });

          // Recent Activity Header
          Row() {
            Text('Recent Activity')
              .fontSize(20)
              .fontWeight(FontWeight.Medium)
              .fontColor(AppTokens.Colors.onSurface);
            Blank(); // Pushes the next item to the right
            Text('View All')
              .fontSize(12)
              .fontWeight(FontWeight.Medium)
              .fontColor(AppTokens.Colors.tertiary);
          }
          .width('100%')
          .margin({ bottom: 16 });

          // Transactions List
          ForEach(transactions, (tx: Transaction) => {
            Row() {
              // Leading Icon Box
              Column()
                .width(48)
                .height(48)
                .backgroundColor(AppTokens.Colors.surfaceVariant)
                .borderRadius(16)
                .margin({ right: 16 });

              // Name and Detail
              Column() {
                Text(tx.name)
                  .fontSize(16)
                  .fontWeight(FontWeight.SemiBold)
                  .fontColor(AppTokens.Colors.onSurface);
                Text(tx.detail)
                  .fontSize(12)
                  .fontWeight(FontWeight.Medium)
                  .fontColor(AppTokens.Colors.tertiary);
              }
              .alignItems(HorizontalAlign.Start)
              .layoutWeight(1);

              // Amount
              Text(tx.amount)
                .fontSize(16)
                .fontWeight(FontWeight.SemiBold)
                .fontColor(tx.isCredit ? AppTokens.Colors.success : AppTokens.Colors.onSurface);
            }
            .width('100%')
            .padding(16)
            .backgroundColor(AppTokens.Colors.surface)
            .borderRadius(16)
            .border({ width: 1, color: AppTokens.Colors.outline })
            .margin({ bottom: 12 });
          });
        }
        .padding({ left: 16, right: 16, top: 8, bottom: 16 });
      }
      .layoutWeight(1)
      .scrollBar(BarState.Off);

      // Bottom Navigation Bar
      Row() {
        ForEach(navItems, (item: NavItem) => {
          Column() {
            Circle({ width: 24, height: 24 })
              .fill(this.selectedNavItem === item.label ? AppTokens.Colors.primary : AppTokens.Colors.outline)
              .margin({ bottom: 4 });
            Text(item.label)
              .fontSize(12)
              .fontWeight(FontWeight.Medium)
              .fontColor(this.selectedNavItem === item.label ? AppTokens.Colors.primary : AppTokens.Colors.tertiary);
          }
          .layoutWeight(1)
          .justifyContent(FlexAlign.Center)
          .onClick(() => {
            this.selectedNavItem = item.label;
          });
        });
      }
      .width('100%')
      .height(72)
      .backgroundColor(AppTokens.Colors.surface)
      .border({ width: 1, color: AppTokens.Colors.outline })
      .justifyContent(FlexAlign.SpaceAround)
      .alignItems(VerticalAlign.Center);
    }
    .width('100%')
    .height('100%')
    .backgroundColor(AppTokens.Colors.background);
  }
}