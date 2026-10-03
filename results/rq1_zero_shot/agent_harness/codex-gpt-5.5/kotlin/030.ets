const NAME: string = '031_ClipboardHistory_en';
const UI_TYPE: string = 'Productivity';
const STYLE_THEME: string = 'Modern Blue';
const LANG: string = 'en';
const BASELINE_SIZE: string = '720x1280';

class AppColors {
  static readonly primary: string = '#007BFF';
  static readonly secondary: string = '#6C757D';
  static readonly tertiary: string = '#17A2B8';
  static readonly background: string = '#F8F9FA';
  static readonly surface: string = '#FFFFFF';
  static readonly surfaceVariant: string = '#E9ECEF';
  static readonly outline: string = '#DEE2E6';
  static readonly success: string = '#28A745';
  static readonly warning: string = '#FFC107';
  static readonly error: string = '#DC3545';
  static readonly onPrimary: string = '#FFFFFF';
  static readonly onSecondary: string = '#FFFFFF';
  static readonly onTertiary: string = '#FFFFFF';
  static readonly onBackground: string = '#212529';
  static readonly onSurface: string = '#212529';
}

class AppSpacing {
  static readonly xs: number = 4;
  static readonly sm: number = 8;
  static readonly md: number = 12;
  static readonly lg: number = 16;
  static readonly xl: number = 24;
}

class ClipboardItem {
  id: number;
  content: string;
  type: string;
  timestamp: string;
  progress: number;

  constructor(id: number, content: string, type: string, timestamp: string, progress: number) {
    this.id = id;
    this.content = content;
    this.type = type;
    this.timestamp = timestamp;
    this.progress = progress;
  }
}

@Entry
@Component
struct MainActivity {
  @State sliderValue: number = 24;
  private clipboardItems: ClipboardItem[] = [
    new ClipboardItem(1, 'https://www.example.com/modern-design', 'Link', '5 min ago', 0.2),
    new ClipboardItem(2, 'Final project review notes have been updated.', 'Text', '23 min ago', 0.5),
    new ClipboardItem(3, '#007BFF', 'Color', '1 hour ago', 0.8),
    new ClipboardItem(4, 'Meeting at 3 PM with the design team.', 'Text', '3 hours ago', 0.9),
    new ClipboardItem(5, 'Shared file: \'Q3_Report.pdf\'', 'File', 'Yesterday', 1.0)
  ];

  @Builder
  TopBar(): void {
    Row() {
      Blank();
      Text('Clipboard History')
        .fontSize(22)
        .fontWeight(FontWeight.Medium)
        .fontColor(AppColors.onSurface);
      Blank();
      Button('Clear')
        .fontSize(14)
        .fontWeight(FontWeight.Medium)
        .fontColor(AppColors.onSurface)
        .backgroundColor(AppColors.surfaceVariant)
        .borderRadius(8);
    }
    .width('100%')
    .height(56)
    .padding({ left: AppSpacing.md, right: AppSpacing.md })
    .alignItems(VerticalAlign.Center)
    .backgroundColor(AppColors.surface);
  }

  @Builder
  ClipboardCard(item: ClipboardItem): void {
    Column() {
      Row({ space: AppSpacing.sm }) {
        Rect().width(24).height(24).fill(AppColors.primary).radius(4);
        Text(item.type)
          .fontSize(14)
          .fontWeight(FontWeight.Bold)
          .fontColor(AppColors.primary);
        Blank();
        Text(item.timestamp)
          .fontSize(14)
          .fontWeight(FontWeight.Medium)
          .fontColor(AppColors.secondary);
      }
      .width('100%')
      .alignItems(VerticalAlign.Center);
      Blank().height(AppSpacing.sm);
      Text(item.content)
        .fontSize(16)
        .fontColor(AppColors.onSurface)
        .maxLines(2)
        .textOverflow({ overflow: TextOverflow.Ellipsis });
      Blank().height(AppSpacing.md);
      Progress({ value: item.progress * 100, total: 100, type: ProgressType.Linear })
        .width('100%')
        .height(4)
        .color(AppColors.tertiary)
        .backgroundColor(AppColors.surfaceVariant);
    }
    .width('100%')
    .padding(AppSpacing.md)
    .backgroundColor(AppColors.surface)
    .border({ width: 1, color: AppColors.surfaceVariant })
    .borderRadius(12)
    .shadow({ radius: 3, color: '#1A000000', offsetY: 1 })
    .alignItems(HorizontalAlign.Start);
  }

  @Builder
  SettingsPane(): void {
    Column() {
      Row() {
        Text('History Limit (Hours)')
          .fontSize(14)
          .fontWeight(FontWeight.Medium)
          .fontColor(AppColors.onSurface);
        Blank();
        Text(Math.floor(this.sliderValue).toString())
          .fontSize(16)
          .fontWeight(FontWeight.SemiBold)
          .fontColor(AppColors.onSurface);
      }
      .width('100%')
      .alignItems(VerticalAlign.Center);
      Slider({ value: this.sliderValue, min: 1, max: 72, step: 1 })
        .width('100%')
        .selectedColor(AppColors.primary)
        .trackColor(AppColors.surfaceVariant)
        .onChange((value: number) => {
          this.sliderValue = value;
        });
    }
    .width('100%')
    .padding(AppSpacing.lg)
    .backgroundColor(AppColors.surface)
    .shadow({ radius: 6, color: '#1A000000', offsetY: -2 });
  }

  build() {
    Column() {
      this.TopBar();
      Scroll() {
        Column({ space: AppSpacing.md }) {
          ForEach(this.clipboardItems, (item: ClipboardItem) => {
            this.ClipboardCard(item);
          }, (item: ClipboardItem) => item.id.toString())
        }
        .width('100%')
        .padding({ left: AppSpacing.lg, right: AppSpacing.lg, top: AppSpacing.md, bottom: AppSpacing.md });
      }
      .layoutWeight(1);
      this.SettingsPane();
    }
    .width('100%')
    .height('100%')
    .backgroundColor(AppColors.background);
  }
}
