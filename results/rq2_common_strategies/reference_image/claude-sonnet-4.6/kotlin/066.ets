// pages/Index.ets
// Port of com.example.singlefileui — NAME="111StockListen" UI_TYPE="Calendar"
// STYLE_THEME="Retro Flat" LANG="en" BASELINE_SIZE="720x1280"
// main_pages.json: { "src": ["pages/Index"] }

import { window } from '@kit.ArkUI';

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

/* ---------------- Design tokens ---------------- */

class AppColors {
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

class AppSpacing {
  static readonly xs: number = 4;
  static readonly sm: number = 8;
  static readonly md: number = 12;
  static readonly lg: number = 16;
  static readonly xl: number = 20;
  static readonly xxl: number = 28;
  static readonly xxxl: number = 40;
}

// Typography (sp -> fp)
class AppType {
  static readonly displaySize: number = 26;
  static readonly displayLine: number = 32;
  static readonly headlineSize: number = 20;
  static readonly headlineLine: number = 26;
  static readonly titleSize: number = 16;
  static readonly titleLine: number = 20;
  static readonly bodySize: number = 13;
  static readonly bodyLine: number = 18;
  static readonly labelSize: number = 11;
  static readonly labelLine: number = 14;
}

class AppRadius {
  static readonly small: number = 6;
  static readonly medium: number = 10;
  static readonly large: number = 14;
}

// ElevationMapping levels 1..2 (used by the quotes list / filter card)
const SHADOW_LEVEL_1: ShadowOptions = { radius: 3, color: '#1A000000', offsetX: 0, offsetY: 1 };
const SHADOW_LEVEL_2: ShadowOptions = { radius: 6, color: '#24000000', offsetX: 0, offsetY: 3 };

/* ---------------- Screen ---------------- */

@Entry
@Component
struct Index {
  @State selectedDay: number = 1;
  @State currentSector: string = 'All';

  private days: DayTab[] = [
    { id: 1, label: 'Mon' },
    { id: 2, label: 'Tue' },
    { id: 3, label: 'Wed' },
    { id: 4, label: 'Thu' },
    { id: 5, label: 'Fri' }
  ];

  private sectors: string[] = ['All', 'Tech', 'Energy', 'Finance'];

  private rows: StockRow[] = [
    { code: '600519', name: 'Kweichow Moutai', price: '1687.3', change: '+1.24%', positive: true },
    { code: '000001', name: 'Ping An Bank', price: '12.54', change: '-0.62%', positive: false },
    { code: '300750', name: 'CATL', price: '192.8', change: '+0.87%', positive: true },
    { code: '601318', name: 'Ping An Ins.', price: '44.2', change: '-1.12%', positive: false },
    { code: '600036', name: 'CMBC', price: '36.9', change: '+0.15%', positive: true },
    { code: '688981', name: 'SMIC', price: '56.4', change: '-0.48%', positive: false }
  ];

  // Compose: WindowCompat.setDecorFitsSystemWindows(window, false) + hide(navigationBars)
  aboutToAppear(): void {
    window.getLastWindow(getContext(this))
      .then((win: window.Window) => {
        win.setWindowLayoutFullScreen(true);
        win.setWindowSystemBarEnable([]);
      })
      .catch(() => {
        // window unavailable (e.g. previewer) — keep bars as-is
      });
  }

  @Builder
  FilterCard() {
    Column({ space: AppSpacing.sm }) {
      // Day segmented row
      Row({ space: AppSpacing.sm }) {
        ForEach(this.days, (d: DayTab) => {
          Stack() {
            Text(d.label)
              .fontSize(this.selectedDay === d.id ? AppType.titleSize : AppType.bodySize)
              .fontWeight(this.selectedDay === d.id ? FontWeight.Medium : FontWeight.Normal)
              .fontColor(this.selectedDay === d.id ? AppColors.onPrimary : AppColors.onSurface)
          }
          .layoutWeight(1)
          .height(36)
          .backgroundColor(this.selectedDay === d.id ? AppColors.primary : AppColors.surfaceVariant)
          .borderRadius(AppRadius.small)
          .onClick(() => {
            this.selectedDay = d.id;
          })
        }, (d: DayTab) => d.id.toString())
      }
      .width('100%')

      // Sector filter chips
      Row({ space: AppSpacing.sm }) {
        ForEach(this.sectors, (s: string) => {
          Row() {
            Text(s)
              .fontSize(AppType.labelSize)
              .fontWeight(FontWeight.Medium)
              .fontColor(this.currentSector === s ? AppColors.onPrimary : AppColors.onSurface)
          }
          .height(32)
          .padding({ left: AppSpacing.md, right: AppSpacing.md })
          .alignItems(VerticalAlign.Center)
          .backgroundColor(this.currentSector === s ? AppColors.secondary : AppColors.surface)
          .borderRadius(AppRadius.small)
          .border({ width: 1, color: AppColors.outline })
          .onClick(() => {
            this.currentSector = s;
          })
        }, (s: string) => s)
      }
      .width('100%')
    }
    .width('100%')
    .padding(AppSpacing.md)
    .backgroundColor(AppColors.surface)
    .borderRadius(AppRadius.large)
    .border({ width: 1, color: AppColors.outline })
    .shadow(SHADOW_LEVEL_2)
  }

  @Builder
  QuoteRow(row: StockRow) {
    Row() {
      // Avatar + name/code
      Row({ space: AppSpacing.md }) {
        Text('')
          .width(28)
          .height(28)
          .backgroundColor(AppColors.surfaceVariant)
          .borderRadius(AppRadius.small)
        Column({ space: AppSpacing.xs }) {
          Text(row.name)
            .fontSize(AppType.titleSize)
            .fontWeight(FontWeight.Medium)
            .fontColor(AppColors.onSurface)
            .maxLines(1)
            .textOverflow({ overflow: TextOverflow.Ellipsis })
          Text(row.code)
            .fontSize(AppType.labelSize)
            .fontWeight(FontWeight.Medium)
            .lineHeight(AppType.labelLine)
            .fontColor(AppColors.onSurface)
        }
        .alignItems(HorizontalAlign.Start)
      }
      .layoutWeight(1)
      .alignItems(VerticalAlign.Center)

      // Price / change / action
      Row({ space: AppSpacing.lg }) {
        Column({ space: AppSpacing.xs }) {
          Text(row.price)
            .fontSize(AppType.titleSize)
            .fontWeight(FontWeight.Medium)
            .fontColor(AppColors.onSurface)
          Row({ space: AppSpacing.xs }) {
            Text('')
              .width(8)
              .height(8)
              .backgroundColor(row.positive ? AppColors.success : AppColors.error)
              .borderRadius(4)
            Text(row.change)
              .fontSize(AppType.labelSize)
              .fontWeight(FontWeight.Medium)
              .fontColor(row.positive ? AppColors.success : AppColors.error)
          }
          .alignItems(VerticalAlign.Center)
        }
        .alignItems(HorizontalAlign.End)

        Button('Detail', { type: ButtonType.Normal, stateEffect: true })
          .width(76)
          .height(36)
          .backgroundColor(AppColors.primary)
          .fontColor(AppColors.onPrimary)
          .fontSize(AppType.labelSize)
          .fontWeight(FontWeight.Medium)
          .borderRadius(AppRadius.small)
          .onClick(() => {
            // navigation target for the row detail screen
          })
      }
      .alignItems(VerticalAlign.Center)
    }
    .width('100%')
    .padding(AppSpacing.md)
    .justifyContent(FlexAlign.SpaceBetween)
    .alignItems(VerticalAlign.Center)
  }

  @Builder
  QuoteList() {
    List({ space: AppSpacing.sm }) {
      ForEach(this.rows, (row: StockRow) => {
        ListItem() {
          this.QuoteRow(row)
        }
        .width('100%')
        .constraintSize({ minHeight: 72 })
        .backgroundColor(AppColors.surface)
        .borderRadius(AppRadius.medium)
        .border({ width: 1, color: AppColors.outline })
        .shadow(SHADOW_LEVEL_1)
      }, (row: StockRow) => row.code)
    }
    .width('100%')
    .layoutWeight(1)
    .scrollBar(BarState.Off)
    .edgeEffect(EdgeEffect.Spring)
    .padding({ bottom: AppSpacing.md })
  }

  build() {
    Column() {
      // CenterAlignedTopAppBar
      Row() {
        Text('Stock Calendar')
          .fontSize(AppType.displaySize)
          .fontWeight(FontWeight.SemiBold)
          .lineHeight(AppType.displayLine)
          .fontColor(AppColors.onSurface)
      }
      .width('100%')
      .height(56)
      .justifyContent(FlexAlign.Center)
      .backgroundColor(AppColors.background)

      // Screen content
      Column({ space: AppSpacing.md }) {
        this.FilterCard()
        this.QuoteList()
      }
      .width('100%')
      .layoutWeight(1)
      .padding({
        left: AppSpacing.lg,
        right: AppSpacing.lg,
        top: AppSpacing.md,
        bottom: AppSpacing.md
      })
    }
    .width('100%')
    .height('100%')
    .backgroundColor(AppColors.background)
  }
}