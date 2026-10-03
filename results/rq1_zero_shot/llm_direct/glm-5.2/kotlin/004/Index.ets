// 007_FinanceWallect_en
// UI_TYPE: Finance Wallet
// STYLE_THEME: High-Contrast Accessible
// LANG: en
// BASELINE_SIZE: 1280x720

class AppTokens {
  static Colors: object = {
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
  };
  static TypographyTokens: object = {
    display: '24sp',
    headline: '18sp',
    title: '14sp',
    body: '12sp',
    label: '10sp'
  };
  static Shapes: object = {
    small: 6,
    medium: 8,
    large: 12
  };
  static Spacing: object = {
    xs: 2,
    sm: 4,
    md: 6,
    lg: 8,
    xl: 12,
    xxl: 16,
    xxxl: 24
  };
  static ElevationMapping: object = {
    level1: 1,
    level2: 2,
    level3: 3,
    level4: 4,
    level5: 5
  };
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

@Entry
@Component
struct RootScreen {
  @State showBalance: boolean = true;
  @State selected: string = 'Month';
  @State flags: string[] = [];
  
  private range: string[] = ['All', 'Week', 'Month', 'Year'];
  private accounts: AccountCard[] = [
    { id: 1, name: 'Wallet', balance: '$2,845.20', accent: '#10B981' },
    { id: 2, name: 'Savings', balance: '$8,120.00', accent: '#3B82F6' },
    { id: 3, name: 'Investments', balance: '$15,430.55', accent: '#F59E0B' }
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
      // Top App Bar
      Row() {
        Row() {
          Box()
            .width(20)
            .height(20)
            .backgroundColor(AppTokens.Colors.primary)
            .borderRadius(AppTokens.Shapes.small);
          Text('Wallet')
            .fontSize(AppTokens.TypographyTokens.display)
            .fontColor(AppTokens.Colors.onSurface)
            .margin({ left: AppTokens.Spacing.sm });
        }
      }
      .width('100%')
      .height(56)
      .justifyContent(FlexAlign.Center)
      .backgroundColor(AppTokens.Colors.surface);

      // Content List
      Scroll() {
        Column() {
          // Filter & Hide Row
          Row() {
            Row() {
              ForEach(this.range, (r: string) => {
                Text(r)
                  .fontSize(this.selected === r ? AppTokens.TypographyTokens.title : AppTokens.TypographyTokens.body)
                  .fontColor(this.selected === r ? AppTokens.Colors.onPrimary : AppTokens.Colors.onSurface)
                  .backgroundColor(this.selected === r ? AppTokens.Colors.primary : AppTokens.Colors.surface)
                  .borderRadius(AppTokens.Shapes.medium)
                  .border({ width: 1, color: AppTokens.Colors.outline })
                  .padding({ left: AppTokens.Spacing.lg, right: AppTokens.Spacing.lg, top: AppTokens.Spacing.sm, bottom: AppTokens.Spacing.sm })
                  .margin({ right: AppTokens.Spacing.sm })
                  .onClick(() => { this.selected = r; });
              });
            }

            Row() {
              Text('Hide')
                .fontSize(AppTokens.TypographyTokens.label)
                .fontColor(AppTokens.Colors.onSurface)
                .margin({ right: AppTokens.Spacing.sm });
              Toggle({ type: ToggleType.Switch, isOn: !this.showBalance })
                .selectedColor(AppTokens.Colors.primary)
                .switchPointColor(AppTokens.Colors.onPrimary)
                .onChange((isOn: boolean) => { this.showBalance = !isOn; });
            }
          }
          .width('100%')
          .justifyContent(FlexAlign.SpaceBetween)
          .alignItems(VerticalAlign.Center)
          .padding({ left: AppTokens.Spacing.lg, right: AppTokens.Spacing.lg, top: AppTokens.Spacing.md, bottom: AppTokens.Spacing.lg });

          // Account Cards
          ForEach(this.accounts, (a: AccountCard) => {
            Column() {
              Row() {
                Row() {
                  Box()
                    .width(16)
                    .height(16)
                    .backgroundColor(a.accent)
                    .borderRadius(AppTokens.Shapes.small);
                  Text(a.name)
                    .fontSize(AppTokens.TypographyTokens.title)
                    .fontColor(AppTokens.Colors.onSurface)
                    .margin({ left: AppTokens.Spacing.sm });
                }

                Text('Manage')
                  .fontSize(AppTokens.TypographyTokens.label)
                  .fontColor(AppTokens.Colors.onSecondary)
                  .backgroundColor(AppTokens.Colors.secondary)
                  .borderRadius(AppTokens.Shapes.small)
                  .border({ width: 1, color: AppTokens.Colors.outline })
                  .padding({ left: AppTokens.Spacing.lg, right: AppTokens.Spacing.lg, top: AppTokens.Spacing.sm, bottom: AppTokens.Spacing.sm });
              }
              .width('100%')
              .justifyContent(FlexAlign.SpaceBetween)
              .alignItems(VerticalAlign.Center);

              // Balance Box
              Row() {
                Text(this.showBalance ? a.balance : '•••••••')
                  .fontSize(AppTokens.TypographyTokens.headline)
                  .fontColor(AppTokens.Colors.onSurface);
              }
              .width('100%')
              .height(80)
              .margin({ top: AppTokens.Spacing.sm, bottom: AppTokens.Spacing.sm })
              .backgroundColor(AppTokens.Colors.surfaceVariant)
              .borderRadius(AppTokens.Shapes.medium)
              .justifyContent(FlexAlign.Center)
              .alignItems(VerticalAlign.Center);

              Row() {
                Text('Transfer')
                  .fontSize(AppTokens.TypographyTokens.label)
                  .fontColor(AppTokens.Colors.onSecondary)
                  .backgroundColor(AppTokens.Colors.secondary)
                  .borderRadius(AppTokens.Shapes.small)
                  .border({ width: 1, color: AppTokens.Colors.outline })
                  .padding({ left: AppTokens.Spacing.lg, right: AppTokens.Spacing.lg, top: AppTokens.Spacing.sm, bottom: AppTokens.Spacing.sm })
                  .margin({ right: AppTokens.Spacing.sm });

                Text('Details')
                  .fontSize(AppTokens.TypographyTokens.label)
                  .fontColor(AppTokens.Colors.onSurface)
                  .backgroundColor(AppTokens.Colors.surface)
                  .borderRadius(AppTokens.Shapes.small)
                  .border({ width: 1, color: AppTokens.Colors.outline })
                  .padding({ left: AppTokens.Spacing.lg, right: AppTokens.Spacing.lg, top: AppTokens.Spacing.sm, bottom: AppTokens.Spacing.sm });
              }
            }
            .width('100%')
            .padding(AppTokens.Spacing.lg)
            .margin({ bottom: AppTokens.Spacing.lg, left: AppTokens.Spacing.lg, right: AppTokens.Spacing.lg })
            .backgroundColor(AppTokens.Colors.surface)
            .borderRadius(AppTokens.Shapes.large)
            .border({ width: 1, color: AppTokens.Colors.outline })
            .shadow({ radius: AppTokens.ElevationMapping.level2, color: '#1A000000' });
          });

          // Recent Activity Header
          Row() {
            Text('Recent Activity')
              .fontSize(AppTokens.TypographyTokens.headline)
              .fontColor(AppTokens.Colors.onSurface);

            Row() {
              Text('Income')
                .fontSize(AppTokens.TypographyTokens.label)
                .fontColor(this.flags.includes('Income') ? AppTokens.Colors.onSecondary : AppTokens.Colors.onSurface)
                .backgroundColor(this.flags.includes('Income') ? AppTokens.Colors.secondary : AppTokens.Colors.surface)
                .borderRadius(AppTokens.Shapes.small)
                .border({ width: 1, color: AppTokens.Colors.outline })
                .padding({ left: AppTokens.Spacing.lg, right: AppTokens.Spacing.lg, top: AppTokens.Spacing.sm, bottom: AppTokens.Spacing.sm })
                .margin({ right: AppTokens.Spacing.sm })
                .onClick(() => {
                  const index = this.flags.indexOf('Income');
                  if (index >= 0) {
                    this.flags.splice(index, 1);
                  } else {
                    this.flags.push('Income');
                  }
                });

              Text('Expense')
                .fontSize(AppTokens.TypographyTokens.label)
                .fontColor(this.flags.includes('Expense') ? AppTokens.Colors.onSecondary : AppTokens.Colors.onSurface)
                .backgroundColor(this.flags.includes('Expense') ? AppTokens.Colors.secondary : AppTokens.Colors.surface)
                .borderRadius(AppTokens.Shapes.small)
                .border({ width: 1, color: AppTokens.Colors.outline })
                .padding({ left: AppTokens.Spacing.lg, right: AppTokens.Spacing.lg, top: AppTokens.Spacing.sm, bottom: AppTokens.Spacing.sm })
                .onClick(() => {
                  const index = this.flags.indexOf('Expense');
                  if (index >= 0) {
                    this.flags.splice(index, 1);
                  } else {
                    this.flags.push('Expense');
                  }
                });
            }
          }
          .width('100%')
          .justifyContent(FlexAlign.SpaceBetween)
          .alignItems(VerticalAlign.Center)
          .padding({ left: AppTokens.Spacing.lg, right: AppTokens.Spacing.lg, bottom: AppTokens.Spacing.lg });

          // Transaction Items
          ForEach(this.txs, (t: TxItem) => {
            Row() {
              Row() {
                Box()
                  .width(32)
                  .height(32)
                  .backgroundColor(t.positive ? AppTokens.Colors.success : AppTokens.Colors.error)
                  .borderRadius(AppTokens.Shapes.small)
                  .margin({ right: AppTokens.Spacing.md });

                Column() {
                  Text(t.title)
                    .fontSize(AppTokens.TypographyTokens.title)
                    .fontColor(AppTokens.Colors.onSurface);
                  Text(t.subtitle)
                    .fontSize(AppTokens.TypographyTokens.body)
                    .fontColor(AppTokens.Colors.onSurface)
                    .margin({ top: AppTokens.Spacing.xs });
                }
                .alignItems(HorizontalAlign.Start);
              }
              .alignItems(VerticalAlign.Center);

              Text(t.amount)
                .fontSize(AppTokens.TypographyTokens.title)
                .fontColor(t.positive ? AppTokens.Colors.success : AppTokens.Colors.error);
            }
            .width('100%')
            .justifyContent(FlexAlign.SpaceBetween)
            .alignItems(VerticalAlign.Center)
            .padding(AppTokens.Spacing.lg)
            .margin({ bottom: AppTokens.Spacing.lg, left: AppTokens.Spacing.lg, right: AppTokens.Spacing.lg })
            .backgroundColor(AppTokens.Colors.surface)
            .borderRadius(AppTokens.Shapes.large)
            .border({ width: 1, color: AppTokens.Colors.outline })
            .shadow({ radius: AppTokens.ElevationMapping.level1, color: '#1A000000' });
          });

          // Bottom Spacer
          Column().height(AppTokens.Spacing.xxxl);
        }
      }
      .layoutWeight(1)
      .backgroundColor(AppTokens.Colors.background);

      // Bottom Bar
      Row() {
        Column() {
          Text('Total Balance')
            .fontSize(AppTokens.TypographyTokens.label)
            .fontColor(AppTokens.Colors.onSurface);
          Text(this.showBalance ? '$26,395.75' : '•••••••')
            .fontSize(AppTokens.TypographyTokens.headline)
            .fontColor(AppTokens.Colors.onSurface)
            .margin({ top: AppTokens.Spacing.xs });
        }
        .alignItems(HorizontalAlign.Start);

        Button('Add Money')
          .fontSize(AppTokens.TypographyTokens.title)
          .fontColor(AppTokens.Colors.onSecondary)
          .backgroundColor(AppTokens.Colors.secondary)
          .borderRadius(AppTokens.Shapes.large)
          .height(44)
          .width(140);
      }
      .width('100%')
      .height(80)
      .justifyContent(FlexAlign.SpaceBetween)
      .alignItems(VerticalAlign.Center)
      .padding({ left: AppTokens.Spacing.lg, right: AppTokens.Spacing.lg, top: AppTokens.Spacing.md, bottom: AppTokens.Spacing.md })
      .backgroundColor(AppTokens.Colors.surface)
      .shadow({ radius: AppTokens.ElevationMapping.level3, color: '#1A000000' });
    }
    .height('100%')
    .width('100%');
  }
}