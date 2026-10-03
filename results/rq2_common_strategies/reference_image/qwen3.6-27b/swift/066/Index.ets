// entry/src/main/ets/viewmodel/AppTokens.ts
/**
 * Design System Tokens
 */
export class AppTokens {
  static readonly Colors = {
    primary: '#214E34',
    secondary: '#2D6A4F',
    tertiary: '#6C757D',
    background: '#F8F1E5',
    surface: '#FFFBF0',
    surfaceVariant: '#E9DFC7',
    outline: '#D2C6AA',
    success: '#2B9348',
    warning: '#F4A261',
    error: '#D62828',
    onPrimary: '#FFFFFF',
    onSecondary: '#FFFFFF',
    onTertiary: '#1B1F22',
    onBackground: '#1B1F22',
    onSurface: '#1B1F22'
  }

  static readonly Spacing = {
    xs: 4,
    sm: 8,
    md: 12,
    lg: 16,
    xl: 20,
    xxl: 28,
    xxxl: 40
  }

  static readonly FontSizes = {
    display: 26,
    headline: 20,
    title: 16,
    body: 13,
    label: 11
  }
}

// entry/src/main/ets/model/DataModels.ts
/**
 * Data Models
 */
export interface DayTab {
  id: number;
  label: string;
}

export interface StockRow {
  id: number;
  code: string;
  name: string;
  price: string;
  change: string;
  positive: boolean;
}

// entry/src/main/ets/components/CustomCard.ets
import { AppTokens } from '../viewmodel/AppTokens';

@Component
export struct CustomCard {
  @Prop containerColor: ResourceColor = AppTokens.Colors.surface;
  @Prop content: () => void;
  @Prop cornerRadius: number = 14;

  build() {
    Column() {
      this.content();
    }
    .width('100%')
    .backgroundColor(this.containerColor)
    .borderRadius(this.cornerRadius)
    .border({ width: 1, color: AppTokens.Colors.outline })
    // Simulating Elevation Level 2 shadow
    .shadow({ radius: 6, color: 'rgba(0, 0, 0, 0.14)', offsetY: 3 })
  }
}

// entry/src/main/ets/components/FilterChip.ets
import { AppTokens } from '../viewmodel/AppTokens';

@Component
export struct FilterChip {
  @Prop selected: boolean = false;
  @Prop label: string = '';
  @Prop action: () => void;

  build() {
    Button(this.label) {
      Text(this.label)
        .fontSize(AppTokens.FontSizes.label)
        .fontWeight(FontWeight.Medium)
        .fontColor(this.selected ? AppTokens.Colors.onPrimary : AppTokens.Colors.onSurface)
    }
    .type(ButtonType.Normal)
    .backgroundColor(this.selected ? AppTokens.Colors.secondary : AppTokens.Colors.surface)
    .borderRadius(6)
    .border({ width: 1, color: AppTokens.Colors.outline })
    .padding({ left: AppTokens.Spacing.md, right: AppTokens.Spacing.md, top: AppTokens.Spacing.sm, bottom: AppTokens.Spacing.sm })
    .onClick(() => {
      this.action();
    })
  }
}

// entry/src/main/ets/pages/Index.ets
import { AppTokens } from '../viewmodel/AppTokens';
import { DayTab, StockRow } from '../model/DataModels';
import { CustomCard } from '../components/CustomCard';
import { FilterChip } from '../components/FilterChip';

@Entry
@Component
struct RootScreen {
  // State Management
  @State selectedDayId: number = 1;
  @State currentSector: string = "All";

  // Mock Data
  private days: DayTab[] = [
    { id: 1, label: "Mon" },
    { id: 2, label: "Tue" },
    { id: 3, label: "Wed" },
    { id: 4, label: "Thu" },
    { id: 5, label: "Fri" }
  ];

  private sectors: string[] = ["All", "Tech", "Energy", "Finance"];

  private items: StockRow[] = [
    { id: 1, code: "600519", name: "Kweichow Moutai", price: "1687.3", change: "+1.24%", positive: true },
    { id: 2, code: "000001", name: "Ping An Bank", price: "12.54", change: "-0.62%", positive: false },
    { id: 3, code: "300750", name: "CATL", price: "192.8", change: "+0.87%", positive: true },
    { id: 4, code: "601318", name: "Ping An Ins.", price: "44.2", change: "-1.12%", positive: false },
    { id: 5, code: "600036", name: "CMBC", price: "36.9", change: "+0.15%", positive: true },
    { id: 6, code: "688981", name: "SMIC", price: "56.4", change: "-0.48%", positive: false }
  ];

  build() {
    Column() {
      // Top Bar
      Row() {
        Text("Stock Calendar")
          .fontSize(AppTokens.FontSizes.display)
          .fontWeight(FontWeight.Semibold)
          .fontColor(AppTokens.Colors.onSurface)
      }
      .width('100%')
      .justifyContent(FlexAlign.Center)
      .padding({ top: AppTokens.Spacing.xxl, bottom: AppTokens.Spacing.xxl })

      // Scrollable Content
      Scroll() {
        Column({ space: AppTokens.Spacing.md }) {
          
          // Date & Sector Selection Card
          CustomCard({
            containerColor: AppTokens.Colors.surface,
            cornerRadius: 14
          }) {
            Column({ space: AppTokens.Spacing.md }) {
              // Days Row
              Row({ space: AppTokens.Spacing.md }) {
                ForEach(this.days, (day: DayTab) => {
                  Button(day.label) {
                    Text(day.label)
                      .fontSize(day.id === this.selectedDayId ? AppTokens.FontSizes.title : AppTokens.FontSizes.body)
                      .fontWeight(day.id === this.selectedDayId ? FontWeight.Medium : FontWeight.Regular)
                      .fontColor(day.id === this.selectedDayId ? AppTokens.Colors.onPrimary : AppTokens.Colors.onSurface)
                  }
                  .type(ButtonType.Normal)
                  .layoutWeight(1)
                  .height(36)
                  .backgroundColor(day.id === this.selectedDayId ? AppTokens.Colors.primary : AppTokens.Colors.surfaceVariant)
                  .borderRadius(6)
                  .onClick(() => {
                    this.selectedDayId = day.id;
                  })
                })
              }

              // Sectors Row
              Flex({ wrap: FlexWrap.Wrap, justifyContent: FlexAlign.Start }) {
                ForEach(this.sectors, (sector: string) => {
                  FilterChip({
                    selected: this.currentSector === sector,
                    label: sector,
                    action: () => {
                      this.currentSector = sector;
                    }
                  })
                  .margin({ right: AppTokens.Spacing.sm, bottom: AppTokens.Spacing.sm })
                })
              }
            }
            .padding(AppTokens.Spacing.md)
          }

          // Stock List
          Column({ space: AppTokens.Spacing.sm }) {
            ForEach(this.items, (item: StockRow) => {
              CustomCard({
                containerColor: AppTokens.Colors.surface,
                cornerRadius: 10
              }) {
                Row() {
                  // Left Side: Icon + Info
                  Row({ space: AppTokens.Spacing.md }) {
                    // Placeholder Icon
                    Rectangle()
                      .width(28)
                      .height(28)
                      .fill(AppTokens.Colors.surfaceVariant)
                      .borderRadius(6)

                    Column({ space: AppTokens.Spacing.xs }) {
                      Text(item.name)
                        .fontSize(AppTokens.FontSizes.title)
                        .fontWeight(FontWeight.Medium)
                        .fontColor(AppTokens.Colors.onSurface)
                      
                      Text(item.code)
                        .fontSize(AppTokens.FontSizes.label)
                        .fontWeight(FontWeight.Medium)
                        .fontColor(AppTokens.Colors.onSurface)
                    }
                  }

                  Blank()

                  // Right Side: Price + Change + Button
                  Row({ space: AppTokens.Spacing.lg }) {
                    Column({ space: AppTokens.Spacing.xs }) {
                      Text(item.price)
                        .fontSize(AppTokens.FontSizes.title)
                        .fontWeight(FontWeight.Medium)
                        .fontColor(AppTokens.Colors.onSurface)
                        .textAlign(TextAlign.End)

                      Row({ space: AppTokens.Spacing.xs }) {
                        Circle()
                          .width(8)
                          .height(8)
                          .fill(item.positive ? AppTokens.Colors.success : AppTokens.Colors.error)
                        
                        Text(item.change)
                          .fontSize(AppTokens.FontSizes.label)
                          .fontWeight(FontWeight.Medium)
                          .fontColor(item.positive ? AppTokens.Colors.success : AppTokens.Colors.error)
                      }
                      .alignItems(VerticalAlign.Center)
                    }
                    .alignItems(HorizontalAlign.End)

                    Button("Detail") {
                      Text("Detail")
                        .fontSize(AppTokens.FontSizes.label)
                        .fontWeight(FontWeight.Medium)
                        .fontColor(AppTokens.Colors.onPrimary)
                    }
                    .type(ButtonType.Normal)
                    .width(76)
                    .height(36)
                    .backgroundColor(AppTokens.Colors.primary)
                    .borderRadius(6)
                  }
                }
                .padding(AppTokens.Spacing.md)
                .minHeight(72)
              }
            })
          }
        }
        .padding({
          left: AppTokens.Spacing.lg,
          right: AppTokens.Spacing.lg,
          top: AppTokens.Spacing.md,
          bottom: AppTokens.Spacing.xxxl
        })
      }
      .layoutWeight(1)
      .scrollBar(BarState.Off)
    }
    .width('100%')
    .height('100%')
    .backgroundColor(AppTokens.Colors.background)
    .statusBarConfig({ mode: StatusBarMode.Custom, color: AppTokens.Colors.background })
  }
}