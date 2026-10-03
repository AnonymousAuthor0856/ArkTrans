interface ClipboardItem {
  id: number;
  content: string;
  type: string;
  timestamp: string;
  progress: number;
}

class AppColors {
  static readonly primary: ResourceColor = '#007BFF';
  static readonly secondary: ResourceColor = '#6C757D';
  static readonly tertiary: ResourceColor = '#17A2B8';
  static readonly background: ResourceColor = '#F8F9FA';
  static readonly surface: ResourceColor = '#FFFFFF';
  static readonly surfaceVariant: ResourceColor = '#E9ECEF';
  static readonly outline: ResourceColor = '#DEE2E6';
  static readonly success: ResourceColor = '#28A745';
  static readonly warning: ResourceColor = '#FFC107';
  static readonly error: ResourceColor = '#DC3545';
  static readonly onPrimary: ResourceColor = '#FFFFFF';
  static readonly onSecondary: ResourceColor = '#FFFFFF';
  static readonly onTertiary: ResourceColor = '#FFFFFF';
  static readonly onBackground: ResourceColor = '#212529';
  static readonly onSurface: ResourceColor = '#212529';
}

class AppSpacing {
  static readonly xs: number = 4;
  static readonly sm: number = 8;
  static readonly md: number = 12;
  static readonly lg: number = 16;
  static readonly xl: number = 24;
}

class AppRadius {
  static readonly small: number = 4;
  static readonly medium: number = 8;
  static readonly large: number = 12;
}

class AppElevation {
  static readonly level1: number = 1;
  static readonly level2: number = 3;
  static readonly level3: number = 6;
}

class AppTypography {
  static readonly displaySize: number = 36;
  static readonly headlineSize: number = 28;
  static readonly titleSize: number = 22;
  static readonly bodySize: number = 16;
  static readonly labelSize: number = 14;
}

@Component
struct ClipboardCard {
  item: ClipboardItem = {
    id: 0,
    content: '',
    type: '',
    timestamp: '',
    progress: 0
  };

  build() {
    Column() {
      Row({ space: AppSpacing.sm }) {
        Box()
          .width(24)
          .height(24)
          .borderRadius(AppRadius.small)
          .backgroundColor(AppColors.primary)

        Text(this.item.type)
          .fontSize(AppTypography.labelSize)
          .fontWeight(FontWeight.Bold)
          .fontColor(AppColors.primary)

        Blank()

        Text(this.item.timestamp)
          .fontSize(AppTypography.labelSize)
          .fontWeight(FontWeight.Medium)
          .fontColor(AppColors.secondary)
      }
      .width('100%')
      .alignItems(VerticalAlign.Center)

      Blank()
        .height(AppSpacing.sm)

      Text(this.item.content)
        .fontSize(AppTypography.bodySize)
        .fontWeight(FontWeight.Normal)
        .fontColor(AppColors.onSurface)
        .lineHeight(24)
        .maxLines(2)
        .textOverflow({ overflow: TextOverflow.Ellipsis })
        .width('100%')

      Blank()
        .height(AppSpacing.md)

      Progress({
        value: this.item.progress * 100,
        total: 100,
        type: ProgressType.Linear
      })
        .width('100%')
        .height(4)
        .color(AppColors.tertiary)
        .backgroundColor(AppColors.surfaceVariant)
        .borderRadius(AppRadius.small)
    }
    .width('100%')
    .padding(AppSpacing.md)
    .backgroundColor(AppColors.surface)
    .borderRadius(AppRadius.large)
    .border({
      width: 1,
      color: AppColors.surfaceVariant
    })
    .shadow({
      radius: 3,
      color: '#1A000000',
      offsetX: 0,
      offsetY: 1
    })
  }
}

@Component
struct SettingsPane {
  @Link sliderValue: number;

  build() {
    Column() {
      Row() {
        Text('History Limit (Hours)')
          .fontSize(AppTypography.labelSize)
          .fontWeight(FontWeight.Medium)
          .fontColor(AppColors.onSurface)

        Blank()

        Text(Math.round(this.sliderValue).toString())
          .fontSize(AppTypography.bodySize)
          .fontWeight(FontWeight.SemiBold)
          .fontColor(AppColors.onSurface)
      }
      .width('100%')
      .alignItems(VerticalAlign.Center)

      Slider({
        value: this.sliderValue,
        min: 1,
        max: 72,
        step: 1,
        style: SliderStyle.OutSet
      })
        .width('100%')
        .blockColor(AppColors.primary)
        .trackColor(AppColors.surfaceVariant)
        .selectedColor(AppColors.primary)
        .showTips(false)
        .onChange((value: number) => {
          this.sliderValue = value;
        })
    }
    .width('100%')
    .padding(AppSpacing.lg)
    .backgroundColor(AppColors.surface)
    .shadow({
      radius: 6,
      color: '#1A000000',
      offsetX: 0,
      offsetY: 2
    })
  }
}

@Entry
@Component
struct RootScreen {
  @State sliderValue: number = 24;

  private clipboardItems: ClipboardItem[] = [
    {
      id: 1,
      content: 'https://www.example.com/modern-design',
      type: 'Link',
      timestamp: '5 min ago',
      progress: 0.2
    },
    {
      id: 2,
      content: 'Final project review notes have been updated.',
      type: 'Text',
      timestamp: '23 min ago',
      progress: 0.5
    },
    {
      id: 3,
      content: '#007BFF',
      type: 'Color',
      timestamp: '1 hour ago',
      progress: 0.8
    },
    {
      id: 4,
      content: 'Meeting at 3 PM with the design team.',
      type: 'Text',
      timestamp: '3 hours ago',
      progress: 0.9
    },
    {
      id: 5,
      content: 'Shared file: \'Q3_Report.pdf\'',
      type: 'File',
      timestamp: 'Yesterday',
      progress: 1.0
    }
  ];

  build() {
    Column() {
      Stack({ alignContent: Alignment.Center }) {
        Text('Clipboard History')
          .fontSize(AppTypography.titleSize)
          .fontWeight(FontWeight.Medium)
          .fontColor(AppColors.onSurface)
          .maxLines(1)
          .textOverflow({ overflow: TextOverflow.Ellipsis })

        Row() {
          Blank()

          Button('Clear')
            .fontSize(AppTypography.labelSize)
            .fontWeight(FontWeight.Medium)
            .fontColor(AppColors.onSurface)
            .backgroundColor(AppColors.surfaceVariant)
            .borderRadius(AppRadius.medium)
            .padding({
              left: AppSpacing.md,
              right: AppSpacing.md,
              top: AppSpacing.sm,
              bottom: AppSpacing.sm
            })
            .margin({ right: AppSpacing.md })
            .onClick(() => {
            })
        }
        .width('100%')
        .height('100%')
        .alignItems(VerticalAlign.Center)
      }
      .width('100%')
      .height(56)
      .backgroundColor(AppColors.surface)

      List({ space: AppSpacing.md }) {
        ForEach(this.clipboardItems, (item: ClipboardItem) => {
          ListItem() {
            ClipboardCard({ item: item })
          }
        }, (item: ClipboardItem) => item.id.toString())
      }
      .width('100%')
      .layoutWeight(1)
      .padding({
        left: AppSpacing.lg,
        right: AppSpacing.lg,
        top: AppSpacing.md,
        bottom: AppSpacing.md
      })
      .backgroundColor(AppColors.background)

      SettingsPane({ sliderValue: $sliderValue })
    }
    .width('100%')
    .height('100%')
    .backgroundColor(AppColors.background)
  }
}