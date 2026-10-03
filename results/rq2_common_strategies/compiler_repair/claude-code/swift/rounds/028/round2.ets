interface ColorTokens {
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

interface TypographyStyle {
  fontSize: number;
  fontWeight: number;
  lineHeight: number;
  letterSpacing: number;
}

interface TypographyTokens {
  display: TypographyStyle;
  headline: TypographyStyle;
  title: TypographyStyle;
  body: TypographyStyle;
  label: TypographyStyle;
}

interface ShapeTokens {
  smallCornerRadius: number;
  mediumCornerRadius: number;
  largeCornerRadius: number;
}

interface SpacingTokens {
  xs: number;
  sm: number;
  md: number;
  lg: number;
  xl: number;
  xxl: number;
}

interface ElevationSpec {
  radius: number;
  dy: number;
  opacity: number;
}

interface ElevationTokens {
  level1: ElevationSpec;
  level2: ElevationSpec;
  level3: ElevationSpec;
}

// AppTokens - Design system tokens
class AppTokens {
  static Colors: ColorTokens = {
    primary: '#FF0F172A',
    secondary: '#FF475569',
    tertiary: '#FF94A3B8',
    background: '#FFF8FAFC',
    surface: '#FFFFFFFF',
    surfaceVariant: '#FFF1F5F9',
    outline: '#FFE2E8F0',
    success: '#FF22C55E',
    warning: '#FFF59E0B',
    error: '#FFEF4444',
    onPrimary: '#FFFFFFFF',
    onSecondary: '#FFFFFFFF',
    onTertiary: '#FF0F172A',
    onBackground: '#FF0F172A',
    onSurface: '#FF0F172A',
  };

  static Typography: TypographyTokens = {
    display: { fontSize: 32, fontWeight: FontWeight.Bold, lineHeight: 40, letterSpacing: 0 },
    headline: { fontSize: 24, fontWeight: FontWeight.Medium, lineHeight: 32, letterSpacing: 0 },
    title: { fontSize: 18, fontWeight: FontWeight.Medium, lineHeight: 24, letterSpacing: 0.15 },
    body: { fontSize: 16, fontWeight: FontWeight.Normal, lineHeight: 22, letterSpacing: 0.5 },
    label: { fontSize: 14, fontWeight: FontWeight.Medium, lineHeight: 18, letterSpacing: 0.5 },
  };

  static Shapes: ShapeTokens = {
    smallCornerRadius: 8,
    mediumCornerRadius: 12,
    largeCornerRadius: 16,
  };

  static Spacing: SpacingTokens = {
    xs: 4,
    sm: 8,
    md: 16,
    lg: 24,
    xl: 32,
    xxl: 48,
  };

  static Elevation: ElevationTokens = {
    level1: { radius: 3, dy: 1, opacity: 0.10 },
    level2: { radius: 6, dy: 2, opacity: 0.10 },
    level3: { radius: 10, dy: 4, opacity: 0.10 },
  };
}

// Data Models
interface ProductivityItem {
  id: number;
  title: string;
  status: string;
  progress: number;
  statusColor: string;
}

interface ChartData {
  label: string;
  value: number;
}

// FilterChip Component
@Component
struct FilterChip {
  title: string = '';
  isSelected: boolean = false;
  onSelect: () => void = () => {};

  build() {
    Button({ type: ButtonType.Normal }) {
      Text(this.title)
        .fontSize(AppTokens.Typography.label.fontSize)
        .fontWeight(AppTokens.Typography.label.fontWeight)
        .fontColor(this.isSelected ? AppTokens.Colors.onPrimary : AppTokens.Colors.onSurface)
        .letterSpacing(AppTokens.Typography.label.letterSpacing)
    }
    .height('auto')
    .backgroundColor(this.isSelected ? AppTokens.Colors.primary : AppTokens.Colors.surface)
    .borderRadius(AppTokens.Shapes.smallCornerRadius)
    .border({ width: 1, color: AppTokens.Colors.outline })
    .padding({ left: AppTokens.Spacing.md, right: AppTokens.Spacing.md, top: AppTokens.Spacing.sm, bottom: AppTokens.Spacing.sm })
    .onClick(() => this.onSelect())
  }
}

// CustomLinearProgressIndicator Component
@Component
struct CustomLinearProgressIndicator {
  progress: number = 0;
  color: string = AppTokens.Colors.primary;
  trackColor: string = AppTokens.Colors.surfaceVariant;
  barHeight: number = 8;

  build() {
    Stack({ alignContent: Alignment.Start }) {
      Row()
        .width('100%')
        .height(this.barHeight)
        .backgroundColor(this.trackColor)
        .borderRadius(this.barHeight / 2)

      Row()
        .width(`${this.progress * 100}%`)
        .height(this.barHeight)
        .backgroundColor(this.color)
        .borderRadius(this.barHeight / 2)
    }
    .width('100%')
    .height(this.barHeight)
  }
}

// TopBar Component
@Component
struct TopBar {
  build() {
    Row() {
      Circle({ width: 24, height: 24 })
        .fill(AppTokens.Colors.outline)
        .margin({ left: AppTokens.Spacing.md })

      Blank()

      Text('Productivity Check')
        .fontSize(AppTokens.Typography.headline.fontSize)
        .fontWeight(FontWeight.Medium)
        .fontColor(AppTokens.Colors.onSurface)
        .lineHeight(AppTokens.Typography.headline.lineHeight)

      Blank()

      Circle({ width: 24, height: 24 })
        .fill(AppTokens.Colors.outline)
        .margin({ right: AppTokens.Spacing.md })
    }
    .width('100%')
    .height(56)
    .backgroundColor(AppTokens.Colors.surface)
    .shadow({
      radius: AppTokens.Elevation.level3.radius,
      color: `rgba(0, 0, 0, ${AppTokens.Elevation.level3.opacity})`,
      offsetY: AppTokens.Elevation.level3.dy,
    })
    .zIndex(1)
  }
}

// WeeklyThroughputCard Component
@Component
struct WeeklyThroughputCard {
  chartData: ChartData[] = [];

  build() {
    Column({ space: AppTokens.Spacing.md }) {
      Text('Weekly Throughput')
        .fontSize(AppTokens.Typography.title.fontSize)
        .fontWeight(AppTokens.Typography.title.fontWeight)
        .fontColor(AppTokens.Colors.onSurface)
        .lineHeight(AppTokens.Typography.title.lineHeight)
        .width('100%')

      Row({ space: 0 }) {
        ForEach(this.chartData, (item: ChartData) => {
          Column() {
            Blank()
            Row()
              .width('60%')
              .height(`${item.value * 100}%`)
              .backgroundColor(AppTokens.Colors.primary)
              .borderRadius(AppTokens.Shapes.smallCornerRadius)
          }
          .width('100%')
          .height('100%')
          .layoutWeight(1)
          .alignItems(HorizontalAlign.Center)
        })
      }
      .width('100%')
      .height(150)

      Row({ space: 0 }) {
        ForEach(this.chartData, (item: ChartData) => {
          Text(item.label)
            .fontSize(AppTokens.Typography.label.fontSize)
            .fontWeight(AppTokens.Typography.label.fontWeight)
            .fontColor(AppTokens.Colors.secondary)
            .textAlign(TextAlign.Center)
            .layoutWeight(1)
        })
      }
      .width('100%')
    }
    .width('100%')
    .padding(AppTokens.Spacing.md)
    .backgroundColor(AppTokens.Colors.surface)
    .borderRadius(AppTokens.Shapes.largeCornerRadius)
    .shadow({
      radius: AppTokens.Elevation.level1.radius,
      color: `rgba(0, 0, 0, ${AppTokens.Elevation.level1.opacity})`,
      offsetY: AppTokens.Elevation.level1.dy,
    })
    .margin({ left: AppTokens.Spacing.md, right: AppTokens.Spacing.md })
  }
}

// ProductivityItemRow Component
@Component
struct ProductivityItemRow {
  item: ProductivityItem = { id: 0, title: '', status: '', progress: 0, statusColor: '' };

  build() {
    Column({ space: AppTokens.Spacing.md }) {
      Row() {
        Text(this.item.title)
          .fontSize(AppTokens.Typography.title.fontSize)
          .fontWeight(AppTokens.Typography.title.fontWeight)
          .fontColor(AppTokens.Colors.onSurface)
          .lineHeight(AppTokens.Typography.title.lineHeight)

        Blank()

        Row({ space: AppTokens.Spacing.sm }) {
          Circle({ width: 10, height: 10 })
            .fill(this.item.statusColor)

          Text(this.item.status)
            .fontSize(AppTokens.Typography.label.fontSize)
            .fontWeight(AppTokens.Typography.label.fontWeight)
            .fontColor(this.item.statusColor)
        }
      }
      .width('100%')
      .alignItems(VerticalAlign.Center)

      Row({ space: AppTokens.Spacing.sm }) {
        CustomLinearProgressIndicator({
          progress: this.item.progress,
          color: this.item.statusColor,
          trackColor: AppTokens.Colors.surfaceVariant,
          barHeight: 8,
        })
          .layoutWeight(1)

        Text(`${Math.round(this.item.progress * 100)}%`)
          .fontSize(AppTokens.Typography.label.fontSize)
          .fontWeight(AppTokens.Typography.label.fontWeight)
          .fontColor(AppTokens.Colors.secondary)
          .textAlign(TextAlign.End)
          .width(40)
      }
      .width('100%')
      .alignItems(VerticalAlign.Center)
    }
    .width('100%')
    .padding(AppTokens.Spacing.md)
    .backgroundColor(AppTokens.Colors.surface)
    .borderRadius(AppTokens.Shapes.mediumCornerRadius)
    .border({ width: 1, color: AppTokens.Colors.outline })
    .margin({ left: AppTokens.Spacing.md, right: AppTokens.Spacing.md })
  }
}

// BottomBar Component
@Component
struct BottomBar {
  build() {
    Column() {
      Button('Submit New Form')
        .fontSize(AppTokens.Typography.title.fontSize)
        .fontWeight(AppTokens.Typography.title.fontWeight)
        .fontColor(AppTokens.Colors.onPrimary)
      .width('100%')
      .height(56)
      .backgroundColor(AppTokens.Colors.primary)
      .borderRadius(AppTokens.Shapes.mediumCornerRadius)
      .padding(AppTokens.Spacing.md)
    }
    .width('100%')
    .backgroundColor(AppTokens.Colors.surface)
    .shadow({
      radius: AppTokens.Elevation.level3.radius,
      color: `rgba(0, 0, 0, ${AppTokens.Elevation.level3.opacity})`,
      offsetY: -AppTokens.Elevation.level3.dy,
    })
    .zIndex(1)
  }
}

// Root Screen - ProductivityPage
@Entry
@Component
struct ProductivityPage {
  @State selectedFilter: string = 'Weekly';

  private filters: string[] = ['Daily', 'Weekly', 'Monthly'];

  private productivityItems: ProductivityItem[] = [
    { id: 1, title: 'Form Batch #A-102', status: 'Completed', progress: 1.0, statusColor: AppTokens.Colors.success },
    { id: 2, title: 'Invoice Set #B-231', status: 'In Progress', progress: 0.75, statusColor: AppTokens.Colors.warning },
    { id: 3, title: 'Document Scan #C-456', status: 'Pending', progress: 0.1, statusColor: AppTokens.Colors.secondary },
    { id: 4, title: 'Form Batch #A-103', status: 'Completed', progress: 1.0, statusColor: AppTokens.Colors.success },
    { id: 5, title: 'Data Entry #D-789', status: 'Failed', progress: 0.4, statusColor: AppTokens.Colors.error },
  ];

  private chartData: ChartData[] = [
    { label: 'Mon', value: 0.6 },
    { label: 'Tue', value: 0.8 },
    { label: 'Wed', value: 0.5 },
    { label: 'Thu', value: 1.0 },
    { label: 'Fri', value: 0.7 },
    { label: 'Sat', value: 0.4 },
    { label: 'Sun', value: 0.2 },
  ];

  build() {
    Column() {
      TopBar()

      Scroll() {
        Column({ space: AppTokens.Spacing.lg }) {
          Row({ space: AppTokens.Spacing.sm }) {
            ForEach(this.filters, (filter: string) => {
              FilterChip({
                title: filter,
                isSelected: this.selectedFilter === filter,
                onSelect: () => {
                  this.selectedFilter = filter;
                },
              })
            })
          }
          .width('100%')
          .padding({ left: AppTokens.Spacing.md, right: AppTokens.Spacing.md })

          WeeklyThroughputCard({ chartData: this.chartData })

          Column({ space: AppTokens.Spacing.md }) {
            ForEach(this.productivityItems, (item: ProductivityItem) => {
              ProductivityItemRow({ item: item })
            })
          }
          .width('100%')

          Blank()
            .height(AppTokens.Spacing.lg + 56 + AppTokens.Spacing.md * 2)
        }
        .width('100%')
        .padding({ top: AppTokens.Spacing.md, bottom: AppTokens.Spacing.md })
      }
      .width('100%')
      .layoutWeight(1)
      .backgroundColor(AppTokens.Colors.background)
      .scrollBar(BarState.Off)

      BottomBar()
    }
    .width('100%')
    .height('100%')
    .backgroundColor(AppTokens.Colors.background)
  }
}
