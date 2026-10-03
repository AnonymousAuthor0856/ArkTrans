import { Component, View, Text, Column, Row, Button, Scroll, ForEach } from '@ohos.arkui';

// AppTokens
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
    onSurface: '#020617'
  };

  static Typography = {
    display: { fontSize: 48, fontWeight: FontWeight.Bold, lineHeight: 56 },
    headline: { fontSize: 28, fontWeight: FontWeight.Medium, lineHeight: 36 },
    title: { fontSize: 20, fontWeight: FontWeight.Medium, lineHeight: 28 },
    body: { fontSize: 16, fontWeight: FontWeight.Normal, lineHeight: 24 },
    label: { fontSize: 12, fontWeight: FontWeight.Medium, lineHeight: 16 }
  };

  static Shapes = {
    small: 8,
    medium: 16,
    large: 24
  };

  static Spacing = {
    xs: 4,
    sm: 8,
    md: 16,
    lg: 24,
    xl: 32,
    xxl: 48
  };
}

// Data models
class Transaction {
  id: number;
  name: string;
  detail: string;
  amount: string;
  isCredit: boolean;

  constructor(id: number, name: string, detail: string, amount: string, isCredit: boolean) {
    this.id = id;
    this.name = name;
    this.detail = detail;
    this.amount = amount;
    this.isCredit = isCredit;
  }
}

class ControlAction {
  label: string;

  constructor(label: string) {
    this.label = label;
  }
}

class NavItem {
  label: string;

  constructor(label: string) {
    this.label = label;
  }
}

// Root Screen Component
@Component
struct RootScreen {
  @State selectedNavItem: string = 'Home';
  @State transactions: Transaction[] = [
    new Transaction(1, 'Spotify', 'Subscription', '-$9.99', false),
    new Transaction(2, 'Income', 'Monthly Salary', '+$2,500.00', true),
    new Transaction(3, 'Starbucks', 'Coffee', '-$5.75', false),
    new Transaction(4, 'Amazon', 'Shopping', '-$124.50', false),
    new Transaction(5, 'Refund', 'Amazon Return', '+$32.00', true)
  ];
  @State controlActions: ControlAction[] = [
    new ControlAction('Send'),
    new ControlAction('Receive'),
    new ControlAction('Add'),
    new ControlAction('More')
  ];
  @State navItems: NavItem[] = [
    new NavItem('Home'),
    new NavItem('Cards'),
    new NavItem('Activity'),
    new NavItem('Profile')
  ];

  build() {
    Column() {
      // Top App Bar
      Row() {
        // Navigation icon placeholder
        Row()
          .width(28)
          .height(28)
          .borderRadius(14)
          .backgroundColor(AppTokens.Colors.surfaceVariant)

        Blank()
          .layoutWeight(1)

        Text('My Wallet')
          .fontSize(AppTokens.Typography.title.fontSize)
          .fontWeight(AppTokens.Typography.title.fontWeight)
          .fontColor(AppTokens.Colors.onBackground)

        Blank()
          .layoutWeight(1)

        // Action icon placeholder
        Row()
          .width(28)
          .height(28)
          .borderRadius(14)
          .backgroundColor(AppTokens.Colors.surfaceVariant)
      }
      .width('100%')
      .padding({ left: 16, right: 16, top: 8, bottom: 8 })
      .alignItems(VerticalAlign.Center)

      // Main content
      Scroll() {
        Column() {
          // Total Balance Card
          Column() {
            Text('Total Balance')
              .fontSize(AppTokens.Typography.body.fontSize)
              .fontColor('#B3FFFFFF')
              .fontWeight(AppTokens.Typography.body.fontWeight)

            Text('$ 1,145.14')
              .fontSize(AppTokens.Typography.display.fontSize)
              .fontWeight(AppTokens.Typography.display.fontWeight)
              .fontColor(AppTokens.Colors.onPrimary)
              .margin({ top: AppTokens.Spacing.sm })

            Row() {
              Row()
                .width(10)
                .height(10)
                .borderRadius(5)
                .backgroundColor(AppTokens.Colors.secondary)

              Text('+$234.10 today')
                .fontSize(AppTokens.Typography.body.fontSize)
                .fontColor(AppTokens.Colors.secondary)
                .margin({ left: AppTokens.Spacing.sm })
            }
            .margin({ top: AppTokens.Spacing.xs })
            .alignItems(VerticalAlign.Center)
          }
          .width('100%')
          .padding(AppTokens.Spacing.lg)
          .borderRadius(AppTokens.Shapes.large)
          .backgroundColor(AppTokens.Colors.primary)

          // Control Actions
          Row() {
            ForEach(this.controlActions, (action: ControlAction) => {
              Column() {
                Button() {
                  Row()
                    .width(24)
                    .height(24)
                    .borderRadius(AppTokens.Shapes.small)
                    .backgroundColor(AppTokens.Colors.primary)
                }
                .width(64)
                .height(64)
                .borderRadius(32)
                .backgroundColor(AppTokens.Colors.surface)

                Text(action.label)
                  .fontSize(AppTokens.Typography.label.fontSize)
                  .fontWeight(AppTokens.Typography.label.fontWeight)
                  .fontColor(AppTokens.Colors.onSurface)
                  .margin({ top: AppTokens.Spacing.sm })
              }
              .alignItems(HorizontalAlign.Center)
            })
          }
          .width('100%')
          .justifyContent(FlexAlign.SpaceAround)
          .margin({ top: AppTokens.Spacing.lg })

          // Recent Activity Header
          Row() {
            Text('Recent Activity')
              .fontSize(AppTokens.Typography.title.fontSize)
              .fontWeight(AppTokens.Typography.title.fontWeight)
              .fontColor(AppTokens.Colors.onBackground)

            Blank()
              .layoutWeight(1)

            Text('View All')
              .fontSize(AppTokens.Typography.label.fontSize)
              .fontWeight(AppTokens.Typography.label.fontWeight)
              .fontColor(AppTokens.Colors.tertiary)
          }
          .width('100%')
          .margin({ top: AppTokens.Spacing.lg })
          .alignItems(VerticalAlign.Center)

          // Transaction Cards
          ForEach(this.transactions, (transaction: Transaction) => {
            Row() {
              Row()
                .width(48)
                .height(48)
                .borderRadius(AppTokens.Shapes.medium)
                .backgroundColor(AppTokens.Colors.surfaceVariant)

              Column() {
                Text(transaction.name)
                  .fontSize(AppTokens.Typography.body.fontSize)
                  .fontWeight(FontWeight.Bold)
                  .fontColor(AppTokens.Colors.onSurface)

                Text(transaction.detail)
                  .fontSize(AppTokens.Typography.label.fontSize)
                  .fontWeight(AppTokens.Typography.label.fontWeight)
                  .fontColor(AppTokens.Colors.tertiary)
                  .margin({ top: 2 })
              }
              .layoutWeight(1)
              .margin({ left: AppTokens.Spacing.md })

              Text(transaction.amount)
                .fontSize(AppTokens.Typography.body.fontSize)
                .fontWeight(FontWeight.Bold)
                .fontColor(transaction.isCredit ? AppTokens.Colors.success : AppTokens.Colors.onSurface)
            }
            .width('100%')
            .padding(AppTokens.Spacing.md)
            .borderRadius(AppTokens.Shapes.medium)
            .backgroundColor(AppTokens.Colors.surface)
            .border({ width: 1, color: AppTokens.Colors.outline })
            .margin({ top: AppTokens.Spacing.md })
            .alignItems(VerticalAlign.Center)
          })
        }
        .width('100%')
        .padding({ left: AppTokens.Spacing.md, right: AppTokens.Spacing.md, top: AppTokens.Spacing.sm, bottom: AppTokens.Spacing.sm })
      }
      .layoutWeight(1)
      .scrollBar(BarState.Off)

      // Bottom Navigation Bar
      Row() {
        ForEach(this.navItems, (item: NavItem) => {
          Column() {
            Row()
              .width(24)
              .height(24)
              .borderRadius(12)
              .backgroundColor(this.selectedNavItem === item.label ? AppTokens.Colors.primary : AppTokens.Colors.outline)

            Text(item.label)
              .fontSize(AppTokens.Typography.label.fontSize)
              .fontWeight(AppTokens.Typography.label.fontWeight)
              .fontColor(this.selectedNavItem === item.label ? AppTokens.Colors.primary : AppTokens.Colors.tertiary)
              .margin({ top: 4 })
          }
          .layoutWeight(1)
          .alignItems(HorizontalAlign.Center)
          .padding({ top: 8, bottom: 8 })
          .onClick(() => {
            this.selectedNavItem = item.label;
          })
        })
      }
      .width('100%')
      .backgroundColor(AppTokens.Colors.surface)
    }
    .width('100%')
    .height('100%')
    .backgroundColor(AppTokens.Colors.background)
  }
}

// Main Entry
@Entry
@Component
struct MainPage {
  build() {
    RootScreen()
  }
}