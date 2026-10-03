const NAME: string = '040_RetroFilterSearch_en';
const UI_TYPE: string = 'Search/Productivity';
const STYLE_THEME: string = 'Retro Warm';
const LANG: string = 'en';
const BASELINE_SIZE: string = '720x1280';

class AppColors {
  static readonly primary: string = '#FF7B00';
  static readonly secondary: string = '#FFD166';
  static readonly background: string = '#FFF6E5';
  static readonly surface: string = '#FFFFFF';
  static readonly surfaceVariant: string = '#FFF0C1';
  static readonly outline: string = '#E0C080';
  static readonly onPrimary: string = '#FFFFFF';
  static readonly onSecondary: string = '#3E2723';
  static readonly onBackground: string = '#3E2723';
  static readonly onSurface: string = '#3E2723';
}

class AppSpacing {
  static readonly sm: number = 8;
  static readonly md: number = 12;
  static readonly lg: number = 16;
}

class OffsetPoint {
  x: number;
  y: number;
  constructor(x: number, y: number) { this.x = x; this.y = y; }
}

class ResultItem {
  id: number;
  title: string;
  constructor(id: number, title: string) { this.id = id; this.title = title; }
}

@Entry
@Component
struct MainActivity {
  @State query: string = '';
  @State knob: OffsetPoint = new OffsetPoint(160, 120);
  private filters: string[] = ['Popular', 'New', 'Discount', 'Premium'];
  private results: ResultItem[] = [
    new ResultItem(0, 'Result 1'), new ResultItem(1, 'Result 2'), new ResultItem(2, 'Result 3'),
    new ResultItem(3, 'Result 4'), new ResultItem(4, 'Result 5'), new ResultItem(5, 'Result 6')
  ];

  @Builder
  FilterButton(label: string): void {
    Button(label)
      .fontSize(12)
      .fontWeight(FontWeight.Medium)
      .fontColor(AppColors.onSecondary)
      .backgroundColor(AppColors.secondary)
      .borderRadius(6)
      .height(36);
  }

  @Builder
  KnobPanel(): void {
    Stack() {
      Rect().width('100%').height('100%').fill(AppColors.surfaceVariant);
      Circle().width(160).height(160).fill(AppColors.secondary);
      Circle()
        .width(32)
        .height(32)
        .fill(AppColors.primary)
        .position({ x: this.knob.x, y: this.knob.y });
    }
    .width('100%')
    .height(180)
    .padding(16)
    .backgroundColor(AppColors.surface)
    .borderRadius(14)
    .alignContent(Alignment.Center)
    .gesture(PanGesture().onActionUpdate((event: GestureEvent) => {
      this.knob = new OffsetPoint(event.offsetX, event.offsetY);
    }));
  }

  @Builder
  ResultCard(item: ResultItem): void {
    Column({ space: AppSpacing.sm }) {
      Rect().width(96).height(96).fill(AppColors.surfaceVariant).radius(10);
      Text(item.title)
        .fontSize(16)
        .fontWeight(FontWeight.Medium)
        .fontColor(AppColors.onSurface);
      Button('Add')
        .fontSize(12)
        .fontWeight(FontWeight.Medium)
        .fontColor(AppColors.onPrimary)
        .backgroundColor(AppColors.primary)
        .borderRadius(10)
        .width('100%');
    }
    .width('100%')
    .padding(AppSpacing.lg)
    .backgroundColor(AppColors.surface)
    .borderRadius(14)
    .shadow({ radius: 8, color: '#1F000000', offsetY: 4 })
    .alignItems(HorizontalAlign.Center);
  }

  build() {
    Column({ space: AppSpacing.md }) {
      Text('Retro Filter Search')
        .fontSize(28)
        .fontWeight(FontWeight.Bold)
        .fontColor(AppColors.onBackground);
      TextInput({ text: this.query, placeholder: 'Search products' })
        .fontSize(14)
        .fontColor(AppColors.onSurface)
        .backgroundColor(AppColors.surface)
        .border({ width: 1, color: AppColors.outline })
        .borderRadius(10)
        .width('100%')
        .height(48)
        .onChange((value: string) => {
          this.query = value;
        });
      Row({ space: AppSpacing.sm }) {
        ForEach(this.filters, (filter: string) => {
          this.FilterButton(filter);
        }, (filter: string) => filter)
      }
      .alignItems(VerticalAlign.Center);
      this.KnobPanel();
      Grid() {
        ForEach(this.results, (item: ResultItem) => {
          GridItem() {
            this.ResultCard(item);
          }
        }, (item: ResultItem) => item.id.toString())
      }
      .columnsTemplate('1fr 1fr')
      .columnsGap(AppSpacing.lg)
      .rowsGap(AppSpacing.lg)
      .layoutWeight(1);
    }
    .width('100%')
    .height('100%')
    .padding(AppSpacing.lg)
    .backgroundColor(AppColors.background);
  }
}
