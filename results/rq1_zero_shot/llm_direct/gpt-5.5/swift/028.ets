import window from '@ohos.window';

class AppColors {
  static readonly primary: ResourceColor = '#0F172A';
  static readonly secondary: ResourceColor = '#475569';
  static readonly tertiary: ResourceColor = '#94A3B8';
  static readonly background: ResourceColor = '#F8FAFC';
  static readonly surface: ResourceColor = '#FFFFFF';
  static readonly surfaceVariant: ResourceColor = '#F1F5F9';
  static readonly outline: ResourceColor = '#E2E8F0';
  static readonly success: ResourceColor = '#22C55E';
  static readonly warning: ResourceColor = '#F59E0B';
  static readonly error: ResourceColor = '#EF4444';
  static readonly onPrimary: ResourceColor = '#FFFFFF';
  static readonly onSecondary: ResourceColor = '#FFFFFF';
  static readonly onTertiary: ResourceColor = '#0F172A';
  static readonly onBackground: ResourceColor = '#0F172A';
  static readonly onSurface: ResourceColor = '#0F172A';
}

class TypographyStyle {
  fontSize: number;
  fontWeight: FontWeight;
  lineHeight: number;
  letterSpacing: number;

  constructor(fontSize: number, fontWeight: FontWeight, lineHeight: number, letterSpacing: number) {
    this.fontSize = fontSize;
    this.fontWeight = fontWeight;
    this.lineHeight = lineHeight;
    this.letterSpacing = letterSpacing;
  }
}

class AppTypography {
  static readonly display: TypographyStyle = new TypographyStyle(32, FontWeight.Bold, 40, 0);
  static readonly headline: TypographyStyle = new TypographyStyle(24, FontWeight.SemiBold, 32, 0);
  static readonly title: TypographyStyle = new TypographyStyle(18, FontWeight.Medium, 24, 0.15);
  static readonly body: TypographyStyle = new TypographyStyle(16, FontWeight.Regular, 22, 0.5);
  static readonly label: TypographyStyle = new TypographyStyle(14, FontWeight.Medium, 18, 0.5);
}

class AppShapes {
  static readonly smallCornerRadius: number = 8;
  static readonly mediumCornerRadius: number = 12;
  static readonly largeCornerRadius: number = 16;
}

class AppSpacing {
  static readonly xs: number = 4;
  static readonly sm: number = 8;
  static readonly md: number = 16;
  static readonly lg: number = 24;
  static readonly xl: number = 32;
  static readonly xxl: number = 48;
}

class ShadowSpec {
  elevation: number;
  radius: number;
  dy: number;
  opacity: number;

  constructor(elevation: number, radius: number, dy: number, opacity: number) {
    this.elevation = elevation;
    this.radius = radius;
    this.dy = dy;
    this.opacity = opacity;
  }
}

class AppElevation {
  static readonly level1: ShadowSpec = new ShadowSpec(1, 3, 1, 0.10);
  static readonly level2: ShadowSpec = new ShadowSpec(3, 6, 2, 0.10);
  static readonly level3: ShadowSpec = new ShadowSpec(6, 10, 4, 0.10);
}

class ProductivityItem {
  id: number;
  title: string;
  status: string;
  progress: number;
  statusColor: ResourceColor;

  constructor(id: number, title: string, status: string, progress: number, statusColor: ResourceColor) {
    this.id = id;
    this.title = title;
    this.status = status;
    this.progress = progress;
    this.statusColor = statusColor;
  }
}

class ChartData {
  id: number;
  label: string;
  value: number;

  constructor(id: number, label: string, value: number) {
    this.id = id;
    this.label = label;
    this.value = value;
  }
}

@Component
struct FilterChip {
  title: string = '';
  isSelected: boolean = false;
  action: () => void = () => {};

  build() {
    Text(this.title)
      .fontSize(AppTypography.label.fontSize)
      .fontWeight(AppTypography.label.fontWeight)
      .lineHeight(AppTypography.label.lineHeight)
      .letterSpacing(AppTypography.label.letterSpacing)
      .fontColor(this.isSelected ? AppColors.onPrimary : AppColors.onSurface)
      .padding({
        left: AppSpacing.md,
        right: AppSpacing.md,
        top: AppSpacing.sm,
        bottom: AppSpacing.sm
      })
      .backgroundColor(this.isSelected ? AppColors.primary : AppColors.surface)
      .borderRadius(AppShapes.smallCornerRadius)
      .border({
        width: 1,
        color: AppColors.outline
      })
      .onClick(() => {
        this.action();
      })
  }
}

@Component
struct CustomLinearProgressIndicator {
  progress: number = 0;
  color: ResourceColor = AppColors.primary;
  trackColor: ResourceColor = AppColors.surfaceVariant;
  heightValue: number = 8;

  private normalizedProgress(): number {
    return Math.max(0, Math.min(1, this.progress));
  }

  build() {
    Stack({ alignContent: Alignment.Start }) {
      Row()
        .width('100%')
        .height(this.heightValue)
        .backgroundColor(this.trackColor)
        .borderRadius(this.heightValue / 2)

      Row()
        .width(`${this.normalizedProgress() * 100}%`)
        .height(this.heightValue)
        .backgroundColor(this.color)
        .borderRadius(this.heightValue / 2)
    }
    .width('100%')
    .height(this.heightValue)
  }
}

@Entry
@Component
struct RootScreen {
  @State private selectedFilter: string = 'Weekly';

  private filters: string[] = ['Daily', 'Weekly', 'Monthly'];

  private productivityItems: ProductivityItem[] = [
    new ProductivityItem(1, 'Form Batch #A-102', 'Completed', 1.0, AppColors.success),
    new ProductivityItem(2, 'Invoice Set #B-231', 'In Progress', 0.75, AppColors.warning),
    new ProductivityItem(3, 'Document Scan #C-456', 'Pending', 0.1, AppColors.secondary),
    new ProductivityItem(4, 'Form Batch #A-103', 'Completed', 1.0, AppColors.success),
    new ProductivityItem(5, 'Data Entry #D-789', 'Failed', 0.4, AppColors.error)
  ];

  private chartData: ChartData[] = [
    new ChartData(1, 'Mon', 0.6),
    new ChartData(2, 'Tue', 0.8),
    new ChartData(3, 'Wed', 0.5),
    new ChartData(4, 'Thu', 1.0),
    new ChartData(5, 'Fri', 0.7),
    new ChartData(6, 'Sat', 0.4),
    new ChartData(7, 'Sun', 0.2)
  ];

  private topBarHeight: number = 56;
  private bottomBarButtonHeight: number = 56;
  private bottomBarPadding: number = AppSpacing.md;

  private bottomBarTotalHeight(): number {
    return this.bottomBarButtonHeight + this.bottomBarPadding * 2;
  }

  aboutToAppear(): void {
    window.getLastWindow(getContext(this), (err, win) => {
      if (!err.code) {
        win.setWindowLayoutFullScreen(true);
        win.setWindowSystemBarEnable([]);
      }
    });
  }

  build() {
    Column({ space: 0 }) {
      Row() {
        Row() {
          Circle()
            .width(24)
            .height(24)
            .fill(AppColors.outline)
        }
        .width(56)
        .height(this.topBarHeight)
        .justifyContent(FlexAlign.Center)
        .alignItems(VerticalAlign.Center)
        .onClick(() => {
        })

        Blank()
          .layoutWeight(1)

        Text('Productivity Check')
          .fontSize(AppTypography.headline.fontSize)
          .fontWeight(AppTypography.headline.fontWeight)
          .lineHeight(AppTypography.headline.lineHeight)
          .letterSpacing(AppTypography.headline.letterSpacing)
          .fontColor(AppColors.onSurface)

        Blank()
          .layoutWeight(1)

        Row() {
          Circle()
            .width(24)
            .height(24)
            .fill(AppColors.outline)
        }
        .width(56)
        .height(this.topBarHeight)
        .justifyContent(FlexAlign.Center)
        .alignItems(VerticalAlign.Center)
        .onClick(() => {
        })
      }
      .width('100%')
      .height(this.topBarHeight)
      .backgroundColor(AppColors.surface)
      .shadow({
        radius: AppElevation.level3.radius,
        color: '#1A000000',
        offsetX: 0,
        offsetY: AppElevation.level3.dy
      })
      .zIndex(1)

      Scroll() {
        Column({ space: AppSpacing.lg }) {
          Row() {
            ForEach(this.filters, (filter: string) => {
              FilterChip({
                title: filter,
                isSelected: this.selectedFilter === filter,
                action: () => {
                  this.selectedFilter = filter;
                }
              })

              if (filter !== this.filters[this.filters.length - 1]) {
                Blank()
                  .width(AppSpacing.sm)
              }
            }, (filter: string) => filter)
          }
          .width('100%')
          .padding({
            left: AppSpacing.md,
            right: AppSpacing.md
          })

          Column({ space: 0 }) {
            Text('Weekly Throughput')
              .fontSize(AppTypography.title.fontSize)
              .fontWeight(AppTypography.title.fontWeight)
              .lineHeight(AppTypography.title.lineHeight)
              .letterSpacing(AppTypography.title.letterSpacing)
              .fontColor(AppColors.onSurface)
              .margin({ bottom: AppSpacing.md })

            Column({ space: AppSpacing.sm }) {
              Row() {
                ForEach(this.chartData, (data: ChartData) => {
                  Column() {
                    Blank()
                      .layoutWeight(1)

                    Row()
                      .width('60%')
                      .height(150 * data.value)
                      .backgroundColor(AppColors.primary)
                      .borderRadius(AppShapes.smallCornerRadius)
                  }
                  .height(150)
                  .layoutWeight(1)
                  .alignItems(HorizontalAlign.Center)
                  .justifyContent(FlexAlign.End)
                }, (data: ChartData) => data.id.toString())
              }
              .width('100%')
              .height(150)
              .alignItems(VerticalAlign.Bottom)

              Row() {
                ForEach(this.chartData, (data: ChartData) => {
                  Text(data.label)
                    .fontSize(AppTypography.label.fontSize)
                    .fontWeight(AppTypography.label.fontWeight)
                    .lineHeight(AppTypography.label.lineHeight)
                    .letterSpacing(AppTypography.label.letterSpacing)
                    .fontColor(AppColors.secondary)
                    .textAlign(TextAlign.Center)
                    .layoutWeight(1)
                }, (data: ChartData) => data.id.toString())
              }
              .width('100%')
            }
          }
          .width('100%')
          .padding(AppSpacing.md)
          .backgroundColor(AppColors.surface)
          .borderRadius(AppShapes.largeCornerRadius)
          .shadow({
            radius: AppElevation.level1.radius,
            color: '#1A000000',
            offsetX: 0,
            offsetY: AppElevation.level1.dy
          })
          .margin({
            left: AppSpacing.md,
            right: AppSpacing.md
          })

          ForEach(this.productivityItems, (item: ProductivityItem) => {
            Column({ space: 0 }) {
              Row() {
                Text(item.title)
                  .fontSize(AppTypography.title.fontSize)
                  .fontWeight(AppTypography.title.fontWeight)
                  .lineHeight(AppTypography.title.lineHeight)
                  .letterSpacing(AppTypography.title.letterSpacing)
                  .fontColor(AppColors.onSurface)

                Blank()
                  .layoutWeight(1)

                Row({ space: AppSpacing.sm }) {
                  Circle()
                    .width(10)
                    .height(10)
                    .fill(item.statusColor)

                  Text(item.status)
                    .fontSize(AppTypography.label.fontSize)
                    .fontWeight(AppTypography.label.fontWeight)
                    .lineHeight(AppTypography.label.lineHeight)
                    .letterSpacing(AppTypography.label.letterSpacing)
                    .fontColor(item.statusColor)
                }
                .alignItems(VerticalAlign.Center)
              }
              .width('100%')
              .alignItems(VerticalAlign.Center)
              .margin({ bottom: AppSpacing.md })

              Row({ space: AppSpacing.sm }) {
                CustomLinearProgressIndicator({
                  progress: item.progress,
                  color: item.statusColor,
                  trackColor: AppColors.surfaceVariant,
                  heightValue: 8
                })
                  .layoutWeight(1)

                Text(`${Math.round(item.progress * 100)}%`)
                  .fontSize(AppTypography.label.fontSize)
                  .fontWeight(AppTypography.label.fontWeight)
                  .lineHeight(AppTypography.label.lineHeight)
                  .letterSpacing(AppTypography.label.letterSpacing)
                  .fontColor(AppColors.secondary)
                  .textAlign(TextAlign.End)
                  .width(40)
              }
              .width('100%')
              .alignItems(VerticalAlign.Center)
            }
            .width('100%')
            .padding(AppSpacing.md)
            .backgroundColor(AppColors.surface)
            .borderRadius(AppShapes.mediumCornerRadius)
            .border({
              width: 1,
              color: AppColors.outline
            })
            .margin({
              left: AppSpacing.md,
              right: AppSpacing.md
            })
          }, (item: ProductivityItem) => item.id.toString())
        }
        .width('100%')
        .padding({
          top: AppSpacing.md,
          bottom: this.bottomBarTotalHeight() + AppSpacing.md
        })
      }
      .layoutWeight(1)
      .width('100%')
      .scrollBar(BarState.Off)
      .backgroundColor(AppColors.background)

      Column() {
        Text('Submit New Form')
          .width('100%')
          .height(this.bottomBarButtonHeight)
          .fontSize(AppTypography.title.fontSize)
          .fontWeight(AppTypography.title.fontWeight)
          .lineHeight(AppTypography.title.lineHeight)
          .letterSpacing(AppTypography.title.letterSpacing)
          .fontColor(AppColors.onPrimary)
          .textAlign(TextAlign.Center)
          .backgroundColor(AppColors.primary)
          .borderRadius(AppShapes.mediumCornerRadius)
          .onClick(() => {
          })
      }
      .width('100%')
      .padding(AppSpacing.md)
      .backgroundColor(AppColors.surface)
      .shadow({
        radius: AppElevation.level3.radius,
        color: '#1A000000',
        offsetX: 0,
        offsetY: AppElevation.level3.dy
      })
      .zIndex(1)
    }
    .width('100%')
    .height('100%')
    .backgroundColor(AppColors.background)
    .expandSafeArea([SafeAreaType.SYSTEM], [SafeAreaEdge.TOP, SafeAreaEdge.BOTTOM])
  }
}