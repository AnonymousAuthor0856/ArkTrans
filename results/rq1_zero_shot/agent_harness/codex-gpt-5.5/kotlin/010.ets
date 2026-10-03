const NAME: string = '007_StoryEditor_en';
const UI_TYPE: string = 'Social';
const STYLE_THEME: string = 'Monochrome';
const LANG: string = 'en';
const BASELINE_SIZE: string = '720x1280';

class AppColors {
  static readonly primary: string = '#1976D2';
  static readonly secondary: string = '#607D8B';
  static readonly tertiary: string = '#757575';
  static readonly background: string = '#ECEFF1';
  static readonly surface: string = '#FFFFFF';
  static readonly surfaceVariant: string = '#CFD8DC';
  static readonly outline: string = '#B0BEC5';
  static readonly success: string = '#4CAF50';
  static readonly warning: string = '#FFC107';
  static readonly error: string = '#F44336';
  static readonly onPrimary: string = '#FFFFFF';
  static readonly onSecondary: string = '#FFFFFF';
  static readonly onTertiary: string = '#FFFFFF';
  static readonly onBackground: string = '#263238';
  static readonly onSurface: string = '#263238';
}

class AppSpacing {
  static readonly sm: number = 8;
  static readonly md: number = 12;
  static readonly lg: number = 16;
}

class StoryLayer {
  id: number;
  type: string;
  content: string;

  constructor(id: number, type: string, content: string) {
    this.id = id;
    this.type = type;
    this.content = content;
  }
}

@Entry
@Component
struct MainActivity {
  @State textOpacity: number = 1;
  @State uploadProgress: number = 65;
  @State selectedLayer: number = 3;
  private layers: StoryLayer[] = [
    new StoryLayer(1, 'BG', 'Gradient'),
    new StoryLayer(2, 'IMG', 'User Photo'),
    new StoryLayer(3, 'TXT', 'Hello World'),
    new StoryLayer(4, 'ICO', 'Sticker')
  ];

  @Builder
  TopBar(): void {
    Row() {
      Button('Exit')
        .fontSize(14)
        .fontColor(AppColors.onBackground)
        .backgroundColor(Color.Transparent)
        .padding({ left: AppSpacing.sm, right: AppSpacing.sm });
      Blank();
      Text('Story Editor')
        .fontSize(18)
        .fontWeight(FontWeight.Medium)
        .fontColor(AppColors.onSurface);
      Blank();
      Button('Post')
        .fontSize(14)
        .fontColor(AppColors.onPrimary)
        .backgroundColor(AppColors.primary)
        .borderRadius(8)
        .padding({ left: AppSpacing.sm, right: AppSpacing.sm });
    }
    .width('100%')
    .height(56)
    .padding({ left: AppSpacing.sm, right: AppSpacing.sm })
    .backgroundColor(AppColors.surface)
    .alignItems(VerticalAlign.Center);
  }

  @Builder
  PreviewCard(): void {
    Stack() {
      Text('Your Story Preview')
        .fontSize(24)
        .fontWeight(FontWeight.SemiBold)
        .fontColor(AppColors.onTertiary)
        .opacity(this.textOpacity)
        .textAlign(TextAlign.Center);
    }
    .width('100%')
    .layoutWeight(1)
    .margin(AppSpacing.lg)
    .backgroundColor(AppColors.tertiary)
    .borderRadius(12)
    .shadow({ radius: 3, color: '#1A000000', offsetY: 1 })
    .alignContent(Alignment.Center);
  }

  @Builder
  UploadStatus(): void {
    Column({ space: AppSpacing.sm }) {
      Text('Upload Status')
        .fontSize(12)
        .fontWeight(FontWeight.Medium)
        .fontColor(AppColors.secondary);
      Progress({ value: this.uploadProgress, total: 100, type: ProgressType.Linear })
        .width('100%')
        .height(AppSpacing.sm)
        .color(AppColors.success)
        .backgroundColor(AppColors.surfaceVariant);
    }
    .width('100%')
    .padding({ left: AppSpacing.lg, right: AppSpacing.lg });
  }

  @Builder
  LayerCard(layer: StoryLayer): void {
    Column({ space: AppSpacing.sm }) {
      Circle()
        .width(32)
        .height(32)
        .fill(layer.id === this.selectedLayer ? '#33FFFFFF' : AppColors.surfaceVariant);
      Text(layer.type)
        .fontSize(12)
        .fontWeight(FontWeight.Medium)
        .fontColor(layer.id === this.selectedLayer ? AppColors.onPrimary : '#B3263238');
      Text(layer.content)
        .fontSize(14)
        .fontColor(layer.id === this.selectedLayer ? AppColors.onPrimary : AppColors.onSurface);
    }
    .width(100)
    .padding({ left: AppSpacing.lg, right: AppSpacing.lg, top: AppSpacing.md, bottom: AppSpacing.md })
    .backgroundColor(layer.id === this.selectedLayer ? AppColors.primary : AppColors.surface)
    .border({ width: 1, color: layer.id === this.selectedLayer ? AppColors.primary : AppColors.outline })
    .borderRadius(8)
    .alignItems(HorizontalAlign.Center)
    .onClick(() => {
      this.selectedLayer = layer.id;
    });
  }

  @Builder
  LayerRow(): void {
    Scroll() {
      Row({ space: AppSpacing.md }) {
        ForEach(this.layers, (layer: StoryLayer) => {
          this.LayerCard(layer);
        }, (layer: StoryLayer) => layer.id.toString())
      }
      .padding({ left: AppSpacing.lg, right: AppSpacing.lg, top: AppSpacing.md, bottom: AppSpacing.md });
    }
    .scrollable(ScrollDirection.Horizontal)
    .width('100%');
  }

  @Builder
  BottomBar(): void {
    Column() {
      Text('Layer Properties')
        .fontSize(12)
        .fontWeight(FontWeight.Medium)
        .fontColor(AppColors.secondary);
      Blank().height(AppSpacing.md);
      Row() {
        Text('Opacity')
          .fontSize(14)
          .fontColor(AppColors.onSurface)
          .width(80);
        Slider({ value: this.textOpacity, min: 0, max: 1 })
          .layoutWeight(1)
          .selectedColor(AppColors.primary)
          .trackColor(AppColors.surfaceVariant)
          .onChange((value: number) => {
            this.textOpacity = value;
          });
      }
      .alignItems(VerticalAlign.Center);
    }
    .width('100%')
    .padding(AppSpacing.lg)
    .backgroundColor(AppColors.surface)
    .shadow({ radius: 6, color: '#1A000000', offsetY: -2 });
  }

  build() {
    Column() {
      this.TopBar();
      Column({ space: AppSpacing.lg }) {
        this.PreviewCard();
        this.UploadStatus();
        this.LayerRow();
      }
      .width('100%')
      .layoutWeight(1)
      .alignItems(HorizontalAlign.Center);
      this.BottomBar();
    }
    .width('100%')
    .height('100%')
    .backgroundColor(AppColors.background);
  }
}
