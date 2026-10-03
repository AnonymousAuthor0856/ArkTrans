// AppTokens.ets - Design tokens and theme configuration

export class AppColors {
  static readonly primary: string = '#214E34';
  static readonly secondary: string = '#2D6A4F';
  static readonly tertiary: string = '#6C757D';
  static readonly background: string = '#F8F1E5';
  static readonly surface: string = '#FFFBF0';
  static readonly surfaceVariant: string = '#E9DFC7';
  static readonly outline: string = '#D2C6AA';
  static readonly success: string = '#2B9348';
  static readonly warning: string = '#F4A261';
  static readonly error: string = '#D62828';
  static readonly onPrimary: string = '#FFFFFF';
  static readonly onSecondary: string = '#FFFFFF';
  static readonly onTertiary: string = '#1B1F22';
  static readonly onBackground: string = '#1B1F22';
  static readonly onSurface: string = '#1B1F22';
}

export class AppTypography {
  static readonly display: string = '26';
  static readonly headline: string = '20';
  static readonly title: string = '16';
  static readonly body: string = '13';
  static readonly label: string = '11';
}

export class AppSpacing {
  static readonly xs: number = 4;
  static readonly sm: number = 8;
  static readonly md: number = 12;
  static readonly lg: number = 16;
  static readonly xl: number = 20;
  static readonly xxl: number = 28;
  static readonly xxxl: number = 40;
}

export class AppShapes {
  static readonly small: number = 6;
  static readonly medium: number = 10;
  static readonly large: number = 14;
}

// Models
export class DayTab {
  id: number;
  label: string;

  constructor(id: number, label: string) {
    this.id = id;
    this.label = label;
  }
}

export class StockRow {
  code: string;
  name: string;
  price: string;
  change: string;
  positive: boolean;

  constructor(code: string, name: string, price: string, change: string, positive: boolean) {
    this.code = code;
    this.name = name;
    this.price = price;
    this.change = change;
    this.positive = positive;
  }
}

// RootScreen.ets - Main UI Component

import { AppColors, AppTypography, AppSpacing, AppShapes, DayTab, StockRow } from './AppTokens';

@Entry
@Component
struct RootScreen {
  @State selectedDayId: number = 1;
  @State currentSector: string = 'All';
  
  private days: DayTab[] = [
    new DayTab(1, 'Mon'),
    new DayTab(2, 'Tue'),
    new DayTab(3, 'Wed'),
    new DayTab(4, 'Thu'),
    new DayTab(5, 'Fri')
  ];
  
  private sectors: string[] = ['All', 'Tech', 'Energy', 'Finance'];
  
  private items: StockRow[] = [
    new StockRow('600519', 'Kweichow Moutai', '1687.3', '+1.24%', true),
    new StockRow('000001', 'Ping An Bank', '12.54', '-0.62%', false),
    new StockRow('300750', 'CATL', '192.8', '+0.87%', true),
    new StockRow('601318', 'Ping An Ins.', '44.2', '-1.12%', false),
    new StockRow('600036', 'CMBC', '36.9', '+0.15%', true),
    new StockRow('688981', 'SMIC', '56.4', '-0.48%', false)
  ];

  build() {
    Column() {
      // Top App Bar
      Text('Stock Calendar')
        .fontSize(AppTypography.display)
        .fontWeight(FontWeight.Medium)
        .fontColor(AppColors.onSurface)
        .width('100%')
        .textAlign(TextAlign.Center)
        .padding(AppSpacing.md)

      // Content Area
      Column() {
        // Filter Card
        Column() {
          // Days Row
          Row({ space: AppSpacing.sm }) {
            ForEach(this.days, (day: DayTab) => {
              Column() {
                Text(day.label)
                  .fontSize(this.selectedDayId === day.id ? AppTypography.title : AppTypography.body)
                  .fontColor(this.selectedDayId === day.id ? AppColors.onPrimary : AppColors.onSurface)
              }
              .layoutWeight(1)
              .height(36)
              .backgroundColor(this.selectedDayId === day.id ? AppColors.primary : AppColors.surfaceVariant)
              .borderRadius(AppShapes.small)
              .justifyContent(FlexAlign.Center)
              .onClick(() => {
                this.selectedDayId = day.id;
              })
            })
          }
          .width('100%')
          .margin({ bottom: AppSpacing.sm })

          // Sectors Row
          Row({ space: AppSpacing.sm }) {
            ForEach(this.sectors, (sector: string) => {
              Text(sector)
                .fontSize(AppTypography.label)
                .fontColor(this.currentSector === sector ? AppColors.onPrimary : AppColors.onSurface)
                .backgroundColor(this.currentSector === sector ? AppColors.secondary : AppColors.surface)
                .borderRadius(AppShapes.small)
                .border({ width: 1, color: AppColors.outline })
                .padding({ top: AppSpacing.xs, bottom: AppSpacing.xs, left: AppSpacing.sm, right: AppSpacing.sm })
                .onClick(() => {
                  this.currentSector = sector;
                })
            })
          }
          .width('100%')
        }
        .width('100%')
        .padding(AppSpacing.md)
        .backgroundColor(AppColors.surface)
        .borderRadius(AppShapes.large)
        .border({ width: 1, color: AppColors.outline })
        .margin({ bottom: AppSpacing.md })

        // Stock List
        Scroll() {
          Column({ space: AppSpacing.sm }) {
            ForEach(this.items, (item: StockRow) => {
              // Stock Card
              Row() {
                // Left Section: Icon + Name/Code
                Row({ space: AppSpacing.md }) {
                  Column()
                    .width(28)
                    .height(28)
                    .backgroundColor(AppColors.surfaceVariant)
                    .borderRadius(AppShapes.small)

                  Column({ space: AppSpacing.xs }) {
                    Text(item.name)
                      .fontSize(AppTypography.title)
                      .fontWeight(FontWeight.Medium)
                      .fontColor(AppColors.onSurface)
                    Text(item.code)
                      .fontSize(AppTypography.label)
                      .fontColor(AppColors.onSurface)
                  }
                  .alignItems(HorizontalAlign.Start)
                }

                // Right Section: Price/Change + Button
                Row({ space: AppSpacing.lg }) {
                  Column() {
                    Text(item.price)
                      .fontSize(AppTypography.title)
                      .fontWeight(FontWeight.Medium)
                      .fontColor(AppColors.onSurface)
                      .margin({ bottom: AppSpacing.xs })

                    Row({ space: AppSpacing.xs }) {
                      Column()
                        .width(8)
                        .height(8)
                        .backgroundColor(item.positive ? AppColors.success : AppColors.error)
                        .borderRadius(AppShapes.small)
                      Text(item.change)
                        .fontSize(AppTypography.label)
                        .fontColor(item.positive ? AppColors.success : AppColors.error)
                    }
                  }
                  .alignItems(HorizontalAlign.End)

                  // Detail Button
                  Button('Detail')
                    .fontSize(AppTypography.label)
                    .fontColor(AppColors.onPrimary)
                    .backgroundColor(AppColors.primary)
                    .borderRadius(AppShapes.small)
                    .height(36)
                    .width(76)
                    .padding(0)
                }
              }
              .width('100%')
              .padding(AppSpacing.md)
              .backgroundColor(AppColors.surface)
              .borderRadius(AppShapes.medium)
              .border({ width: 1, color: AppColors.outline })
              .justifyContent(FlexAlign.SpaceBetween)
              .alignItems(VerticalAlign.Center)
            })
          }
          .width('100%')
          .padding({ bottom: AppSpacing.xxxl })
        }
        .layoutWeight(1)
        .align(Alignment.Top)
        .scrollBar(BarState.Off)
      }
      .width('100%')
      .height('100%')
      .padding({ left: AppSpacing.lg, right: AppSpacing.lg, top: AppSpacing.md, bottom: AppSpacing.md })
    }
    .width('100%')
    .height('100%')
    .backgroundColor(AppColors.background)
  }
}