const Colors = {
  primary: '#38BDF8',
  secondary: '#A78BFA',
  tertiary: '#7DD3FC',
  background: '#F1F5F9',
  surface: '#FFFFFF',
  surfaceVariant: '#E2E8F0',
  outline: '#CBD5E1',
  success: '#22C55E',
  warning: '#F59E0B',
  error: '#EF4444',
  onPrimary: '#FFFFFF',
  onSecondary: '#1E1E1E',
  onTertiary: '#1E1E1E',
  onBackground: '#1E1E1E',
  onSurface: '#1E1E1E'
};

const Spacing = {
  sm: 8,
  md: 12,
  lg: 16,
  xl: 24,
  xxl: 32
};

@Entry
@Component
struct Index {
  @State offsetX: number = 0;
  @State offsetY: number = 0;
  @State lastX: number = -1;
  @State lastY: number = -1;

  build() {
    Column() {
      Row() {
        Text('Glass Doc Reader')
          .fontSize(28)
          .fontWeight(FontWeight.Bold)
          .fontColor(Colors.onSurface)
      }
      .width('100%')
      .height(64)
      .justifyContent(FlexAlign.Center)
      .backgroundColor(Colors.background)

      Stack() {
        Column() {
          Text('Document Reader')
            .fontSize(18)
            .fontWeight(FontWeight.Medium)
            .fontColor(Colors.primary)
          ForEach(['1', '2', '3', '4', '5', '6', '7', '8'], (n: string) => {
            Text('This is a sample line of text content number ' + n + '.')
              .fontSize(14)
              .fontColor(Colors.onSurface)
          }, (n: string) => n)
        }
        .width('90%')
        .height(400)
        .padding(Spacing.lg)
        .space(Spacing.md)
        .backgroundColor(Colors.surface)
        .borderRadius(20)
        .shadow({ radius: 8, color: 'rgba(0, 0, 0, 0.18)', offsetY: 4 })
        .offset({ y: this.offsetY / 5 })
      }
      .width('100%')
      .layoutWeight(1)
      .alignContent(Alignment.Center)
      .linearGradient({ direction: GradientDirection.Bottom, colors: [['#FFFFFF', 0], [Colors.background, 0.5], ['#FFFFFF', 1]] })
      .onTouch((event: TouchEvent) => {
        if (event.type === TouchType.Down && event.touches.length > 0) {
          this.lastX = event.touches[0].x;
          this.lastY = event.touches[0].y;
        } else if (event.type === TouchType.Move && event.touches.length > 0 && this.lastX >= 0) {
          const dx = event.touches[0].x - this.lastX;
          const dy = event.touches[0].y - this.lastY;
          this.offsetX += dx;
          this.offsetY += dy;
          this.lastX = event.touches[0].x;
          this.lastY = event.touches[0].y;
        } else if (event.type === TouchType.Up || event.type === TouchType.Cancel) {
          this.lastX = -1;
          this.lastY = -1;
        }
      })
    }
    .width('100%')
    .height('100%')
    .backgroundColor(Colors.background)
  }
}
