// entry/src/main/ets/viewmodel/AppTokens.ts

export interface ColorToken {
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

export interface TypographyToken {
  fontSize: number;
  fontWeight: FontWeight;
  lineHeight: number;
  letterSpacing: number;
}

export interface ShapeToken {
  small: number;
  medium: number;
  large: number;
}

export interface SpacingToken {
  xs: number;
  sm: number;
  md: number;
  lg: number;
  xl: number;
  xxl: number;
  xxxl: number;
}

export class AppTokens {
  static readonly Colors: ColorToken = {
    primary: '#0EA5E9',
    secondary: '#22C55E',
    tertiary: '#F59E0B',
    background: '#F7FAFC',
    surface: '#FFFFFF',
    surfaceVariant: '#EFF3F7',
    outline: '#D4D9E1',
    success: '#16A34A',
    warning: '#F59E0B',
    error: '#EF4444',
    onPrimary: '#FFFFFF',
    onSecondary: '#0F172A',
    onTertiary: '#111827',
    onBackground: '#0B1220',
    onSurface: '#0B1220'
  };

  static readonly TypographyTokens: Record<string, TypographyToken> = {
    display: { fontSize: 24, fontWeight: FontWeight.Bold, lineHeight: 30, letterSpacing: 0 },
    headline: { fontSize: 18, fontWeight: FontWeight.Bold, lineHeight: 24, letterSpacing: 0 },
    title: { fontSize: 14, fontWeight: FontWeight.Medium, lineHeight: 18, letterSpacing: 0 },
    body: { fontSize: 12, fontWeight: FontWeight.Normal, lineHeight: 16, letterSpacing: 0 },
    label: { fontSize: 10, fontWeight: FontWeight.Medium, lineHeight: 14, letterSpacing: 0 }
  };

  static readonly Shapes: ShapeToken = {
    small: 6,
    medium: 8,
    large: 12
  };

  static readonly Spacing: SpacingToken = {
    xs: 2,
    sm: 4,
    md: 6,
    lg: 8,
    xl: 12,
    xxl: 16,
    xxxl: 24
  };
}

// entry/src/main/ets/model/DataModels.ts
export interface MetricCardUi {
  id: number;
  title: string;
  value: string;
  delta: string;
  color: string;
}

export interface ChartCardUi {
  id: number;
  title: string;
  color: string;
}

// entry/src/main/ets/components/FilterChip.ts
import { AppTokens } from '../viewmodel/AppTokens';

@Component
export struct FilterChip {
  @Prop text: string;
  @Prop isSelected: boolean;
  onSelect?: () => void;

  build() {
    Button(this.text)
      .type(ButtonType.Capsule)
      .backgroundColor(this.isSelected ? AppTokens.Colors.primary : AppTokens.Colors.surface)
      .fontColor(this.isSelected ? AppTokens.Colors.onPrimary : AppTokens.Colors.onSurface)
      .borderWidth(1)
      .borderColor(AppTokens.Colors.outline)
      .borderRadius(AppTokens.Shapes.medium)
      .height(36)
      .onClick(() => {
        if (this.onSelect) {
          this.onSelect();
        }
      })
  }
}

// entry/src/main/ets/components/AssistChip.ts
import { AppTokens } from '../viewmodel/AppTokens';

@Component
export struct AssistChip {
  @Prop text: string;
  @Prop isSelected: boolean;
  onSelect?: () => void;

  build() {
    Button(this.text)
      .type(ButtonType.Capsule)
      .backgroundColor(this.isSelected ? AppTokens.Colors.secondary : AppTokens.Colors.surface)
      .fontColor(this.isSelected ? AppTokens.Colors.onSecondary : AppTokens.Colors.onSurface)
      .borderWidth(1)
      .borderColor(AppTokens.Colors.outline)
      .borderRadius(AppTokens.Shapes.small)
      .height(32)
      .onClick(() => {
        if (this.onSelect) {
          this.onSelect();
        }
      })
  }
}

// entry/src/main/ets/components/MetricCard.ts
import { AppTokens } from '../viewmodel/AppTokens';
import { MetricCardUi } from '../model/DataModels';

@Component
export struct MetricCard {
  @ObjectLink metric: MetricCardUi;

  build() {
    Column() {
      Row() {
        Text(this.metric.title)
          .fontColor(AppTokens.Colors.onSurface)
          .fontWeight(FontWeight.Medium)
          .fontSize(AppTokens.TypographyTokens['title'].fontSize)
        
        Blank()
        
        Row()
          .width(16)
          .height(16)
          .borderRadius(AppTokens.Shapes.small)
          .backgroundColor(this.metric.color)
      }
      .width('100%')

      Text(this.metric.value)
        .fontColor(AppTokens.Colors.onSurface)
        .fontWeight(FontWeight.Bold)
        .fontSize(AppTokens.TypographyTokens['headline'].fontSize)
        .margin({ top: AppTokens.Spacing.sm })

      Row() {
        Row()
          .width(6)
          .height(6)
          .borderRadius(AppTokens.Shapes.small)
          .backgroundColor(this.metric.delta.startsWith('+') ? AppTokens.Colors.success : AppTokens.Colors.error)
        
        Text(this.metric.delta)
          .fontColor(this.metric.delta.startsWith('+') ? AppTokens.Colors.success : AppTokens.Colors.error)
          .fontWeight(FontWeight.Medium)
          .fontSize(AppTokens.TypographyTokens['label'].fontSize)
          .margin({ left: AppTokens.Spacing.xs })
      }
      .margin({ top: AppTokens.Spacing.xs })
    }
    .width('100%')
    .padding(AppTokens.Spacing.lg)
    .backgroundColor(AppTokens.Colors.surface)
    .borderRadius(AppTokens.Shapes.large)
    .shadow({ radius: 4, color: 'rgba(0,0,0,0.1)', offsetY: 1 })
    .border({ width: 1, color: AppTokens.Colors.outline })
  }
}

// entry/src/main/ets/components/ChartCard.ts
import { AppTokens } from '../viewmodel/AppTokens';
import { ChartCardUi } from '../model/DataModels';

@Component
export struct ChartCard {
  @ObjectLink chart: ChartCardUi;

  build() {
    Column() {
      Text(this.chart.title)
        .fontColor(AppTokens.Colors.onSurface)
        .fontWeight(FontWeight.Medium)
        .fontSize(AppTokens.TypographyTokens['title'].fontSize)

      // Mock Chart Area
      Row() {
        Row().width(6).height(40).borderRadius(AppTokens.Shapes.small).backgroundColor(AppTokens.Colors.primary)
        Row().width(6).height(30).borderRadius(AppTokens.Shapes.small).backgroundColor(AppTokens.Colors.secondary)
        Row().width(6).height(48).borderRadius(AppTokens.Shapes.small).backgroundColor(AppTokens.Colors.tertiary)
        Row().width(6).height(22).borderRadius(AppTokens.Shapes.small).backgroundColor(AppTokens.Colors.outline)
        Row().width(6).height(32).borderRadius(AppTokens.Shapes.small).backgroundColor(AppTokens.Colors.primary)
        Row().width(6).height(42).borderRadius(AppTokens.Shapes.small).backgroundColor(AppTokens.Colors.secondary)
      }
      .width('100%')
      .aspectRatio(1.6)
      .justifyContent(FlexAlign.Center)
      .alignItems(VerticalAlign.Bottom)
      .margin({ top: AppTokens.Spacing.md })
      .borderRadius(AppTokens.Shapes.medium)
      .backgroundColor(this.chart.color)

      Row() {
        Row().width(8).height(8).borderRadius(AppTokens.Shapes.small).backgroundColor(AppTokens.Colors.primary)
        Text("Series A")
          .fontColor(AppTokens.Colors.onSurface)
          .fontWeight(FontWeight.Medium)
          .fontSize(AppTokens.TypographyTokens['label'].fontSize)
          .margin({ left: AppTokens.Spacing.xs })
        
        Row().width(8).height(8).borderRadius(AppTokens.Shapes.small).backgroundColor(AppTokens.Colors.secondary)
        Text("Series B")
          .fontColor(AppTokens.Colors.onSurface)
          .fontWeight(FontWeight.Medium)
          .fontSize(AppTokens.TypographyTokens['label'].fontSize)
          .margin({ left: AppTokens.Spacing.xs })
      }
      .margin({ top: AppTokens.Spacing.md })
    }
    .width('100%')
    .padding(AppTokens.Spacing.lg)
    .backgroundColor(AppTokens.Colors.surface)
    .borderRadius(AppTokens.Shapes.large)
    .shadow({ radius: 4, color: 'rgba(0,0,0,0.1)', offsetY: 1 })
    .border({ width: 1, color: AppTokens.Colors.outline })
  }
}

// entry/src/main/ets/pages/Index.ets
import { AppTokens } from '../viewmodel/AppTokens';
import { MetricCardUi, ChartCardUi } from '../model/DataModels';
import { FilterChip } from '../components/FilterChip';
import { AssistChip } from '../components/AssistChip';
import { MetricCard } from '../components/MetricCard';
import { ChartCard } from '../components/ChartCard';

@Entry
@Component
struct RootScreen {
  @State selectedRange: string = "7 Days";
  @State flags: string[] = [];
  @State darkSwitch: boolean = false;
  @State notifCount: number = 2;

  private ranges: string[] = ["Today", "7 Days", "30 Days", "90 Days", "YTD", "Custom"];
  
  private kpis: MetricCardUi[] = [
    { id: 1, title: "Revenue", value: "$24,560", delta: "+8.2%", color: AppTokens.Colors.secondary },
    { id: 2, title: "Orders", value: "1,284", delta: "+3.1%", color: AppTokens.Colors.primary },
    { id: 3, title: "Refunds", value: "42", delta: "-1.4%", color: AppTokens.Colors.error },
    { id: 4, title: "Active Users", value: "8,921", delta: "+5.6%", color: AppTokens.Colors.tertiary }
  ];

  private charts: ChartCardUi[] = [
    { id: 1, title: "Sales Trend", color: "#E0F2FE" },
    { id: 2, title: "Conversion Funnel", color: "#EFF6FF" },
    { id: 3, title: "Geo Distribution", color: "#ECFDF5" },
    { id: 4, title: "Device Breakdown", color: "#FFFFFBEB" }
  ];

  build() {
    Column() {
      // Top Bar
      Row() {
        Row()
          .width(20)
          .height(20)
          .borderRadius(AppTokens.Shapes.small)
          .backgroundColor(AppTokens.Colors.primary)
        
        Text("Analytics")
          .fontColor(AppTokens.Colors.onSurface)
          .fontWeight(FontWeight.Bold)
          .fontSize(AppTokens.TypographyTokens['display'].fontSize)
          .margin({ left: AppTokens.Spacing.sm })
      }
      .width('100%')
      .justifyContent(FlexAlign.Center)
      .padding({ top: AppTokens.Spacing.xxxl, bottom: AppTokens.Spacing.lg })

      // Range Chips
      Flex({ wrap: FlexWrap.Wrap, justifyContent: FlexAlign.Start, alignItems: ItemAlign.Center }) {
        ForEach(this.ranges, (range: string) => {
          FilterChip({
            text: range,
            isSelected: this.selectedRange === range,
            onSelect: () => {
              this.selectedRange = range;
            }
          })
          .margin({ right: AppTokens.Spacing.sm, bottom: AppTokens.Spacing.xs })
        })
      }
      .width('100%')
      .margin({ top: AppTokens.Spacing.md })

      // Compare Controls
      Row() {
        Text("Compare")
          .fontColor(AppTokens.Colors.onSurface)
          .fontWeight(FontWeight.Medium)
          .fontSize(AppTokens.TypographyTokens['label'].fontSize)
        
        AssistChip({
          text: "Prev Period",
          isSelected: this.flags.includes("Prev Period"),
          onSelect: () => {
            if (this.flags.includes("Prev Period")) {
              this.flags = this.flags.filter(f => f !== "Prev Period");
            } else {
              this.flags.push("Prev Period");
            }
          }
        })
        .margin({ left: AppTokens.Spacing.sm })

        AssistChip({
          text: "Goal",
          isSelected: this.flags.includes("Goal"),
          onSelect: () => {
            if (this.flags.includes("Goal")) {
              this.flags = this.flags.filter(f => f !== "Goal");
            } else {
              this.flags.push("Goal");
            }
          }
        })
        .margin({ left: AppTokens.Spacing.sm })

        Row() {
          Text("Dark")
            .fontColor(AppTokens.Colors.onSurface)
            .fontWeight(FontWeight.Medium)
            .fontSize(AppTokens.TypographyTokens['label'].fontSize)
          
          Toggle({ type: ToggleType.Switch, isOn: this.darkSwitch })
            .onChange((isOn: boolean) => {
              this.darkSwitch = isOn;
            })
            .margin({ left: AppTokens.Spacing.xs })
        }
        .margin({ left: AppTokens.Spacing.sm })
      }
      .width('100%')
      .margin({ top: AppTokens.Spacing.md })

      // Grid Content
      Grid() {
        ForEach(this.kpis, (metric: MetricCardUi) => {
          GridItem() {
            MetricCard({ metric: metric })
          }
        })
        ForEach(this.charts, (chart: ChartCardUi) => {
          GridItem() {
            ChartCard({ chart: chart })
          }
        })
      }
      .columnsTemplate('1fr 1fr')
      .rowsTemplate('auto auto auto')
      .itemSpacing({ row: AppTokens.Spacing.lg, column: AppTokens.Spacing.lg })
      .width('100%')
      .layoutWeight(1)
      .margin({ top: AppTokens.Spacing.lg })

      // Bottom Bar
      Row() {
        Column() {
          Text("Notifications")
            .fontColor(AppTokens.Colors.onSurface)
            .fontWeight(FontWeight.Medium)
            .fontSize(AppTokens.TypographyTokens['label'].fontSize)
          
          Text(`${this.notifCount} pending`)
            .fontColor(AppTokens.Colors.onSurface)
            .fontWeight(FontWeight.Bold)
            .fontSize(AppTokens.TypographyTokens['headline'].fontSize)
        }
        .alignItems(HorizontalAlign.Start)

        Blank()

        Button("Mark All Read")
          .type(ButtonType.Capsule)
          .backgroundColor(AppTokens.Colors.secondary)
          .fontColor(AppTokens.Colors.onSecondary)
          .fontWeight(FontWeight.Medium)
          .fontSize(AppTokens.TypographyTokens['title'].fontSize)
          .height(44)
          .width(140)
          .onClick(() => {
            this.notifCount = 0;
          })
      }
      .width('100%')
      .padding({ left: AppTokens.Spacing.lg, right: AppTokens.Spacing.lg, top: AppTokens.Spacing.md, bottom: AppTokens.Spacing.md })
      .backgroundColor(AppTokens.Colors.surface)
      .shadow({ radius: 6, color: 'rgba(0,0,0,0.16)', offsetY: 1.5 })
    }
    .width('100%')
    .height('100%')
    .backgroundColor(AppTokens.Colors.background)
    .padding({ left: AppTokens.Spacing.lg, right: AppTokens.Spacing.lg })
  }
}