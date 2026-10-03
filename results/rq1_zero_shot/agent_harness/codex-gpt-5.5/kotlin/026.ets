const NAME: string = '027*DocReader*en';
const UI_TYPE: string = 'Productivity';
const STYLE_THEME: string = 'Glassmorphic';
const LANG: string = 'en';
const BASELINE_SIZE: string = '750x1334';

class AppColors {
  static readonly primary: string = '#38BDF8';
  static readonly secondary: string = '#A78BFA';
  static readonly tertiary: string = '#7DD3FC';
  static readonly background: string = '#F1F5F9';
  static readonly surface: string = '#FFFFFF';
  static readonly surfaceVariant: string = '#E2E8F0';
  static readonly outline: string = '#CBD5E1';
  static readonly success: string = '#22C55E';
  static readonly warning: string = '#F59E0B';
  static readonly error: string = '#EF4444';
  static readonly onPrimary: string = '#FFFFFF';
  static readonly onSecondary: string = '#1E1E1E';
  static readonly onTertiary: string = '#1E1E1E';
  static readonly onBackground: string = '#1E1E1E';
  static readonly onSurface: string = '#1E1E1E';
}

class AppSpacing {
  static readonly sm: number = 8;
  static readonly md: number = 12;
  static readonly lg: number = 16;
  static readonly xl: number = 24;
  static readonly xxl: number = 32;
}

class OffsetPoint {
  x: number;
  y: number;

  constructor(x: number, y: number) {
    this.x = x;
    this.y = y;
  }
}

@Entry
@Component
struct MainActivity {
  @State scrollOffset: OffsetPoint = new OffsetPoint(0, 0);
  private lines: string[] = [
    'This is a sample line of text content number 1.',
    'This is a sample line of text content number 2.',
    'This is a sample line of text content number 3.',
    'This is a sample line of text content number 4.',
    'This is a sample line of text content number 5.',
    'This is a sample line of text content number 6.',
    'This is a sample line of text content number 7.',
    'This is a sample line of text content number 8.'
  ];

  @Builder
  Header(): void {
    Text('Glass Doc Reader')
      .fontSize(28)
      .fontWeight(FontWeight.Bold)
      .fontColor(AppColors.onSurface)
      .width('100%')
      .height(56)
      .textAlign(TextAlign.Center)
      .backgroundColor(AppColors.background);
  }

  @Builder
  DocumentCard(): void {
    Column({ space: AppSpacing.md }) {
      Text('Document Reader')
        .fontSize(18)
        .fontWeight(FontWeight.Medium)
        .fontColor(AppColors.primary);
      ForEach(this.lines, (line: string) => {
        Text(line)
          .fontSize(14)
          .fontColor(AppColors.onSurface);
      }, (line: string) => line)
    }
    .width('90%')
    .height(400)
    .padding(AppSpacing.lg)
    .backgroundColor('#B3FFFFFF')
    .borderRadius(20)
    .shadow({ radius: 8, color: '#2E000000', offsetY: 4 })
    .translate({ y: this.scrollOffset.y / 5 })
    .alignItems(HorizontalAlign.Start);
  }

  build() {
    Column() {
      this.Header();
      Stack() {
        this.DocumentCard();
      }
      .width('100%')
      .layoutWeight(1)
      .backgroundColor(AppColors.surfaceVariant)
      .alignContent(Alignment.Center)
      .gesture(PanGesture().onActionUpdate((event: GestureEvent) => {
        this.scrollOffset = new OffsetPoint(this.scrollOffset.x + event.offsetX, this.scrollOffset.y + event.offsetY);
      }));
    }
    .width('100%')
    .height('100%')
    .backgroundColor(AppColors.background);
  }
}
