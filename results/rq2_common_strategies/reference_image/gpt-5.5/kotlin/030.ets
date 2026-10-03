class AppColors {
  static readonly primary: string = '#007BFF';
  static readonly secondary: string = '#6C757D';
  static readonly tertiary: string = '#17A2B8';
  static readonly background: string = '#F8F9FA';
  static readonly surface: string = '#FFFFFF';
  static readonly surfaceTinted: string = '#EAF4FF';
  static readonly surfaceVariant: string = '#E9ECEF';
  static readonly outline: string = '#DEE2E6';
  static readonly success: string = '#28A745';
  static readonly warning: string = '#FFC107';
  static readonly error: string = '#DC3545';
  static readonly onPrimary: string = '#FFFFFF';
  static readonly onSurface: string = '#212529';
}

class AppSpacing {
  static readonly xs: number = 4;
  static readonly sm: number = 8;
  static readonly md: number = 12;
  static readonly lg: number = 16;
  static readonly xl: number = 24;
}

interface ClipboardItem {
  id: number;
  content: string;
  type: string;
  timestamp: string;
  progress: number;
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
      Row() {
        Text('')
          .width(24)
          .height(24)
          .borderRadius(4)
          .backgroundColor(AppColors.primary)

        Text(this.item.type)
          .fontSize(14)
          .fontWeight(FontWeight.Bold)
          .fontColor(AppColors.primary)
          .letterSpacing(0.25)
          .margin({ left: AppSpacing.sm })

        Blank()

        Text(this.item.timestamp)
          .fontSize(14)
          .fontWeight(FontWeight.Medium)
          .fontColor(AppColors.secondary)
          .letterSpacing(0.25)
      }
      .width('100%')
      .height(24)
      .alignItems(VerticalAlign.Center)

      Text(this.item.content)
        .width('100%')
        .fontSize(16)
        .fontWeight(FontWeight.Regular)
        .fontColor(AppColors.onSurface)
        .lineHeight(24)
        .maxLines(2)
        .textOverflow({ overflow: TextOverflow.Ellipsis })
        .margin({ top: AppSpacing.sm })

      Stack({ alignContent: Alignment.Start }) {
        Row()
          .width('100%')
          .height(4)
          .borderRadius(2)
          .backgroundColor(AppColors.surfaceVariant)

        Row()
          .width(`${this.item.progress * 100}%`)
          .height(4)
          .borderRadius(2)
          .backgroundColor(AppColors.tertiary)
      }
      .width('100%')
      .height(4)
      .margin({ top: AppSpacing.md })
    }
    .width('100%')
    .padding(AppSpacing.md)
    .backgroundColor(AppColors.surface)
    .borderRadius(12)
    .border({ width: 1, color: AppColors.surfaceVariant })
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
  @Prop sliderValue: number;
  onSliderChange: (value: number) => void = (_value: number) => {
  };

  build() {
    Column() {
      Row() {
        Text('History Limit (Hours)')
          .fontSize(14)
          .fontWeight(FontWeight.Medium)
          .fontColor(AppColors.onSurface)
          .letterSpacing(0.25)

        Blank()

        Text(Math.round(this.sliderValue).toString())
          .fontSize(16)
          .fontWeight(FontWeight.Bold)
          .fontColor(AppColors.onSurface)
          .lineHeight(24)
      }
      .width('100%')
      .height(24)
      .alignItems(VerticalAlign.Center)

      Slider({
        value: this.sliderValue,
        min: 1,
        max: 72,
        step: 1,
        style: SliderStyle.OutSet
      })
        .width('100%')
        .margin({ top: AppSpacing.sm })
        .blockColor(AppColors.primary)
        .selectedColor(AppColors.primary)
        .trackColor(AppColors.surfaceVariant)
        .showTips(false)
        .showSteps(false)
        .onChange((value: number, mode: SliderChangeMode) => {
          this.onSliderChange(value);
        })
    }
    .width('100%')
    .height(100)
    .padding(AppSpacing.lg)
    .backgroundColor(AppColors.surfaceTinted)
    .shadow({
      radius: 6,
      color: '#1A000000',
      offsetX: 0,
      offsetY: -2
    })
  }
}

@Entry
@Component
struct Index {
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

  @Builder
  TopBar() {
    Stack({ alignContent: Alignment.Center }) {
      Text('Clipboard History')
        .fontSize(22)
        .fontWeight(FontWeight.Medium)
        .fontColor(AppColors.onSurface)
        .maxLines(1)
        .textOverflow({ overflow: TextOverflow.Ellipsis })

      Row() {
        Blank()

        Button('Clear', { type: ButtonType.Normal, stateEffect: true })
          .width(82)
          .height(40)
          .borderRadius(8)
          .backgroundColor(AppColors.surfaceVariant)
          .fontColor(AppColors.onSurface)
          .fontSize(14)
          .fontWeight(FontWeight.Medium)
          .onClick(() => {
          })
      }
      .width('100%')
      .height('100%')
      .padding({ right: AppSpacing.lg })
      .alignItems(VerticalAlign.Center)
    }
    .width('100%')
    .height(64)
    .backgroundColor(AppColors.background)
  }

  build() {
    Column() {
      this.TopBar()

      Stack({ alignContent: Alignment.Bottom }) {
        List({ space: AppSpacing.md }) {
          ForEach(this.clipboardItems, (item: ClipboardItem) => {
            ListItem() {
              ClipboardCard({ item: item })
            }
          }, (item: ClipboardItem) => item.id.toString())
        }
        .width('100%')
        .height('100%')
        .padding({
          left: AppSpacing.lg,
          right: AppSpacing.lg,
          top: AppSpacing.md,
          bottom: AppSpacing.md
        })
        .scrollBar(BarState.Off)
        .edgeEffect(EdgeEffect.None)

        SettingsPane({
          sliderValue: this.sliderValue,
          onSliderChange: (value: number) => {
            this.sliderValue = value;
          }
        })
      }
      .width('100%')
      .layoutWeight(1)
    }
    .width('100%')
    .height('100%')
    .backgroundColor(AppColors.background)
  }
}