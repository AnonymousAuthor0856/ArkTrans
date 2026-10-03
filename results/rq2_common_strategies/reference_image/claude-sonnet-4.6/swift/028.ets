// RootScreen.ets —— 主界面（对应 SwiftUI 的 RootScreen + ProductivityApp 入口页）
import { window } from '@kit.ArkUI';
import { common } from '@kit.AbilityKit';
import { BusinessError } from '@kit.BasicServicesKit';

// MARK: - FilterChip（对应 Compose / SwiftUI 的筛选芯片）

@Component
struct FilterChip {
  @Prop title: string = '';
  @Prop isSelected: boolean = false;
  onChipClick: (title: string) => void = () => {};

  build() {
    Row() {
      Text(this.title)
        .fontSize(AppTypography.label.fontSize)
        .fontWeight(AppTypography.label.fontWeight)
        .lineHeight(AppTypography.label.lineHeight)
        .letterSpacing(AppTypography.label.letterSpacing)
        .fontColor(this.isSelected ? AppColors.onPrimary : AppColors.onSurface)
    }
    .justifyContent(FlexAlign.Center)
    .padding({
      left: AppSpacing.md,
      right: AppSpacing.md,
      top: AppSpacing.sm,
      bottom: AppSpacing.sm
    })
    .backgroundColor(this.isSelected ? AppColors.primary : AppColors.surface)
    .borderRadius(AppShapes.smallCornerRadius)
    .border({ width: 1, color: AppColors.outline })
    .onClick(() => {
      this.onChipClick(this.title);
    })
  }
}

// MARK: - CustomLinearProgressIndicator（对应 Compose 的 LinearProgressIndicator）

@Component
struct CustomLinearProgressIndicator {
  @Prop progress: number = 0;
  @Prop barColor: string = AppColors.primary;
  @Prop trackColor: string = AppColors.surfaceVariant;
  @Prop barHeight: number = 8;

  build() {
    Stack({ alignContent: Alignment.Start }) {
      Row()
        .width('100%')
        .height(this.barHeight)
        .borderRadius(this.barHeight / 2)
        .backgroundColor(this.trackColor)

      Row()
        .width(`${this.progress * 100}%`)
        .height(this.barHeight)
        .borderRadius(this.barHeight / 2)
        .backgroundColor(this.barColor)
    }
    .width('100%')
    .height(this.barHeight)
  }
}

// MARK: - RootScreen

@Entry
@Component
struct RootScreen {
  @State selectedFilter: string = 'Weekly';

  private filters: string[] = ['Daily', 'Weekly', 'Monthly'];

  private productivityItems: ProductivityItem[] = [
    new ProductivityItem(1, 'Form Batch #A-102', 'Completed', 1.0, AppColors.success),
    new ProductivityItem(2, 'Invoice Set #B-231', 'In Progress', 0.75, AppColors.warning),
    new ProductivityItem(3, 'Document Scan #C-456', 'Pending', 0.1, AppColors.secondary),
    new ProductivityItem(4, 'Form Batch #A-103', 'Completed', 1.0, AppColors.success),
    new ProductivityItem(5, 'Data Entry #D-789', 'Failed', 0.4, AppColors.error)
  ];

  private chartData: ChartData[] = [
    new ChartData('Mon', 0.6), new ChartData('Tue', 0.8), new ChartData('Wed', 0.5),
    new ChartData('Thu', 1.0), new ChartData('Fri', 0.7), new ChartData('Sat', 0.4),
    new ChartData('Sun', 0.2)
  ];

  private topBarHeight: number = 56;
  private bottomBarButtonHeight: number = 56;
  private bottomBarPadding: number = AppSpacing.md;
  private chartHeight: number = 150;

  private bottomBarTotalHeight(): number {
    return this.bottomBarButtonHeight + this.bottomBarPadding * 2;
  }

  aboutToAppear(): void {
    // 对应 .ignoresSafeArea(.all) + .statusBarHidden(true)：全屏布局并隐藏状态栏
    const ctx = getContext(this) as common.UIAbilityContext;
    window.getLastWindow(ctx).then((win: window.Window) => {
      win.setWindowLayoutFullScreen(true);
      win.setWindowSystemBarEnable([]).catch((err: BusinessError) => {
        console.error(`setWindowSystemBarEnable failed: ${err.code}`);
      });
    }).catch((err: BusinessError) => {
      console.error(`getLastWindow failed: ${err.code}`);
    });
  }

  // MARK: 顶栏
  @Builder
  topBar() {
    Row() {
      Row()
        .width(24)
        .height(24)
        .borderRadius(12)
        .backgroundColor(AppColors.outline)

      Text('Productivity Check')
        .fontSize(AppTypography.headline.fontSize)
        .fontWeight(AppTypography.headline.fontWeight)
        .lineHeight(AppTypography.headline.lineHeight)
        .letterSpacing(AppTypography.headline.letterSpacing)
        .fontColor(AppColors.onSurface)
        .maxLines(1)
        .textOverflow({ overflow: TextOverflow.Ellipsis })

      Row()
        .width(24)
        .height(24)
        .borderRadius(12)
        .backgroundColor(AppColors.outline)
    }
    .width('100%')
    .height(this.topBarHeight)
    .padding({ left: AppSpacing.md, right: AppSpacing.md })
    .justifyContent(FlexAlign.SpaceBetween)
    .alignItems(VerticalAlign.Center)
    .backgroundColor(AppColors.surface)
    .shadow(shadowOf(AppElevation.level3))
    .zIndex(1)
  }

  // MARK: 柱状图
  @Builder
  throughputChart() {
    Column({ space: AppSpacing.sm }) {
      Row() {
        ForEach(this.chartData, (data: ChartData) => {
          Column() {
            Row()
              .width('60%')
              .height(this.chartHeight * data.value)
              .borderRadius(AppShapes.smallCornerRadius)
              .backgroundColor(AppColors.primary)
          }
          .layoutWeight(1)
          .height('100%')
          .justifyContent(FlexAlign.End)
        }, (data: ChartData) => data.label)
      }
      .width('100%')
      .height(this.chartHeight)
      .alignItems(VerticalAlign.Bottom)

      Row() {
        ForEach(this.chartData, (data: ChartData) => {
          Text(data.label)
            .fontSize(AppTypography.label.fontSize)
            .fontWeight(AppTypography.label.fontWeight)
            .fontColor(AppColors.secondary)
            .textAlign(TextAlign.Center)
            .layoutWeight(1)
        }, (data: ChartData) => data.label)
      }
      .width('100%')
    }
    .width('100%')
    .alignItems(HorizontalAlign.Start)
  }

  // MARK: 吞吐量卡片
  @Builder
  throughputCard() {
    Column() {
      Text('Weekly Throughput')
        .fontSize(AppTypography.title.fontSize)
        .fontWeight(AppTypography.title.fontWeight)
        .lineHeight(AppTypography.title.lineHeight)
        .letterSpacing(AppTypography.title.letterSpacing)
        .fontColor(AppColors.onSurface)

      Column() {
        this.throughputChart()
      }
      .width('100%')
      .margin({ top: AppSpacing.md })
    }
    .width('100%')
    .alignItems(HorizontalAlign.Start)
    .padding(AppSpacing.md)
    .backgroundColor(AppColors.surface)
    .borderRadius(AppShapes.largeCornerRadius)
    .shadow(shadowOf(AppElevation.level1))
    .margin({ left: AppSpacing.md, right: AppSpacing.md })
  }

  // MARK: 生产力条目卡片
  @Builder
  productivityCard(item: ProductivityItem) {
    Column() {
      Row() {
        Text(item.title)
          .fontSize(AppTypography.title.fontSize)
          .fontWeight(AppTypography.title.fontWeight)
          .lineHeight(AppTypography.title.lineHeight)
          .letterSpacing(AppTypography.title.letterSpacing)
          .fontColor(AppColors.onSurface)
          .layoutWeight(1)
          .maxLines(1)
          .textOverflow({ overflow: TextOverflow.Ellipsis })

        Row({ space: AppSpacing.sm }) {
          Row()
            .width(10)
            .height(10)
            .borderRadius(5)
            .backgroundColor(item.statusColor)

          Text(item.status)
            .fontSize(AppTypography.label.fontSize)
            .fontWeight(AppTypography.label.fontWeight)
            .fontColor(item.statusColor)
        }
        .alignItems(VerticalAlign.Center)
      }
      .width('100%')
      .justifyContent(FlexAlign.SpaceBetween)
      .alignItems(VerticalAlign.Center)
      .margin({ bottom: AppSpacing.md })

      Row({ space: AppSpacing.sm }) {
        CustomLinearProgressIndicator({
          progress: item.progress,
          barColor: item.statusColor,
          trackColor: AppColors.surfaceVariant,
          barHeight: 8
        })
          .layoutWeight(1)

        Text(`${Math.round(item.progress * 100)}%`)
          .fontSize(AppTypography.label.fontSize)
          .fontWeight(AppTypography.label.fontWeight)
          .fontColor(AppColors.secondary)
          .textAlign(TextAlign.End)
          .width(40)
      }
      .width('100%')
      .alignItems(VerticalAlign.Center)
    }
    .width('100%')
    .alignItems(HorizontalAlign.Start)
    .padding(AppSpacing.md)
    .backgroundColor(AppColors.surface)
    .borderRadius(AppShapes.mediumCornerRadius)
    .border({ width: 1, color: AppColors.outline })
    .margin({ left: AppSpacing.md, right: AppSpacing.md })
  }

  // MARK: 底栏
  @Builder
  bottomBar() {
    Column() {
      Button({ type: ButtonType.Normal, stateEffect: true }) {
        Text('Submit New Form')
          .fontSize(AppTypography.title.fontSize)
          .fontWeight(AppTypography.title.fontWeight)
          .letterSpacing(AppTypography.title.letterSpacing)
          .fontColor(AppColors.onPrimary)
      }
      .width('100%')
      .height(this.bottomBarButtonHeight)
      .borderRadius(AppShapes.mediumCornerRadius)
      .backgroundColor(AppColors.primary)
    }
    .width('100%')
    .padding(this.bottomBarPadding)
    .backgroundColor(AppColors.surface)
    .shadow(shadowOf(AppElevation.level3))
    .zIndex(1)
  }

  // MARK: - build（对应 Scaffold: topBar / content / bottomBar）
  build() {
    Column() {
      // Top Bar
      this.topBar()

      // Scrollable Content
      Scroll() {
        Column({ space: AppSpacing.lg }) {
          // Filter Chips
          Row({ space: AppSpacing.sm }) {
            ForEach(this.filters, (filter: string) => {
              FilterChip({
                title: filter,
                isSelected: this.selectedFilter === filter,
                onChipClick: (title: string) => {
                  this.selectedFilter = title;
                }
              })
            }, (filter: string) => filter)
          }
          .width('100%')
          .justifyContent(FlexAlign.Center)
          .alignItems(VerticalAlign.Center)
          .padding({ left: AppSpacing.md, right: AppSpacing.md })

          // Weekly Throughput Card
          this.throughputCard()

          // Productivity Items
          ForEach(this.productivityItems, (item: ProductivityItem) => {
            this.productivityCard(item)
          }, (item: ProductivityItem) => item.id.toString())
        }
        .width('100%')
        .padding({ top: AppSpacing.md, bottom: this.bottomBarTotalHeight() })
      }
      .width('100%')
      .layoutWeight(1)
      .scrollBar(BarState.Off)
      .align(Alignment.Top)
      .backgroundColor(AppColors.background)

      // Bottom Bar
      this.bottomBar()
    }
    .width('100%')
    .height('100%')
    .backgroundColor(AppColors.background)
    .expandSafeArea([SafeAreaType.SYSTEM], [SafeAreaEdge.TOP, SafeAreaEdge.BOTTOM])
  }
}