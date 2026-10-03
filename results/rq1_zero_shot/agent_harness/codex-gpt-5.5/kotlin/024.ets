const NAME: string = '025Whiteboarden';
const UI_TYPE: string = 'Productivity';
const STYLE_THEME: string = 'Retro Flat';
const LANG: string = 'en';
const BASELINE_SIZE: string = '720x1280';

class AppColors {
  static readonly primary: string = '#EF476F';
  static readonly secondary: string = '#FFD166';
  static readonly tertiary: string = '#06D6A0';
  static readonly background: string = '#FFFCF2';
  static readonly surface: string = '#FFFFFF';
  static readonly surfaceVariant: string = '#F7EDE2';
  static readonly outline: string = '#E5D4B1';
  static readonly success: string = '#06D6A0';
  static readonly warning: string = '#FFA600';
  static readonly error: string = '#D62828';
  static readonly onPrimary: string = '#FFFFFF';
  static readonly onSecondary: string = '#1E1E1E';
  static readonly onTertiary: string = '#1E1E1E';
  static readonly onBackground: string = '#1E1E1E';
  static readonly onSurface: string = '#1E1E1E';
}

class AppSpacing {
  static readonly xs: number = 4;
  static readonly sm: number = 8;
  static readonly md: number = 12;
  static readonly lg: number = 16;
  static readonly xl: number = 24;
}

class PointItem {
  x: number;
  y: number;
  color: string;

  constructor(x: number, y: number, color: string) {
    this.x = x;
    this.y = y;
    this.color = color;
  }
}

@Entry
@Component
struct MainActivity {
  @State points: PointItem[] = [];
  @State color: string = AppColors.primary;

  @Builder
  Header(): void {
    Text('Retro Whiteboard')
      .fontSize(26)
      .fontWeight(FontWeight.Bold)
      .fontColor(AppColors.onSurface)
      .width('100%')
      .height(56)
      .textAlign(TextAlign.Center)
      .backgroundColor(AppColors.background);
  }

  @Builder
  CanvasArea(): void {
    Stack() {
      ForEach(this.points, (point: PointItem, index: number) => {
        Circle()
          .width(20)
          .height(20)
          .fill(point.color)
          .position({ x: point.x, y: point.y });
      }, (_point: PointItem, index: number) => index.toString())
      Button('Clear')
        .fontSize(12)
        .fontWeight(FontWeight.Medium)
        .fontColor(AppColors.onSecondary)
        .backgroundColor(AppColors.secondary)
        .borderRadius(28)
        .width(72)
        .height(56)
        .position({ x: '78%', y: '78%' })
        .onClick(() => {
          this.points = [];
        });
    }
    .width('100%')
    .height('100%')
    .backgroundColor(AppColors.background)
    .gesture(PanGesture().onActionUpdate((event: GestureEvent) => {
      this.points = [...this.points, new PointItem(event.offsetX, event.offsetY, this.color)];
    }));
  }

  @Builder
  ColorButton(label: string, value: string, textColor: string): void {
    Button(label)
      .fontSize(14)
      .fontColor(textColor)
      .backgroundColor(value)
      .borderRadius(6)
      .onClick(() => {
        this.color = value;
      });
  }

  @Builder
  BottomBar(): void {
    Row() {
      this.ColorButton('Red', AppColors.primary, AppColors.onPrimary);
      this.ColorButton('Yellow', AppColors.secondary, AppColors.onSecondary);
      this.ColorButton('Green', AppColors.tertiary, AppColors.onTertiary);
    }
    .width('100%')
    .padding(AppSpacing.md)
    .backgroundColor(AppColors.surface)
    .justifyContent(FlexAlign.SpaceEvenly)
    .alignItems(VerticalAlign.Center)
    .shadow({ radius: 4, color: '#1F000000', offsetY: -2 });
  }

  build() {
    Column() {
      this.Header();
      this.CanvasArea();
      this.BottomBar();
    }
    .width('100%')
    .height('100%')
    .backgroundColor(AppColors.background);
  }
}
