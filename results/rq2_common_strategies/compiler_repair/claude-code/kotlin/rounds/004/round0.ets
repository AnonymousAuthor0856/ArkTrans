// Finance Wallet - High-Contrast Accessible
// Converted from Kotlin Compose to ArkTS

@Entry
@Component
struct Index {
  @State showBalance: boolean = true;
  @State selectedRange: string = 'Month';
  @State incomeFilter: boolean = false;
  @State expenseFilter: boolean = false;

  private rangeOptions: string[] = ['All', 'Week', 'Month', 'Year'];

  private accounts: AccountCard[] = [
    { id: 1, name: 'Wallet', balance: '$2,845.20', accent: '#10B981' },
    { id: 2, name: 'Savings', balance: '$8,120.00', accent: '#3B82F6' },
    { id: 3, name: 'Investments', balance: '$15,430.55', accent: '#F59E0B' }
  ];

  private transactions: TxItem[] = [
    { id: 1, title: 'Grocery Market', subtitle: 'Today · 12:40', amount: '-$32.18', positive: false },
    { id: 2, title: 'Salary', subtitle: 'Yesterday · 09:00', amount: '+$3,200.00', positive: true },
    { id: 3, title: 'Coffee Shop', subtitle: 'Yesterday · 15:22', amount: '-$4.90', positive: false },
    { id: 4, title: 'ETF Purchase', subtitle: 'Mon · 10:05', amount: '-$250.00', positive: false },
    { id: 5, title: 'Refund', subtitle: 'Sun · 18:40', amount: '+$18.99', positive: true }
  ];

  build() {
    Column() {
      // Top App Bar
      Row() {
        Row() {
          Rect()
            .width(20)
            .height(20)
            .fill(AppTokens.Colors.primary)
            .radius(AppTokens.Shapes.small)
          Text('Wallet')
            .fontSize(24)
            .fontWeight(FontWeight.SemiBold)
            .fontColor(AppTokens.Colors.onSurface)
            .lineHeight(30)
        }
        .alignItems(VerticalAlign.Center)
        .justifyContent(FlexAlign.Center)
        .width('100%')
      }
      .width('100%')
      .height(56)
      .backgroundColor(AppTokens.Colors.surface)

      // Main content (scrollable)
      Scroll() {
        Column() {
          // Range filter + Hide switch row
          Row() {
            Row() {
              ForEach(this.rangeOptions, (r: string) => {
                Text(r)
                  .fontSize(r === this.selectedRange ? 14 : 12)
                  .fontWeight(r === this.selectedRange ? FontWeight.Medium : FontWeight.Normal)
                  .fontColor(r === this.selectedRange ? AppTokens.Colors.onPrimary : AppTokens.Colors.onSurface)
                  .lineHeight(r === this.selectedRange ? 18 : 16)
                  .padding({ left: 12, right: 12, top: 6, bottom: 6 })
                  .backgroundColor(r === this.selectedRange ? AppTokens.Colors.primary : AppTokens.Colors.surface)
                  .border({ width: 1, color: AppTokens.Colors.outline })
                  .borderRadius(AppTokens.Shapes.medium)
                  .onClick(() => {
                    this.selectedRange = r;
                  })
              })
            }
            .alignItems(VerticalAlign.Center)
            .justifyContent(FlexAlign.Start)
            .gap(AppTokens.Spacing.sm)

            Blank()

            Row() {
              Text('Hide')
                .fontSize(10)
                .fontWeight(FontWeight.Medium)
                .fontColor(AppTokens.Colors.onSurface)
                .lineHeight(14)
              Toggle({ type: ToggleType.Switch, isOn: !this.showBalance })
                .selectedColor(AppTokens.Colors.primary)
                .onChange((isOn: boolean) => {
                  this.showBalance = !isOn;
                })
                .width(40)
                .height(24)
            }
            .alignItems(VerticalAlign.Center)
            .gap(AppTokens.Spacing.sm)
          }
          .width('100%')
          .justifyContent(FlexAlign.SpaceBetween)
          .alignItems(VerticalAlign.Center)

          // Account cards
          ForEach(this.accounts, (a: AccountCard) => {
            Column() {
              // Card header
              Row() {
                Row() {
                  Rect()
                    .width(16)
                    .height(16)
                    .fill(a.accent)
                    .radius(AppTokens.Shapes.small)
                  Text(a.name)
                    .fontSize(14)
                    .fontWeight(FontWeight.Medium)
                    .fontColor(AppTokens.Colors.onSurface)
                    .lineHeight(18)
                }
                .alignItems(VerticalAlign.Center)
                .gap(AppTokens.Spacing.sm)

                Blank()

                Text('Manage')
                  .fontSize(10)
                  .fontWeight(FontWeight.Medium)
                  .fontColor(AppTokens.Colors.onSecondary)
                  .lineHeight(14)
                  .padding({ left: 10, right: 10, top: 4, bottom: 4 })
                  .backgroundColor(AppTokens.Colors.secondary)
                  .border({ width: 1, color: AppTokens.Colors.outline })
                  .borderRadius(AppTokens.Shapes.small)
              }
              .width('100%')
              .justifyContent(FlexAlign.SpaceBetween)
              .alignItems(VerticalAlign.Center)

              // Balance display
              Row() {
                Text(this.showBalance ? a.balance : '•••••••')
                  .fontSize(18)
                  .fontWeight(FontWeight.SemiBold)
                  .fontColor(AppTokens.Colors.onSurface)
                  .lineHeight(24)
              }
              .width('100%')
              .height(80)
              .justifyContent(FlexAlign.Center)
              .alignItems(VerticalAlign.Center)
              .backgroundColor(AppTokens.Colors.surfaceVariant)
              .borderRadius(AppTokens.Shapes.medium)

              // Action chips
              Row() {
                Text('Transfer')
                  .fontSize(10)
                  .fontWeight(FontWeight.Medium)
                  .fontColor(AppTokens.Colors.onSecondary)
                  .lineHeight(14)
                  .padding({ left: 10, right: 10, top: 4, bottom: 4 })
                  .backgroundColor(AppTokens.Colors.secondary)
                  .border({ width: 1, color: AppTokens.Colors.outline })
                  .borderRadius(AppTokens.Shapes.small)
                Text('Details')
                  .fontSize(10)
                  .fontWeight(FontWeight.Medium)
                  .fontColor(AppTokens.Colors.onSurface)
                  .lineHeight(14)
                  .padding({ left: 10, right: 10, top: 4, bottom: 4 })
                  .backgroundColor(AppTokens.Colors.surface)
                  .border({ width: 1, color: AppTokens.Colors.outline })
                  .borderRadius(AppTokens.Shapes.small)
              }
              .alignItems(VerticalAlign.Center)
              .gap(AppTokens.Spacing.sm)
            }
            .width('100%')
            .padding(AppTokens.Spacing.lg)
            .backgroundColor(AppTokens.Colors.surface)
            .borderRadius(AppTokens.Shapes.large)
            .border({ width: 1, color: AppTokens.Colors.outline })
            .shadow({ radius: 4, color: 'rgba(0,0,0,0.14)', offsetY: 1 })
            .justifyContent(FlexAlign.Start)
            .gap(AppTokens.Spacing.sm)
          })

          // Recent Activity header
          Row() {
            Text('Recent Activity')
              .fontSize(18)
              .fontWeight(FontWeight.SemiBold)
              .fontColor(AppTokens.Colors.onSurface)
              .lineHeight(24)

            Blank()

            Row() {
              Text('Income')
                .fontSize(10)
                .fontWeight(FontWeight.Medium)
                .fontColor(this.incomeFilter ? AppTokens.Colors.onSecondary : AppTokens.Colors.onSurface)
                .lineHeight(14)
                .padding({ left: 10, right: 10, top: 4, bottom: 4 })
                .backgroundColor(this.incomeFilter ? AppTokens.Colors.secondary : AppTokens.Colors.surface)
                .border({ width: 1, color: AppTokens.Colors.outline })
                .borderRadius(AppTokens.Shapes.small)
                .onClick(() => {
                  this.incomeFilter = !this.incomeFilter;
                })
              Text('Expense')
                .fontSize(10)
                .fontWeight(FontWeight.Medium)
                .fontColor(this.expenseFilter ? AppTokens.Colors.onSecondary : AppTokens.Colors.onSurface)
                .lineHeight(14)
                .padding({ left: 10, right: 10, top: 4, bottom: 4 })
                .backgroundColor(this.expenseFilter ? AppTokens.Colors.secondary : AppTokens.Colors.surface)
                .border({ width: 1, color: AppTokens.Colors.outline })
                .borderRadius(AppTokens.Shapes.small)
                .onClick(() => {
                  this.expenseFilter = !this.expenseFilter;
                })
            }
            .alignItems(VerticalAlign.Center)
            .gap(AppTokens.Spacing.sm)
          }
          .width('100%')
          .justifyContent(FlexAlign.SpaceBetween)
          .alignItems(VerticalAlign.Center)

          // Transaction items
          ForEach(this.transactions, (t: TxItem) => {
            Row() {
              Row() {
                Rect()
                  .width(32)
                  .height(32)
                  .fill(t.positive ? AppTokens.Colors.success : AppTokens.Colors.error)
                  .radius(AppTokens.Shapes.small)
                Column() {
                  Text(t.title)
                    .fontSize(14)
                    .fontWeight(FontWeight.Medium)
                    .fontColor(AppTokens.Colors.onSurface)
                    .lineHeight(18)
                  Text(t.subtitle)
                    .fontSize(12)
                    .fontWeight(FontWeight.Normal)
                    .fontColor(AppTokens.Colors.onSurface)
                    .lineHeight(16)
                }
                .alignItems(HorizontalAlign.Start)
                .gap(AppTokens.Spacing.xs)
              }
              .alignItems(VerticalAlign.Center)
              .gap(AppTokens.Spacing.md)

              Blank()

              Text(t.amount)
                .fontSize(14)
                .fontWeight(FontWeight.Medium)
                .fontColor(t.positive ? AppTokens.Colors.success : AppTokens.Colors.error)
                .lineHeight(18)
            }
            .width('100%')
            .padding(AppTokens.Spacing.lg)
            .backgroundColor(AppTokens.Colors.surface)
            .borderRadius(AppTokens.Shapes.large)
            .border({ width: 1, color: AppTokens.Colors.outline })
            .shadow({ radius: 2, color: 'rgba(0,0,0,0.12)', offsetY: 0.5 })
            .alignItems(VerticalAlign.Center)
            .minHeight(72)
          })

          // Bottom spacer
          Blank()
            .height(AppTokens.Spacing.xxl)
        }
        .width('100%')
        .padding({ left: AppTokens.Spacing.lg, right: AppTokens.Spacing.lg, top: AppTokens.Spacing.md, bottom: AppTokens.Spacing.md })
        .gap(AppTokens.Spacing.lg)
      }
      .layoutWeight(1)
      .scrollBar(BarState.Off)
      .edgeEffect(EdgeEffect.Spring)

      // Bottom bar
      Row() {
        Column() {
          Text('Total Balance')
            .fontSize(10)
            .fontWeight(FontWeight.Medium)
            .fontColor(AppTokens.Colors.onSurface)
            .lineHeight(14)
          Text(this.showBalance ? '$26,395.75' : '•••••••')
            .fontSize(18)
            .fontWeight(FontWeight.SemiBold)
            .fontColor(AppTokens.Colors.onSurface)
            .lineHeight(24)
        }
        .alignItems(HorizontalAlign.Start)
        .gap(AppTokens.Spacing.xs)

        Blank()

        Button('Add Money')
          .height(44)
          .width(140)
          .fontSize(14)
          .fontWeight(FontWeight.Medium)
          .fontColor(AppTokens.Colors.onSecondary)
          .backgroundColor(AppTokens.Colors.secondary)
          .borderRadius(AppTokens.Shapes.large)
          .onClick(() => {})
      }
      .width('100%')
      .padding({ left: AppTokens.Spacing.lg, right: AppTokens.Spacing.lg, top: AppTokens.Spacing.md, bottom: AppTokens.Spacing.md })
      .backgroundColor(AppTokens.Colors.surface)
      .justifyContent(FlexAlign.SpaceBetween)
      .alignItems(VerticalAlign.Center)
      .shadow({ radius: 6, color: 'rgba(0,0,0,0.16)', offsetY: 1.5 })
    }
    .width('100%')
    .height('100%')
    .backgroundColor(AppTokens.Colors.background)
  }
}

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

namespace AppTokens {
  export namespace Colors {
    export const primary: string = '#1F2937';
    export const secondary: string = '#10B981';
    export const tertiary: string = '#3B82F6';
    export const background: string = '#F3F4F6';
    export const surface: string = '#FFFFFF';
    export const surfaceVariant: string = '#E5E7EB';
    export const outline: string = '#D1D5DB';
    export const success: string = '#16A34A';
    export const warning: string = '#F59E0B';
    export const error: string = '#EF4444';
    export const onPrimary: string = '#FFFFFF';
    export const onSecondary: string = '#0B1220';
    export const onTertiary: string = '#FFFFFF';
    export const onBackground: string = '#0B1220';
    export const onSurface: string = '#0B1220';
  }
  export namespace Shapes {
    export const small: number = 6;
    export const medium: number = 8;
    export const large: number = 12;
  }
  export namespace Spacing {
    export const xs: number = 2;
    export const sm: number = 4;
    export const md: number = 6;
    export const lg: number = 8;
    export const xl: number = 12;
    export const xxl: number = 16;
    export const xxxl: number = 24;
  }
}
