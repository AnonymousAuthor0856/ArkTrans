import { router } from '@kit.ArkUI';

// --- Design Tokens & Constants ---

interface AppTokenColors {
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
  onTertiary: string;
  onBackground: string;
  onSurface: string;
}

interface AppTokenSpacing {
  xs: number;
  sm: number;
  md: number;
  lg: number;
  xl: number;
  xxl: number;
  xxxl: number;
}

interface AppTokenRadius {
  small: number;
  medium: number;
  large: number;
}

const AppTokens = {
  Colors: {
    primary: '#214E34',
    secondary: '#2D6A4F',
    tertiary: '#6C757D',
    background: '#F8F1E5',
    surface: '#FFFDF5', // Slightly adjusted for better contrast on ArkTS
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
  } as AppTokenColors,
  Spacing: {
    xs: 4,
    sm: 8,
    md: 12,
    lg: 16,
    xl: 20,
    xxl: 28,
    xxxl: 40
  } as AppTokenSpacing,
  Radius: {
    small: 6,
    medium: 10,
    large: 14
  } as AppTokenRadius
};

interface StockItem {
  code: string;
  name: string;
  price: string;
  change: string;
  positive: boolean;
}

@Entry
@Component
struct StockCalendarApp {
  @State selectedDayIndex: number = 0;
  @State selectedSectorIndex: number = 0;

  private days: string[] = ['Mon', 'Tue', 'Wed', 'Thu', 'Fri'];
  private sectors: string[] = ['All', 'Tech', 'Energy', 'Finance'];
  
  private stockData: StockItem[] = [
    { code: "600519", name: "Kweichow Moutai", price: "1687.3", change: "+1.24%", positive: true },
    { code: "000001", name: "Ping An Bank", price: "12.54", change: "-0.62%", positive: false },
    { code: "300750", name: "CATL", price: "192.8", change: "+0.87%", positive: true },
    { code: "601318", name: "Ping An Ins.", price: "44.2", change: "-1.12%", positive: false },
    { code: "600036", name: "CMBC", price: "36.9", change: "+0.15%", positive: true },
    { code: "688981", name: "SMIC", price: "56.4", change: "-0.48%", positive: false }
  ];

  build() {
    Column() {
      // Header
      Text('Stock Calendar')
        .fontSize(26)
        .fontWeight(FontWeight.Bold)
        .fontColor(AppTokens.Colors.onSurface)
        .textAlign(TextAlign.Center)
        .width('100%')
        .margin({ top: 40, bottom: AppTokens.Spacing.md })

      // Filter Card
      Row() {
        Column() {
          // Days Row
          Flex({ wrap: FlexWrap.Wrap, justifyContent: FlexAlign.SpaceBetween }) {
            ForEach(this.days, (day: string, index: number) => {
              Button(day)
                .type(ButtonType.Normal)
                .backgroundColor(index === this.selectedDayIndex ? AppTokens.Colors.primary : AppTokens.Colors.surfaceVariant)
                .fontColor(index === this.selectedDayIndex ? AppTokens.Colors.onPrimary : AppTokens.Colors.onSurface)
                .borderRadius(AppTokens.Radius.small)
                .height(36)
                .flexShrink(1)
                .margin({ right: index < this.days.length - 1 ? AppTokens.Spacing.sm : 0 })
                .onClick(() => {
                  this.selectedDayIndex = index;
                })
            })
          }
          .width('100%')
          .margin({ bottom: AppTokens.Spacing.sm })

          // Sectors Row
          Flex({ wrap: FlexWrap.Wrap, justifyContent: FlexAlign.Start }) {
            ForEach(this.sectors, (sector: string, index: number) => {
              Button(sector)
                .type(ButtonType.Normal)
                .backgroundColor(index === this.selectedSectorIndex ? AppTokens.Colors.secondary : AppTokens.Colors.surface)
                .fontColor(index === this.selectedSectorIndex ? AppTokens.Colors.onPrimary : AppTokens.Colors.onSurface)
                .borderWidth(1)
                .borderColor(AppTokens.Colors.outline)
                .borderRadius(AppTokens.Radius.small)
                .height(36)
                .padding({ left: 12, right: 12 })
                .margin({ right: AppTokens.Spacing.sm, bottom: AppTokens.Spacing.xs })
                .onClick(() => {
                  this.selectedSectorIndex = index;
                })
            })
          }
          .width('100%')
        }
        .padding(AppTokens.Spacing.md)
        .backgroundColor(AppTokens.Colors.surface)
        .borderRadius(AppTokens.Radius.large)
        .shadow({ radius: 6, color: 'rgba(0,0,0,0.1)', offsetY: 3 })
        .border({ width: 1, color: AppTokens.Colors.outline })
      }
      .width('100%')

      // List of Stocks
      List({ space: AppTokens.Spacing.sm }) {
        ForEach(this.stockData, (item: StockItem) => {
          ListItem() {
            Row() {
              // Left Side: Icon + Info
              Row() {
                // Placeholder Icon Box
                Rect()
                  .width(28)
                  .height(28)
                  .fill(AppTokens.Colors.surfaceVariant)
                  .borderRadius(AppTokens.Radius.small)
                  .margin({ right: AppTokens.Spacing.md })

                Column() {
                  Text(item.name)
                    .fontSize(16)
                    .fontWeight(FontWeight.Medium)
                    .fontColor(AppTokens.Colors.onSurface)
                  
                  Text(item.code)
                    .fontSize(11)
                    .fontWeight(FontWeight.Medium)
                    .fontColor(AppTokens.Colors.onSurface)
                    .opacity(0.7)
                    .margin({ top: 2 })
                }
              }

              Blank().layoutWeight(1)

              // Right Side: Price + Change + Button
              Row() {
                Column() {
                  Text(item.price)
                    .fontSize(16)
                    .fontWeight(FontWeight.Medium)
                    .fontColor(AppTokens.Colors.onSurface)
                    .alignSelf(ItemAlign.End)
                  
                  Row() {
                    Circle()
                      .width(8)
                      .height(8)
                      .fill(item.positive ? AppTokens.Colors.success : AppTokens.Colors.error)
                      .margin({ right: 4 })
                    
                    Text(item.change)
                      .fontSize(11)
                      .fontWeight(FontWeight.Medium)
                      .fontColor(item.positive ? AppTokens.Colors.success : AppTokens.Colors.error)
                  }
                  .margin({ top: 2 })
                }
                .alignItems(HorizontalAlign.End)
                .margin({ right: AppTokens.Spacing.lg })

                Button('Detail')
                  .type(ButtonType.Normal)
                  .backgroundColor(AppTokens.Colors.primary)
                  .fontColor(AppTokens.Colors.onPrimary)
                  .borderRadius(AppTokens.Radius.small)
                  .height(36)
                  .width(76)
                  .fontSize(11)
                  .fontWeight(FontWeight.Medium)
              }
            }
            .width('100%')
            .padding(AppTokens.Spacing.md)
            .backgroundColor(AppTokens.Colors.surface)
            .borderRadius(AppTokens.Radius.medium)
            .shadow({ radius: 3, color: 'rgba(0,0,0,0.1)', offsetY: 1 })
            .border({ width: 1, color: AppTokens.Colors.outline })
          }
        })
      }
      .layoutWeight(1)
      .padding({ bottom: AppTokens.Spacing.xxxl })
    }
    .width('100%')
    .height('100%')
    .backgroundColor(AppTokens.Colors.background)
    .padding({ left: AppTokens.Spacing.lg, right: AppTokens.Spacing.lg })
  }
}