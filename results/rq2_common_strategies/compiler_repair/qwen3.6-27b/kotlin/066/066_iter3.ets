import { router } from '@kit.ArkUI'

// --- Design Tokens & Constants ---

const NAME = "111StockListen"
const UI_TYPE = "Calendar"
const STYLE_THEME = "Retro Flat"
const LANG = "en"
const BASELINE_SIZE = "720x1280"

class AppTokens {
  static Colors: Record<string, string> = {
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

  static Spacing: Record<string, number> = {
    xs: 4,
    sm: 8,
    md: 12,
    lg: 16,
    xl: 20,
    xxl: 28,
    xxxl: 40
  }
}

// --- Data Models ---

interface DayTab {
  id: number;
  label: string;
}

interface StockRow {
  code: string;
  name: string;
  price: string;
  change: string;
  positive: boolean;
}

// --- Components ---

@Component
struct DayTabItem {
  @Prop day: DayTab = {} as DayTab;
  @Prop isSelected: boolean = false;
  @Consume onClick: (id: number) => void;

  build() {
    Row() {
      Text(this.day.label)
        .fontSize(16)
        .fontWeight(FontWeight.Medium)
        .fontColor(this.isSelected ? AppTokens.Colors.onPrimary : AppTokens.Colors.onSurface)
    }
    .width('100%')
    .height(36)
    .justifyContent(FlexAlign.Center)
    .backgroundColor(this.isSelected ? AppTokens.Colors.primary : AppTokens.Colors.surfaceVariant)
    .borderRadius(6)
    .onClick(() => {
      this.onClick(this.day.id);
    })
  }
}

@Component
struct FilterChipItem {
  @Prop label: string = "";
  @Prop isSelected: boolean = false;
  @Consume onClick: (label: string) => void;

  build() {
    Row() {
      Text(this.label)
        .fontSize(11)
        .fontWeight(FontWeight.Medium)
        .fontColor(this.isSelected ? AppTokens.Colors.onPrimary : AppTokens.Colors.onSurface)
    }
    .padding({ left: 12, right: 12, top: 6, bottom: 6 })
    .backgroundColor(this.isSelected ? AppTokens.Colors.secondary : AppTokens.Colors.surface)
    .borderRadius(6)
    .borderWidth(1)
    .borderColor(AppTokens.Colors.outline)
    .onClick(() => {
      this.onClick(this.label);
    })
  }
}

@Component
struct StockCardItem {
  @Prop item: StockRow = {} as StockRow;

  build() {
    Row() {
      // Left Section: Icon + Info
      Row() {
        // Placeholder Icon Box
        Row()
          .width(28)
          .height(28)
          .backgroundColor(AppTokens.Colors.surfaceVariant)
          .borderRadius(6)

        Column() {
          Text(this.item.name)
            .fontSize(16)
            .fontWeight(FontWeight.Medium)
            .fontColor(AppTokens.Colors.onSurface)
            .margin({ top: 2 }) // Approximate spacing adjustment

          Text(this.item.code)
            .fontSize(11)
            .fontWeight(FontWeight.Medium)
            .fontColor(AppTokens.Colors.onSurface)
        }
        .alignItems(HorizontalAlign.Start)
        .margin({ left: AppTokens.Spacing.md })
      }

      // Right Section: Price + Change + Button
      Row() {
        Column() {
          Text(this.item.price)
            .fontSize(16)
            .fontWeight(FontWeight.Medium)
            .fontColor(AppTokens.Colors.onSurface)

          Row() {
            // Indicator Dot
            Row()
              .width(8)
              .height(8)
              .backgroundColor(this.item.positive ? AppTokens.Colors.success : AppTokens.Colors.error)
              .borderRadius(6)

            Text(this.item.change)
              .fontSize(11)
              .fontWeight(FontWeight.Medium)
              .fontColor(this.item.positive ? AppTokens.Colors.success : AppTokens.Colors.error)
              .margin({ left: AppTokens.Spacing.xs })
          }
          .margin({ top: 2 })
        }
        .alignItems(HorizontalAlign.End)
        .margin({ right: AppTokens.Spacing.lg })

        // Detail Button
        Button() {
          Text("Detail")
            .fontSize(11)
            .fontWeight(FontWeight.Medium)
            .fontColor(AppTokens.Colors.onPrimary)
        }
        .type(ButtonType.Normal)
        .backgroundColor(AppTokens.Colors.primary)
        .borderRadius(6)
        .width(76)
        .height(36)
      }
    }
    .width('100%')
    .padding(AppTokens.Spacing.md)
    .justifyContent(FlexAlign.SpaceBetween)
    .alignItems(VerticalAlign.Center)
  }
}

@Entry
@Component
struct RootScreen {
  @State selectedDayId: number = 1;
  @State currentSector: string = "All";

  private days: DayTab[] = [
    { id: 1, label: "Mon" },
    { id: 2, label: "Tue" },
    { id: 3, label: "Wed" },
    { id: 4, label: "Thu" },
    { id: 5, label: "Fri" }
  ];

  private sectors: string[] = ["All", "Tech", "Energy", "Finance"];

  private stockItems: StockRow[] = [
    { code: "600519", name: "Kweichow Moutai", price: "1687.3", change: "+1.24%", positive: true },
    { code: "000001", name: "Ping An Bank", price: "12.54", change: "-0.62%", positive: false },
    { code: "300750", name: "CATL", price: "192.8", change: "+0.87%", positive: true },
    { code: "601318", name: "Ping An Ins.", price: "44.2", change: "-1.12%", positive: false },
    { code: "600036", name: "CMBC", price: "36.9", change: "+0.15%", positive: true },
    { code: "688981", name: "SMIC", price: "56.4", change: "-0.48%", positive: false }
  ];

  build() {
    Column() {
      // Top Bar Area (Simulated Scaffold TopBar)
      Row() {
        Text("Stock Calendar")
          .fontSize(26)
          .fontWeight(FontWeight.Bold)
          .fontColor(AppTokens.Colors.onSurface)
          .textAlign(TextAlign.Center)
      }
      .width('100%')
      .height(56) // Standard app bar height approx
      .justifyContent(FlexAlign.Center)
      .backgroundColor(AppTokens.Colors.background)

      Scroll() {
        Column() {
          // Filter Card
          Column() {
            // Day Tabs
            Flex({ wrap: FlexWrap.NoWrap, justifyContent: FlexAlign.SpaceBetween }) {
              ForEach(this.days, (day: DayTab) => {
                DayTabItem({
                  day: day,
                  isSelected: this.selectedDayId === day.id
                })
              })
            }
            .width('100%')
            .margin({ bottom: AppTokens.Spacing.sm })

            // Sector Chips
            Flex({ wrap: FlexWrap.Wrap, justifyContent: FlexAlign.Start, alignItems: ItemAlign.Center }) {
              ForEach(this.sectors, (sector: string) => {
                FilterChipItem({
                  label: sector,
                  isSelected: this.currentSector === sector
                })
                .margin({ right: AppTokens.Spacing.sm, bottom: AppTokens.Spacing.sm })
              })
            }
            .width('100%')
          }
          .width('100%')
          .padding(AppTokens.Spacing.md)
          .backgroundColor(AppTokens.Colors.surface)
          .borderRadius(14)
          .borderWidth(1)
          .borderColor(AppTokens.Colors.outline)
          .shadow({ radius: 6, color: 'rgba(0,0,0,0.14)', offsetY: 3 })
          .margin({ bottom: AppTokens.Spacing.md })

          // Stock List
          List({ space: AppTokens.Spacing.sm }) {
            ForEach(this.stockItems, (item: StockRow) => {
              ListItem() {
                StockCardItem({ item: item })
                  .width('100%')
                  .backgroundColor(AppTokens.Colors.surface)
                  .borderRadius(10)
                  .borderWidth(1)
                  .borderColor(AppTokens.Colors.outline)
                  .shadow({ radius: 3, color: 'rgba(0,0,0,0.10)', offsetY: 1 })
              }
            })
          }
          .width('100%')
          .layoutWeight(1)
        }
        .width('100%')
        .padding({ left: AppTokens.Spacing.lg, right: AppTokens.Spacing.lg, bottom: AppTokens.Spacing.xxxl })
      }
      .layoutWeight(1)
    }
    .width('100%')
    .height('100%')
    .backgroundColor(AppTokens.Colors.background)
    .provide('onClick', (id: number) => {
      this.selectedDayId = id;
    })
    .provide('onClick', (label: string) => {
      this.currentSector = label;
    })
  }
}